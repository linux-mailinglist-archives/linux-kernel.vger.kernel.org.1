Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87F42CB481
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgLBFYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgLBFYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:24:38 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72404C061A48
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 21:23:47 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id t8so656239iov.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 21:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ThlXfcc364FojUO3y5P/ifl4RemTQu3v9eNcTeklg7g=;
        b=V62z5icg0nzFchCWhHxdLHnEZw8ThRBnzwT84W37nOjJNHZaHjOMna6MYZ/5k2l8y0
         iQRgQ3rKIhbf1Y4YPk8dCKgJfeDzOCFNKCLjEf3Tc91smlQ9jjhhQcQ+zZKBSWUI5my7
         wszyyjhQcfu6lxWLgH6v2zovh70tmMPk2eV/kqaskr+T12Z3Ihk834pXeAP/GjoI7mFc
         H+0sCKJYy5tsBosNAupfcsW+nzCuZBmePwqNdzM8MjKpXsYdQWvX629BeG06u5w38qkt
         IQUNHWugAurAIntDBvxS1L+R/jcHhjSvH1j61JJX9UNngu6CPkHJvC7ksf7wb+y7bm5u
         xKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ThlXfcc364FojUO3y5P/ifl4RemTQu3v9eNcTeklg7g=;
        b=GVljOIK2wrmCR/hyFRWRbQusbwzktDgYW2g+XHc4R3FdutLGRbjQw6okErGIb4qA/D
         iN73q4nuRWKNp+OU4a+cgTMFKCNiJuDqGA1n2kDym76Jj85T9Z9J+s4SkeTY1Xse2Ja1
         aulGdnvtTDIS1Y7OGPTESnQpFKszYPXThgmlBXOs6185ae4C6QDIzdpTPsuoi6TDQTO3
         U/fBKDbLE8ryQmomP3gKRL24aT92wkQw5lZzHF6rEhMHQuxsCabPue1NEx8K+RqURv77
         TK44c8wOEWsXaOgwH5ZTdoe8o0H+ibNDi5Vd+a7mWHRy8TEf2jUWyiD4A+MaNynbf+7L
         I14Q==
X-Gm-Message-State: AOAM5326+yHS1WHV/njer8IymZo2aR5atkB+xU1a1bZtEGRip6aULB+b
        XGs3vNvWReQTJ4Pw9mxoyZZXTw==
X-Google-Smtp-Source: ABdhPJzTLoCZReLgz51Hrk6XAF0pPmsQoEP7xNffwdXB4knjafqxqpMOhwLiaadyI7uMnqTjiR/W9g==
X-Received: by 2002:a05:6602:2209:: with SMTP id n9mr605230ion.181.1606886626860;
        Tue, 01 Dec 2020 21:23:46 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m19sm295938ila.81.2020.12.01.21.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 21:23:46 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com
Subject: [PATCH 6/6] mm/gup: migrate pinned pages out of movable zone
Date:   Wed,  2 Dec 2020 00:23:30 -0500
Message-Id: <20201202052330.474592-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202052330.474592-1-pasha.tatashin@soleen.com>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not allocate pin pages in ZONE_MOVABLE, but if pages were already
allocated before pinning they need to migrated to a different zone.
Currently, we migrate movable CMA pages only. Generalize the function
that migrates CMA pages to migrate all movable pages.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/migrate.h        |  1 +
 include/trace/events/migrate.h |  3 +-
 mm/gup.c                       | 56 +++++++++++++---------------------
 3 files changed, 24 insertions(+), 36 deletions(-)

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
index 724d8a65e1df..1d511f65f8a7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1593,19 +1593,18 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
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
+	LIST_HEAD(page_list);
 	long ret = nr_pages;
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
@@ -1623,13 +1622,12 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
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
+		if (is_migrate_movable(get_pageblock_migratetype(head))) {
 			if (PageHuge(head))
-				isolate_huge_page(head, &cma_page_list);
+				isolate_huge_page(head, &page_list);
 			else {
 				if (!PageLRU(head) && drain_allow) {
 					lru_add_drain_all();
@@ -1637,7 +1635,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 				}
 
 				if (!isolate_lru_page(head)) {
-					list_add_tail(&head->lru, &cma_page_list);
+					list_add_tail(&head->lru, &page_list);
 					mod_node_page_state(page_pgdat(head),
 							    NR_ISOLATED_ANON +
 							    page_is_file_lru(head),
@@ -1649,7 +1647,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 		i += step;
 	}
 
-	if (!list_empty(&cma_page_list)) {
+	if (!list_empty(&page_list)) {
 		/*
 		 * drop the above get_user_pages reference.
 		 */
@@ -1659,7 +1657,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 			for (i = 0; i < nr_pages; i++)
 				put_page(pages[i]);
 
-		if (migrate_pages(&cma_page_list, alloc_migration_target, NULL,
+		if (migrate_pages(&page_list, alloc_migration_target, NULL,
 			(unsigned long)&mtc, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
 			/*
 			 * some of the pages failed migration. Do get_user_pages
@@ -1667,17 +1665,16 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 			 */
 			migrate_allow = false;
 
-			if (!list_empty(&cma_page_list))
-				putback_movable_pages(&cma_page_list);
+			if (!list_empty(&page_list))
+				putback_movable_pages(&page_list);
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
@@ -1688,17 +1685,6 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 
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
@@ -1746,8 +1732,8 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 			goto out;
 		}
 
-		rc = check_and_migrate_cma_pages(mm, start, rc, pages,
-						 vmas_tmp, gup_flags);
+		rc = check_and_migrate_movable_pages(mm, start, rc, pages,
+						     vmas_tmp, gup_flags);
 out:
 		memalloc_nomovable_restore(flags);
 	}
-- 
2.25.1

