Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C812D7FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 21:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404011AbgLKUX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 15:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393726AbgLKUXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 15:23:04 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52343C06179C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:21:47 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 143so9712116qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ve2Y3KyjfJ0AcyhaSnbcdGlrTS/DXPL0D7g5Z5vXr2k=;
        b=jNxyZJYdVlUEtHJZDtzGthaff6vbf780cJIiunh/MGlWxo+KQJD5PU39v91o0n0xQ6
         BbnmNsO2114VQna2I7ROFYoQJ5ZxF9Gk618hdH0TrsdLFeabM2DKcTB9DscJ2Td1xq+G
         UMoLnniE099PXf6WSCUu0afMNsn8lpbEzcfUM8tJ/6WhGuGWSrMkv6hAvKB+xN9G/m3Q
         PsIipIFEotu9jjGqcZMgzFWJcJ1lcEVPiHinq/CZ1JT95omh8cma5qCXb+S2tFVhzrl0
         G7tiaPKZrxy9Rg6W51BKkZN9rCKRFIi9lW2uc+scX1Cl/zY0BnPOUm6s5lczPanpRkDr
         HnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ve2Y3KyjfJ0AcyhaSnbcdGlrTS/DXPL0D7g5Z5vXr2k=;
        b=aozDnMSuRvPcZNYj6jTAYAIJ7QNdgiSPkguL314LmgYN401EGSTa8LFKr3P9Lyc6B5
         3UxZJzJi/WTnv9XZjEtwIWo6ZjVko2H+Dr+hIECohSYmdcC5X3vsxBNKNx2YhO2a07u/
         A+PhXYieevKyhHBXDqecf8HW1R35JZRtSENnfByBxEOnmy1qqnjUvwht37Efnktpe4aC
         8h05EnD+0oTxx3Q9BgKpPJAwuGOcmJ/lM6gXzpfIojIbIS6mhksicTlcy1yJOc6Onrlw
         ged089kmAGhqkwYu1LDFnmEUhDtshDcdINwIcpSxv6g3bw5x23GHhHeQ5ABkE/7U0wR6
         j8uw==
X-Gm-Message-State: AOAM5301zLsAW1n/+qgFi2CvzqH/UXwqh4iDt1X1b7NjO/MioCH8fLIo
        Di1hzv097AAnsjeZ4Z2WvvlN7g==
X-Google-Smtp-Source: ABdhPJwW9LhE+IEXTVN1QzHVmN5L6rSD9DGH9xIvfUhSPHHBaU8dXdiAb8UWmqgcYwxSXxhbarhP+g==
X-Received: by 2002:ae9:eb8b:: with SMTP id b133mr18039447qkg.399.1607718106567;
        Fri, 11 Dec 2020 12:21:46 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id y192sm8514455qkb.12.2020.12.11.12.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 12:21:45 -0800 (PST)
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
Subject: [PATCH v3 2/6] mm cma: rename PF_MEMALLOC_NOCMA to PF_MEMALLOC_PIN
Date:   Fri, 11 Dec 2020 15:21:36 -0500
Message-Id: <20201211202140.396852-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201211202140.396852-1-pasha.tatashin@soleen.com>
References: <20201211202140.396852-1-pasha.tatashin@soleen.com>
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
index e5ad6d354b7b..f3226ef7134f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1576,7 +1576,7 @@ extern struct pid *cad_pid;
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
-#define PF_MEMALLOC_NOCMA	0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
+#define PF_MEMALLOC_PIN		0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
 #define PF_FREEZER_SKIP		0x40000000	/* Freezer should not count it as freezable */
 #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 1ae08b8462a4..5f4dd3274734 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -270,29 +270,18 @@ static inline void memalloc_noreclaim_restore(unsigned int flags)
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
index 87452fcad048..007060e66a48 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1671,7 +1671,7 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 	long rc;
 
 	if (gup_flags & FOLL_LONGTERM)
-		flags = memalloc_nocma_save();
+		flags = memalloc_pin_save();
 
 	rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas, NULL,
 				     gup_flags);
@@ -1680,7 +1680,7 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 		if (rc > 0)
 			rc = check_and_migrate_cma_pages(mm, start, rc, pages,
 							 vmas, gup_flags);
-		memalloc_nocma_restore(flags);
+		memalloc_pin_restore(flags);
 	}
 	return rc;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3bcc0bc7e02a..012246234eb5 100644
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
index 774542e1483e..ec05396a597b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3808,8 +3808,8 @@ static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
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

