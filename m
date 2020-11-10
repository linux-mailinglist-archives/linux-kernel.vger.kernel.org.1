Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DA72ADDE8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbgKJSNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgKJSNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:13:10 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88046C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:13:10 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id g11so6862836pll.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=METT62l5bl1QOeNAT1zAxW9WSJIbbi+SftVWPulzf3A=;
        b=I1r4bpBeciZdhrdMeQwTpQtdYv/5vYY/Lb31pwQy2h56pSZowU/JX8kxfxQ4lrfgy8
         4GeJLASRCwf9/CfBBN37pB/NeapqGvnF9e2Z6JL58jYQSaIetWzu02c6HH8CwCCebg1/
         u/lxKclSTnO0zibDO+sz7Mj8W0MfHjwGd3dif6mtMLo2hdIzh9fH3Y2MFDvnViubY+XB
         8aK09OfEyhC57jPykdZ+so0AZJf4Xh6ZuaaKRbc+8mvvHVKH+7apZZX7W+QlCRGHrVRO
         Y2sVem3sDPsiPBbmKdR8VrakHmZ7Et6+DjFi9UYXxf3PTEjujv0QXBikJcUxNp/7UWyk
         dvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=METT62l5bl1QOeNAT1zAxW9WSJIbbi+SftVWPulzf3A=;
        b=Y59pRwQBJNsxc09VjbvRUEDJE0k+t4ARRVLCXRODThAQi81F3XRvmlVc23a+D29BqU
         PWWduhSNVyLcwui+kPXnPRCCtYzEv//sHuspGUTAp6wh+XVF4/07J3suCw2p4753RxaG
         NVBOCBnYuszopJm32hSaYsTBYcAkF0Jpbq1O5bb0jfb15+eMc5Cq5qHFm5IPkntUWRMd
         uui6tlOMt+R0MLdrVz4789Q91zPCQNEKWCXQYIyPjGJS6C+aozQY2tDNc6cpJPYa3pcX
         fOapc+GbFQtei7Ri/DrYcvp7zvoSiv7FdOH07XCL0EUyMrih7DrUfpCogzNg8ncGFTYe
         4FrA==
X-Gm-Message-State: AOAM532jr2MfZtD97sfKopu6AqU4CYK8gxnVeuOGTyTV9xh2dmp+5DEi
        vyhZny5EE59opwUvoxAN4ZQ=
X-Google-Smtp-Source: ABdhPJwo/sGFSUG1Jh6oyERIbbJeS18FFBCXGxTR+9l230LLSqNwItQ5DiwkzTpfym9jNhWf7icmjg==
X-Received: by 2002:a17:902:56d:b029:d7:c927:2e51 with SMTP id 100-20020a170902056db02900d7c9272e51mr15637869plf.27.1605031990148;
        Tue, 10 Nov 2020 10:13:10 -0800 (PST)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id k5sm4157369pjj.37.2020.11.10.10.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 10:13:09 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mhocko@suse.com, ziy@nvidia.com, songliubraving@fb.com,
        mgorman@suse.de, jack@suse.cz, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 4/5] mm: migrate: clean up migrate_prep{_local}
Date:   Tue, 10 Nov 2020 10:12:49 -0800
Message-Id: <20201110181250.264394-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201110181250.264394-1-shy828301@gmail.com>
References: <20201110181250.264394-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The migrate_prep{_local} never fails, so it is pointless to have return
value and check the return value.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/migrate.h | 4 ++--
 mm/mempolicy.c          | 8 ++------
 mm/migrate.c            | 8 ++------
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 0f8d1583fa8e..4594838a0f7c 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -45,8 +45,8 @@ extern struct page *alloc_migration_target(struct page *page, unsigned long priv
 extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 extern void putback_movable_page(struct page *page);
 
-extern int migrate_prep(void);
-extern int migrate_prep_local(void);
+extern void migrate_prep(void);
+extern void migrate_prep_local(void);
 extern void migrate_page_states(struct page *newpage, struct page *page);
 extern void migrate_page_copy(struct page *newpage, struct page *page);
 extern int migrate_huge_page_move_mapping(struct address_space *mapping,
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3ca4898f3f24..8cf96bd21341 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1114,9 +1114,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 	int err;
 	nodemask_t tmp;
 
-	err = migrate_prep();
-	if (err)
-		return err;
+	migrate_prep();
 
 	mmap_read_lock(mm);
 
@@ -1315,9 +1313,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
 
-		err = migrate_prep();
-		if (err)
-			goto mpol_out;
+		migrate_prep();
 	}
 	{
 		NODEMASK_SCRATCH(scratch);
diff --git a/mm/migrate.c b/mm/migrate.c
index 1b103e801fe4..693bf06448ad 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -62,7 +62,7 @@
  * to be migrated using isolate_lru_page(). If scheduling work on other CPUs is
  * undesirable, use migrate_prep_local()
  */
-int migrate_prep(void)
+void migrate_prep(void)
 {
 	/*
 	 * Clear the LRU lists so pages can be isolated.
@@ -71,16 +71,12 @@ int migrate_prep(void)
 	 * pages that may be busy.
 	 */
 	lru_add_drain_all();
-
-	return 0;
 }
 
 /* Do the necessary work of migrate_prep but not if it involves other CPUs */
-int migrate_prep_local(void)
+void migrate_prep_local(void)
 {
 	lru_add_drain();
-
-	return 0;
 }
 
 int isolate_movable_page(struct page *page, isolate_mode_t mode)
-- 
2.26.2

