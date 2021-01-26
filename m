Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D87530314F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 02:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbhAZBcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 20:32:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:22974 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731495AbhAZBaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:30:21 -0500
IronPort-SDR: scPRWOXqBMoU7SF43+wpW1KwE1h/ZFzh6i8nM8d3oywKWTmtVu6NYxegB5U9n6DSQ6epTieB+k
 1fh/BQvdjFHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="166926623"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="166926623"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 16:41:45 -0800
IronPort-SDR: 2D6hzaYzNeix4aXG0vjo4bfLR6rV4dbyAABH9qErRl+o/h/m6KqoOPU+NeuJbo/vvApMGSB5n9
 oA5WoE5CxSUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="409948383"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jan 2021 16:41:45 -0800
Subject: [RFC][PATCH 07/13] mm/migrate: make migrate_pages() return nr_succeeded
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com,
        osalvador@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 25 Jan 2021 16:34:25 -0800
References: <20210126003411.2AC51464@viggo.jf.intel.com>
In-Reply-To: <20210126003411.2AC51464@viggo.jf.intel.com>
Message-Id: <20210126003425.038B4812@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Yang Shi <yang.shi@linux.alibaba.com>

The migrate_pages() returns the number of pages that were not migrated,
or an error code.  When returning an error code, there is no way to know
how many pages were migrated or not migrated.

In the following patch, migrate_pages() is used to demote pages to PMEM
node, we need account how many pages are reclaimed (demoted) since page
reclaim behavior depends on this.  Add *nr_succeeded parameter to make
migrate_pages() return how many pages are demoted successfully for all
cases.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>
---

 b/include/linux/migrate.h |    5 +++--
 b/mm/compaction.c         |    3 ++-
 b/mm/gup.c                |    4 +++-
 b/mm/memory-failure.c     |    4 +++-
 b/mm/memory_hotplug.c     |    4 +++-
 b/mm/mempolicy.c          |    8 ++++++--
 b/mm/migrate.c            |   17 ++++++++++-------
 b/mm/page_alloc.c         |    9 ++++++---
 8 files changed, 36 insertions(+), 18 deletions(-)

diff -puN include/linux/migrate.h~migrate_pages-add-success-return include/linux/migrate.h
--- a/include/linux/migrate.h~migrate_pages-add-success-return	2021-01-25 16:23:12.931866701 -0800
+++ b/include/linux/migrate.h	2021-01-25 16:23:12.954866701 -0800
@@ -40,7 +40,8 @@ extern int migrate_page(struct address_s
 			struct page *newpage, struct page *page,
 			enum migrate_mode mode);
 extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
-		unsigned long private, enum migrate_mode mode, int reason);
+		unsigned long private, enum migrate_mode mode, int reason,
+		unsigned int *nr_succeeded);
 extern struct page *alloc_migration_target(struct page *page, unsigned long private);
 extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 extern void putback_movable_page(struct page *page);
@@ -58,7 +59,7 @@ extern int migrate_page_move_mapping(str
 static inline void putback_movable_pages(struct list_head *l) {}
 static inline int migrate_pages(struct list_head *l, new_page_t new,
 		free_page_t free, unsigned long private, enum migrate_mode mode,
-		int reason)
+		int reason, unsigned int *nr_succeeded)
 	{ return -ENOSYS; }
 static inline struct page *alloc_migration_target(struct page *page,
 		unsigned long private)
