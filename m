Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C81285375
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgJFUvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:51:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:39969 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbgJFUvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:51:13 -0400
IronPort-SDR: N884+lHk2JEfLHKg6wgSBDRUoK7l4TycV0nzHSoN0cnyrFm8V1jhhr4zmNRVH/QC5gOwOHArgi
 hnQNpKQvIb+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="162068067"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="162068067"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 13:51:13 -0700
IronPort-SDR: sq+R0Aiu9u4TGvm7w4h4XTyWHaLAr9kcg7G0h4/qxUjWJ8R+pbtAUpKJdCpCe+2FCL93K1hlap
 UXxdrHznKJBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="518474613"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga005.fm.intel.com with ESMTP; 06 Oct 2020 13:51:12 -0700
Subject: [RFC][PATCH 02/12] mm/vmscan: move RECLAIM* bits to uapi header
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, ben.widawsky@intel.com,
        rientjes@google.com, alex.shi@linux.alibaba.com, dwagner@suse.de,
        tobin@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        ying.huang@intel.com, dan.j.williams@intel.com, cai@lca.pw
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 06 Oct 2020 13:51:08 -0700
References: <20201006205103.268F74A9@viggo.jf.intel.com>
In-Reply-To: <20201006205103.268F74A9@viggo.jf.intel.com>
Message-Id: <20201006205108.ADF7B6F2@viggo.jf.intel.com>
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
Cc: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: "Tobin C. Harding" <tobin@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Daniel Wagner <dwagner@suse.de>

--

Note: This is not cc'd to stable.  It does not fix any bugs.
---

 b/include/uapi/linux/mempolicy.h |    7 +++++++
 b/mm/vmscan.c                    |    8 --------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff -puN include/uapi/linux/mempolicy.h~mm-vmscan-move-RECLAIM-bits-to-uapi include/uapi/linux/mempolicy.h
--- a/include/uapi/linux/mempolicy.h~mm-vmscan-move-RECLAIM-bits-to-uapi	2020-10-06 13:39:21.720818440 -0700
+++ b/include/uapi/linux/mempolicy.h	2020-10-06 13:39:21.726818440 -0700
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
--- a/mm/vmscan.c~mm-vmscan-move-RECLAIM-bits-to-uapi	2020-10-06 13:39:21.722818440 -0700
+++ b/mm/vmscan.c	2020-10-06 13:39:21.727818440 -0700
@@ -4084,14 +4084,6 @@ module_init(kswapd_init)
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
