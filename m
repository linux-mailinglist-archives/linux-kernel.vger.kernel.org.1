Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B803C2B67DF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgKQOt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:49:26 -0500
Received: from foss.arm.com ([217.140.110.172]:59334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729861AbgKQOtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:49:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DD161480;
        Tue, 17 Nov 2020 06:49:24 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.59.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4DD153F718;
        Tue, 17 Nov 2020 06:49:22 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        jolsa@redhat.com
Cc:     james.clark@arm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v5 11/12] perf tools: Add separate core member
Date:   Tue, 17 Nov 2020 16:48:44 +0200
Message-Id: <20201117144845.13714-12-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201117144845.13714-1-james.clark@arm.com>
References: <20201117144845.13714-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add core as a separate member so that it doesn't have to be
packed into the int value.

Signed-off-by: James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: John Garry <john.garry@huawei.com>
---
 tools/perf/builtin-stat.c      |  9 +++------
 tools/perf/tests/topology.c    |  6 +++++-
 tools/perf/util/cpumap.c       | 18 ++++++++++--------
 tools/perf/util/cpumap.h       |  6 +-----
 tools/perf/util/stat-display.c | 16 ++++++++--------
 5 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 514144dad8b1..d79a29e22dfd 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1404,15 +1404,12 @@ static struct aggr_cpu_id perf_env__get_core(struct perf_cpu_map *map, int idx,
 	if (cpu != -1) {
 		/*
 		 * core_id is relative to socket and die,
-		 * we need a global id. So we combine
-		 * socket + die id + core id
+		 * we need a global id. So we set
+		 * socket, die id and core id
 		 */
-		if (WARN_ONCE(env->cpu[cpu].core_id >> 16, "The core id number is too big.\n"))
-			return cpu_map__empty_aggr_cpu_id();
-
 		id.socket = env->cpu[cpu].socket_id;
 		id.die = env->cpu[cpu].die_id;
-		id.id = env->cpu[cpu].core_id & 0xffff;
+		id.core = env->cpu[cpu].core_id;
 	}
 
 	return id;
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 1b0db2405720..3baaac6c7454 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -111,7 +111,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	for (i = 0; i < map->nr; i++) {
 		id = cpu_map__get_core(map, i, NULL);
 		TEST_ASSERT_VAL("Core map - Core ID doesn't match",
-			session->header.env.cpu[map->map[i]].core_id == cpu_map__id_to_cpu(id.id));
+			session->header.env.cpu[map->map[i]].core_id == id.core);
 
 		TEST_ASSERT_VAL("Core map - Socket ID doesn't match",
 			session->header.env.cpu[map->map[i]].socket_id == id.socket);
@@ -119,6 +119,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		TEST_ASSERT_VAL("Core map - Die ID doesn't match",
 			session->header.env.cpu[map->map[i]].die_id == id.die);
 		TEST_ASSERT_VAL("Core map - Node ID is set", id.node == -1);
+		TEST_ASSERT_VAL("Core map - ID is set", id.id == -1);
 	}
 
 	// Test that die ID contains socket and die
@@ -131,6 +132,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 			session->header.env.cpu[map->map[i]].die_id == id.die);
 		TEST_ASSERT_VAL("Die map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Die map - ID is set", id.id == -1);
+		TEST_ASSERT_VAL("Die map - Core is set", id.core == -1);
 	}
 
 	// Test that socket ID contains only socket
@@ -141,6 +143,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		TEST_ASSERT_VAL("Socket map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Socket map - Die ID is set", id.die == -1);
 		TEST_ASSERT_VAL("Socket map - ID is set", id.id == -1);
+		TEST_ASSERT_VAL("Socket map - Core is set", id.core == -1);
 	}
 
 	// Test that node ID contains only node
@@ -151,6 +154,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		TEST_ASSERT_VAL("Node map - ID is set", id.id == -1);
 		TEST_ASSERT_VAL("Node map - Socket is set", id.socket == -1);
 		TEST_ASSERT_VAL("Node map - Die ID is set", id.die == -1);
+		TEST_ASSERT_VAL("Node map - Core is set", id.core == -1);
 	}
 	perf_session__delete(session);
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 10a52058d838..d164f7bd1ac7 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -154,8 +154,10 @@ static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
 		return a->node - b->node;
 	else if (a->socket != b->socket)
 		return a->socket - b->socket;
-	else
+	else if (a->die != b->die)
 		return a->die - b->die;
+	else
+		return a->core - b->core;
 }
 
 int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
