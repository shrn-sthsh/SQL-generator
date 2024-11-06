from src.model import llm

class gpt_neox_llm(llm):
    def __init__(self, library_name: str = "EleutherAI/gpt-neox-20b"):
        super().__init__(library_name)
       
    def infer(self, prompt: str, max_response_length: int = 100) -> str:
        return super().infer(prompt, max_response_length) 
