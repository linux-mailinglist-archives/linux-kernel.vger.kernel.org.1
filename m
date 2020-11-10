Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F148F2ADDEF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgKJSPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731221AbgKJSNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:13:06 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8FAC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:13:06 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c20so12159212pfr.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w/5/DKL41ubRzJ/0MsKC6N7liZIas0t4NHg8fh0y8+o=;
        b=NAfJXPjiMWTtwfhbG9naf/w6U8KyJ/t848F3Iw4AZzgF25FMqWojzAYfNRgl/xGUvP
         Vy0e2dzmt51qvj7ISeTPzk/djTw0OtsDeUvuJ/FjjAqGgo75RHrMa/aDgcZIsbnOyLQy
         ayMyu8SRR0c9e/DBI4GaITPL9fYFSQrCI86oXXz9EeP+6ViYuwf078Pc9mSu1fP0gtz4
         sHu585Amit/hGacdaRBeaxNgP/uQTuX242VUcKTwKEobSzzrZ6I1D9zBCTsHSFGdDGe2
         8Lm8iyCSHzcbAXmW/vKK71mVL1ddwHn2DpTgEidkKeFqJQl1gL/urfGOPPLa/Vz0OHtT
         jbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w/5/DKL41ubRzJ/0MsKC6N7liZIas0t4NHg8fh0y8+o=;
        b=rON7cnCfjIGraUbd4MSNvQm234V1nZFTW+/vt3+SSJMouAAYIr7d0JtJnsSHN+Q8qt
         JYO/6+TSN5RFhqMGQXXGpOJYiSvcqOY5zLD5m7gYMntGzY03nnfdV6gggqAZBALHmkW8
         4D1sN5fBwiWKRfTH9gaoCrTsm+C3L24UXjgy2+X78DwZebyT9AUSaBqKNpCUN0DBTYbi
         SbbE/idVBGGegzo+ws5Zu5dDZDuBUDGh/dp+DpoJDD81uioape52aSFJ21pJXyCY7D/K
         GC0r1dlnTAaqaWphgSidSV1hjGqnlsOK5VbvgZCxZh/KqgvFK/U88JlT5TNRgvTsMtq3
         Ftew==
X-Gm-Message-State: AOAM530KfUof6TUXCXwZHodbSPC1qrhKCAjPoiINnRS7Ak84uxS14gx1
        g2J/wswYeSHnEugIBraBoq0=
X-Google-Smtp-Source: ABdhPJydP5HwqAKtuGteJf/ZKsiG60bFFB9Tp0RZbC4lkxXDLuCnLD/ShKB+VaTHZbeimHfSdhuTnA==
X-Received: by 2002:a17:90b:496:: with SMTP id bh22mr386015pjb.120.1605031985614;
        Tue, 10 Nov 2020 10:13:05 -0800 (PST)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id k5sm4157369pjj.37.2020.11.10.10.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 10:13:04 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mhocko@suse.com, ziy@nvidia.com, songliubraving@fb.com,
        mgorman@suse.de, jack@suse.cz, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 2/5] mm: migrate: simplify the logic for handling permanent failure
Date:   Tue, 10 Nov 2020 10:12:47 -0800
Message-Id: <20201110181250.264394-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201110181250.264394-1-shy828301@gmail.com>
References: <20201110181250.264394-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unmap_and_move{_huge_page}() returns !-EAGAIN and !MIGRATEPAGE_SUCCESS,
the page would be put back to LRU or proper list if it is non-LRU movable
page.  But, the callers always call putback_movable_pages() to put the
failed pages back later on, so it seems not very efficient to put every
single page back immediately, and the code looks convoluted.

Put the failed page on a separate list, then splice the list to migrate
list when all pages are tried.  It is the caller's responsibility to
call putback_movable_pages() to handle failures.  This also makes the
code simpler and more readable.

After the change the rules are:
    * Success: non hugetlb page will be freed, hugetlb page will be put
               back
    * -EAGAIN: stay on the from list
    * -ENOMEM: stay on the from list
    * Other errno: put on ret_pages list then splice to from list

