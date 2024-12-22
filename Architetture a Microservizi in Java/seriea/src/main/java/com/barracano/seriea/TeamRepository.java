package com.barracano.seriea;


import org.springframework.data.jpa.repository.JpaRepository;

public interface TeamRepository extends JpaRepository<Team, Integer> {
	boolean existsByTeamname(String teamname);
}
