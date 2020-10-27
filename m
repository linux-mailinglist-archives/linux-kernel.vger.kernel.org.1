Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D850429A4B5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 07:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506797AbgJ0GdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 02:33:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:9347 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506773AbgJ0GdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 02:33:12 -0400
IronPort-SDR: eG+QH3Rw4/3DMufuXHCSYTgNfvNsXaxYPqmfv0u0+n5FEd5dtnaXoNEdfbwVc9hITcxI0DoJ2c
 Zfe61KkMosrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="147317887"
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="147317887"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 23:33:11 -0700
IronPort-SDR: c0pcvM5smIdBXL0iR+fyD6KRHnY1dCAnnMR719911lEylQPFFcxj/JP+EWrpU+/3OMPFWDldCE
 jSeNVGzsMwog==
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="535666749"
Received: from lzhengha-mobl.ccr.corp.intel.com (HELO yhuang-mobile.ccr.corp.intel.com) ([10.254.213.46])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 23:33:10 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>
Subject: [RFC -V4 6/6] autonuma, memory tiering: Add page promotion counter
Date:   Tue, 27 Oct 2020 14:32:17 +0800
Message-Id: <20201027063217.211096-7-ying.huang@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201027063217.211096-1-ying.huang@intel.com>
References: <20201027063217.211096-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To distinguish the number of promotion from the original inter-socket
NUMA balancing migration.  The counter is per-node (target node).
This is to identify imbalance among NUMA nodes.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
---
 include/linux/mmzone.h |  1 +
 mm/migrate.c           | 10 +++++++++-
 mm/vmstat.c            |  1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c10efdc92b17..b384489897b7 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -209,6 +209,7 @@ enum node_stat_item {
 #endif
 #ifdef CONFIG_NUMA_BALANCING
 	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
+	PGPROMOTE_SUCCESS,	/* promote successfully */
 #endif
 	NR_VM_NODE_STAT_ITEMS
 };
diff --git a/mm/migrate.c b/mm/migrate.c
index d8d80b111a6a..0f4106b6c4fe 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2161,8 +2161,13 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 			putback_lru_page(page);
 		}
 		isolated = 0;
-	} else
+	} else {
 		count_vm_numa_event(NUMA_PAGE_MIGRATE);
+		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+		    !node_is_toptier(page_to_nid(page)) && node_is_toptier(node))
+			mod_node_page_state(NODE_DATA(node), PGPROMOTE_SUCCESS,
+					    nr_succeeded);
+	}
 	BUG_ON(!list_empty(&migratepages));
 	return isolated;
 
@@ -2287,6 +2292,9 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	mod_node_page_state(page_pgdat(page),
 			NR_ISOLATED_ANON + page_lru,
 			-HPAGE_PMD_NR);
+	if (!node_is_toptier(page_to_nid(page)) && node_is_toptier(node))
+		mod_node_page_state(NODE_DATA(node), PGPROMOTE_SUCCESS,
+				    HPAGE_PMD_NR);
 	return isolated;
 
 out_fail:
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 2e60cc0232ef..ba5f6f987711 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1217,6 +1217,7 @@ const char * const vmstat_text[] = {
 #endif
 #ifdef CONFIG_NUMA_BALANCING
 	"pgpromote_candidate",
+	"pgpromote_success",
 #endif
 
 	/* enum writeback_stat_item counters */
-- 
2.28.0

