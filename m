Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2237F2B74AA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 04:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgKRDXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 22:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKRDXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 22:23:07 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6802CC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 19:23:07 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id v21so236689pgi.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 19:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=VbxZX7WZligZjkSjsPYjoIiLte2+7MW+ya6moaJXAZc=;
        b=tnHOdOJZRTbSZlzSiQyyUSf3QheUdLAMWcgI49dddOaT/IAJq1FZZpuNDWAAg+5ane
         IdyomdfrMjEJJfLNFpYy4DZcCyeCOw7fNX2/+rtNd/Z0OkPQEILhfU7fVhbDP2YOJCV5
         Y00D6CLcgLtQCGBiyHIcvcaSjHnl0h5xpGzM1A6qwSynmj9RJDnfu3nWnJNqVAbgm/6n
         4LopK7mNTzh2/V/mqPDNsepnS2LD/AcAL0gYf26VEfwDOeUgfpdsLGqV2KnOeHz+QuzX
         pWnA48BAqsVOwBvFZEZPZnkvBs6ngOTerJgDAx7VFA5sDgpj8D8aLJVW4kh80h342U2Z
         niZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=VbxZX7WZligZjkSjsPYjoIiLte2+7MW+ya6moaJXAZc=;
        b=HgG9GOiFKlR1PWxY2LpoXKkGKaoct0Tv+d+YHI2tBdVBfJfo3og6Evj6pWUO2PrMK+
         osmTEGhen+MNEiq48t9qbCNsKF84+wxIYZ2yIOOnZR8cDDyqCOynrcVygQf7hJ44m4JZ
         yeNg5FxSj+S7DAw8kQfw9mZxKKLASKq3DpIRqRcYV43Apr7QULUzBjDsxLMXQeLl0sgI
         VyRLBEs2le4DY+M5Sn/WzLUXedNmiHYzdYhknBBHMoi8JGtIlDxddITsfb8WGY98ogVi
         jcj6KLZC2KMSEY4czbWggkhEYt3bEJ/cdEe8nSackMxo0NbB2y14e3FrsgIdwdXd91w7
         cIng==
X-Gm-Message-State: AOAM533RLnFtNJ5undDxq1UZ1BEEmtHIB3Ua1zEeGpONLnX9F1h1glXM
        PhzMvueHx1r66lIpTAMEbqM=
X-Google-Smtp-Source: ABdhPJx9dLn+FwfoxB4sZt+nr8eOpIqAcpQQWlxMqtCwJxS/NyqIFlb0fmuUP7PhnfnReH70MSZXqw==
X-Received: by 2002:a63:5853:: with SMTP id i19mr6529864pgm.333.1605669787037;
        Tue, 17 Nov 2020 19:23:07 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id f21sm20055197pga.32.2020.11.17.19.23.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 19:23:06 -0800 (PST)
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
X-Google-Original-From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
To:     Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: bail out from psi memstall when cond_resched
Date:   Wed, 18 Nov 2020 11:22:56 +0800
Message-Id: <1605669776-24242-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory reclaiming will run as several seconds in memory constraint system, which
will be deemed as heavy memstall. Have the memory reclaim be more presiced by
bailing out when cond_resched

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/vmscan.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a815f73..a083c85 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -316,6 +316,15 @@ static inline bool memcg_congested(struct pglist_data *pgdat,
 }
 #endif
 
+static inline void psi_cond_resched(void)
+{
+	unsigned long *flags;
+
+	if (current->flags & PF_MEMSTALL)
+		psi_memstall_leave(&flags);
+	cond_resched();
+	psi_memstall_enter(&flags);
+}
 /*
  * This misses isolated pages which are not accounted for to save counters.
  * As the data only determines if reclaim or compaction continues, it is
@@ -557,7 +566,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 		total_scan -= shrinkctl->nr_scanned;
 		scanned += shrinkctl->nr_scanned;
 
-		cond_resched();
+		psi_cond_resched();
 	}
 
 	if (next_deferred >= scanned)
@@ -714,7 +723,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 
 	up_read(&shrinker_rwsem);
 out:
-	cond_resched();
+	psi_cond_resched();
 	return freed;
 }
 
@@ -1109,7 +1118,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 	unsigned nr_reclaimed = 0;
 
 	memset(stat, 0, sizeof(*stat));
-	cond_resched();
+	psi_cond_resched();
 
 	while (!list_empty(page_list)) {
 		struct address_space *mapping;
@@ -1118,7 +1127,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		enum page_references references = PAGEREF_RECLAIM_CLEAN;
 		bool dirty, writeback;
 
-		cond_resched();
+		psi_cond_resched();
 
 		page = lru_to_page(page_list);
 		list_del(&page->lru);
@@ -2084,7 +2093,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	spin_unlock_irq(&pgdat->lru_lock);
 
 	while (!list_empty(&l_hold)) {
-		cond_resched();
+		psi_cond_resched();
 		page = lru_to_page(&l_hold);
 		list_del(&page->lru);
 
@@ -2500,7 +2509,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
 			}
 		}
 
-		cond_resched();
+		psi_cond_resched();
 
 		if (nr_reclaimed < nr_to_reclaim || scan_adjusted)
 			continue;
@@ -4149,7 +4158,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 		.reclaim_idx = gfp_zone(gfp_mask),
 	};
 
-	cond_resched();
+	psi_cond_resched();
 	fs_reclaim_acquire(sc.gfp_mask);
 	/*
 	 * We need to be able to allocate from the reserves for RECLAIM_UNMAP
-- 
1.9.1

