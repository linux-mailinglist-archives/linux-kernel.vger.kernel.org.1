Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC8A2D7FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 21:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404158AbgLKUYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 15:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394325AbgLKUXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 15:23:05 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BC8C061282
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:21:52 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id k4so7394488qtj.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=e4U32UDa9FIR2WW2M/Hs6yDtPhoxlLQYE5D/fEXlT1M=;
        b=iUm815QkcoXTftgKqSIhU5C+ikvvGNOqTXnuFVw5J64xBIqtebG+lMokASH9kcUIBp
         IFGB8V8vFW3Mcut07z4jqtgdTiL27vE4EMMXVBltu38ndFXMpa79ksrAbcOoUqZy49J0
         Y04RgoYqyGESlmeHBijXULNXYQSdRmImQ5I9OmSeHpapRP7ZpdpxZ3msyXMnkPt34Tmz
         WDBvZc5l4/HgJPn3hStBbYle3W1Dxqu75LDrBuLx/WrMPm26J9qtTA+6Y21Gzk7uUgJE
         n/tQe5RbRe5c6/UiDOQ/OxEXiSH7omB+K5blMmvc7KmsnO6heCloSue5OtJict1nXZnl
         nUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e4U32UDa9FIR2WW2M/Hs6yDtPhoxlLQYE5D/fEXlT1M=;
        b=JLC8UTzCjPvHJo2FmdWN5yIueUq5PvxhBxCxpOvbxsjfHZBVwDEhKV3JzXyeDiGNxH
         EQPYu7NRBPcB0YRyFYlxWB41mwnbwJbXP98oxtrFI3UiX2aWS12pzTbrgPR89ol8jUvn
         VPgd8mHMbRR/TiYV+QjcbLL1xzzvDKat+Nua8+Ujdm+rdvGM/TPrDM9jnwEYYwJ7311n
         rQ7v2JK3F0b5092mntKuMewyYEGn0tBhKvzySYxCOUaoKPURAJAkPOD3c7KCBS2TBIok
         ZUY0EXroTFhuH4sM95pmoe7z1Ndtm6cl9G3YvHw13thjzxe4KoBJCDkpP6NBUCQfeLcB
         OP/g==
X-Gm-Message-State: AOAM531eq9HFQJBvAmejJ1DbA+oHwP0D+yxzpKT59aKTminSxi+PwU/d
        jfcigtyzx6Sq64En4cQ4bSbyfg==
