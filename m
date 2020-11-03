Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAC92A8866
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 21:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbgKEUxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 15:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732120AbgKEUxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:53:46 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C446C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 12:53:46 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id z24so2193803pgk.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 12:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jE4qSk2GuBQuLE3VKoSzbFTrSHhXqdRokaed5NT8Mes=;
        b=gaK5tfxoQSaRHHEbQMSlU8zj9YPCoi0uuimK2r5eJ7E4XnR07Ov3FH8IonVXyJdkCe
         v52OhSZKZom6zW8qiS10sZjo+wwutX1eZgMyfkEvFG2XdQC8EGkGJU9BkFuOsoS8Wiby
         /frtI43Ougmrq0bEyaMZwWv5YGk4kdAWEtoCwfQ1kS0nHu40ymqIK8Emhdz+sQ6GxgwD
         MnaClz+8XmCB9Qwq6M6uOF1nGux/OrJXch/pamebOBKnDbq7CtJNAZuj3J2hzedTr4AN
         KpmU1OyxwwNKmX2qbm2XLSnpfP3Gi0gEosHSFErb7jfhhxbI610KwLOBaJKIF+0UCzET
         0jFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jE4qSk2GuBQuLE3VKoSzbFTrSHhXqdRokaed5NT8Mes=;
        b=Jm3jM043NwQljHWrxQTTgYhWZOU4dCnT/6DQyKWniuINEkXyD2QwtYhrtTh6zckOj0
         CyLOMQ1SWwoqgdk9mVxkspsLHwl3Q0jZTBqYvkLVgl7G4ne1o7E4y4TeuvAHtyKq5DTc
         ea6uAOj/z0abVky4/X+2FqalQN7vdLA47FVhb4hduZPI61sXejmarawhB3dXO30LEw3i
         jjD0kygUzt9qgaBMa1puaiYOY1VcElHw7zvt1sVWrAYLsASrMCdDVmuT+6UQ48Q0zvKN
         O/1/tYRwbwL10a9IZp92DG9HznisMsQM5YUu0NMMhjF1ysMHFnXgaHYNnEmtcw5eDPpT
         Xr7A==
X-Gm-Message-State: AOAM531cbbZacS5jbnHrDO4oce7qdKCDEawtTlFMVmRYUTd7DN0Z6NJQ
        Hz64eqnK3EWxfPJQNa5Jsy4=
X-Google-Smtp-Source: ABdhPJx0XwY0IdRHx1Njn+CvjHuWeJssCSQR+wFpwv9Wevxik8A5BqkXfjTXCuOQhoZHB6wAvZNscw==
X-Received: by 2002:a63:3c1b:: with SMTP id j27mr4077005pga.79.1604609626212;
        Thu, 05 Nov 2020 12:53:46 -0800 (PST)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id u22sm3265528pgf.24.2020.11.05.12.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 12:53:45 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mhocko@suse.com, ziy@nvidia.com, songliubraving@fb.com,
        mgorman@suse.de, jack@suse.cz, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] mm: migrate: simplify the logic for handling permanent failure
Date:   Tue,  3 Nov 2020 05:03:31 -0800
Message-Id: <20201103130334.13468-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103130334.13468-1-shy828301@gmail.com>
References: <20201103130334.13468-1-shy828301@gmail.com>
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

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 58 ++++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 8a2e7e19e27b..c33c92495ead 100644
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
@@ -1448,11 +1441,12 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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
+						reason, &ret_pages);
 
 			switch(rc) {
 			case -ENOMEM:
@@ -1519,6 +1513,12 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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

