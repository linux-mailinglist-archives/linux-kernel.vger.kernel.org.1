Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2602B25F5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgKMUy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgKMUyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:54:23 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5146CC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:54:23 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 10so8643330pfp.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NlCySaarQuBRqx4ZarxGkk5wyOoOIoY4LEnvGt+q/V8=;
        b=FWbOftTweAh9DsE1ejLx5Hj3jf3rfjvcSWPSDIPv0iHC9LP3BmDaa0znpjQG0Nuynu
         APq3xUhBOA52WhIlJuoBeDVb5kRULJS097Yh1I1K8OQc88hAcDET1v2MR2JrEkj4MmKc
         6/EZwRmqUA6QebJmH9dg+pwDo9vufW81WRuy/BW+G/QzFlWCmL4e7c1n6wpVZPp2nz+y
         qoyvjxWFLR3BQpvRZzZKkwxT45OIDLWaMiWEIkUMGu5mSr9JjuMCV5fDUnSNyruRxuA8
         gBfms96UIGgIdYGDpuEe5+4JWsqdXvU6VVSnovz8kwPLuuvxt3YrdcaIBthenUBQOLnZ
         vBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NlCySaarQuBRqx4ZarxGkk5wyOoOIoY4LEnvGt+q/V8=;
        b=QTwA+GFH5lURbVyop541OkoqvBdYaUfV4J0WqVMFuyQ0b8Dd7ScgWbtY6NtPrNNKWY
         VEWKxt+KUm8hqXQmXKbjOVFV1pIpOmYlSeETG04/s4te9Do+lK6dQ9Kz6wxvne0HJIdO
         aEJ/TxvEdCr7XOD+ao7FVe7inQVkiYgLb/RZ5CFzIBLI226uwXGwxZQ7FXkq/ZomUkwA
         KYOlnGzN/VFUmx8WhhYgmXxlomPvlGHNrJxCROcMGXESp6ZRc9taB1nigjdpigIVmHxD
         PwIBIUrpDVX3vhCdduaepFmrPjNUULrSK3oOZ4mzEAfdjvr7cH8jIvXN7gZfwG0d94Lq
         FACw==
X-Gm-Message-State: AOAM531avDrLViEKMxH7YQW6vem+Q6x+aZYNqpw7lAh9FAax+O2n+m41
        CrNf8Z382fI+GF88qJ7phkA=
X-Google-Smtp-Source: ABdhPJxnzIuqoEzeSjtKEmms0/Rel0ToY3PHomWAvPB4LIt6hlhlCX+b1+j14OZ/MnPJDvulD+LRkw==
X-Received: by 2002:a17:90a:1696:: with SMTP id o22mr4768923pja.44.1605300862975;
        Fri, 13 Nov 2020 12:54:22 -0800 (PST)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id a18sm3780234pfa.151.2020.11.13.12.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 12:54:21 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mhocko@suse.com, ziy@nvidia.com, songliubraving@fb.com,
        mgorman@suse.de, jack@suse.cz, willy@infradead.org,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 4/5] mm: migrate: clean up migrate_prep{_local}
Date:   Fri, 13 Nov 2020 12:53:58 -0800
Message-Id: <20201113205359.556831-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201113205359.556831-1-shy828301@gmail.com>
References: <20201113205359.556831-1-shy828301@gmail.com>
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
index 18cc1ef0e447..4d3d173a1706 100644
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

