package com.barracano.seriea;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface PlayerRepository extends JpaRepository<Player, Integer> {

	List<Player> findByTeamname(String teamname);
	
}
