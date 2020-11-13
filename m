Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302E42B2235
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgKMR1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:27:24 -0500
Received: from foss.arm.com ([217.140.110.172]:42310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgKMR1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:27:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AF49153B;
        Fri, 13 Nov 2020 09:27:20 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.58.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 48BEA3F718;
        Fri, 13 Nov 2020 09:27:18 -0800 (PST)
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
Subject: [PATCH 03/13 v4] perf tools: Add new struct for cpu aggregation
Date:   Fri, 13 Nov 2020 19:26:44 +0200
Message-Id: <20201113172654.989-4-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113172654.989-1-james.clark@arm.com>
References: <20201113172654.989-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This struct currently has only a single int member so that
it can be used as a drop in replacement for the existing
behaviour.

Comparison and constructor functions have also been added
that will replace usages of '==' and '= -1'.

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
 tools/perf/util/cpumap.c | 18 ++++++++++++++++++
 tools/perf/util/cpumap.h |  8 ++++++++
 2 files changed, 26 insertions(+)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index fd7d0a77a9e6..e6b4def17839 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -587,3 +587,21 @@ const struct perf_cpu_map *cpu_map__online(void) /* thread unsafe */
 
 	return online;
 }
+
+bool cpu_map__compare_aggr_cpu_id(struct aggr_cpu_id a, struct aggr_cpu_id b)
+{
+	return a.id == b.id;
+}
+
+bool cpu_map__aggr_cpu_id_is_empty(struct aggr_cpu_id a)
+{
+	return a.id == -1;
+}
+
+struct aggr_cpu_id cpu_map__empty_aggr_cpu_id(void)
+{
+	struct aggr_cpu_id ret = {
+		.id = -1
+	};
+	return ret;
+}
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 3a442f021468..1cdccc69cd4b 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -7,6 +7,10 @@
 #include <internal/cpumap.h>
 #include <perf/cpumap.h>
 
+struct aggr_cpu_id {
+	int id;
+};
+
 struct perf_record_cpu_map_data;
 
 struct perf_cpu_map *perf_cpu_map__empty_new(int nr);
@@ -64,4 +68,8 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct perf_cpu_map **res,
 int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
 bool cpu_map__has(struct perf_cpu_map *cpus, int cpu);
 
+bool cpu_map__compare_aggr_cpu_id(struct aggr_cpu_id a, struct aggr_cpu_id b);
+bool cpu_map__aggr_cpu_id_is_empty(struct aggr_cpu_id a);
+struct aggr_cpu_id cpu_map__empty_aggr_cpu_id(void);
+
 #endif /* __PERF_CPUMAP_H */
-- 
2.28.0

