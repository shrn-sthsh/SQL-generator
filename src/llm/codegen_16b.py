from src.model import llm

class codegen_llm(llm):
    def __init__(self, library_name: str = "Salesforce/codegen-16B-mono"):
        super().__init__(library_name)
       
    def infer(self, prompt: str, **hyperparameters) -> str:
        return super().infer(prompt, hyperparameters=hyperparameters) 
