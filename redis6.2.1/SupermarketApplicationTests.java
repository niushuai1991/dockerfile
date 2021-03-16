package com.github.niushuai1991.supermarket;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;
import redis.clients.jedis.JedisShardInfo;

//@SpringBootTest
class SupermarketApplicationTests {

	@Test
	void contextLoads() {
	}

	@Test
	void aaa(){
		JedisPoolConfig poolConfig = new JedisPoolConfig();
		poolConfig.setMaxTotal(50);
		poolConfig.setMaxIdle(5);
		poolConfig.setMaxWaitMillis(100*1000);
		JedisPool jedisPool = new JedisPool(poolConfig, "192.144.237.230",46379, 10000, "ibps1234", false);
		Jedis jedis = jedisPool.getResource();
		jedis.set("aaa", "21");
		System.out.println(jedis.get("aaa"));
		jedis.close();
	}

	@Test
	void bbb(){
		String uri = "http://default:ibps1234@192.144.237.230:46379/0";
		JedisShardInfo infoA = new JedisShardInfo(uri);
		infoA.setPassword("ibps1234");
		Jedis jedis = infoA.createResource();
		jedis.set("bbb", "444");
		System.out.println(jedis.get("bbb"));
		jedis.close();
	}
}