diff -puN mm/compaction.c~migrate_pages-add-success-return mm/compaction.c
--- a/mm/compaction.c~migrate_pages-add-success-return	2021-01-25 16:23:12.933866701 -0800
+++ b/mm/compaction.c	2021-01-25 16:23:12.956866701 -0800
@@ -2199,6 +2199,7 @@ compact_zone(struct compact_control *cc,
 	unsigned long last_migrated_pfn;
 	const bool sync = cc->mode != MIGRATE_ASYNC;
 	bool update_cached;
+	unsigned int nr_succeeded = 0;
 
 	/*
 	 * These counters track activities during zone compaction.  Initialize
@@ -2317,7 +2318,7 @@ compact_zone(struct compact_control *cc,
 
 		err = migrate_pages(&cc->migratepages, compaction_alloc,
 				compaction_free, (unsigned long)cc, cc->mode,
-				MR_COMPACTION);
+				MR_COMPACTION, &nr_succeeded);
 
 		trace_mm_compaction_migratepages(cc->nr_migratepages, err,
 							&cc->migratepages);
diff -puN mm/gup.c~migrate_pages-add-success-return mm/gup.c
--- a/mm/gup.c~migrate_pages-add-success-return	2021-01-25 16:23:12.935866701 -0800
+++ b/mm/gup.c	2021-01-25 16:23:12.957866701 -0800
@@ -1599,6 +1599,7 @@ static long check_and_migrate_cma_pages(
 	unsigned long step;
 	bool drain_allow = true;
 	bool migrate_allow = true;
+	unsigned int nr_succeeded = 0;
 	LIST_HEAD(cma_page_list);
 	long ret = nr_pages;
 	struct migration_target_control mtc = {
@@ -1654,7 +1655,8 @@ check_again:
 				put_page(pages[i]);
 
 		if (migrate_pages(&cma_page_list, alloc_migration_target, NULL,
-			(unsigned long)&mtc, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
+			(unsigned long)&mtc, MIGRATE_SYNC, MR_CONTIG_RANGE,
+				  &nr_succeeded)) {
 			/*
 			 * some of the pages failed migration. Do get_user_pages
 			 * without migration.
diff -puN mm/memory-failure.c~migrate_pages-add-success-return mm/memory-failure.c
--- a/mm/memory-failure.c~migrate_pages-add-success-return	2021-01-25 16:23:12.939866701 -0800
+++ b/mm/memory-failure.c	2021-01-25 16:23:12.959866701 -0800
@@ -1783,6 +1783,7 @@ static int __soft_offline_page(struct pa
 	unsigned long pfn = page_to_pfn(page);
 	struct page *hpage = compound_head(page);
 	char const *msg_page[] = {"page", "hugepage"};
+	unsigned int nr_succeeded = 0;
 	bool huge = PageHuge(page);
 	LIST_HEAD(pagelist);
 	struct migration_target_control mtc = {
@@ -1826,7 +1827,8 @@ static int __soft_offline_page(struct pa
 
 	if (isolate_page(hpage, &pagelist)) {
 		ret = migrate_pages(&pagelist, alloc_migration_target, NULL,
-			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_FAILURE);
+			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_FAILURE,
+			&nr_succeeded);
 		if (!ret) {
 			bool release = !huge;
 
diff -puN mm/memory_hotplug.c~migrate_pages-add-success-return mm/memory_hotplug.c
--- a/mm/memory_hotplug.c~migrate_pages-add-success-return	2021-01-25 16:23:12.941866701 -0800
+++ b/mm/memory_hotplug.c	2021-01-25 16:23:12.959866701 -0800
@@ -1278,6 +1278,7 @@ do_migrate_range(unsigned long start_pfn
 	unsigned long pfn;
 	struct page *page, *head;
 	int ret = 0;
+	unsigned int nr_succeeded = 0;
 	LIST_HEAD(source);
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
@@ -1352,7 +1353,8 @@ do_migrate_range(unsigned long start_pfn
 		if (nodes_empty(nmask))
 			node_set(mtc.nid, nmask);
 		ret = migrate_pages(&source, alloc_migration_target, NULL,
-			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
+			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG,
+			&nr_succeeded);
 		if (ret) {
 			list_for_each_entry(page, &source, lru) {
 				pr_warn("migrating pfn %lx failed ret:%d ",
diff -puN mm/mempolicy.c~migrate_pages-add-success-return mm/mempolicy.c
--- a/mm/mempolicy.c~migrate_pages-add-success-return	2021-01-25 16:23:12.944866701 -0800
+++ b/mm/mempolicy.c	2021-01-25 16:23:12.960866701 -0800
@@ -1071,6 +1071,7 @@ static int migrate_page_add(struct page
 static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 			   int flags)
 {
+	unsigned int nr_succeeded = 0;
 	nodemask_t nmask;
 	LIST_HEAD(pagelist);
 	int err = 0;
@@ -1093,7 +1094,8 @@ static int migrate_to_node(struct mm_str
 
 	if (!list_empty(&pagelist)) {
 		err = migrate_pages(&pagelist, alloc_migration_target, NULL,
-				(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
+				(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL,
+				&nr_succeeded);
 		if (err)
 			putback_movable_pages(&pagelist);
 	}
@@ -1270,6 +1272,7 @@ static long do_mbind(unsigned long start
 		     nodemask_t *nmask, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
+	unsigned int nr_succeeded = 0;
 	struct mempolicy *new;
 	unsigned long end;
 	int err;
@@ -1349,7 +1352,8 @@ static long do_mbind(unsigned long start
 		if (!list_empty(&pagelist)) {
 			WARN_ON_ONCE(flags & MPOL_MF_LAZY);
 			nr_failed = migrate_pages(&pagelist, new_page, NULL,
-				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND);
+				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND,
+				&nr_succeeded);
 			if (nr_failed)
 				putback_movable_pages(&pagelist);
 		}
diff -puN mm/migrate.c~migrate_pages-add-success-return mm/migrate.c
--- a/mm/migrate.c~migrate_pages-add-success-return	2021-01-25 16:23:12.947866701 -0800
+++ b/mm/migrate.c	2021-01-25 16:23:12.964866701 -0800
@@ -1432,6 +1432,7 @@ out:
  * @mode:		The migration mode that specifies the constraints for
  *			page migration, if any.
  * @reason:		The reason for page migration.
+ * @nr_succeeded:	The number of pages migrated successfully.
  *
  * The function returns after 10 attempts or if no pages are movable any more
  * because the list has become empty or no retryable pages exist any more.
@@ -1442,12 +1443,11 @@ out:
  */
 int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		free_page_t put_new_page, unsigned long private,
-		enum migrate_mode mode, int reason)
+		enum migrate_mode mode, int reason, unsigned int *nr_succeeded)
 {
 	int retry = 1;
 	int thp_retry = 1;
 	int nr_failed = 0;
-	int nr_succeeded = 0;
 	int nr_thp_succeeded = 0;
 	int nr_thp_failed = 0;
 	int nr_thp_split = 0;
@@ -1527,7 +1527,7 @@ retry:
 					nr_succeeded += nr_subpages;
 					break;
 				}
