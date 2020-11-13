Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F492B220B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgKMRUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:20:43 -0500
Received: from foss.arm.com ([217.140.110.172]:41896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbgKMRT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:19:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6B551534;
        Fri, 13 Nov 2020 09:19:40 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.58.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 013FC3F718;
        Fri, 13 Nov 2020 09:19:38 -0800 (PST)
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
Subject: [PATCH 02/13 v3] perf tools: Use allocator for perf_cpu_map
Date:   Fri, 13 Nov 2020 19:19:12 +0200
Message-Id: <20201113171923.29721-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113171923.29721-1-james.clark@arm.com>
References: <20201113171923.29721-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the existing allocator for perf_cpu_map to avoid use
of raw malloc. This could cause an issue in later commits
where the size of perf_cpu_map is changed.

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
 tools/perf/util/cpumap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index dc5c5e6fc502..fd7d0a77a9e6 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -132,15 +132,16 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct perf_cpu_map **res,
 		       int (*f)(struct perf_cpu_map *map, int cpu, void *data),
 		       void *data)
 {
-	struct perf_cpu_map *c;
 	int nr = cpus->nr;
+	struct perf_cpu_map *c = perf_cpu_map__empty_new(nr);
 	int cpu, s1, s2;
 
-	/* allocate as much as possible */
-	c = calloc(1, sizeof(*c) + nr * sizeof(int));
 	if (!c)
 		return -1;
 
+	/* Reset size as it may only be partially filled */
+	c->nr = 0;
+
 	for (cpu = 0; cpu < nr; cpu++) {
 		s1 = f(cpus, cpu, data);
 		for (s2 = 0; s2 < c->nr; s2++) {
-- 
2.28.0

