package com.barracano.shopping_list;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

@Service

public class ItemService {
	
	private final ItemRepository itemRepository;
	
	public ItemService(ItemRepository itemRepository) {
		this.itemRepository = itemRepository;
	}
	
	public List<Item> findAll(){
		return itemRepository.findAll();
	}
	
	public Optional<Item> findByID(Long id){
		return itemRepository.findById(id);
	}
	
	public Item create(Item item){
		return itemRepository.save(item);
	}
	
	
	public void delete(Long id){
		itemRepository.deleteById(id);
	}
	
	// Metodo per ottenere i prodotti da acquistare
    public List<Item> findItemsToBuy() {
        return itemRepository.findByPurchased(false);
    }
	
	
}
