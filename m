Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A282167AF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 09:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgGGHpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 03:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgGGHpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:45:36 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71F3C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 00:45:36 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e8so19630757pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 00:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JREELX005WpRXb73w0JtV5PhDqNNv1F/EVctlbeQmTE=;
        b=f4sx6BvZ+581C+xa5MZ1bi5iz0cs2DtAB3sGsqj40LqP3WuYPyyfKMarja8129+yFA
         RvXbLlA3STRqCTIr/h5t8vcyYTtxIGYFubNpGFnwO6O+JEaYqRk37f9TED34q1DTZVth
         FbirWZdShwrEtSvPBqrwCu22UTiZbldD45kzIHT1oH8pHAGDV9T1QgXh9St+kL3FS1Bc
         hOp9qtt0KG8ksVOHKRuwmOumfYwhf58fc05v54WCE+esXszvICYs/Dp5/qk/9H7tqZUt
         ON6VnIcYoXMM9NXMNtc4OVHISJ/0K0f8ivLMlR0/PiZU0U5CAXhEW0JcN76aZZpSatm3
         yN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JREELX005WpRXb73w0JtV5PhDqNNv1F/EVctlbeQmTE=;
        b=HmaA12yr7Im3X9/bbacrHfx0ILYnn5W7nT2eJ4uqVPK4RF+WWzBqF3V9HM1uyx9x9t
         gxBQA/FdLyRTdMqpjWfdeNctWklujV6zSmR/GMl+X8o46IWycppNlJ6H5lGEwxuUhwar
         rFqxnZXAxy2WmUtrinGXCcHoEmNSAq7iqrUUqFVPzHtnnDytSRpYQFS6fFfhDwQeZq8c
         wIuBDCSU3bTn07BDQufMp7xvhQ5JVRplF67EDcUM2yJLFjq1mad4+p/MyBx9JMVmhv3S
         Ka7hmFp0GUHuvwoDUwtWsv240lQaWP1FfA3CKY3dkl03rsYwTrBZFpUqipFAK4h77jf2
         2img==
X-Gm-Message-State: AOAM5326hN7uHYl+eZ4yei6YPQPAJv/vJwuvhNORkIYKSlM0UB9mzDF1
        ETs342K4Hy2z47hdnbstJw9Ny+yw
X-Google-Smtp-Source: ABdhPJyFBvzhDiXcrh5tQrtq9cTzCrIXfD0xjKrVR7jyJKrJMbNqWvZPkjntb3GJSlKTTv84tOn7CA==
X-Received: by 2002:a65:6706:: with SMTP id u6mr43598298pgf.69.1594107936274;
        Tue, 07 Jul 2020 00:45:36 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id 191sm21330151pfw.150.2020.07.07.00.45.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 00:45:35 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v4 08/11] mm/mempolicy: use a standard migration target allocation callback
Date:   Tue,  7 Jul 2020 16:44:46 +0900
Message-Id: <1594107889-32228-9-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is a well-defined migration target allocation callback.  Use it.

Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/internal.h  |  1 -
 mm/mempolicy.c | 31 ++++++-------------------------
 mm/migrate.c   |  8 ++++++--
 3 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 3236fef..6205d8a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -613,7 +613,6 @@ static inline bool is_migrate_highatomic_page(struct page *page)
 }
 
 void setup_zone_pageset(struct zone *zone);
-extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
 
 struct migration_target_control {
 	int nid;		/* preferred node id */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 667b453..93fcfc1 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1065,29 +1065,6 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
 	return 0;
 }
 
-/* page allocation callback for NUMA node migration */
-struct page *alloc_new_node_page(struct page *page, unsigned long node)
-{
-	if (PageHuge(page)) {
-		struct hstate *h = page_hstate(compound_head(page));
-		gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
-
-		return alloc_huge_page_nodemask(h, node, NULL, gfp_mask, false);
-	} else if (PageTransHuge(page)) {
-		struct page *thp;
-
-		thp = alloc_pages_node(node,
-			(GFP_TRANSHUGE | __GFP_THISNODE),
-			HPAGE_PMD_ORDER);
-		if (!thp)
-			return NULL;
-		prep_transhuge_page(thp);
-		return thp;
-	} else
-		return __alloc_pages_node(node, GFP_HIGHUSER_MOVABLE |
-						    __GFP_THISNODE, 0);
-}
-
 /*
  * Migrate pages from one node to a target node.
  * Returns error or the number of pages not migrated.
@@ -1098,6 +1075,10 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 	nodemask_t nmask;
 	LIST_HEAD(pagelist);
 	int err = 0;
+	struct migration_target_control mtc = {
+		.nid = dest,
+		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_THISNODE,
+	};
 
 	nodes_clear(nmask);
 	node_set(source, nmask);
@@ -1112,8 +1093,8 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
 
 	if (!list_empty(&pagelist)) {
-		err = migrate_pages(&pagelist, alloc_new_node_page, NULL, dest,
-					MIGRATE_SYNC, MR_SYSCALL);
+		err = migrate_pages(&pagelist, alloc_migration_target, NULL,
+				(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
 		if (err)
 			putback_movable_pages(&pagelist);
 	}
diff --git a/mm/migrate.c b/mm/migrate.c
index ab18b9c..b7eac38 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1599,9 +1599,13 @@ static int do_move_pages_to_node(struct mm_struct *mm,
 		struct list_head *pagelist, int node)
 {
 	int err;
+	struct migration_target_control mtc = {
+		.nid = node,
+		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_THISNODE,
+	};
 
-	err = migrate_pages(pagelist, alloc_new_node_page, NULL, node,
-			MIGRATE_SYNC, MR_SYSCALL);
+	err = migrate_pages(pagelist, alloc_migration_target, NULL,
+			(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
 	if (err)
 		putback_movable_pages(pagelist);
 	return err;
-- 
2.7.4

