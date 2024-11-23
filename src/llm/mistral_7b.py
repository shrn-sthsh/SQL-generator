from src.model import llm

class mistral_llm(llm):
    def __init__(self, library_name: str = "mistralai/Mistral-7B-v0.1"):
        super().__init__(library_name)
       
    def infer(self, prompt: str, **hyperparameters) -> str:
        return super().infer(prompt, hyperparameters=hyperparameters) 
