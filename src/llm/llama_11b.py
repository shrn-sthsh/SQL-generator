from src.model import llm

class llama_llm(llm):
    def __init__(self, library_name: str = "meta-llama/Llama-3.2-11B-Vision-Instruct"):
        super().__init__(library_name)
       
    def infer(self, prompt: str, **hyperparameters) -> str:
        return super().infer(prompt, hyperparameters=hyperparameters) 
