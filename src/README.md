## Source Directory

This directory contains two important modules.  The `model.py` module, one, and the `metrics.py` module, two.  


### Models

This module acts a template for different models in our use case.  
- It creates objects out of the models with their tokenizers and the pretrained model itself.  
- It also exposes and inference API which can be used to run inferences against the model with prompt and hyperparameters

Models used in testing live in the `LLM` folder here and inherit from this template, making it simple to load and use a model as well as add new models.


### Metrics

This module acts as the primary result set analyzer.  All the result calculations are done through the APIs exposes here for metrics such as:
- BLEU
- ROUGE 
    - ROUGE-1
        - Precision
        - Recall
        - F-Score
    - ROUGE-2
        - Precision
        - Recall
        - F-Score
    - ROUGE-L
        - Precision
        - Recall
        - F-Score
- METEOR
- BERTScore 
    - Precision
    - Recall
    - F1-Score
- SemScore