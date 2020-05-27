Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B99F1E398F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 08:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgE0GqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 02:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgE0GqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:46:20 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46985C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:46:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ci21so1134430pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LD4nOSV9Q5/nUL44C/nwA6um3iZn7Ive/+WUziLGPFQ=;
        b=BkiAWMaX/I9ujMAoBo6t7L8zCNnJgSCLqQDS5vs1dQa0q9SDl25D+bxceT7rjR5cjk
         420XJQJcVuy/uxn167AfLYIsdzCgKvIS3IpyKUYYPT6DiwXf+yk/jwjnQANKUX/L0j0/
         PhTjmRaM/xBfHDmj7E9dD2lJJW6lS94kGRE7H1uq0fUKPfsMUjCkWGzKI2gTIGWnxWQ+
         hsJcUW1nJIBHa28TjCjqtPRoaNaJrJKPMGqbG5z1jnKOYiJcf2T6jP8WrqvMAgz88edz
         yJVVZGf6OaDp1SQ9Q95TJp/2rxxXBmA3gfQrEEqx7YdyXV7748BNQzA2EzPRpAbTeKfU
         LiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LD4nOSV9Q5/nUL44C/nwA6um3iZn7Ive/+WUziLGPFQ=;
        b=X6o+tIm+NZSRDkQiEoubppBlJG74ZORQMlLWOgQet1ID0daDAD4L7jp7Qws3NKN04S
         Tv6qTHiAwGGbILhdQemHcjF1Ni57y9Wl5NZEbbEYdw/nKTtGfQv8rymcybzXHGZ8wkst
         oC8riy9mYi5RnZ1wFd8VVcdegFkUGOHxKG0/MmLPQYg0h+nAkQUEEHn9iPZtgzaa4YqI
         FMDCb9VcZDO88MrMkLoVlrocFfuMWLEIwZq/7BL5XOAjwkFDMAUViFXwuC25ZeRe3LHX
         TZIWpIXb298jUFJTTJQ0tm/mHrcyK4ZuxoNmPWdG4zhs1kblpsznEP6KPk9LGWjiisKP
         iGaQ==
X-Gm-Message-State: AOAM5337NYqNe8aH9y72vgI2TbtTm7kUqYkqgAy1HpmWT5VhH7qLNDui
        cHIt6nUpAL8PqHAyVn3/2wE=
X-Google-Smtp-Source: ABdhPJyLR8l4BwzvlTmK4b8Jrxc14GaH/BNezIXrH95OxJbBRsyD2RFAL0GVMEGmaMkAKJVTxuFWPw==
X-Received: by 2002:a17:902:4b:: with SMTP id 69mr4196053pla.99.1590561978780;
        Tue, 26 May 2020 23:46:18 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id r13sm443883pgv.50.2020.05.26.23.46.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 23:46:18 -0700 (PDT)
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
Subject: [PATCH v2 11/12] mm/mempolicy: use standard migration target allocation function
Date:   Wed, 27 May 2020 15:45:02 +0900
Message-Id: <1590561903-13186-12-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is no reason to implement it's own function for migration
target allocation. Use standard one.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/internal.h  |  3 ---
 mm/mempolicy.c | 32 +++-----------------------------
 mm/migrate.c   |  3 ++-
 3 files changed, 5 insertions(+), 33 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 6f5d810..82495ee 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -612,9 +612,6 @@ static inline bool is_migrate_highatomic_page(struct page *page)
 }
 
 void setup_zone_pageset(struct zone *zone);
-struct alloc_control;
-extern struct page *alloc_new_node_page(struct page *page,
-				struct alloc_control *ac);
 
 struct alloc_control {
 	int nid;		/* preferred node id */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e50c3eb..27329bdf 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1065,33 +1065,6 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
 	return 0;
 }
 
-/* page allocation callback for NUMA node migration */
-struct page *alloc_new_node_page(struct page *page, struct alloc_control *__ac)
-{
-	if (PageHuge(page)) {
-		struct hstate *h = page_hstate(compound_head(page));
-		struct alloc_control ac = {
-			.nid = __ac->nid,
-			.nmask = NULL,
-			.gfp_mask = __GFP_THISNODE,
-		};
-
-		return alloc_huge_page_nodemask(h, &ac);
-	} else if (PageTransHuge(page)) {
-		struct page *thp;
-
-		thp = alloc_pages_node(__ac->nid,
-			(GFP_TRANSHUGE | __GFP_THISNODE),
-			HPAGE_PMD_ORDER);
-		if (!thp)
-			return NULL;
-		prep_transhuge_page(thp);
-		return thp;
-	} else
-		return __alloc_pages_node(__ac->nid, GFP_HIGHUSER_MOVABLE |
-						    __GFP_THISNODE, 0);
-}
-
 /*
  * Migrate pages from one node to a target node.
  * Returns error or the number of pages not migrated.
@@ -1104,6 +1077,7 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 	int err = 0;
 	struct alloc_control ac = {
 		.nid = dest,
+		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_THISNODE,
 	};
 
 	nodes_clear(nmask);
@@ -1119,8 +1093,8 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
 
 	if (!list_empty(&pagelist)) {
-		err = migrate_pages(&pagelist, alloc_new_node_page, NULL, &ac,
-					MIGRATE_SYNC, MR_SYSCALL);
+		err = migrate_pages(&pagelist, alloc_migration_target, NULL,
+					&ac, MIGRATE_SYNC, MR_SYSCALL);
 		if (err)
 			putback_movable_pages(&pagelist);
 	}
diff --git a/mm/migrate.c b/mm/migrate.c
index 780135a..393f592 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1590,9 +1590,10 @@ static int do_move_pages_to_node(struct mm_struct *mm,
 	int err;
 	struct alloc_control ac = {
 		.nid = node,
+		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_THISNODE,
 	};
 
-	err = migrate_pages(pagelist, alloc_new_node_page, NULL, &ac,
+	err = migrate_pages(pagelist, alloc_migration_target, NULL, &ac,
 			MIGRATE_SYNC, MR_SYSCALL);
 	if (err)
 		putback_movable_pages(pagelist);
-- 
2.7.4

