Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848242B2243
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgKMR1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:27:36 -0500
Received: from foss.arm.com ([217.140.110.172]:42404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgKMR1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:27:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CB631042;
        Fri, 13 Nov 2020 09:27:32 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.58.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BA2D73F718;
        Fri, 13 Nov 2020 09:27:30 -0800 (PST)
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
Subject: [PATCH 09/13 v4] perf tools: Add separate node member
Date:   Fri, 13 Nov 2020 19:26:50 +0200
Message-Id: <20201113172654.989-10-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113172654.989-1-james.clark@arm.com>
References: <20201113172654.989-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node as a separate member so that it doesn't have to be
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
 tools/perf/builtin-stat.c      |  2 +-
 tools/perf/tests/topology.c    |  6 +++++-
 tools/perf/util/cpumap.c       | 16 +++++++++++-----
 tools/perf/util/cpumap.h       |  1 +
 tools/perf/util/stat-display.c |  2 +-
 5 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index afe9fa6112b6..2db2550eef9e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1437,7 +1437,7 @@ static struct aggr_cpu_id perf_env__get_node(struct perf_cpu_map *map, int idx,
 	int cpu = perf_env__get_cpu(data, map, idx);
 	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
 
-	id.id = perf_env__numa_node(data, cpu);
+	id.node = perf_env__numa_node(data, cpu);
 	return id;
 }
 
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index aeca2510dea8..90d9c259d258 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -119,6 +119,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 
 		TEST_ASSERT_VAL("Core map - Die ID doesn't match",
 			session->header.env.cpu[map->map[i]].die_id == cpu_map__id_to_die(id.id));
+		TEST_ASSERT_VAL("Core map - Node ID is set", id.node == -1);
 	}
 
 	// Test that die ID contains socket and die
@@ -130,6 +131,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 
 		TEST_ASSERT_VAL("Die map - Die ID doesn't match",
 			session->header.env.cpu[map->map[i]].die_id == cpu_map__id_to_die(id.id));
+		TEST_ASSERT_VAL("Die map - Node ID is set", id.node == -1);
 	}
 
 	// Test that socket ID contains only socket
@@ -138,13 +140,15 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		TEST_ASSERT_VAL("Socket map - Socket ID doesn't match",
 			session->header.env.cpu[map->map[i]].socket_id ==
 				cpu_map__id_to_socket(id.id));
+		TEST_ASSERT_VAL("Socket map - Node ID is set", id.node == -1);
 	}
 
 	// Test that node ID contains only node
 	for (i = 0; i < map->nr; i++) {
 		id = cpu_map__get_node(map, i, NULL);
 		TEST_ASSERT_VAL("Node map - Node ID doesn't match",
-			cpu__get_node(map->map[i]) == id.id);
+			cpu__get_node(map->map[i]) == id.node);
+		TEST_ASSERT_VAL("Node map - ID shouldn't be set", id.id == -1);
 	}
 	perf_session__delete(session);
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 0f42e6a6b704..9929ee5cf177 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -148,7 +148,10 @@ static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
 	struct aggr_cpu_id *a = (struct aggr_cpu_id *)a_pointer;
 	struct aggr_cpu_id *b = (struct aggr_cpu_id *)b_pointer;
 
-	return a->id - b->id;
+	if (a->id != b->id)
+		return a->id - b->id;
+	else
+		return a->node - b->node;
 }
 
 int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
@@ -276,7 +279,7 @@ struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *da
 	if (idx < 0 || idx >= map->nr)
 		return id;
 
-	id.id = cpu_map__get_node_id(map->map[idx]);
+	id.node = cpu_map__get_node_id(map->map[idx]);
 	return id;
 }
 
@@ -621,18 +624,21 @@ const struct perf_cpu_map *cpu_map__online(void) /* thread unsafe */
 
 bool cpu_map__compare_aggr_cpu_id(struct aggr_cpu_id a, struct aggr_cpu_id b)
 {
-	return a.id == b.id;
+	return a.id == b.id &&
+		a.node == b.node;
 }
 
 bool cpu_map__aggr_cpu_id_is_empty(struct aggr_cpu_id a)
 {
-	return a.id == -1;
+	return a.id == -1 &&
+		a.node == -1;
 }
 
 struct aggr_cpu_id cpu_map__empty_aggr_cpu_id(void)
 {
 	struct aggr_cpu_id ret = {
-		.id = -1
+		.id = -1,
+		.node = -1
 	};
 	return ret;
 }
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index d8fc265bc762..f79e92603024 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -9,6 +9,7 @@
 
 struct aggr_cpu_id {
 	int id;
+	int node;
 };
 
 struct cpu_aggr_map {
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ad91e8a7d5af..36cec8e1e05e 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -104,7 +104,7 @@ static void aggr_printout(struct perf_stat_config *config,
 	case AGGR_NODE:
 		fprintf(config->output, "N%*d%s%*d%s",
 			config->csv_output ? 0 : -5,
-			id.id,
+			id.node,
 			config->csv_sep,
 			config->csv_output ? 0 : 4,
 			nr,
-- 
2.28.0

