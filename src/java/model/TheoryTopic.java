package model;

public class TheoryTopic {

    private int id;
    private String name;

    public TheoryTopic() {}

    public TheoryTopic(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public int getId() { return id; }
    public String getName() { return name; }
}