-				nr_succeeded++;
+				(*nr_succeeded)++;
 				break;
 			default:
 				/*
@@ -1550,12 +1550,12 @@ retry:
 	nr_thp_failed += thp_retry;
 	rc = nr_failed;
 out:
-	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
+	count_vm_events(PGMIGRATE_SUCCESS, *nr_succeeded);
 	count_vm_events(PGMIGRATE_FAIL, nr_failed);
 	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
 	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
 	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
-	trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
+	trace_mm_migrate_pages(*nr_succeeded, nr_failed, nr_thp_succeeded,
 			       nr_thp_failed, nr_thp_split, mode, reason);
 
 	if (!swapwrite)
@@ -1623,6 +1623,7 @@ static int store_status(int __user *stat
 static int do_move_pages_to_node(struct mm_struct *mm,
 		struct list_head *pagelist, int node)
 {
+	unsigned int nr_succeeded = 0;
 	int err;
 	struct migration_target_control mtc = {
 		.nid = node,
@@ -1630,7 +1631,8 @@ static int do_move_pages_to_node(struct
 	};
 
 	err = migrate_pages(pagelist, alloc_migration_target, NULL,
-			(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
+			(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL,
+			&nr_succeeded);
 	if (err)
 		putback_movable_pages(pagelist);
 	return err;
@@ -2103,6 +2105,7 @@ int migrate_misplaced_page(struct page *
 	pg_data_t *pgdat = NODE_DATA(node);
 	int isolated;
 	int nr_remaining;
+	unsigned int nr_succeeded = 0;
 	LIST_HEAD(migratepages);
 
 	/*
@@ -2127,7 +2130,7 @@ int migrate_misplaced_page(struct page *
 	list_add(&page->lru, &migratepages);
 	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_page,
 				     NULL, node, MIGRATE_ASYNC,
-				     MR_NUMA_MISPLACED);
+				     MR_NUMA_MISPLACED, &nr_succeeded);
 	if (nr_remaining) {
 		if (!list_empty(&migratepages)) {
 			list_del(&page->lru);
diff -puN mm/page_alloc.c~migrate_pages-add-success-return mm/page_alloc.c
--- a/mm/page_alloc.c~migrate_pages-add-success-return	2021-01-25 16:23:12.950866701 -0800
+++ b/mm/page_alloc.c	2021-01-25 16:23:12.968866701 -0800
@@ -8401,7 +8401,8 @@ static unsigned long pfn_max_align_up(un
 
 /* [start, end) must belong to a single zone. */
 static int __alloc_contig_migrate_range(struct compact_control *cc,
-					unsigned long start, unsigned long end)
+					unsigned long start, unsigned long end,
+					unsigned int *nr_succeeded)
 {
 	/* This function is based on compact_zone() from compaction.c. */
 	unsigned int nr_reclaimed;
@@ -8439,7 +8440,8 @@ static int __alloc_contig_migrate_range(
 		cc->nr_migratepages -= nr_reclaimed;
 
 		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
-				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
+				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE,
+				nr_succeeded);
 	}
 	if (ret < 0) {
 		putback_movable_pages(&cc->migratepages);
@@ -8475,6 +8477,7 @@ int alloc_contig_range(unsigned long sta
 	unsigned long outer_start, outer_end;
 	unsigned int order;
 	int ret = 0;
+	unsigned int nr_succeeded = 0;
 
 	struct compact_control cc = {
 		.nr_migratepages = 0,
@@ -8527,7 +8530,7 @@ int alloc_contig_range(unsigned long sta
 	 * allocated.  So, if we fall through be sure to clear ret so that
 	 * -EBUSY is not accidentally used or returned to caller.
 	 */
-	ret = __alloc_contig_migrate_range(&cc, start, end);
+	ret = __alloc_contig_migrate_range(&cc, start, end, &nr_succeeded);
 	if (ret && ret != -EBUSY)
 		goto done;
 	ret =0;
_
