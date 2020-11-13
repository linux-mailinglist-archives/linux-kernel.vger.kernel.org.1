Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359D12B2232
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgKMR1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:27:18 -0500
Received: from foss.arm.com ([217.140.110.172]:42274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgKMR1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:27:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0005914BF;
        Fri, 13 Nov 2020 09:27:15 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.58.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E2073F718;
        Fri, 13 Nov 2020 09:27:14 -0800 (PST)
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
Subject: [PATCH 01/13 v4] perf tools: Improve topology test
Date:   Fri, 13 Nov 2020 19:26:42 +0200
Message-Id: <20201113172654.989-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113172654.989-1-james.clark@arm.com>
References: <20201113172654.989-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the topology test to check all aggregation
types. This is to lock down the behaviour before
'id' is changed into a struct in later commits.

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
 tools/perf/tests/topology.c | 53 ++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 22daf2bdf5fa..7bd8848d36b6 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -64,10 +64,11 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		.path = path,
 		.mode = PERF_DATA_MODE_READ,
 	};
-	int i;
+	int i, id;
 
 	session = perf_session__new(&data, false, NULL);
 	TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
+	cpu__setup_cpunode_map();
 
 	/* On platforms with large numbers of CPUs process_cpu_topology()
 	 * might issue an error while reading the perf.data file section
@@ -85,11 +86,18 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	 *  "socket_id number is too big. You may need to upgrade the
 	 *  perf tool."
 	 *
-	 *  This is the reason why this test might be skipped.
+	 *  This is the reason why this test might be skipped. aarch64 and
+	 *  s390 always write this part of the header, even when the above
+	 *  condition is true (see do_core_id_test in header.c). So always
+	 *  run this test on those platforms.
 	 */
-	if (!session->header.env.cpu)
+	if (!session->header.env.cpu
+			&& strncmp(session->header.env.arch, "s390", 4)
+			&& strncmp(session->header.env.arch, "aarch64", 7))
 		return TEST_SKIP;
 
+	TEST_ASSERT_VAL("Session header CPU map not set", session->header.env.cpu);
+
 	for (i = 0; i < session->header.env.nr_cpus_avail; i++) {
 		if (!cpu_map__has(map, i))
 			continue;
@@ -98,14 +106,45 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 			 session->header.env.cpu[i].socket_id);
 	}
 
+	// Test that core ID contains socket, die and core
+	for (i = 0; i < map->nr; i++) {
+		id = cpu_map__get_core(map, i, NULL);
+		TEST_ASSERT_VAL("Core map - Core ID doesn't match",
+			session->header.env.cpu[map->map[i]].core_id == cpu_map__id_to_cpu(id));
+
+		TEST_ASSERT_VAL("Core map - Socket ID doesn't match",
+			session->header.env.cpu[map->map[i]].socket_id ==
+				cpu_map__id_to_socket(id));
+
+		TEST_ASSERT_VAL("Core map - Die ID doesn't match",
+			session->header.env.cpu[map->map[i]].die_id == cpu_map__id_to_die(id));
+	}
+
+	// Test that die ID contains socket and die
 	for (i = 0; i < map->nr; i++) {
-		TEST_ASSERT_VAL("Core ID doesn't match",
-			(session->header.env.cpu[map->map[i]].core_id == (cpu_map__get_core(map, i, NULL) & 0xffff)));
+		id = cpu_map__get_die(map, i, NULL);
+		TEST_ASSERT_VAL("Die map - Socket ID doesn't match",
+			session->header.env.cpu[map->map[i]].socket_id ==
+				cpu_map__id_to_socket(id));
 
-		TEST_ASSERT_VAL("Socket ID doesn't match",
-			(session->header.env.cpu[map->map[i]].socket_id == cpu_map__get_socket(map, i, NULL)));
+		TEST_ASSERT_VAL("Die map - Die ID doesn't match",
+			session->header.env.cpu[map->map[i]].die_id == cpu_map__id_to_die(id));
 	}
 
+	// Test that socket ID contains only socket
+	for (i = 0; i < map->nr; i++) {
+		id = cpu_map__get_socket(map, i, NULL);
+		TEST_ASSERT_VAL("Socket map - Socket ID doesn't match",
+			session->header.env.cpu[map->map[i]].socket_id ==
+				cpu_map__id_to_socket(id));
+	}
+
+	// Test that node ID contains only node
+	for (i = 0; i < map->nr; i++) {
+		id = cpu_map__get_node(map, i, NULL);
+		TEST_ASSERT_VAL("Node map - Node ID doesn't match",
+			cpu__get_node(map->map[i]) == id);
+	}
 	perf_session__delete(session);
 
 	return 0;
-- 
2.28.0

