Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12362FEAC5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbhAUMzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:55:46 -0500
Received: from mga12.intel.com ([192.55.52.136]:32902 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbhAUMzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:55:38 -0500
IronPort-SDR: I95eGTPkc201Q8lWo1Ryo9azNgQiYTHRCcXnip1l7G4s1TBY0T+Nt+50kEnpVw0Mj8nVZxj1+S
 PnCQxjuMSPhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="158441529"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="158441529"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 04:54:42 -0800
IronPort-SDR: ignPXyJesCJw2Evd1+F6bqdsPHsRxE/Yheb8ymc8pp0MtkvC6kWZTtdaREvhANzvmEFurnp0fi
 1Eb4zrSIH0bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="574215421"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jan 2021 04:54:41 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jin@vger.kernel.org,
        Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf evlist: Fix id index for heterogeneous systems
Date:   Thu, 21 Jan 2021 14:54:46 +0200
Message-Id: <20210121125446.11287-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_evlist__set_sid_idx() updates perf_sample_id with the evlist map
index, cpu number and tid. It is passed indexes to the evsel's cpu and
thread maps, but references the evlist's maps instead. That results in
using incorrect cpu numbers on heterogeneous systems. Fix by using evsel
maps.

The id index (PERF_RECORD_ID_INDEX) is used by AUX area tracing when in
sampling mode. Having an incorrect cpu number causes the trace data to
be attributed to the wrong cpu, and can result in decoder errors because
the trace data is then associated with the wrong process.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index cfcdbd7be066..37be8042889f 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -367,21 +367,13 @@ static struct perf_mmap* perf_evlist__alloc_mmap(struct perf_evlist *evlist, boo
 	return map;
 }
 
-static void perf_evlist__set_sid_idx(struct perf_evlist *evlist,
-				     struct perf_evsel *evsel, int idx, int cpu,
-				     int thread)
+static void set_sid_idx(struct perf_evsel *evsel, int idx, int cpu, int thread)
 {
 	struct perf_sample_id *sid = SID(evsel, cpu, thread);
 
 	sid->idx = idx;
-	if (evlist->cpus && cpu >= 0)
-		sid->cpu = evlist->cpus->map[cpu];
-	else
-		sid->cpu = -1;
-	if (!evsel->system_wide && evlist->threads && thread >= 0)
-		sid->tid = perf_thread_map__pid(evlist->threads, thread);
-	else
-		sid->tid = -1;
+	sid->cpu = perf_cpu_map__cpu(evsel->cpus, cpu);
+	sid->tid = perf_thread_map__pid(evsel->threads, thread);
 }
 
 static struct perf_mmap*
@@ -500,8 +492,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 			if (perf_evlist__id_add_fd(evlist, evsel, cpu, thread,
 						   fd) < 0)
 				return -1;
-			perf_evlist__set_sid_idx(evlist, evsel, idx, cpu,
-						 thread);
+			set_sid_idx(evsel, idx, cpu, thread);
 		}
 	}
 
-- 
2.17.1

