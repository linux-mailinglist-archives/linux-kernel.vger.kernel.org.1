Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4709C2D4FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 01:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbgLJAot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 19:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730135AbgLJAol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 19:44:41 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA88C0619D2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 16:43:50 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id h20so3310919qkk.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 16:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Qk8rVh1rXtyNOJhKlNnNxraylm8G6DtD3KrN637cCCY=;
        b=fMdVWCNKITv0dg2NlC0bJIuTY/rS0L/auHzJODLG1gJsRMzwg1f2vhMfk8VgTPWFb1
         EGP2rvW7Ddsyis7N9GW7HF9Esuunne9NnIMmaRDqXC6mpUhPIXZ+1ciCTkNDyjdLhx+y
         VfNtVUaQFX50fcEsJqRUZeONp2iOgImfFJ6YSI0zItK+pg6nljFaSVEl5+VMIn5Ju/yi
         Ef6R/VeZqKwv8OkjcphblD65i3nnkN+eM34dHKwtHrfzYg3muPKZwZvlA4vqzv/S06Gv
         nUFwMjeZ3/39YoDQqyquk9o1umGf+i7jw6W4Uz7/oSy7LPLzfaRkrKxMEAWQqIQc0jTU
         aBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qk8rVh1rXtyNOJhKlNnNxraylm8G6DtD3KrN637cCCY=;
        b=GcHuUx0glEPdSw74TCNG8ebJpsnqjTLz+BHlPpB7ZwGr1FcGyPY3f+tliM2d+zgRDx
         W3Jt+Fkh5Mz/5iPRCTAKCOMYpRis8DS6hTUksxYz7Iy7FIjG9fCV2CV05G52icsSa619
         rd0bla1qCMsKgg6AjoUFfuJ33CaI6955GvDL0nm9MW3x2Sr1xfsXvVuBlxhVUNZT01y0
         PFniikJlEjSYYlpXnSTCpHEEzvqY9nmVGh3wZNI2X8sPRBGA2+36yXmwPGdvAJq95e58
         Ua3E6SzSZS6Km5MoALq3EvasB5RtJDhR6jzCTJxdVWg/it5vYiHeTPxh0c22j7any7Z7
         5O0g==
X-Gm-Message-State: AOAM5333SN7UU2MWVqPuC9ZQjF5HXiq/ATw5M2JXWc++yn7+fPVhzTd2
        Xj2THkrvqHd1CfGISLGyR3MQbw==
X-Google-Smtp-Source: ABdhPJy/W1k/3gnadCh/Cym4o8ZSSnpU7JcnD+shVsxXMkusZ00RCHBLY90vQHfYNck7M8GFIweDew==
X-Received: by 2002:a37:aa15:: with SMTP id t21mr6023243qke.86.1607561029865;
        Wed, 09 Dec 2020 16:43:49 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id y1sm2538745qky.63.2020.12.09.16.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 16:43:49 -0800 (PST)
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
Subject: [PATCH v2 7/8] mm/gup: migrate pinned pages out of movable zone
Date:   Wed,  9 Dec 2020 19:43:34 -0500
Message-Id: <20201210004335.64634-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210004335.64634-1-pasha.tatashin@soleen.com>
References: <20201210004335.64634-1-pasha.tatashin@soleen.com>
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
 mm/gup.c                       | 65 ++++++++++++++--------------------
 4 files changed, 37 insertions(+), 43 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 0f8d1583fa8e..00bab23d1ee5 100644
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
index fb3bf696c05e..87a7321b4252 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -405,9 +405,14 @@ enum zone_type {
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
index 0eb8a85fb704..e575237d4c67 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -88,11 +88,12 @@ static __maybe_unused struct page *try_grab_compound_head(struct page *page,
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
@@ -1593,19 +1594,18 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
 }
 #endif
 
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
@@ -1623,13 +1623,12 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
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
@@ -1637,7 +1636,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 				}
 
 				if (!isolate_lru_page(head)) {
-					list_add_tail(&head->lru, &cma_page_list);
+					list_add_tail(&head->lru, &movable_page_list);
 					mod_node_page_state(page_pgdat(head),
 							    NR_ISOLATED_ANON +
 							    page_is_file_lru(head),
@@ -1649,7 +1648,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 		i += step;
 	}
 
-	if (!list_empty(&cma_page_list)) {
+	if (!list_empty(&movable_page_list)) {
 		/*
 		 * drop the above get_user_pages reference.
 		 */
@@ -1659,7 +1658,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 			for (i = 0; i < nr_pages; i++)
 				put_page(pages[i]);
 
-		if (migrate_pages(&cma_page_list, alloc_migration_target, NULL,
+		if (migrate_pages(&movable_page_list, alloc_migration_target, NULL,
 			(unsigned long)&mtc, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
 			/*
 			 * some of the pages failed migration. Do get_user_pages
@@ -1667,17 +1666,16 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
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
@@ -1688,17 +1686,6 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 
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
@@ -1746,8 +1733,8 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 			goto out;
 		}
 
-		rc = check_and_migrate_cma_pages(mm, start, rc, pages,
-						 vmas_tmp, gup_flags);
+		rc = check_and_migrate_movable_pages(mm, start, rc, pages,
+						     vmas_tmp, gup_flags);
 out:
 		memalloc_pin_restore(flags);
 	}
-- 
2.25.1

