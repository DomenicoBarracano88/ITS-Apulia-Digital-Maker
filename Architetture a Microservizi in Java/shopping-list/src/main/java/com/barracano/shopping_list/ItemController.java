package com.barracano.shopping_list;

import java.util.List;
import java.util.Optional;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/items")

public class ItemController {
	
	private final ItemService itemService;
	
	public ItemController(ItemService itemService) {
		this.itemService = itemService;
	}

	@GetMapping
	public List<Item> getAllItems(){
		return itemService.findAll();
	}
	
	@GetMapping("/{id}")
	public Optional<Item> getItemById(@PathVariable Long id){
		return itemService.findByID(id);
	}
	
	@PostMapping
	public Item createItem(@RequestBody Item item) {
		return itemService.create(item);
	}
	
	
	@DeleteMapping("/{id}")
	public void deleteItem(@PathVariable Long id) {
		itemService.delete(id);
	}
	
	// Endpoint per ottenere i prodotti da acquistare
    @GetMapping("/to-buy")
    public List<Item> getItemsToBuy() {
        return itemService.findItemsToBuy();
    }
}
