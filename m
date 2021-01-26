Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568A9303A2C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404058AbhAZKZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:25:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:14024 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbhAZB3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:29:54 -0500
IronPort-SDR: ijEBPsTiFLvISqZgYzh1MN4DnF3lhfLHMD+tU5Uy/5wqrSIPSfOEWr4DgEj78zv20FTSVcWz6c
 JpyEtm2CCLPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="159004883"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="159004883"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 16:41:35 -0800
IronPort-SDR: e5hvp7TXBKd+AGfYz2vcRX3Rd7zXOPxjEAc7KkfjO13HyKnTg5K/sYXXUWvvYNzcMZ7D94JV6W
 drXa9uwmxMwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="577639888"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jan 2021 16:41:35 -0800
Subject: [RFC][PATCH 02/13] mm/vmscan: move RECLAIM* bits to uapi header
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        ben.widawsky@intel.com, rientjes@google.com, cl@linux.com,
        alex.shi@linux.alibaba.com, dwagner@suse.de, tobin@kernel.org,
        akpm@linux-foundation.org, ying.huang@intel.com,
        dan.j.williams@intel.com, cai@lca.pw, osalvador@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 25 Jan 2021 16:34:15 -0800
References: <20210126003411.2AC51464@viggo.jf.intel.com>
In-Reply-To: <20210126003411.2AC51464@viggo.jf.intel.com>
Message-Id: <20210126003415.1171FE94@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

It is currently not obvious that the RECLAIM_* bits are part of the
uapi since they are defined in vmscan.c.  Move them to a uapi header
to make it obvious.

This should have no functional impact.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Christoph Lameter <cl@linux.com>
Cc: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: "Tobin C. Harding" <tobin@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: osalvador <osalvador@suse.de>

--

Note: This is not cc'd to stable.  It does not fix any bugs.
---

 b/include/uapi/linux/mempolicy.h |    7 +++++++
 b/mm/vmscan.c                    |    8 --------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff -puN include/uapi/linux/mempolicy.h~mm-vmscan-move-RECLAIM-bits-to-uapi include/uapi/linux/mempolicy.h
--- a/include/uapi/linux/mempolicy.h~mm-vmscan-move-RECLAIM-bits-to-uapi	2021-01-25 16:23:07.197866715 -0800
+++ b/include/uapi/linux/mempolicy.h	2021-01-25 16:23:07.203866715 -0800
@@ -62,5 +62,12 @@ enum {
 #define MPOL_F_MOF	(1 << 3) /* this policy wants migrate on fault */
 #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
 
+/*
+ * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
+ * ABI.  New bits are OK, but existing bits can never change.
+ */
+#define RECLAIM_ZONE	(1<<0)	/* Run shrink_inactive_list on the zone */
+#define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
+#define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
 
 #endif /* _UAPI_LINUX_MEMPOLICY_H */
diff -puN mm/vmscan.c~mm-vmscan-move-RECLAIM-bits-to-uapi mm/vmscan.c
--- a/mm/vmscan.c~mm-vmscan-move-RECLAIM-bits-to-uapi	2021-01-25 16:23:07.199866715 -0800
+++ b/mm/vmscan.c	2021-01-25 16:23:07.204866715 -0800
@@ -4087,14 +4087,6 @@ module_init(kswapd_init)
 int node_reclaim_mode __read_mostly;
 
 /*
- * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
- * ABI.  New bits are OK, but existing bits can never change.
- */
-#define RECLAIM_ZONE  (1<<0)   /* Run shrink_inactive_list on the zone */
-#define RECLAIM_WRITE (1<<1)   /* Writeout pages during reclaim */
-#define RECLAIM_UNMAP (1<<2)   /* Unmap pages during reclaim */
-
-/*
  * Priority for NODE_RECLAIM. This determines the fraction of pages
  * of a node considered for each zone_reclaim. 4 scans 1/16th of
  * a zone.
_
