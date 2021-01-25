Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5045302CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732219AbhAYUhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731989AbhAYTvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:51:10 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A83C0611C3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:48:14 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 19so13733378qkh.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IY6D8/ZMyGIUDKqllv86b5qOcyIRLy633LCHCtaaquY=;
        b=B2YCL2rAyFoZqE4WT/4QUlTLv0sbMnioKPrp1NGkhpM4TfBDRU0nz+ueHoSh2qqzzH
         Y3ws3+Lgh9rdkYaAlQ0tux2bwasCXVlUL3V6AoyITO940H+MX59ufzy3ves/bKkzEpvP
         dJ4LorhjJ+Tiu2GN+FnEl5uMAkdvdCygd1cYuM9fDokHwsb3q1/9yKgL9Xcc8Ec8YcLh
         5bmOyEKXP0SCtISkhaByU7tvRgoJVo1Re+PRCO8ka11ZRNARhNU+xkumGzdAt6VKyJgt
         dPfcQqFEQF6Q9xhV87BVtimH/vmyY9cumqyNJZz5/5Roj8V4Q7adw/cXIEwnqMCwdzM1
         9x3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IY6D8/ZMyGIUDKqllv86b5qOcyIRLy633LCHCtaaquY=;
        b=WTVfl+NrEhH7Md8r933lEZA1wTbcbEBiywjSkbFSOAB3kR4vJQQfJm/V1QZxlp6cZa
         L2XdkonjtMI0SMQc2m1i2npmVZRXiI0uIn5CYCzdQGvJjLJFB34lxZQn5qjFlOtivXv2
         PlOnydfL3lfXPgb82GtUy9+xuYzTiU8OEC51DC0gJ8fWNNP5zg3nhappDwAbdju27mOS
         N8zggsGM24XcURP1R+toGt1jlJGLVVnM4WDTv2xI7lqanpBfkLvsDV0v6k2io1oncoTd
         5rkTOEJOY/PmfA2gLpnGuJ6+Q3Iplt79yrkZ8/83cwy6Fd7ePwtwOVnsIosT8ib2OwKD
         PWfg==
X-Gm-Message-State: AOAM533P4u+tNAgsD6PzQn0HPI3K87P7rfHVSoqfYEEmYsh5OI9hQxMO
        egy/6bNJb8Rks82m7qvW2INEWA==
X-Google-Smtp-Source: ABdhPJytYypa/BCyR6Vkx3Q9a3yFIqDeeC4LQvsoMCNCusgTFdSKwLYE8QhUdAdv2IOy5rLuLeHXUQ==
X-Received: by 2002:a37:a7d1:: with SMTP id q200mr2444716qke.365.1611604093523;
        Mon, 25 Jan 2021 11:48:13 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c12sm12121569qtq.76.2021.01.25.11.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:48:13 -0800 (PST)
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
        linux-kselftest@vger.kernel.org, jmorris@namei.org
Subject: [PATCH v8 12/14] mm/gup: longterm pin migration cleanup
Date:   Mon, 25 Jan 2021 14:47:49 -0500
Message-Id: <20210125194751.1275316-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125194751.1275316-1-pasha.tatashin@soleen.com>
References: <20210125194751.1275316-1-pasha.tatashin@soleen.com>
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 mm/gup.c | 93 ++++++++++++++++++++++----------------------------------
 1 file changed, 37 insertions(+), 56 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f98af75dab0f..fabfe2a5c627 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1549,27 +1549,28 @@ struct page *get_dump_page(unsigned long addr)
 #endif /* CONFIG_ELF_CORE */
 
 #ifdef CONFIG_MIGRATION
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
@@ -1607,47 +1608,27 @@ static long check_and_migrate_movable_pages(struct mm_struct *mm,
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
 #else
-static long check_and_migrate_movable_pages(struct mm_struct *mm,
-					    unsigned long start,
-					    unsigned long nr_pages,
+static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages,
-					    struct vm_area_struct **vmas,
 					    unsigned int gup_flags)
 {
 	return nr_pages;
@@ -1665,22 +1646,22 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 				  struct vm_area_struct **vmas,
 				  unsigned int gup_flags)
 {
-	unsigned long flags = 0;
+	unsigned int flags;
 	long rc;
 
-	if (gup_flags & FOLL_LONGTERM)
-		flags = memalloc_pin_save();
-
-	rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas, NULL,
-				     gup_flags);
+	if (!(gup_flags & FOLL_LONGTERM))
+		return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
+					       NULL, gup_flags);
+	flags = memalloc_pin_save();
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

