Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFDA2A8869
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 21:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbgKEUx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 15:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732376AbgKEUxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:53:52 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BA4C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 12:53:52 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id o129so2302660pfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 12:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6DgJdBCW4aME83u7WdKcgwL2UHBAOIfxXW7hlUge6Q=;
        b=YPU4FyKSPyyWzrPeopYZ1EK1tTC0tPFrMQBZnhHGrBiI3B+NxHHytSDtGZp91BR3b1
         /DGkv4vzRRiSIujXFtBmLmz/DJzGtVQPyJLr6g9XPk8xWDrKegbejuJltSSlLTVJ5ibj
         ic7k4rf+Hn+G0qhcDsyY0hyInVS64Ffd+Z5dHOLebRG48XGs76BhfM4zAYGcg09v2P41
         gm4hrNYec0MgHSpIoCjg8AgUR82jZR7vs9cKyg8XVWVHHigPI3MxMtmWrbipNmKbW+b9
         tSa/QSdZnbU7+PEnaQHrrvsLuaCdxlZIBk72MqRqN3SrbpTgESaikRIioI+IARWDInlY
         S7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6DgJdBCW4aME83u7WdKcgwL2UHBAOIfxXW7hlUge6Q=;
        b=FwLZhIg8/OxmL214mgSvqSwu+zjxSv+Cc4HkpS2RoIryXXg575m4F39PWCqizjNsHP
         DY44vydxt7Tll+wV11C6jYbUX0KJNFaJZlGj1USRnjA+nJ7OaPyb8AkYe+J4SM1J5P4F
         PjzmFomU9Gq9eC5LoBCh71d3bUmDUAzeaJFH2s/0LjPNCSsQGxaVQ9DZoCOez+4rym65
         E1HvS8w3AUGK1iNP+n4zla9YxVaJDiBv+YBoJClbcvFVSBEt5kFl03nLN0bRe3VGG9EG
         kMg8JFzZWrqKz8BD1w/K4lBSkQkBRDVH/wWZ2m7Zw7kG2yFv/+DB86NX1OFbPe0drwda
         7Xag==
X-Gm-Message-State: AOAM532qLpiDjoVrzm0Tk0yiLz0CuJs+KEIId7GfoUp5uLfPSkjaxM+1
        GWn/wbwEUq15BKaFZJJ7oWo=
X-Google-Smtp-Source: ABdhPJzqK69VUMaA57xqokGJVipfkh3WJguLL/FDol0ji5PTkvxN+Wj3+9OZ6C2QFndraPll6u0Ukw==
X-Received: by 2002:a17:90a:fb4e:: with SMTP id iq14mr4276671pjb.68.1604609632438;
        Thu, 05 Nov 2020 12:53:52 -0800 (PST)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id u22sm3265528pgf.24.2020.11.05.12.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 12:53:51 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mhocko@suse.com, ziy@nvidia.com, songliubraving@fb.com,
        mgorman@suse.de, jack@suse.cz, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] mm: migrate: return -ENOSYS if THP migration is unsupported
Date:   Tue,  3 Nov 2020 05:03:34 -0800
Message-Id: <20201103130334.13468-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103130334.13468-1-shy828301@gmail.com>
References: <20201103130334.13468-1-shy828301@gmail.com>
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
index 8f6a61c9274b..b3466d8c7f03 100644
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
 
+static inline int try_split_thp(struct page *page, struct page *page2,
+				struct list_head *from)
+{
+	int rc = 0;
+
+	lock_page(page);
+	rc = split_huge_page_to_list(page, from);
+	unlock_page(page);
+	if (!rc)
+		list_safe_reset_next(page, page2, lru);
+
+	return rc;
+}
+
 /*
  * migrate_pages - migrate the pages specified in a list, to the free pages
  *		   supplied as the target for the page migration
@@ -1445,24 +1459,40 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 						reason, &ret_pages);
 
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
+					if (!try_split_thp(page, page2, from)) {
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
+					if (!try_split_thp(page, page2, from)) {
 						nr_thp_split++;
 						goto retry;
 					}
@@ -1490,7 +1520,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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

