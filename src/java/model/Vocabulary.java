package model;

public class Vocabulary {

    private int id;
    private String word;
    private String meaning;
    private String example;

    public Vocabulary() {}

    public Vocabulary(int id, String word, String meaning, String example) {
        this.id = id;
        this.word = word;
        this.meaning = meaning;
        this.example = example;
    }

    public int getId() { return id; }
    public String getWord() { return word; }
    public String getMeaning() { return meaning; }
    public String getExample() { return example; }
}