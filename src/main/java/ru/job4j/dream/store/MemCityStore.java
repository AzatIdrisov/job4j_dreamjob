package ru.job4j.dream.store;

import java.util.ArrayList;
import java.util.List;

public class MemCityStore implements CityStore {

    private static final MemCityStore INST = new MemCityStore();
    private final List<String> items = new ArrayList<>();

    private MemCityStore(){
        items.add("Moscow");
        items.add("Yekaterinburg");
        items.add("SPB");
    }

    public static MemCityStore instOf() {
        return INST;
    }

    @Override
    public List<String> getAll() {
        return items;
    }

    @Override
    public int getIdByName(String name) {
        return items.indexOf(name);
    }

    @Override
    public String getNameById(int id) {
        return (id >= 0 && id < items.size()) ? items.get(id) : null;
    }

}
