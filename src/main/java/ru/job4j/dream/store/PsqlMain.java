package ru.job4j.dream.store;

import ru.job4j.dream.model.Candidate;
import ru.job4j.dream.model.Post;

public class PsqlMain {
    public static void main(String[] args) {
        Store store = PsqlStore.instOf();
        store.savePost(new Post(0, "Java Job"));
        for (Post post : store.findAllPosts()) {
            System.out.println(post.getId() + " " + post.getName());
        }
        store.savePost(new Post(1, "Java Middle Job"));
        Post foundedPost = store.findPostById(1);
        System.out.println(foundedPost.getId() + " " + foundedPost.getName());
        store.saveCandidate(new Candidate(0, "Java Junior"));
        for (Candidate candidate : store.findAllCandidates()) {
            System.out.println(candidate.getId() + " " + candidate.getName());
        }
        store.saveCandidate(new Candidate(1, "Java Middle Dev"));
        Candidate foundedCandidate = store.findCandidateById(1);
        System.out.println(foundedCandidate.getId() + " " + foundedCandidate.getName());
    }
}
