Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B9C2ADDE9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbgKJSNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731282AbgKJSNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:13:13 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5608CC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:13:13 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w4so10892871pgg.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WbZNZfdUV+Jb/ecPWV8SHsj0cS3TmcMVN/IJ8mgWjoo=;
        b=ZecElvz8otZT3eF+V+Jipxwyqbrob11E7XA9qzjhlGlhadYlXS8W8PW9wGVdeswGez
         CxF2D9SQhatxA8z2yAvhIBDUfw34NXyDVlQHVyanlirj091JZcS8JwyJeU0qoIyFSY7E
         dYMCcohLw/8s4zcFX5NVO+HVNlr1N+/mvC6PFX0QvSl35tNTidvW5GWpotZHjTh5Lmxi
         gYTd6QhpWjqAOQjrTLoeIamqeEznAjGasRXXHnvBJ1zi0aclgzVQ6ZKGHKdC4RTXDS/v
         qTMYCopbRVqS4A2SIr4Ik9k0+zM3YWmqdB7rmVzDEhSh8nZPjPPIV0WBemo3+wz2n2wb
         OsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WbZNZfdUV+Jb/ecPWV8SHsj0cS3TmcMVN/IJ8mgWjoo=;
        b=HjAbBpMeMu/nsaJ8kEPpmROir+eI+k2pHVhAsSll7CfH3WWcBwKTVP2vDkOVBBFy0K
         7yHJStkq07r2sNsskjSqhCJoOkG8PtfUbnTOMCajomqjPcHTviY6aqJrHvUOVnOpdfEd
         3LYDm6YesczId4Y1zX5ZZEBJfFuo1vVvh+E0YKZZgwcieZ0YCxgEGY3bFtZl8JWpZ7S3
         tJWKcUu+resiD+VEwBGwL/bekHKVzbgTKMG10x70hv0NSSFdcicoDOt1oI9uLh58apQY
         kIXN/6cvF9f21N8CKlJAE4z1Eo3Ie5Bs4LmvAwp4KFaYal+3xfHo9XvJbYlDAa9+TVMz
         wvPA==
X-Gm-Message-State: AOAM531T0952E5oVDAAcB0ajh6xtk5SbG+1whTM+dhG4vGIZIYcESi6o
        XkTFQ1K01TyofGYNNVdrgUo=
X-Google-Smtp-Source: ABdhPJxOUAfMQOEUDeYGAxyPeDNAvEvec0OJ5dlCxusPzBkLXqu1dHgak7I+9muIvRjGfKDPBR3vCg==
X-Received: by 2002:a17:90a:3f10:: with SMTP id l16mr378261pjc.110.1605031992965;
        Tue, 10 Nov 2020 10:13:12 -0800 (PST)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id k5sm4157369pjj.37.2020.11.10.10.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 10:13:11 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mhocko@suse.com, ziy@nvidia.com, songliubraving@fb.com,
        mgorman@suse.de, jack@suse.cz, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 5/5] mm: migrate: return -ENOSYS if THP migration is unsupported
Date:   Tue, 10 Nov 2020 10:12:50 -0800
Message-Id: <20201110181250.264394-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201110181250.264394-1-shy828301@gmail.com>
References: <20201110181250.264394-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current implementation unmap_and_move() would return -ENOMEM if
THP migration is unsupported, then the THP will be split.  If split is
failed just exit without trying to migrate other pages.  It doesn't make
too much sense since there may be enough free memory to migrate other
pages and there may be a lot base pages on the list.

Return -ENOSYS to make consistent with hugetlb.  And if THP split is
failed just skip and try other pages on the list.

Just skip the whole list and exit when free memory is really low.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 62 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 693bf06448ad..d110af76fa4d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1172,7 +1172,7 @@ static int unmap_and_move(new_page_t get_new_page,
 	struct page *newpage = NULL;
 
 	if (!thp_migration_supported() && PageTransHuge(page))
-		return -ENOMEM;
+		return -ENOSYS;
 
 	if (page_count(page) == 1) {
 		/* page was freed from under us. So we are done. */
@@ -1376,6 +1376,20 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	return rc;
 }
 
+static inline int try_split_thp(struct page *page, struct page **page2,
+				struct list_head *from)
+{
+	int rc = 0;
+
+	lock_page(page);
+	rc = split_huge_page_to_list(page, from);
+	unlock_page(page);
+	if (!rc)
+		list_safe_reset_next(page, *page2, lru);
+
+	return rc;
+}
+
 /*
  * migrate_pages - migrate the pages specified in a list, to the free pages
  *		   supplied as the target for the page migration
@@ -1453,24 +1467,40 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			 *		     from list
 			 */
 			switch(rc) {
+			/*
+			 * THP migration might be unsupported or the
+			 * allocation could've failed so we should
+			 * retry on the same page with the THP split
+			 * to base pages.
+			 *
+			 * Head page is retried immediately and tail
+			 * pages are added to the tail of the list so
+			 * we encounter them after the rest of the list
+			 * is processed.
+			 */
+			case -ENOSYS:
+				/* THP migration is unsupported */
+				if (is_thp) {
+					if (!try_split_thp(page, &page2, from)) {
+						nr_thp_split++;
+						goto retry;
+					}
+
+					nr_thp_failed++;
+					nr_failed += nr_subpages;
+					break;
+				}
+
+				/* Hugetlb migration is unsupported */
+				nr_failed++;
+				break;
 			case -ENOMEM:
 				/*
-				 * THP migration might be unsupported or the
-				 * allocation could've failed so we should
-				 * retry on the same page with the THP split
-				 * to base pages.
-				 *
-				 * Head page is retried immediately and tail
-				 * pages are added to the tail of the list so
-				 * we encounter them after the rest of the list
-				 * is processed.
+				 * When memory is low, don't bother to try to migrate
+				 * other pages, just exit.
 				 */
 				if (is_thp) {
-					lock_page(page);
-					rc = split_huge_page_to_list(page, from);
-					unlock_page(page);
-					if (!rc) {
-						list_safe_reset_next(page, page2, lru);
+					if (!try_split_thp(page, &page2, from)) {
 						nr_thp_split++;
 						goto retry;
 					}
@@ -1498,7 +1528,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				break;
 			default:
 				/*
-				 * Permanent failure (-EBUSY, -ENOSYS, etc.):
+				 * Permanent failure (-EBUSY, etc.):
 				 * unlike -EAGAIN case, the failed page is
 				 * removed from migration page list and not
 				 * retried in the next outer loop.
-- 
2.26.2