The from list would be empty iff all pages are migrated successfully, it
was not so before.  This has no impact to current existing callsites.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 68 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 8a2e7e19e27b..d7167f7107bd 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1169,7 +1169,8 @@ static int unmap_and_move(new_page_t get_new_page,
 				   free_page_t put_new_page,
 				   unsigned long private, struct page *page,
 				   int force, enum migrate_mode mode,
-				   enum migrate_reason reason)
+				   enum migrate_reason reason,
+				   struct list_head *ret)
 {
 	int rc = MIGRATEPAGE_SUCCESS;
 	struct page *newpage = NULL;
@@ -1206,7 +1207,14 @@ static int unmap_and_move(new_page_t get_new_page,
 		 * migrated will have kept its references and be restored.
 		 */
 		list_del(&page->lru);
+	}
 
+	/*
+	 * If migration is successful, releases reference grabbed during
+	 * isolation. Otherwise, restore the page to right list unless
+	 * we want to retry.
+	 */
+	if (rc == MIGRATEPAGE_SUCCESS) {
 		/*
 		 * Compaction can migrate also non-LRU pages which are
 		 * not accounted to NR_ISOLATED_*. They can be recognized
@@ -1215,35 +1223,16 @@ static int unmap_and_move(new_page_t get_new_page,
 		if (likely(!__PageMovable(page)))
 			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
 					page_is_file_lru(page), -thp_nr_pages(page));
-	}
 
-	/*
-	 * If migration is successful, releases reference grabbed during
-	 * isolation. Otherwise, restore the page to right list unless
-	 * we want to retry.
-	 */
-	if (rc == MIGRATEPAGE_SUCCESS) {
 		if (reason != MR_MEMORY_FAILURE)
 			/*
 			 * We release the page in page_handle_poison.
 			 */
 			put_page(page);
 	} else {
-		if (rc != -EAGAIN) {
-			if (likely(!__PageMovable(page))) {
-				putback_lru_page(page);
-				goto put_new;
-			}
+		if (rc != -EAGAIN)
+			list_add_tail(&page->lru, ret);
 
-			lock_page(page);
-			if (PageMovable(page))
-				putback_movable_page(page);
-			else
-				__ClearPageIsolated(page);
-			unlock_page(page);
-			put_page(page);
-		}
-put_new:
 		if (put_new_page)
 			put_new_page(newpage, private);
 		else
@@ -1274,7 +1263,8 @@ static int unmap_and_move(new_page_t get_new_page,
 static int unmap_and_move_huge_page(new_page_t get_new_page,
 				free_page_t put_new_page, unsigned long private,
 				struct page *hpage, int force,
-				enum migrate_mode mode, int reason)
+				enum migrate_mode mode, int reason,
+				struct list_head *ret)
 {
 	int rc = -EAGAIN;
 	int page_was_mapped = 0;
@@ -1290,7 +1280,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	 * kicking migration.
 	 */
 	if (!hugepage_migration_supported(page_hstate(hpage))) {
-		putback_active_hugepage(hpage);
+		list_move_tail(&hpage->lru, ret);
 		return -ENOSYS;
 	}
 
@@ -1372,8 +1362,10 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 out_unlock:
 	unlock_page(hpage);
 out:
-	if (rc != -EAGAIN)
+	if (rc == MIGRATEPAGE_SUCCESS)
 		putback_active_hugepage(hpage);
+	else if (rc != -EAGAIN && rc != MIGRATEPAGE_SUCCESS)
+		list_move_tail(&hpage->lru, ret);
 
 	/*
 	 * If migration was not successful and there's a freeing callback, use
@@ -1404,8 +1396,8 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
  *
  * The function returns after 10 attempts or if no pages are movable any more
  * because the list has become empty or no retryable pages exist any more.
- * The caller should call putback_movable_pages() to return pages to the LRU
- * or free list only if ret != 0.
+ * It is caller's responsibility to call putback_movable_pages() to return pages
+ * to the LRU or free list only if ret != 0.
  *
  * Returns the number of pages that were not migrated, or an error code.
  */
@@ -1426,6 +1418,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	struct page *page2;
 	int swapwrite = current->flags & PF_SWAPWRITE;
 	int rc, nr_subpages;
+	LIST_HEAD(ret_pages);
 
 	if (!swapwrite)
 		current->flags |= PF_SWAPWRITE;
@@ -1448,12 +1441,21 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			if (PageHuge(page))
 				rc = unmap_and_move_huge_page(get_new_page,
 						put_new_page, private, page,
-						pass > 2, mode, reason);
+						pass > 2, mode, reason,
+						&ret_pages);
 			else
 				rc = unmap_and_move(get_new_page, put_new_page,
 						private, page, pass > 2, mode,
-						reason);
-
+						reason, &ret_pages);
+			/*
+			 * The rules are:
+			 *	Success: non hugetlb page will be freed, hugetlb
+			 *		 page will be put back
+			 *	-EAGAIN: stay on the from list
+			 *	-ENOMEM: stay on the from list
+			 *	Other errno: put on ret_pages list then splice to
+			 *		     from list
+			 */
 			switch(rc) {
 			case -ENOMEM:
 				/*
@@ -1519,6 +1521,12 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	nr_thp_failed += thp_retry;
 	rc = nr_failed;
 out:
+	/*
+	 * Put the permanent failure page back to migration list, they
+	 * will be put back to the right list by the caller.
+	 */
+	list_splice(&ret_pages, from);
+
 	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
 	count_vm_events(PGMIGRATE_FAIL, nr_failed);
 	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
-- 
2.26.2

