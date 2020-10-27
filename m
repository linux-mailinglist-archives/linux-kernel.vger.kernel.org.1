Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96AD29A4B3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 07:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506783AbgJ0GdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 02:33:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:9343 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506772AbgJ0GdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 02:33:10 -0400
IronPort-SDR: OxJuI/80hzh4+yVjle+H7uTY2A+Hd2SYd93OSZNkQETQKAvcB3WNuyq6OJZBmXOP7sKuSTOoHj
 Q2WjKV33eXoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="147317880"
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="147317880"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 23:33:10 -0700
IronPort-SDR: ZWP0aS7RNy3JTzZVBLPJsOczRvuN1HoALtS7e7PFqCBU7KJhs5hp4Fa746ehgnhdE16vWlrXyH
 V2wsRRW355zw==
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="535666746"
Received: from lzhengha-mobl.ccr.corp.intel.com (HELO yhuang-mobile.ccr.corp.intel.com) ([10.254.213.46])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 23:33:07 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC -V4 5/6] autonuma, memory tiering: Adjust hot threshold automatically
Date:   Tue, 27 Oct 2020 14:32:16 +0800
Message-Id: <20201027063217.211096-6-ying.huang@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201027063217.211096-1-ying.huang@intel.com>
References: <20201027063217.211096-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It isn't easy for the administrator to determine the hot threshold.
So in this patch, a method to adjust the hot threshold automatically
is implemented.  The basic idea is to control the number of the
candidate promotion pages to match the promotion rate limit.  If the
hint page fault latency of a page is less than the hot threshold, we
will try to promote the page, and the page is called the candidate
promotion page.

If the number of the candidate promotion pages in the statistics
interval is much more than the promotion rate limit, the hot threshold
will be decreased to reduce the number of the candidate promotion
pages.  Otherwise, the hot threshold will be increased to increase the
number of the candidate promotion pages.

To make the above method works, in each statistics interval, the total
number of the pages to check (on which the hint page faults occur) and
the hot/cold distribution need to be stable.  Because the page tables
are scanned linearly in AutoNUMA, but the hot/cold distribution isn't
uniform along the address, the statistics interval should be larger
than the AutoNUMA scan period.  So in the patch, the max scan period
is used as statistics interval and it works well in our tests.

The sysctl knob kernel.numa_balancing_hot_threshold_ms becomes the
initial value and max value of the hot threshold.

The patch improves the score of pmbench memory accessing benchmark
with 80:20 read/write ratio and normal access address distribution by
4.4% with 30.8% fewer NUMA page migrations on a 2 socket Intel server
with Optance DC Persistent Memory.  Because it improves the accuracy
of the hot page selection.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mmzone.h |  3 +++
 kernel/sched/fair.c    | 40 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a4fbd711d5e9..c10efdc92b17 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -777,6 +777,9 @@ typedef struct pglist_data {
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned long numa_ts;
 	unsigned long numa_nr_candidate;
+	unsigned long numa_threshold_ts;
+	unsigned long numa_threshold_nr_candidate;
+	unsigned long numa_threshold;
 #endif
 	/* Fields commonly accessed by the page reclaim scanner */
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e84ae9db7e3c..227007f2b9d7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1470,6 +1470,35 @@ static bool numa_migration_check_rate_limit(struct pglist_data *pgdat,
 	return true;
 }
 
+#define NUMA_MIGRATION_ADJUST_STEPS	16
+
+static void numa_migration_adjust_threshold(struct pglist_data *pgdat,
+					    unsigned long rate_limit,
+					    unsigned long ref_th)
+{
+	unsigned long now = jiffies, last_th_ts, th_period;
+	unsigned long unit_th, th;
+	unsigned long nr_cand, ref_cand, diff_cand;
+
+	th_period = msecs_to_jiffies(sysctl_numa_balancing_scan_period_max);
+	last_th_ts = pgdat->numa_threshold_ts;
+	if (now > last_th_ts + th_period &&
+	    cmpxchg(&pgdat->numa_threshold_ts, last_th_ts, now) == last_th_ts) {
+		ref_cand = rate_limit *
+			sysctl_numa_balancing_scan_period_max / 1000;
+		nr_cand = node_page_state(pgdat, PGPROMOTE_CANDIDATE);
+		diff_cand = nr_cand - pgdat->numa_threshold_nr_candidate;
+		unit_th = ref_th / NUMA_MIGRATION_ADJUST_STEPS;
+		th = pgdat->numa_threshold ? : ref_th;
+		if (diff_cand > ref_cand * 11 / 10)
+			th = max(th - unit_th, unit_th);
+		else if (diff_cand < ref_cand * 9 / 10)
+			th = min(th + unit_th, ref_th);
+		pgdat->numa_threshold_nr_candidate = nr_cand;
+		pgdat->numa_threshold = th;
+	}
+}
+
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 				int src_nid, int dst_cpu)
 {
@@ -1484,19 +1513,22 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 	    !node_is_toptier(src_nid)) {
 		struct pglist_data *pgdat;
-		unsigned long rate_limit, latency, th;
+		unsigned long rate_limit, latency, th, def_th;
 
 		pgdat = NODE_DATA(dst_nid);
 		if (pgdat_free_space_enough(pgdat))
 			return true;
 
-		th = sysctl_numa_balancing_hot_threshold;
+		def_th = sysctl_numa_balancing_hot_threshold;
+		rate_limit =
+			sysctl_numa_balancing_rate_limit << (20 - PAGE_SHIFT);
+		numa_migration_adjust_threshold(pgdat, rate_limit, def_th);
+
+		th = pgdat->numa_threshold ? : def_th;
 		latency = numa_hint_fault_latency(page);
 		if (latency > th)
 			return false;
 
-		rate_limit =
-			sysctl_numa_balancing_rate_limit << (20 - PAGE_SHIFT);
 		return numa_migration_check_rate_limit(pgdat, rate_limit,
 						       thp_nr_pages(page));
 	}
-- 
2.28.0

