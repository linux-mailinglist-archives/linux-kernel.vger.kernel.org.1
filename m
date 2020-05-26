Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61431D7139
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 08:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgERGnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 02:43:31 -0400
Received: from foss.arm.com ([217.140.110.172]:34588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgERGnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:43:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D7B6101E;
        Sun, 17 May 2020 23:43:30 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.74.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5A2AD3F305;
        Sun, 17 May 2020 23:43:28 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC V2] mm/vmstat: Add events for PMD based THP migration without split
Date:   Mon, 18 May 2020 12:12:36 +0530
Message-Id: <1589784156-28831-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the following two new VM events which will help in validating PMD
based THP migration without split. Statistics reported through these events
will help in performance debugging.

1. THP_PMD_MIGRATION_SUCCESS
2. THP_PMD_MIGRATION_FAILURE

Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in RFC V2:

- Decopupled and renamed VM events from their implementation per Zi and John
- Added THP_PMD_MIGRATION_FAILURE VM event upon allocation failure and split

Changes in RFC V1: (https://patchwork.kernel.org/patch/11542055/)

 include/linux/vm_event_item.h |  4 ++++
 mm/migrate.c                  | 15 +++++++++++++++
 mm/vmstat.c                   |  4 ++++
 3 files changed, 23 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index ffef0f279747..23d8f9884c2b 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -91,6 +91,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_ZERO_PAGE_ALLOC_FAILED,
 		THP_SWPOUT,
 		THP_SWPOUT_FALLBACK,
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+		THP_PMD_MIGRATION_SUCCESS,
+		THP_PMD_MIGRATION_FAILURE,
+#endif
 #endif
 #ifdef CONFIG_MEMORY_BALLOON
 		BALLOON_INFLATE,
diff --git a/mm/migrate.c b/mm/migrate.c
index 7160c1556f79..5325700a3e90 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1170,6 +1170,18 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 #define ICE_noinline
 #endif
 
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+static inline void thp_migration_success(bool success)
+{
+	if (success)
+		count_vm_event(THP_PMD_MIGRATION_SUCCESS);
+	else
+		count_vm_event(THP_PMD_MIGRATION_FAILURE);
+}
+#else
+static inline void thp_migration_success(bool success) { }
+#endif
+
 /*
  * Obtain the lock on page, remove all ptes and migrate the page
  * to the newly allocated page in newpage.
@@ -1232,6 +1244,8 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 	 * we want to retry.
 	 */
 	if (rc == MIGRATEPAGE_SUCCESS) {
+		if (PageTransHuge(newpage))
+			thp_migration_success(true);
 		put_page(page);
 		if (reason == MR_MEMORY_FAILURE) {
 			/*
@@ -1474,6 +1488,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					unlock_page(page);
 					if (!rc) {
 						list_safe_reset_next(page, page2, lru);
+						thp_migration_success(false);
 						goto retry;
 					}
 				}
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 96d21a792b57..e258c782fd3a 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1274,6 +1274,10 @@ const char * const vmstat_text[] = {
 	"thp_zero_page_alloc_failed",
 	"thp_swpout",
 	"thp_swpout_fallback",
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+	"thp_pmd_migration_success",
+	"thp_pmd_migration_failure",
+#endif
 #endif
 #ifdef CONFIG_MEMORY_BALLOON
 	"balloon_inflate",
-- 
2.20.1

