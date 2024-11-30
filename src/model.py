from abc import ABC
import torch

from transformers import AutoTokenizer, AutoModelForCausalLM, PreTrainedTokenizer, PreTrainedModel

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
        self.model:     PreTrainedModel     = AutoModelForCausalLM.from_pretrained(
                                                  library_name, 
                                                  device_map="auto",
                                                  torch_dtype=torch.bfloat16
                                              )

        if self.tokenizer.pad_token is None:
            self.tokenizer.pad_token    = self.tokenizer.eos_token
            self.tokenizer.pad_token_id = self.tokenizer.eos_token_id 


    def infer(self, prompt: str, **hyperparameters) -> str:
        """ Run infernce on model from a natural language prompt """
        
        inputs = self.tokenizer(
            prompt, 
            return_tensors="pt",
            padding=True,
            truncation=True,
            max_length=self.model.config.max_position_embeddings
        ).to(self.model.device)

        outputs = self.model.generate(
            input_ids=inputs.input_ids, 
            attention_mask=inputs.attention_mask,
            pad_token_id=self.tokenizer.pad_token_id,
            **hyperparameters
        )

        response: str = self.tokenizer.decode(outputs[0], skip_special_tokens=True)
        return response
