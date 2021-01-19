Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE17C2FAFBE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 05:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389230AbhASEvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 23:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387667AbhASEmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 23:42:23 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C78BC0617BE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 20:39:42 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id w79so20775901qkb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 20:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Mozcc4kuYbrNkd78OelIwDi34wEitfuXZj+0y++fO7I=;
        b=nes348fen+42chjh/uf/Hck11INwC4iFF+XsgAEA6JHbTToYZq+aKmO9bDVdE+Lrmb
         wcdXVwEqY0eTMoP4wHR43h/1DOgUOy/LtJm5xPD3IlHDtJprVyXbWMz6SOw9FuwIdU73
         Ed+0/ijhnsSsDFNP5U1BUpB+suSRTWJyi5I6qI0duiYrXzY7K1aw59rgkLXhyAIGA37k
         aIpWbLk+2Jxz51n6c4+fmw0vTapPA/zdo46f/yruQukd826LxWgTaw8LL1ONuOvTtN3I
         6NF9IjGvqI0+5CTIrxPtxwbGMsFpLrduIO8IYFer47jbxzbGc48HQgDgBNyDhc5TZliz
         3vEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mozcc4kuYbrNkd78OelIwDi34wEitfuXZj+0y++fO7I=;
        b=aHmq8olWuN3uP+Feg/JBtlMaUSPOCSaU+Keaff1sKdIqqWszlGZgWPtecy+8NuGeB5
         jAmfc9/sLQ87LFP1AbE3umUz0pQIN7rmOYGORoQj6Ie6Oj5Ui6+CQDjVOKZB4x1/Izfj
         ZC0XrK3KbRJa0hajbW6gyfeBsYKlwRmhGemwUtMFmMHPCRoM7ytwUWqNlXWepgmxFeHf
         1DrW6Ukb4cVTUZZOBE7xuXWUKwlm7UwCZoiVLkJrY/drdOnSVBYCbNIZVu/xpjH60HT4
         Lgop/pAvH5YYH8ZPBHNP7B5l/Fiodiv5jCu76yhU55ptLKgSjR4ZbglNsN84cPDQIsOq
         aJcw==
X-Gm-Message-State: AOAM532tO4bqp0eXZAVawrcq0ujG5m73ruqq96FUhVmLFgBycfozQV2K
        1pb3EZuP5W6+FhzhEnbDVie4gQ==
X-Google-Smtp-Source: ABdhPJz+FNci4xuBDvj9gcDJx+dJbGOnd11aZ4ctDWNnJNtrR0jWNj8Mqh5wiA0py6oc3gJCr/ZP1Q==
X-Received: by 2002:a37:e211:: with SMTP id g17mr2709283qki.298.1611031181530;
        Mon, 18 Jan 2021 20:39:41 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id z20sm11934536qkz.37.2021.01.18.20.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 20:39:41 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org, ira.weiny@intel.com,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v5 12/14] mm/gup: longterm pin migration cleaup
Date:   Mon, 18 Jan 2021 23:39:18 -0500
Message-Id: <20210119043920.155044-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119043920.155044-1-pasha.tatashin@soleen.com>
References: <20210119043920.155044-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pages are longterm pinned, we must migrated them out of movable zone.
The function that migrates them has a hidden loop with goto. The loop is
to retry on isolation failures, and after successful migration.

Make this code better by moving this loop to the caller.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 mm/gup.c | 101 +++++++++++++++++++++++--------------------------------
 1 file changed, 42 insertions(+), 59 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index dfe90b254bc6..3b46eb5fe3ba 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1548,27 +1548,28 @@ struct page *get_dump_page(unsigned long addr)
 }
 #endif /* CONFIG_ELF_CORE */
 
