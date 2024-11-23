from src.model import llm

class gpt_neox_llm(llm):
    def __init__(self, library_name: str = "EleutherAI/gpt-neox-20b"):
        super().__init__(library_name)
       
    def infer(self, prompt: str, **hyperparameters) -> str:
        return super().infer(prompt, hyperparameters=hyperparameters) 
