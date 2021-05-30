package ru.job4j.dream.store;

import ru.job4j.dream.model.Post;
import ru.job4j.dream.model.Candidate;
import ru.job4j.dream.model.User;

import java.util.Collection;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

public class MemStore implements Store {

    private static final MemStore INST = new MemStore();

    private final Map<Integer, Post> posts = new ConcurrentHashMap<>();

    private final Map<Integer, Candidate> candidates = new ConcurrentHashMap<>();

    private final Map<Integer, User> users = new ConcurrentHashMap<>();

    private static AtomicInteger POST_ID = new AtomicInteger(3);

    private static AtomicInteger CANDIDATE_ID = new AtomicInteger(3);

    private static AtomicInteger USER_ID = new AtomicInteger(1);

    private MemStore() {
        posts.put(1, new Post(1, "Junior java Job"));
        posts.put(2, new Post(2, "Middle java Job"));
        posts.put(3, new Post(3, "Senior java Job"));
        candidates.put(1, new Candidate(1, "Junior Java", 0));
        candidates.put(2, new Candidate(2, "Middle Java", 0));
        candidates.put(3, new Candidate(3, "Senior Java", 0));
        users.put(1, new User(1, "Admin", "root@local", "root"));
    }

    public static MemStore instOf() {
        return INST;
    }

    public Collection<Post> findAllPosts() {
        return posts.values();
    }

    public Collection<Candidate> findAllCandidates() {
        return candidates.values();
    }

    public void savePost(Post post) {
        if (post.getId() == 0) {
            post.setId(POST_ID.incrementAndGet());
        }
        posts.put(post.getId(), post);
    }

    public Post findPostById(int id) {
        return posts.get(id);
    }

    public void saveCandidate(Candidate candidate) {
        if (candidate.getId() == 0) {
            candidate.setId(CANDIDATE_ID.incrementAndGet());
        }
        candidates.put(candidate.getId(), candidate);
    }

    public Candidate findCandidateById(int id) {
        return candidates.get(id);
    }

    @Override
    public void deleteCandidate(Candidate candidate) {
        candidates.remove(candidate.getId());
    }

    @Override
    public void saveUser(User user) {
        user.setId(POST_ID.incrementAndGet());
        users.put(user.getId(), user);
    }

    @Override
    public User findUserByEmail(String email) {
        User result = null;
        for (User user : users.values()) {
            if (user.getEmail().equals(email)) {
                result = user;
                break;
            }
        }
        return result;
    }
}
