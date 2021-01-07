Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E51D2ED5DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbhAGRml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:42:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:31689 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbhAGRmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:42:40 -0500
IronPort-SDR: z1lyOyXbewTfkF0RlbU6yxwKuv1DwLxAEiOF9iZKye50Q9i9TThVtYKiwyarG+eQsQysGMk5m/
 WkuTOp+3F+aQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="156648455"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="156648455"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 09:42:00 -0800
IronPort-SDR: ML5kRPZOMvuB/Y4WT2h+AzJ6dKZANUUggH5AU3XCLZm5swx74IRxBoEKQdXyeDvtkHMPsreubc
 pBg6JBv7ZDAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="422656335"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by orsmga001.jf.intel.com with ESMTP; 07 Jan 2021 09:41:58 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf intel-pt: Fix 'CPU too large' error
Date:   Thu,  7 Jan 2021 19:41:59 +0200
Message-Id: <20210107174159.24897-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, the number of cpus (nr_cpus_online) is confused with the
maximum cpu number (nr_cpus_avail), which results in the error in the
example below:

Example on system with 8 cpus:

 Before:
   # echo 0 > /sys/devices/system/cpu/cpu2/online
   # ./perf record --kcore -e intel_pt// taskset --cpu-list 7 uname
   Linux
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.147 MB perf.data ]
   # ./perf script --itrace=e
   Requested CPU 7 too large. Consider raising MAX_NR_CPUS
   0x25908 [0x8]: failed to process type: 68 [Invalid argument]

 After:
   # ./perf script --itrace=e
   #

Fixes: 8c7274691f0d ("perf machine: Replace MAX_NR_CPUS with perf_env::nr_cpus_online")
Fixes: 7df4e36a4785 ("perf session: Replace MAX_NR_CPUS with perf_env::nr_cpus_online")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/machine.c | 4 ++--
 tools/perf/util/session.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 1ae32a81639c..46844599d25d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2977,7 +2977,7 @@ int machines__for_each_thread(struct machines *machines,
 
 pid_t machine__get_current_tid(struct machine *machine, int cpu)
 {
-	int nr_cpus = min(machine->env->nr_cpus_online, MAX_NR_CPUS);
+	int nr_cpus = min(machine->env->nr_cpus_avail, MAX_NR_CPUS);
 
 	if (cpu < 0 || cpu >= nr_cpus || !machine->current_tid)
 		return -1;
@@ -2989,7 +2989,7 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
 			     pid_t tid)
 {
 	struct thread *thread;
-	int nr_cpus = min(machine->env->nr_cpus_online, MAX_NR_CPUS);
+	int nr_cpus = min(machine->env->nr_cpus_avail, MAX_NR_CPUS);
 
 	if (cpu < 0)
 		return -EINVAL;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 3b3c50b12791..2777c2df7d87 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2391,7 +2391,7 @@ int perf_session__cpu_bitmap(struct perf_session *session,
 {
 	int i, err = -1;
 	struct perf_cpu_map *map;
-	int nr_cpus = min(session->header.env.nr_cpus_online, MAX_NR_CPUS);
+	int nr_cpus = min(session->header.env.nr_cpus_avail, MAX_NR_CPUS);
 
 	for (i = 0; i < PERF_TYPE_MAX; ++i) {
 		struct evsel *evsel;
-- 
2.17.1

