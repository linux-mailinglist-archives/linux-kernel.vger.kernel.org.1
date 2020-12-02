Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC8D2CB480
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgLBFYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbgLBFY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:24:29 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F3CC061A04
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 21:23:43 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id r9so660622ioo.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 21:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=g7jlxchzUs1d/FAinzhFIBtXsEXm4/sR0Ksg9506XeU=;
        b=meUVIcZ7VIwMwi/cSom/+PXH6JMZqXpsyjjZQDUQ/m2V8lTEGR/Xnc9mVxGajJjhrf
         jgQhs6/zs4jSQ1U5xiP9cW03Sw+roeWUp0y+nkybRZWDIYj7WV5OcREAO8t/heQxUry+
         T0PqrWC9kOiss9r+kGTzNB2z5IJFAt/PldzCsqwSvxYzivAxrnwNtpxZNaeaj0+82dmv
         uGBAO+JvNdn6SI/xfB5Zd9QY3FyAXBOdZIx2R2M47RNH/OaL4/bBOa7eaaPfiYCjjpWq
         Hob4bVHEvTwZCP3+PkoobH8NM5uJEJvD4eDzobDO4QspUslLUtbdKa4Brr+Z0MMFmE4h
         fB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7jlxchzUs1d/FAinzhFIBtXsEXm4/sR0Ksg9506XeU=;
        b=k+VvZxHCqnuYtciZXdGuHuXm1RrkdSjXbm+mTycwx5uJr0BK5fcbFk7jw/uGp63Fr8
         7QJYu9mZHtmvdlTx8+I9zbacqYr+bfLDPu7754U91Y74d2B03gHPMmX8gx+1XNJBsKWE
         6SnBJfkRv1LvWhv5tm7gUfh6SNY/MJK5euombT6MHyeb3t6BGUQiKyd4zRG77e9vFmsz
         7zp1B31YifW7co3/oiKhieXzNMZzM8cheJcyxFzrT32iv/0b+YcC06kfjvUz4bv4ChiO
         ADWv6UNDHTAUPTHl2qWPm0DiCakUW1IsVOYdEw11SOGw7gpelQKeo9vQsAQnyp9qvUts
         zSTg==
X-Gm-Message-State: AOAM533UdHx6GNkeplPE4F7sEbQQ+riAFOToDS4rbFFke0dOceO3OES0
        BXTybZDjHPAE4NRZ+Y0Bak/AxA==
X-Google-Smtp-Source: ABdhPJw9L/9TB6Ptmk4hotjOfiKYRmPmEApH/Fplhyapd+mf1leuXaR7xRyhfGACderI/wunhOfXZg==
X-Received: by 2002:a05:6638:50c:: with SMTP id i12mr742702jar.74.1606886622709;
        Tue, 01 Dec 2020 21:23:42 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m19sm295938ila.81.2020.12.01.21.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 21:23:42 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com
Subject: [PATCH 4/6] mm cma: rename PF_MEMALLOC_NOCMA to PF_MEMALLOC_NOMOVABLE
Date:   Wed,  2 Dec 2020 00:23:28 -0500
Message-Id: <20201202052330.474592-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202052330.474592-1-pasha.tatashin@soleen.com>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PF_MEMALLOC_NOCMA is used for longterm pinning and has an effect of
clearing _GFP_MOVABLE or prohibiting allocations from ZONE_MOVABLE.

We will prohibit allocating any pages that are getting
longterm pinned from ZONE_MOVABLE, and we would want to unify and re-use
this flag. So, rename it to generic PF_MEMALLOC_NOMOVABLE.
Also re-name:
memalloc_nocma_save()/memalloc_nocma_restore
to
memalloc_nomovable_save()/memalloc_nomovable_restore()
and make the new functions common.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/sched.h    |  2 +-
 include/linux/sched/mm.h | 21 +++++----------------
 mm/gup.c                 |  4 ++--
 mm/hugetlb.c             |  4 ++--
 mm/page_alloc.c          |  4 ++--
 5 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 76cd21fa5501..f1bf05f5f5fa 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1548,7 +1548,7 @@ extern struct pid *cad_pid;
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
-#define PF_MEMALLOC_NOCMA	0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
+#define PF_MEMALLOC_NOMOVABLE	0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
 #define PF_FREEZER_SKIP		0x40000000	/* Freezer should not count it as freezable */
 #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index d5ece7a9a403..5bb9a6b69479 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -254,29 +254,18 @@ static inline void memalloc_noreclaim_restore(unsigned int flags)
 	current->flags = (current->flags & ~PF_MEMALLOC) | flags;
 }
 
-#ifdef CONFIG_CMA
-static inline unsigned int memalloc_nocma_save(void)
+static inline unsigned int memalloc_nomovable_save(void)
 {
-	unsigned int flags = current->flags & PF_MEMALLOC_NOCMA;
+	unsigned int flags = current->flags & PF_MEMALLOC_NOMOVABLE;
 
-	current->flags |= PF_MEMALLOC_NOCMA;
+	current->flags |= PF_MEMALLOC_NOMOVABLE;
 	return flags;
 }
 
-static inline void memalloc_nocma_restore(unsigned int flags)
+static inline void memalloc_nomovable_restore(unsigned int flags)
 {
-	current->flags = (current->flags & ~PF_MEMALLOC_NOCMA) | flags;
+	current->flags = (current->flags & ~PF_MEMALLOC_NOMOVABLE) | flags;
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
index 0e2de888a8b0..724d8a65e1df 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1726,7 +1726,7 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 			if (!vmas_tmp)
 				return -ENOMEM;
 		}
-		flags = memalloc_nocma_save();
+		flags = memalloc_nomovable_save();
 	}
 
 	rc = __get_user_pages_locked(mm, start, nr_pages, pages,
@@ -1749,7 +1749,7 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 		rc = check_and_migrate_cma_pages(mm, start, rc, pages,
 						 vmas_tmp, gup_flags);
 out:
-		memalloc_nocma_restore(flags);
+		memalloc_nomovable_restore(flags);
 	}
 
 	if (vmas_tmp != vmas)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 37f15c3c24dc..02213c74ed6b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1033,10 +1033,10 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
 static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 {
 	struct page *page;
-	bool nocma = !!(current->flags & PF_MEMALLOC_NOCMA);
+	bool nomovable = !!(current->flags & PF_MEMALLOC_NOMOVABLE);
 
 	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
-		if (nocma && is_migrate_cma_page(page))
+		if (nomovable && is_migrate_cma_page(page))
 			continue;
 
 		if (PageHWPoison(page))
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eaa227a479e4..611799c72da5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3772,8 +3772,8 @@ static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
 #ifdef CONFIG_CMA
 	unsigned int pflags = current->flags;
 
-	if (!(pflags & PF_MEMALLOC_NOCMA) &&
-			gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
+	if (!(pflags & PF_MEMALLOC_NOMOVABLE) &&
+	    gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
 		alloc_flags |= ALLOC_CMA;
 
 #endif
-- 
2.25.1

