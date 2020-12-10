Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0D22D4FBF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 01:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbgLJAoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 19:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbgLJAoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 19:44:15 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEB3C0611CA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 16:43:45 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id y18so3284151qki.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 16:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=58dOOX3CT4RgbZN4Iw/Ztczf8OW6HingBFIIO3HxvKE=;
        b=QEV+Vv5BZix6tq+rJigcucRn7NtniibHkkvq84g/WGOiHZ+79JPaLLH0XQIJF1YpBn
         jyk4ywwH8Wd4bXSoWUbrxq22Zdp348uDTDbWjKxjrAP4qqQ7uQkJUsgSxIE2dw2Z6kGy
         uNK1FSp+nRR4R17lIUddn8W6RFqwj+d9uTiFbnbDGawrK+6TuQDkbA8uEFNCrkRX99O9
         Hx6YLXr5cvmMQbFxTVby4sz/s8H1f0tIPwltNr+VkP4l39RTg70mZVTc3GwG1/SKvgDg
         59cDntVv6qlbFWagb0yrhikE0LwGD+hvICZVBhETHT09wrSKOZSdz2PGBrAxpfKxOLAC
         j0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58dOOX3CT4RgbZN4Iw/Ztczf8OW6HingBFIIO3HxvKE=;
        b=rZQkCjUJSh9yiCAV7qYq/HnjsuTILKyA7GDtPOvT/ZWIZ02eJx6uRcfMMC0xla91yA
         4fyYBF5Qf02X/VDgm31V8bXaa668nnzrxXWUXE4bCqMVGhm33up7sQP8AVZrRIF1df9d
         MqqpZM62UFqMPO7MP28+AMA1PN+lm5tKFIPaAfILsRclmi3BFxDUrWwMBnoM9KLtf2nK
         QNPQPhUEJ184+14Hgv2o3n/ChXWHpJ0Z3DEyq9MrwrBlyzz9y4IkIo7Y/UdvhQP3TcdW
         ougTYVWP4gGnVDyjIKa4x+SsUrYFmrvM7s1M63k3iqKZInPxF3kjrWg8USUHu8jgDH/n
         riFw==
X-Gm-Message-State: AOAM533l1RYpTeGqARMDq3Ge1k/YGzBlpXa5hzJ0sHq2R9emzjNt/CKw
        +gl6IeMOyYLopz75CO1ycpjYUe5rHLMBp1x2
X-Google-Smtp-Source: ABdhPJxwNDyBJwYij2uBaeo20myfhyZEJi/8ui6ywvr6y8tyrE6/82bqHD4mZ/G5y/YfBxOZbPzsJw==
X-Received: by 2002:a37:a890:: with SMTP id r138mr6153843qke.164.1607561024825;
        Wed, 09 Dec 2020 16:43:44 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id y1sm2538745qky.63.2020.12.09.16.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 16:43:44 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 4/8] mm cma: rename PF_MEMALLOC_NOCMA to PF_MEMALLOC_PIN
Date:   Wed,  9 Dec 2020 19:43:31 -0500
Message-Id: <20201210004335.64634-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210004335.64634-1-pasha.tatashin@soleen.com>
References: <20201210004335.64634-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PF_MEMALLOC_NOCMA is used ot guarantee that the allocator will not return
pages that might belong to CMA region. This is currently used for long
term gup to make sure that such pins are not going to be done on any CMA
pages.

When PF_MEMALLOC_NOCMA has been introduced we haven't realized that it is
focusing on CMA pages too much and that there is larger class of pages that
need the same treatment. MOVABLE zone cannot contain any long term pins as
well so it makes sense to reuse and redefine this flag for that usecase as
well. Rename the flag to PF_MEMALLOC_PIN which defines an allocation
context which can only get pages suitable for long-term pins.

Also re-name:
memalloc_nocma_save()/memalloc_nocma_restore
to
memalloc_pin_save()/memalloc_pin_restore()
and make the new functions common.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/sched.h    |  2 +-
 include/linux/sched/mm.h | 21 +++++----------------
 mm/gup.c                 |  4 ++--
 mm/hugetlb.c             |  4 ++--
 mm/page_alloc.c          |  4 ++--
 5 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 76cd21fa5501..5c4bd5e1cbd8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1548,7 +1548,7 @@ extern struct pid *cad_pid;
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
-#define PF_MEMALLOC_NOCMA	0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
+#define PF_MEMALLOC_PIN		0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
 #define PF_FREEZER_SKIP		0x40000000	/* Freezer should not count it as freezable */
 #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index d5ece7a9a403..a4b5da13d2c6 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -254,29 +254,18 @@ static inline void memalloc_noreclaim_restore(unsigned int flags)
 	current->flags = (current->flags & ~PF_MEMALLOC) | flags;
 }
 
-#ifdef CONFIG_CMA
-static inline unsigned int memalloc_nocma_save(void)
+static inline unsigned int memalloc_pin_save(void)
 {
-	unsigned int flags = current->flags & PF_MEMALLOC_NOCMA;
+	unsigned int flags = current->flags & PF_MEMALLOC_PIN;
 
-	current->flags |= PF_MEMALLOC_NOCMA;
+	current->flags |= PF_MEMALLOC_PIN;
 	return flags;
 }
 
-static inline void memalloc_nocma_restore(unsigned int flags)
+static inline void memalloc_pin_restore(unsigned int flags)
 {
-	current->flags = (current->flags & ~PF_MEMALLOC_NOCMA) | flags;
+	current->flags = (current->flags & ~PF_MEMALLOC_PIN) | flags;
 }
-#else
-static inline unsigned int memalloc_nocma_save(void)
-{
-	return 0;
-}
-
-static inline void memalloc_nocma_restore(unsigned int flags)
-{
-}
-#endif
 
 #ifdef CONFIG_MEMCG
 DECLARE_PER_CPU(struct mem_cgroup *, int_active_memcg);
diff --git a/mm/gup.c b/mm/gup.c
index 0e2de888a8b0..0eb8a85fb704 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1726,7 +1726,7 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 			if (!vmas_tmp)
 				return -ENOMEM;
 		}
-		flags = memalloc_nocma_save();
+		flags = memalloc_pin_save();
 	}
 
 	rc = __get_user_pages_locked(mm, start, nr_pages, pages,
@@ -1749,7 +1749,7 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 		rc = check_and_migrate_cma_pages(mm, start, rc, pages,
 						 vmas_tmp, gup_flags);
 out:
-		memalloc_nocma_restore(flags);
+		memalloc_pin_restore(flags);
 	}
 
 	if (vmas_tmp != vmas)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 37f15c3c24dc..e797b41998ec 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1033,10 +1033,10 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
 static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 {
 	struct page *page;
-	bool nocma = !!(current->flags & PF_MEMALLOC_NOCMA);
+	bool pin = !!(current->flags & PF_MEMALLOC_PIN);
 
 	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
-		if (nocma && is_migrate_cma_page(page))
+		if (pin && is_migrate_cma_page(page))
 			continue;
 
 		if (PageHWPoison(page))
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eaa227a479e4..2dea5600f308 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3772,8 +3772,8 @@ static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
 #ifdef CONFIG_CMA
 	unsigned int pflags = current->flags;
 
-	if (!(pflags & PF_MEMALLOC_NOCMA) &&
-			gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
+	if (!(pflags & PF_MEMALLOC_PIN) &&
+	    gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
 		alloc_flags |= ALLOC_CMA;
 
 #endif
-- 
2.25.1

