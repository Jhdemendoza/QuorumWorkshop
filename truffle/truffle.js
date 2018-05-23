module.exports = {
	networks: {
		node1: {
			host: "localhost",
			port: 22000,
			network_id: "*",
			gasPrice: 0,
			gas: 9000000,
		},
		node2: {
			host: "localhost",
			port: 22001,
			network_id: "*",
			gasPrice: 0,
			gas: 9000000,
		}
	}
};
