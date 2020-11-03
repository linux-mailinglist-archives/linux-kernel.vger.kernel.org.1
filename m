Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610052A8868
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 21:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732427AbgKEUxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 15:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732112AbgKEUxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:53:51 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05B0C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 12:53:50 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 62so2161610pgg.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 12:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Leqw7u0Dj1Vz2BsTHyCIMeIKX4OIeHsLYnWeVSaw6Y=;
        b=iTdqtA5C73Vrz3wnXMfi2ehPUNtrgAzfjSC9sbuyb4PjCLL0bzTeRuU2Ma1bqfw5+M
         LTLPzs3uOWNX7IhP1zl2a+iyG7Ey3kmIaxok8+vFnhm+Krd7p0wP5F9jQ7e+OVwyX4Bi
         I1W1/E/4pNkN34HwwDGKqFo/gEPafUvsxpwT76QX/vz0ooKmKgphWAAxGJce0w9X1Zp/
         J0oTYiUh2XhPeosOm4yZNQPCm6b4Okc7xfgCrhWLHQS66AjHGI17+LpRJwGyISImBU0I
         DACaGmustp++exPUVtB4TgIOpY1i2QtywH5XI5kmRIcLv3PvmQV22AE6nHTy3u4KnXVQ
         GeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Leqw7u0Dj1Vz2BsTHyCIMeIKX4OIeHsLYnWeVSaw6Y=;
        b=jgNVIZUGHUYlB2vjehzyKLF8lbH/UxAzokZDLz1QaufdBhFzBue2ps9ubtayL5P8gX
         wUDigvlwmQWvJ+8Hw8i8zXDlXro7es6/7YmEW1Ow+rjvGwlqH4NkF5nu3JtcaSPWq3MR
         VSzu3VyXDPpKJBPDz17Kon/0zwVzQsEONy5YJ8mmMXieRo6tDAOISuEkIMxIACcwE3gl
         EP7iGHrD56vNhEVvm2zIjtlZhBaMueNP7id3a6n4QRHDd/DeqJokFJHWLoYmoHmuyhMN
         GOf7nYjTFw2yqRZM8VsSW5FZG/2vpcj9GJwDfNFJd6+IoQBsYviyvf7mexykYs9HUk7K
         bLFg==
X-Gm-Message-State: AOAM531FuvxqtSPzT6kAoqkpum0csLrBwjYNzxpJCnk6BlQuYI7JFmb8
        V/s8F+SQ9kir2D5pKEto1D8=
X-Google-Smtp-Source: ABdhPJxUZsNTq7EX7hHHMb5GM4tGtzAlPxZWwcwNcY7v3Qei0TEfEn0WLfqFpXFSp6pHxKAj/gpXtg==
X-Received: by 2002:a62:a10a:0:b029:154:fd62:ba90 with SMTP id b10-20020a62a10a0000b0290154fd62ba90mr4303657pff.62.1604609630470;
        Thu, 05 Nov 2020 12:53:50 -0800 (PST)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id u22sm3265528pgf.24.2020.11.05.12.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 12:53:49 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mhocko@suse.com, ziy@nvidia.com, songliubraving@fb.com,
        mgorman@suse.de, jack@suse.cz, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] mm: migrate: clean up migrate_prep{_local}
Date:   Tue,  3 Nov 2020 05:03:33 -0800
Message-Id: <20201103130334.13468-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103130334.13468-1-shy828301@gmail.com>
References: <20201103130334.13468-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The migrate_prep{_local} never fails, so it is pointless to have return
value and check the return value.

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
index 3fde772ef5ef..780861312008 100644
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
index 9a32bb128f31..8f6a61c9274b 100644
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

