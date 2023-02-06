## Classify Personal Experiences of PWUD on Reddit
---

This study consists of three main parts:  
1. Qualitative analysis of posts from 4 larger drug subreddits. Subreddits have a "Stop" counterpart.
2. Development of a classifier
3. Application of classifier for large-scale classification of posts

*Future Direction:*
The results of this study will be used to design a mixed-methods study to explore the motivations, phenomena, circumstances, etc of those who choose to engage is recovery-themed dialogue on Reddit. Methods will include applying classifier to posts from the "stop" counterparts of original 4 subreddits classifier was trained on. Thematic and linguistic analyses of personal posts will attempt to understand the online charactersitics of recovery. Lastly, an interview study will be designed to valdiate of expand upon findings.  

*Some Relevant Literature:*  
- [Online disclosure of illicit information: information of illicit behavior on two drug forums](https://asistdl.onlinelibrary.wiley.com/doi/10.1002/asi.23880)
- [Thematic analysis of Reddit content about beuprenorphine-naloxone using manual annotation and natural language processing technicques](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9365256/) 
- [Socially-supportive norms and mutual aid of people who use opioids: An analysis of Reddit during the initial COVID-19 pandemic](https://www.sciencedirect.com/science/article/pii/S0376871621001678?via%3Dihub)
- [A Hybrid Approach for Drug Abuse Events Extraction from Twitter](https://www.sciencedirect.com/science/article/pii/S1877050916319226)
- [Few shot learning with ne-tuned language model for suicidal text detection](https://www.researchsquare.com/article/rs-2392230/v1)

---

### Data

- Posts from the following four subreddits: 
  - [r/opiates](https://www.reddit.com/r/opiates/)
  - [r/cocaine](https://www.reddit.com/r/cocaine/)
  - [r/stims](https://www.reddit.com/r/stims/)
  - [r/benzodiazepines](https://www.reddit.com/r/benzodiazepines/)
  
- Unit of analysis: sentence
- Exclusions: 
  - posts made by known bots
  - title + body of a post is fewer than 5 words
    - including posts that are just links or other media (like images)
