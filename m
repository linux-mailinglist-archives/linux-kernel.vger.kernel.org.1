Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537CF2E716F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 15:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgL2OgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 09:36:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:20295 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgL2OgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 09:36:04 -0500
IronPort-SDR: EaGsnAmXK65klsB3oslnfVHBO9Jmi4hH0aMc1g7FhU5emadby+c3Ho62xSbnGDO1pM4WWxjH6t
 g4B7isMO+ZTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9849"; a="176652524"
X-IronPort-AV: E=Sophos;i="5.78,458,1599548400"; 
   d="scan'208";a="176652524"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 06:35:23 -0800
IronPort-SDR: eYxPnBAWuuBFssEaZl+on9r7PyKlV5TajRHuQ2CGZcaFo3np2Uiks/13bzVdmbX/LUrwDE110k
 VixndsB/+xFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,458,1599548400"; 
   d="scan'208";a="419194823"
Received: from shbuild999.sh.intel.com ([10.239.147.98])
  by orsmga001.jf.intel.com with ESMTP; 29 Dec 2020 06:35:18 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        Feng Tang <feng.tang@intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH 2/2] mm: memcg: add a new MEMCG_UPDATE_BATCH
Date:   Tue, 29 Dec 2020 22:35:14 +0800
Message-Id: <1609252514-27795-2-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609252514-27795-1-git-send-email-feng.tang@intel.com>
References: <1609252514-27795-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When profiling memory cgroup involved benchmarking, status update
sometimes take quite some CPU cycles. Current MEMCG_CHARGE_BATCH
is used for both charging and statistics/events updating, and is
set to 32, which may be good for accuracy of memcg charging, but
too small for stats update which causes concurrent access to global
stats data instead of per-cpu ones.

So handle them differently, by adding a new bigger batch number
for stats updating, while keeping the value for charging (though
comments in memcontrol.h suggests to consider a bigger value too)

The new batch is set to 512, which considers 2MB huge pages (512
pages), as the check logic mostly is:

    if (x > BATCH), then skip updating global data

so it will save 50% global data updating for 2MB pages

Following are some performance data with the patch, against
v5.11-rc1, on several generations of Xeon platforms. Each category
below has several subcases run on different platform, and only the
worst and best scores are listed:

fio:				 +2.0% ~  +6.8%
will-it-scale/malloc:		 -0.9% ~  +6.2%
will-it-scale/page_fault1:	 no change
will-it-scale/page_fault2:	+13.7% ~ +26.2%

One thought is it could be dynamically calculated according to
memcg limit and number of CPUs, and another is to add a periodic
syncing of the data for accuracy reason similar to vmstat, as
suggested by Ying.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 2 ++
 mm/memcontrol.c            | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d827bd7..d58bf28 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -335,6 +335,8 @@ struct mem_cgroup {
  */
 #define MEMCG_CHARGE_BATCH 32U
 
+#define MEMCG_UPDATE_BATCH 512U
+
 extern struct mem_cgroup *root_mem_cgroup;
 
 enum page_memcg_data_flags {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 605f671..01ca85d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -760,7 +760,7 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
  */
 void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 {
-	long x, threshold = MEMCG_CHARGE_BATCH;
+	long x, threshold = MEMCG_UPDATE_BATCH;
 
 	if (mem_cgroup_disabled())
 		return;
@@ -800,7 +800,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 {
 	struct mem_cgroup_per_node *pn;
 	struct mem_cgroup *memcg;
-	long x, threshold = MEMCG_CHARGE_BATCH;
+	long x, threshold = MEMCG_UPDATE_BATCH;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg = pn->memcg;
@@ -905,7 +905,7 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 		return;
 
 	x = count + __this_cpu_read(memcg->vmstats_percpu->events[idx]);
-	if (unlikely(x > MEMCG_CHARGE_BATCH)) {
+	if (unlikely(x > MEMCG_UPDATE_BATCH)) {
 		struct mem_cgroup *mi;
 
 		/*
-- 
2.7.4

