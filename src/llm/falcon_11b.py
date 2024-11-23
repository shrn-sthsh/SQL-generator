from src.model import llm

class falcon_llm(llm):
    def __init__(self, library_name: str = "tiiuae/falcon-11b"):
        super().__init__(library_name)
       
    def infer(self, prompt: str, **hyperparameters) -> str:
        return super().infer(prompt, hyperparameters=hyperparameters) 