X-Google-Smtp-Source: ABdhPJzRC9ql4OcWj+2zPv8HmJtSEtO8Eo8pfbmlM02Fiu75AvjuOAVQl2FNE4JzXT1uSRx1Fch8Qg==
X-Received: by 2002:ac8:5990:: with SMTP id e16mr18050767qte.52.1607718111263;
        Fri, 11 Dec 2020 12:21:51 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id y192sm8514455qkb.12.2020.12.11.12.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 12:21:50 -0800 (PST)
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
Subject: [PATCH v3 5/6] mm/gup: migrate pinned pages out of movable zone
Date:   Fri, 11 Dec 2020 15:21:39 -0500
Message-Id: <20201211202140.396852-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201211202140.396852-1-pasha.tatashin@soleen.com>
References: <20201211202140.396852-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should not pin pages in ZONE_MOVABLE. Currently, we do not pin only
movable CMA pages. Generalize the function that migrates CMA pages to
migrate all movable pages. Use is_pinnable_page() to check which
pages need to be migrated

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/migrate.h        |  1 +
 include/linux/mmzone.h         | 11 ++++--
 include/trace/events/migrate.h |  3 +-
 mm/gup.c                       | 66 ++++++++++++++--------------------
 4 files changed, 38 insertions(+), 43 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 4594838a0f7c..aae5ef0b3ba1 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -27,6 +27,7 @@ enum migrate_reason {
 	MR_MEMPOLICY_MBIND,
 	MR_NUMA_MISPLACED,
 	MR_CONTIG_RANGE,
+	MR_LONGTERM_PIN,
 	MR_TYPES
 };
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b593316bff3d..25c0c13ba4b1 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -386,9 +386,14 @@ enum zone_type {
 	 * likely to succeed, and to locally limit unmovable allocations - e.g.,
 	 * to increase the number of THP/huge pages. Notable special cases are:
 	 *
-	 * 1. Pinned pages: (long-term) pinning of movable pages might
-	 *    essentially turn such pages unmovable. Memory offlining might
-	 *    retry a long time.
+	 * 1. Pinned pages: (long-term) pinning of movable pages is avoided
+	 *    when pages are pinned and faulted, but it is still possible that
+	 *    address space already has pages in ZONE_MOVABLE at the time when
+	 *    pages are pinned (i.e. user has touches that memory before
+	 *    pinning). In such case we try to migrate them to a different zone,
+	 *    but if migration fails the pages can still end-up pinned in
+	 *    ZONE_MOVABLE. In such case, memory offlining might retry a long
+	 *    time and will only succeed once user application unpins pages.
 	 * 2. memblock allocations: kernelcore/movablecore setups might create
 	 *    situations where ZONE_MOVABLE contains unmovable allocations
 	 *    after boot. Memory offlining and allocations fail early.
diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index 4d434398d64d..363b54ce104c 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -20,7 +20,8 @@
 	EM( MR_SYSCALL,		"syscall_or_cpuset")		\
 	EM( MR_MEMPOLICY_MBIND,	"mempolicy_mbind")		\
 	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
-	EMe(MR_CONTIG_RANGE,	"contig_range")
+	EM( MR_CONTIG_RANGE,	"contig_range")			\
+	EMe(MR_LONGTERM_PIN,	"longterm_pin")
 
 /*
  * First define the enums in the above macros to be exported to userspace
diff --git a/mm/gup.c b/mm/gup.c
index 007060e66a48..d5e9c459952e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -89,11 +89,12 @@ static __maybe_unused struct page *try_grab_compound_head(struct page *page,
 		int orig_refs = refs;
 
 		/*
-		 * Can't do FOLL_LONGTERM + FOLL_PIN with CMA in the gup fast
-		 * path, so fail and let the caller fall back to the slow path.
+		 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
+		 * right zone, so fail and let the caller fall back to the slow
+		 * path.
 		 */
-		if (unlikely(flags & FOLL_LONGTERM) &&
-				is_migrate_cma_page(page))
+		if (unlikely((flags & FOLL_LONGTERM) &&
+			     !is_pinnable_page(page)))
 			return NULL;
 
 		/*
@@ -1549,19 +1550,18 @@ struct page *get_dump_page(unsigned long addr)
 }
 #endif /* CONFIG_ELF_CORE */
 
-#ifdef CONFIG_CMA
-static long check_and_migrate_cma_pages(struct mm_struct *mm,
-					unsigned long start,
-					unsigned long nr_pages,
-					struct page **pages,
-					struct vm_area_struct **vmas,
-					unsigned int gup_flags)
+static long check_and_migrate_movable_pages(struct mm_struct *mm,
+					    unsigned long start,
+					    unsigned long nr_pages,
+					    struct page **pages,
+					    struct vm_area_struct **vmas,
+					    unsigned int gup_flags)
 {
 	unsigned long i;
 	unsigned long step;
 	bool drain_allow = true;
 	bool migrate_allow = true;
-	LIST_HEAD(cma_page_list);
+	LIST_HEAD(movable_page_list);
 	long ret = nr_pages;
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
@@ -1579,13 +1579,12 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 		 */
 		step = compound_nr(head) - (pages[i] - head);
 		/*
-		 * If we get a page from the CMA zone, since we are going to
-		 * be pinning these entries, we might as well move them out
-		 * of the CMA zone if possible.
+		 * If we get a movable page, since we are going to be pinning
+		 * these entries, try to move them out if possible.
 		 */
-		if (is_migrate_cma_page(head)) {
+		if (!is_pinnable_page(head)) {
 			if (PageHuge(head))
-				isolate_huge_page(head, &cma_page_list);
+				isolate_huge_page(head, &movable_page_list);
 			else {
 				if (!PageLRU(head) && drain_allow) {
 					lru_add_drain_all();
@@ -1593,7 +1592,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 				}
 
 				if (!isolate_lru_page(head)) {
-					list_add_tail(&head->lru, &cma_page_list);
+					list_add_tail(&head->lru, &movable_page_list);
 					mod_node_page_state(page_pgdat(head),
 							    NR_ISOLATED_ANON +
 							    page_is_file_lru(head),
@@ -1605,7 +1604,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 		i += step;
 	}
 
-	if (!list_empty(&cma_page_list)) {
+	if (!list_empty(&movable_page_list)) {
 		/*
 		 * drop the above get_user_pages reference.
 		 */
@@ -1615,7 +1614,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 			for (i = 0; i < nr_pages; i++)
 				put_page(pages[i]);
 
-		if (migrate_pages(&cma_page_list, alloc_migration_target, NULL,
+		if (migrate_pages(&movable_page_list, alloc_migration_target, NULL,
 			(unsigned long)&mtc, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
 			/*
 			 * some of the pages failed migration. Do get_user_pages
@@ -1623,17 +1622,16 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 			 */
 			migrate_allow = false;
 
-			if (!list_empty(&cma_page_list))
-				putback_movable_pages(&cma_page_list);
+			if (!list_empty(&movable_page_list))
+				putback_movable_pages(&movable_page_list);
 		}
 		/*
 		 * We did migrate all the pages, Try to get the page references
-		 * again migrating any new CMA pages which we failed to isolate
-		 * earlier.
+		 * again migrating any pages which we failed to isolate earlier.
 		 */
 		ret = __get_user_pages_locked(mm, start, nr_pages,
-						   pages, vmas, NULL,
-						   gup_flags);
+					      pages, vmas, NULL,
+					      gup_flags);
 
 		if ((ret > 0) && migrate_allow) {
 			nr_pages = ret;
@@ -1644,17 +1642,6 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 
 	return ret;
 }
-#else
-static long check_and_migrate_cma_pages(struct mm_struct *mm,
-					unsigned long start,
-					unsigned long nr_pages,
-					struct page **pages,
-					struct vm_area_struct **vmas,
-					unsigned int gup_flags)
-{
-	return nr_pages;
-}
-#endif /* CONFIG_CMA */
 
 /*
  * __gup_longterm_locked() is a wrapper for __get_user_pages_locked which
@@ -1678,8 +1665,9 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 
 	if (gup_flags & FOLL_LONGTERM) {
 		if (rc > 0)
-			rc = check_and_migrate_cma_pages(mm, start, rc, pages,
-							 vmas, gup_flags);
+			rc = check_and_migrate_movable_pages(mm, start, rc,
+							     pages, vmas,
+							     gup_flags);
 		memalloc_pin_restore(flags);
 	}
 	return rc;
-- 
2.25.1

