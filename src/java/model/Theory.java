package model;

public class Theory {

    private int id;
    private String title;
    private String content;
    private int topicId;
    private String filePath;

    public Theory() {
    }

    public Theory(int id, String title, String content, int topicId, String filePath) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.topicId = topicId;
        this.filePath = filePath;
    }

    
    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    public int getTopicId() {
        return topicId;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
}