-static long check_and_migrate_movable_pages(struct mm_struct *mm,
-					    unsigned long start,
-					    unsigned long nr_pages,
+/*
+ * Check whether all pages are pinnable, if so return number of pages.  If some
+ * pages are not pinnable, migrate them, and unpin all pages. Return zero if
+ * pages were migrated, or if some pages were not successfully isolated.
+ * Return negative error if migration fails.
+ */
+static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages,
-					    struct vm_area_struct **vmas,
 					    unsigned int gup_flags)
 {
-	unsigned long i, isolation_error_count;
-	bool drain_allow;
+	unsigned long i;
+	unsigned long isolation_error_count = 0;
+	bool drain_allow = true;
 	LIST_HEAD(movable_page_list);
-	long ret = nr_pages;
-	struct page *prev_head, *head;
+	long ret = 0;
+	struct page *prev_head = NULL;
+	struct page *head;
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
 		.gfp_mask = GFP_USER | __GFP_NOWARN,
 	};
 
-check_again:
-	prev_head = NULL;
-	isolation_error_count = 0;
-	drain_allow = true;
 	for (i = 0; i < nr_pages; i++) {
 		head = compound_head(pages[i]);
 		if (head == prev_head)
@@ -1606,40 +1607,23 @@ static long check_and_migrate_movable_pages(struct mm_struct *mm,
 	 * in the correct zone.
 	 */
 	if (list_empty(&movable_page_list) && !isolation_error_count)
-		return ret;
+		return nr_pages;
 
+	if (gup_flags & FOLL_PIN) {
+		unpin_user_pages(pages, nr_pages);
+	} else {
+		for (i = 0; i < nr_pages; i++)
+			put_page(pages[i]);
+	}
 	if (!list_empty(&movable_page_list)) {
-		/*
-		 * drop the above get_user_pages reference.
-		 */
-		if (gup_flags & FOLL_PIN)
-			unpin_user_pages(pages, nr_pages);
-		else
-			for (i = 0; i < nr_pages; i++)
-				put_page(pages[i]);
-
 		ret = migrate_pages(&movable_page_list, alloc_migration_target,
 				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
 				    MR_LONGTERM_PIN);
-		if (ret) {
-			if (!list_empty(&movable_page_list))
-				putback_movable_pages(&movable_page_list);
-			return ret > 0 ? -ENOMEM : ret;
-		}
-
-		/* We unpinned pages before migration, pin them again */
-		ret = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
-					      NULL, gup_flags);
-		if (ret <= 0)
-			return ret;
-		nr_pages = ret;
+		if (ret && !list_empty(&movable_page_list))
+			putback_movable_pages(&movable_page_list);
 	}
 
-	/*
-	 * check again because pages were unpinned, and we also might have
-	 * had isolation errors and need more pages to migrate.
-	 */
-	goto check_again;
+	return ret > 0 ? -ENOMEM : ret;
 }
 
 /*
@@ -1653,30 +1637,29 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 				  struct vm_area_struct **vmas,
 				  unsigned int gup_flags)
 {
-	unsigned long flags = 0;
+	unsigned int flags;
 	long rc;
 
-	if (gup_flags & FOLL_LONGTERM) {
-		/*
-		 * We are long term pinning pages and their PA's should not
-		 * change until unpinned. Without FOLL_WRITE we might get zero
-		 * page which we do not want. Force creating normal
-		 * pages by adding FOLL_WRITE.
-		 */
-		gup_flags |= FOLL_WRITE;
-		flags = memalloc_pin_save();
-	}
+	if (!(gup_flags & FOLL_LONGTERM))
+		return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
+					       NULL, gup_flags);
+	/*
+	 * We are long term pinning pages and their PA's should not change until
+	 * unpinned. Without FOLL_WRITE we might get zero page which we do not
+	 * want. Force creating normal pages by adding FOLL_WRITE.
+	 */
+	gup_flags |= FOLL_WRITE;
+	flags = memalloc_pin_save();
 
-	rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas, NULL,
-				     gup_flags);
+	do {
+		rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
+					     NULL, gup_flags);
+		if (rc <= 0)
+			break;
+		rc = check_and_migrate_movable_pages(rc, pages, gup_flags);
+	} while (!rc);
+	memalloc_pin_restore(flags);
 
-	if (gup_flags & FOLL_LONGTERM) {
-		if (rc > 0)
-			rc = check_and_migrate_movable_pages(mm, start, rc,
-							     pages, vmas,
-							     gup_flags);
-		memalloc_pin_restore(flags);
-	}
 	return rc;
 }
 
-- 
2.25.1

