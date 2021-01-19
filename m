Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F79B2FC189
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbhASUsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:48:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:26408 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392036AbhASUrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:47:14 -0500
IronPort-SDR: DAh+HmUrDQ3qHdih+/ozb4vXiHdyZKDH2CQy0mKgE/EXAB1LRwtN/kDZ1WrN3gEXrEPXcHvymP
 vgquQhRt3yPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="243064938"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="243064938"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 12:42:08 -0800
IronPort-SDR: 6+VHGy7qzd2HnJ2EljN7ZebjLJyo84ZeCoI1wcFbwtvwzL9C2FaUiy25cTPwAxxt1IJeEdsD+y
 NygsUZmuTIaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="365990805"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 19 Jan 2021 12:42:08 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 07/12] perf c2c: Support data block and addr block
Date:   Tue, 19 Jan 2021 12:38:26 -0800
Message-Id: <1611088711-17177-8-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
References: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

perf c2c is also a memory profiling tool. Apply the two new data source
fields to perf c2c as well.

Extend perf c2c to display the number of loads which blocked by data or
address conflict.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-c2c.c     | 3 +++
 tools/perf/util/mem-events.c | 6 ++++++
 tools/perf/util/mem-events.h | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c5babea..4de49ae 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2111,6 +2111,8 @@ static void print_c2c__display_stats(FILE *out)
 	fprintf(out, "  Load MESI State Exclusive         : %10d\n", stats->ld_excl);
 	fprintf(out, "  Load MESI State Shared            : %10d\n", stats->ld_shared);
 	fprintf(out, "  Load LLC Misses                   : %10d\n", llc_misses);
+	fprintf(out, "  Load access blocked by data       : %10d\n", stats->blk_data);
+	fprintf(out, "  Load access blocked by address    : %10d\n", stats->blk_addr);
 	fprintf(out, "  LLC Misses to Local DRAM          : %10.1f%%\n", ((double)stats->lcl_dram/(double)llc_misses) * 100.);
 	fprintf(out, "  LLC Misses to Remote DRAM         : %10.1f%%\n", ((double)stats->rmt_dram/(double)llc_misses) * 100.);
 	fprintf(out, "  LLC Misses to Remote cache (HIT)  : %10.1f%%\n", ((double)stats->rmt_hit /(double)llc_misses) * 100.);
@@ -2139,6 +2141,7 @@ static void print_shared_cacheline_info(FILE *out)
 	fprintf(out, "  L2D hits on shared lines          : %10d\n", stats->ld_l2hit);
 	fprintf(out, "  LLC hits on shared lines          : %10d\n", stats->ld_llchit + stats->lcl_hitm);
 	fprintf(out, "  Locked Access on shared lines     : %10d\n", stats->locks);
+	fprintf(out, "  Blocked Access on shared lines    : %10d\n", stats->blk_data + stats->blk_addr);
 	fprintf(out, "  Store HITs on shared lines        : %10d\n", stats->store);
 	fprintf(out, "  Store L1D hits on shared lines    : %10d\n", stats->st_l1hit);
 	fprintf(out, "  Total Merged records              : %10d\n", hitm_cnt + stats->store);
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 890f638..f93a852 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -385,6 +385,7 @@ int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi)
 	u64 lvl    = data_src->mem_lvl;
 	u64 snoop  = data_src->mem_snoop;
 	u64 lock   = data_src->mem_lock;
+	u64 blk    = data_src->mem_blk;
 	/*
 	 * Skylake might report unknown remote level via this
 	 * bit, consider it when evaluating remote HITMs.
@@ -404,6 +405,9 @@ do {				\
 
 	if (lock & P(LOCK, LOCKED)) stats->locks++;
 
+	if (blk & P(BLK, DATA)) stats->blk_data++;
+	if (blk & P(BLK, ADDR)) stats->blk_addr++;
+
 	if (op & P(OP, LOAD)) {
 		/* load */
 		stats->load++;
@@ -515,6 +519,8 @@ void c2c_add_stats(struct c2c_stats *stats, struct c2c_stats *add)
 	stats->rmt_hit		+= add->rmt_hit;
 	stats->lcl_dram		+= add->lcl_dram;
 	stats->rmt_dram		+= add->rmt_dram;
+	stats->blk_data		+= add->blk_data;
+	stats->blk_addr		+= add->blk_addr;
 	stats->nomap		+= add->nomap;
 	stats->noparse		+= add->noparse;
 }
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 5ddf447..755cef7 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -79,6 +79,8 @@ struct c2c_stats {
 	u32	rmt_hit;             /* count of loads with remote hit clean; */
 	u32	lcl_dram;            /* count of loads miss to local DRAM */
 	u32	rmt_dram;            /* count of loads miss to remote DRAM */
+	u32	blk_data;            /* count of loads blocked by data */
+	u32	blk_addr;            /* count of loads blocked by address conflict */
 	u32	nomap;               /* count of load/stores with no phys adrs */
 	u32	noparse;             /* count of unparsable data sources */
 };
-- 
2.7.4

