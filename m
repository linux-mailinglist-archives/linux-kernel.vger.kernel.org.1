Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3968E2B25F8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgKMUyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgKMUy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:54:26 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390B6C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:54:26 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id x15so7318419pfm.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CvuRYtIWP4UHd11OQXH+00CGziU0NWit5UcWJl2Apfg=;
        b=r5dzGtWNg/mpS+L45R1MXt6/lO/QS8/uCWBMj9w+ktEc6Vo4B6Xy/hw9X+YldMpWTs
         xWxC9Voa3j4Sb9Qub0oSKf+FkyY3Gcy79pIs9LxmFd2jqO7Ps7bZkYUsSqZDC5Q1kQoE
         DaHdfmxCFedkfeQNjiqmfqIOjDluCRIbOALCHAC02vlJ2PX6180hiGgIIQZpt1rCssgU
         x+1usfjyOgW2VBG0tSCcvWhGtXCMlSBcNemYfmyuLcIABPsAFBAYUYrWP37ZJaGRDcCb
         7ohZSp10JeohHQDWp9xpyrEuFIO+va2Z8lV3xqPAxHn4xsGLS9l/f2J+lZxoCl5iC9fc
         0ssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CvuRYtIWP4UHd11OQXH+00CGziU0NWit5UcWJl2Apfg=;
        b=U2NTdnzYhwGb6yg3KHPVr0W5KjE86EactnTrboKzbXeDZRWjM/4XjgDZ39wnCMj8Ak
         EAOWzm9Y1FfCZglc+CHrEzprtrFR0IMSAkvb7Q1xqUr+exdC+eabtGXsc3DmdD6FMvIt
         ERCH7JeT6drSuXo8X48W5fkbKKQqMULLRGWOaM2UZY0AKZaDbwVBVdGHGpQZEfMeGgcI
         ZNQNeE9JiHrLPBFH1DXurBajb2OG5t7SleCAlge2FQG72INARRS7WJ3XTYs63QlkVscW
         1Kd2moUEWFbdvCFVPhY9dyjNNa3esoL3h3rsqxk3zf2e1Vq/8rV+SBGSfc+TyAGNq/za
         mHCg==
X-Gm-Message-State: AOAM531uIwvUYuAmjrR/P5Yr9xtNBziq19vc0kJQlWoD9WPZ/vg2RpOu
        sA5pO7ui8dP2Z7FKe+qrZ10=
X-Google-Smtp-Source: ABdhPJxEE6lvaPdy3hU36wODc6jVPrBk45SRVqFfz1PSofo7RMf8IJilOgQVBbS0DqU5EH76cSxAHQ==
X-Received: by 2002:a17:90a:b790:: with SMTP id m16mr4666099pjr.149.1605300865815;
        Fri, 13 Nov 2020 12:54:25 -0800 (PST)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id a18sm3780234pfa.151.2020.11.13.12.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 12:54:24 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mhocko@suse.com, ziy@nvidia.com, songliubraving@fb.com,
        mgorman@suse.de, jack@suse.cz, willy@infradead.org,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 5/5] mm: migrate: return -ENOSYS if THP migration is unsupported
Date:   Fri, 13 Nov 2020 12:53:59 -0800
Message-Id: <20201113205359.556831-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201113205359.556831-1-shy828301@gmail.com>
References: <20201113205359.556831-1-shy828301@gmail.com>
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
index 4d3d173a1706..344ac645c1f1 100644
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

