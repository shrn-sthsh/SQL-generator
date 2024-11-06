from abc import ABC

from transformers import AutoTokenizer, AutoModelForCausalLM, PreTrainedTokenizer, PreTrainedModel
from torch import LongTensor

class llm(ABC):
    def __init__(self, library_name: str):
        self.library_name: str = library_name
        if '/' in library_name:
            author, name = library_name.split('/')
            self.author: str = author
            self.name:   str = name
        else:
            self.author: str = ""
            self.name:   str = library_name

        self.tokenizer: PreTrainedTokenizer = AutoTokenizer.from_pretrained(library_name)
        self.model:     PreTrainedModel     = AutoModelForCausalLM.from_pretrained(library_name, device_map="auto") 

    def infer(self, prompt: str, **kwargs) -> str:
        """ Run infernce on model from a natural language prompt """
        inputs   = self.tokenizer(
            prompt, 
            return_tensors="pt"
        ).to("cuda")

        outputs  = self.model.generate(
            inputs.input_ids, 
            kwargs=kwargs 
        )

        response: str = self.tokenizer.decode(outputs[0], skip_special_tokens=True)
        return response