@@ -258,10 +260,7 @@ struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *da
 	 * core_id is relative to socket and die, we need a global id.
 	 * So we combine the result from cpu_map__get_die with the core id
 	 */
-	if (WARN_ONCE(cpu >> 16, "The core id number is too big.\n"))
-		return cpu_map__empty_aggr_cpu_id();
-
-	id.id = (cpu & 0xffff);
+	id.core = cpu;
 	return id;
 }
 
@@ -620,7 +619,8 @@ bool cpu_map__compare_aggr_cpu_id(struct aggr_cpu_id a, struct aggr_cpu_id b)
 	return a.id == b.id &&
 		a.node == b.node &&
 		a.socket == b.socket &&
-		a.die == b.die;
+		a.die == b.die &&
+		a.core == b.core;
 }
 
 bool cpu_map__aggr_cpu_id_is_empty(struct aggr_cpu_id a)
@@ -628,7 +628,8 @@ bool cpu_map__aggr_cpu_id_is_empty(struct aggr_cpu_id a)
 	return a.id == -1 &&
 		a.node == -1 &&
 		a.socket == -1 &&
-		a.die == -1;
+		a.die == -1 &&
+		a.core == -1;
 }
 
 struct aggr_cpu_id cpu_map__empty_aggr_cpu_id(void)
@@ -637,7 +638,8 @@ struct aggr_cpu_id cpu_map__empty_aggr_cpu_id(void)
 		.id = -1,
 		.node = -1,
 		.socket = -1,
-		.die = -1
+		.die = -1,
+		.core = -1
 	};
 	return ret;
 }
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 51bbe1eca3f4..1bb8f7d47206 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -12,6 +12,7 @@ struct aggr_cpu_id {
 	int node;
 	int socket;
 	int die;
+	int core;
 };
 
 struct cpu_aggr_map {
@@ -50,11 +51,6 @@ static inline int cpu_map__socket(struct perf_cpu_map *sock, int s)
 	return sock->map[s];
 }
 
-static inline int cpu_map__id_to_cpu(int id)
-{
-	return id & 0xffff;
-}
-
 int cpu__setup_cpunode_map(void);
 
 int cpu__max_node(void);
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index d27ef1e4658f..df54036c5e39 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -76,7 +76,7 @@ static void aggr_printout(struct perf_stat_config *config,
 			id.socket,
 			id.die,
 			config->csv_output ? 0 : -8,
-			cpu_map__id_to_cpu(id.id),
+			id.core,
 			config->csv_sep,
 			config->csv_output ? 0 : 4,
 			nr,
@@ -116,11 +116,11 @@ static void aggr_printout(struct perf_stat_config *config,
 				id.socket,
 				id.die,
 				config->csv_output ? 0 : -3,
-				cpu_map__id_to_cpu(id.id), config->csv_sep);
-		} else if (id.id > -1) {
+				id.core, config->csv_sep);
+		} else if (id.core > -1) {
 			fprintf(config->output, "CPU%*d%s",
 				config->csv_output ? 0 : -7,
-				evsel__cpus(evsel)->map[id.id],
+				evsel__cpus(evsel)->map[id.core],
 				config->csv_sep);
 		}
 		break;
@@ -329,7 +329,7 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 		return 0;
 
 	if (config->aggr_mode == AGGR_NONE)
-		return id.id;
+		return id.core;
 
 	if (config->aggr_mode == AGGR_GLOBAL)
 		return 0;
@@ -661,7 +661,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	uval = val * counter->scale;
 	if (cpu != -1) {
 		id = cpu_map__empty_aggr_cpu_id();
-		id.id = cpu;
+		id.core = cpu;
 	}
 	printout(config, id, nr, counter, uval,
 		 prefix, run, ena, 1.0, &rt_stat);
@@ -874,7 +874,7 @@ static void print_counter(struct perf_stat_config *config,
 
 		uval = val * counter->scale;
 		id = cpu_map__empty_aggr_cpu_id();
-		id.id = cpu;
+		id.core = cpu;
 		printout(config, id, 0, counter, uval, prefix,
 			 run, ena, 1.0, &rt_stat);
 
@@ -901,7 +901,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 			fputs(prefix, config->output);
 		evlist__for_each_entry(evlist, counter) {
 			id = cpu_map__empty_aggr_cpu_id();
-			id.id = cpu;
+			id.core = cpu;
 			if (first) {
 				aggr_printout(config, counter, id, 0);
 				first = false;
-- 
2.28.0

