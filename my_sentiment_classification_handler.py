# Sentiment Classification
#  - Learning how to make a Huggingface handler for TorchServe
#  - Learned from: https://github.com/pytorch/serve/blob/7fdd5acffdb7495bba403f2d17b5d1283aacc9b3/examples/Huggingface_Transformers/Transformer_handler_generalized.py

from ts.torch_handler.base_handler import BaseHandler
from transformers import AutoTokenizer, AutoModelForSequenceClassification

class MySentimentClassification(BaseHandler):
    def __init__(self):
        print(f"HANDER>__init__>")
        super(MySentimentClassification, self).__init__()
        self.sentiment_labels = ["negative", "positive"]

    def initialize(self, ctx):
        print(f"HANDER>initialize> ctx: {ctx}")
        self.ctx = ctx
        model_dir = ctx.system_properties.get("model_dir")
        print(f"HANDER>initialize> model_dir: {model_dir}")
        self.tokenizer = AutoTokenizer.from_pretrained(model_dir)
        self.model = AutoModelForSequenceClassification.from_pretrained(model_dir)
        
    def preprocess(self, requests):
        print(f"HANDER>preprocess> requests: {requests}")
        input_text = requests[0]['body']
        print(f"HANDER>preprocess> input_text: {input_text}")
        inputs = self.tokenizer(input_text, return_tensors="pt")
        print(f"HANDER>preprocess> inputs: {inputs}")
        return inputs["input_ids"] # attention_masks are not used.

    def inference(self, x):
        print(f"HANDER>inference> x: {x}")
        y = self.model(x)
        print(f"HANDER>inference> y: {y}")
        return y

    def postprocess(self, y):
        print(f"HANDER>postprocess> y: {y}")

        prediction = y.logits.argmax(dim=1).numpy()
        print(f"HANDER>postprocess> prediction: {prediction}")
        logits = y.logits.detach().numpy()
        print(f"HANDER>postprocess> logits: {logits}")

        ret = []
        for p, logit in zip(prediction, logits):
            ret.append({
                "sentiment": self.sentiment_labels[p],
                "logits" : {
                    "positive": str(logit[1]),
                    "negative": str(logit[0]),
                },
                "provider": "star-lab",
            })
        print(f"HANDER>postprocess> ret: {ret}")

        return ret
