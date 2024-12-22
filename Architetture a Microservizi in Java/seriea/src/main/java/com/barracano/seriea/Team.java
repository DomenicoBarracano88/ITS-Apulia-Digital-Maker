package com.barracano.seriea;

import java.io.Serializable;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQuery;



/**
 * The persistent class for the team database table.
 * 
 */
@Entity

@NamedQuery(name="Team.findAll", query="SELECT t FROM Team t")
public class Team implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY )
	private Integer id;

	private String cityname;

	private String teamname;

	public Team() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCityname() {
		return this.cityname;
	}

	public void setCityname(String cityname) {
		this.cityname = cityname;
	}

	public String getTeamname() {
		return this.teamname;
	}

	public void setTeamname(String teamname) {
		this.teamname = teamname;
	}

}