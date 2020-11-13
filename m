Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A822B21FA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgKMRTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:19:50 -0500
Received: from foss.arm.com ([217.140.110.172]:41998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbgKMRTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:19:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DF8F1534;
        Fri, 13 Nov 2020 09:19:53 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.58.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 75CF13F718;
        Fri, 13 Nov 2020 09:19:51 -0800 (PST)
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
Subject: [PATCH 08/13 v3] perf tools: Start using cpu_aggr_id in map
Date:   Fri, 13 Nov 2020 19:19:18 +0200
Message-Id: <20201113171923.29721-9-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113171923.29721-1-james.clark@arm.com>
References: <20201113171923.29721-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new cpu_aggr_id struct in the cpu map
instead of int so that it can store more data.

No functional changes.

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
 tools/perf/builtin-stat.c      | 6 +++---
 tools/perf/util/cpumap.c       | 8 ++++----
 tools/perf/util/cpumap.h       | 2 +-
 tools/perf/util/stat-display.c | 6 +++---
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 344e50651b55..afe9fa6112b6 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1223,10 +1223,10 @@ static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
 
 	cpu = map->map[idx];
 
-	if (config->cpus_aggr_map->map[cpu] == -1)
-		config->cpus_aggr_map->map[cpu] = get_id(config, map, idx).id;
+	if (cpu_map__aggr_cpu_id_is_empty(config->cpus_aggr_map->map[cpu]))
+		config->cpus_aggr_map->map[cpu] = get_id(config, map, idx);
 
-	id.id = config->cpus_aggr_map->map[cpu];
+	id = config->cpus_aggr_map->map[cpu];
 	return id;
 }
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index e90270f0be57..0f42e6a6b704 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -97,14 +97,14 @@ struct perf_cpu_map *perf_cpu_map__empty_new(int nr)
 
 struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr)
 {
-	struct cpu_aggr_map *cpus = malloc(sizeof(*cpus) + sizeof(int) * nr);
+	struct cpu_aggr_map *cpus = malloc(sizeof(*cpus) + sizeof(struct aggr_cpu_id) * nr);
 
 	if (cpus != NULL) {
 		int i;
 
 		cpus->nr = nr;
 		for (i = 0; i < nr; i++)
-			cpus->map[i] = -1;
+			cpus->map[i] = cpu_map__empty_aggr_cpu_id();
 
 		refcount_set(&cpus->refcnt, 1);
 	}
@@ -169,11 +169,11 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
 	for (cpu = 0; cpu < nr; cpu++) {
 		s1 = f(cpus, cpu, data);
 		for (s2 = 0; s2 < c->nr; s2++) {
-			if (s1.id == c->map[s2])
+			if (cpu_map__compare_aggr_cpu_id(s1, c->map[s2]))
 				break;
 		}
 		if (s2 == c->nr) {
-			c->map[c->nr] = s1.id;
+			c->map[c->nr] = s1;
 			c->nr++;
 		}
 	}
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index b112069038be..d8fc265bc762 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -14,7 +14,7 @@ struct aggr_cpu_id {
 struct cpu_aggr_map {
 	refcount_t refcnt;
 	int nr;
-	int map[];
+	struct aggr_cpu_id map[];
 };
 
 struct perf_record_cpu_map_data;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 01acb7d5e120..ad91e8a7d5af 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -509,7 +509,7 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 	struct evsel *counter;
 
 	for (s = 0; s < config->aggr_map->nr; s++) {
-		id.id = config->aggr_map->map[s];
+		id = config->aggr_map->map[s];
 		evlist__for_each_entry(evlist, counter) {
 			val = 0;
 			for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
@@ -641,7 +641,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	struct aggr_cpu_id id;
 	double uval;
 
-	ad.id.id = id.id = config->aggr_map->map[s];
+	ad.id = id = config->aggr_map->map[s];
 	ad.val = ad.ena = ad.run = 0;
 	ad.nr = 0;
 	if (!collect_data(config, counter, aggr_cb, &ad))
@@ -1167,7 +1167,7 @@ static void print_percore_thread(struct perf_stat_config *config,
 	for (int i = 0; i < evsel__nr_cpus(counter); i++) {
 		s2 = config->aggr_get_id(config, evsel__cpus(counter), i);
 		for (s = 0; s < config->aggr_map->nr; s++) {
-			id.id = config->aggr_map->map[s];
+			id = config->aggr_map->map[s];
 			if (cpu_map__compare_aggr_cpu_id(s2, id))
 				break;
 		}
-- 
2.28.0

