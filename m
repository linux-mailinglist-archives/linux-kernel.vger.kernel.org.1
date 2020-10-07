Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA4128637F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 18:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgJGQSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 12:18:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:54623 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbgJGQR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 12:17:59 -0400
IronPort-SDR: X/3w0mnAiuWYDvSos2E+JKvGcs5lugtirID6BjsPMi0CbLx5UEK69piI4Q9Au8iCOh6bsQortv
 UKwg3i8Wv8Pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="229142601"
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="229142601"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 09:17:59 -0700
IronPort-SDR: r3PwdlDNxIUz73BRtbmu5/pVS2rWzzHDnfEMrs/BS9mM4kYe9ii7mpS5MDGKE/jSibjqouBUta
 /aQiwnpNLCug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="388424802"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga001.jf.intel.com with ESMTP; 07 Oct 2020 09:17:59 -0700
Subject: [RFC][PATCH 9/9] mm/migrate: new zone_reclaim_mode to enable reclaim migration
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 07 Oct 2020 09:17:52 -0700
References: <20201007161736.ACC6E387@viggo.jf.intel.com>
In-Reply-To: <20201007161736.ACC6E387@viggo.jf.intel.com>
Message-Id: <20201007161752.11E81B0E@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Some method is obviously needed to enable reclaim-based migration.

Just like traditional autonuma, there will be some workloads that
will benefit like workloads with more "static" configurations where
hot pages stay hot and cold pages stay cold.  If pages come and go
from the hot and cold sets, the benefits of this approach will be
more limited.

The benefits are truly workload-based and *not* hardware-based.
We do not believe that there is a viable threshold where certain
hardware configurations should have this mechanism enabled while
others do not.

To be conservative, earlier work defaulted to disable reclaim-
based migration and did not include a mechanism to enable it.
This propses extending the existing "zone_reclaim_mode" (now
now really node_reclaim_mode) as a method to enable it.

We are open to any alternative that allows end users to enable
this mechanism or disable it it workload harm is detected (just
like traditional autonuma).

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
---

 b/Documentation/admin-guide/sysctl/vm.rst |    9 +++++++++
 b/include/linux/swap.h                    |    3 ++-
 b/include/uapi/linux/mempolicy.h          |    1 +
 b/mm/vmscan.c                             |    6 ++++--
 4 files changed, 16 insertions(+), 3 deletions(-)

diff -puN Documentation/admin-guide/sysctl/vm.rst~RECLAIM_MIGRATE Documentation/admin-guide/sysctl/vm.rst
--- a/Documentation/admin-guide/sysctl/vm.rst~RECLAIM_MIGRATE	2020-10-07 09:15:35.622642430 -0700
+++ b/Documentation/admin-guide/sysctl/vm.rst	2020-10-07 09:15:35.640642430 -0700
@@ -969,6 +969,7 @@ This is value OR'ed together of
 1	Zone reclaim on
 2	Zone reclaim writes dirty pages out
 4	Zone reclaim swaps pages
+8	Zone reclaim migrates pages
 =	===================================
 
 zone_reclaim_mode is disabled by default.  For file servers or workloads
@@ -993,3 +994,11 @@ of other processes running on other node
 Allowing regular swap effectively restricts allocations to the local
 node unless explicitly overridden by memory policies or cpuset
 configurations.
+
+Page migration during reclaim is intended for systems with tiered memory
+configurations.  These systems have multiple types of memory with varied
+performance characteristics instead of plain NUMA systems where the same
+kind of memory is found at varied distances.  Allowing page migration
+during reclaim enables these systems to migrate pages from fast tiers to
+slow tiers when the fast tier is under pressure.  This migration is
+performed before swap.
diff -puN include/linux/swap.h~RECLAIM_MIGRATE include/linux/swap.h
--- a/include/linux/swap.h~RECLAIM_MIGRATE	2020-10-07 09:15:35.624642430 -0700
+++ b/include/linux/swap.h	2020-10-07 09:15:35.640642430 -0700
@@ -385,7 +385,8 @@ extern int sysctl_min_slab_ratio;
 static inline bool node_reclaim_enabled(void)
 {
 	/* Is any node_reclaim_mode bit set? */
-	return node_reclaim_mode & (RECLAIM_ZONE|RECLAIM_WRITE|RECLAIM_UNMAP);
+	return node_reclaim_mode & (RECLAIM_ZONE |RECLAIM_WRITE|
+				    RECLAIM_UNMAP|RECLAIM_MIGRATE);
 }
 
 extern void check_move_unevictable_pages(struct pagevec *pvec);
diff -puN include/uapi/linux/mempolicy.h~RECLAIM_MIGRATE include/uapi/linux/mempolicy.h
--- a/include/uapi/linux/mempolicy.h~RECLAIM_MIGRATE	2020-10-07 09:15:35.628642430 -0700
+++ b/include/uapi/linux/mempolicy.h	2020-10-07 09:15:35.640642430 -0700
@@ -69,5 +69,6 @@ enum {
 #define RECLAIM_ZONE	(1<<0)	/* Run shrink_inactive_list on the zone */
 #define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
 #define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
+#define RECLAIM_MIGRATE	(1<<3)	/* Migrate to other nodes during reclaim */
 
 #endif /* _UAPI_LINUX_MEMPOLICY_H */
diff -puN mm/vmscan.c~RECLAIM_MIGRATE mm/vmscan.c
--- a/mm/vmscan.c~RECLAIM_MIGRATE	2020-10-07 09:15:35.630642430 -0700
+++ b/mm/vmscan.c	2020-10-07 09:15:35.641642430 -0700
@@ -1077,6 +1077,9 @@ bool migrate_demote_page_ok(struct page
 	VM_BUG_ON_PAGE(PageHuge(page), page);
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
+	if (!(node_reclaim_mode & RECLAIM_MIGRATE))
+		return false;
+
 	/* It is pointless to do demotion in memcg reclaim */
 	if (cgroup_reclaim(sc))
 		return false;
@@ -1086,8 +1089,7 @@ bool migrate_demote_page_ok(struct page
 	if (PageTransHuge(page) && !thp_migration_supported())
 		return false;
 
-	// FIXME: actually enable this later in the series
-	return false;
+	return true;
 }
 
 
_
