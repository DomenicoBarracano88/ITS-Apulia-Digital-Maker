package com.barracano.seriea;

import java.io.Serializable;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQuery;



/**
 * The persistent class for the player database table.
 * 
 */
@Entity

@NamedQuery(name="Player.findAll", query="SELECT p FROM Player p")
public class Player implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY )
	private Integer id;

	private String playername;

	private String teamname;

	public Player() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPlayername() {
		return this.playername;
	}

	public void setPlayername(String playername) {
		this.playername = playername;
	}

	public String getTeamname() {
		return this.teamname;
	}

	public void setTeamname(String teamname) {
		this.teamname = teamname;
	}

}