Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BBF2CEE7C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 13:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgLDM5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 07:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbgLDM5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 07:57:44 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED914C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 04:56:57 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id h7so3742043pjk.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 04:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KfH3iRIxFYJ1fhTiZ1PPzOKH/EKjKgIPU7+T1IHn0PA=;
        b=ScTO4PXm9Z+w4pOvBzJ8JNPEN/ZIMlTo2uvJW5qX/+5qq3KJCdzJPC90/tIAkfwrLh
         eWFJR26XvnQwFU7rmOiZHTqePXUAxwJOFN+YpNdFHrMPbaL79b7jVIUNA8yDtYvQOd3Y
         ZUVqZwyfjweORrfN3lM2fAAtvDb7pPcTw0NySo3tX1PWC4KzX3+FMAg4kUNJyval0nUh
         sJSPNjbDUrpmYbRj8UdkcZzh9ihcxpAG2LYs6bvN4MRk7PJ3zVVs21JhRng1Ex54aYqS
         JlatRB+swyOymBnIP3hBl5pUCQ1Diu+VMB+oUJb1zVDfT3MRAE6H5Rk9aTrt/5A1VP5W
         SwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KfH3iRIxFYJ1fhTiZ1PPzOKH/EKjKgIPU7+T1IHn0PA=;
        b=WLb0fPWOD0qdr3PgQupPMcxuvawEtlk7KKRf9MbdahuRVvxZ7z+KcWaNkpez66xcKU
         Hw++HcLKGAbPKaWwdtAjY7OA+vsBdgrQWAQ/w6Lmapm/mR8eTy9zg957YSzxaYJHfGh2
         pkutmV7FwlZGwDkTfxwS8CTOSfD+fKAYE3hKF5NsRzZG+X579FcxYSZMtxmmgrTA7v59
         oKsq87eXmSoNzRlRMgCBoM4wA2cXO1ibaaY3i/s8SZP4NN88d7jlmdYe82WX0yExMjSt
         28b53UMWFtFN5FvDuz4jCkaXbrswAFSYEeLXlJi7veqVk1t1Pr+IjR9SXXDp9gTy02yk
         NIiQ==
X-Gm-Message-State: AOAM5313Yl//wHBMQCHJjt/n8wtiFWgYFwLNUfYaP284k0a+97lpYGul
        J2JKwRfSyykeZyL2ORpLVgo4FA==
X-Google-Smtp-Source: ABdhPJz22BO+t4/sZnopHJiIS9RiZj23SNT2TysygLEzOwTMFHcK4mKdX9JNQSKZ2zbwifnuL0IH/g==
X-Received: by 2002:a17:90a:a10c:: with SMTP id s12mr4117070pjp.86.1607086617536;
        Fri, 04 Dec 2020 04:56:57 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.220.97])
        by smtp.gmail.com with ESMTPSA id a124sm4950624pfd.43.2020.12.04.04.56.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2020 04:56:56 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] mm/page_alloc: speeding up the iteration of max_order
Date:   Fri,  4 Dec 2020 20:56:40 +0800
Message-Id: <20201204125640.51804-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we free a page whose order is very close to MAX_ORDER and greater
than pageblock_order, it wastes some CPU cycles to increase max_order
to MAX_ORDER one by one and check the pageblock migratetype of that page
repeatedly especially when MAX_ORDER is much larger than pageblock_order.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
Changes in v2:
 - Rework the code suggested by Vlastimil. Thanks.

 mm/page_alloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f91df593bf71..56e603eea1dd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1002,7 +1002,7 @@ static inline void __free_one_page(struct page *page,
 	struct page *buddy;
 	bool to_tail;
 
-	max_order = min_t(unsigned int, MAX_ORDER, pageblock_order + 1);
+	max_order = min_t(unsigned int, MAX_ORDER - 1, pageblock_order);
 
 	VM_BUG_ON(!zone_is_initialized(zone));
 	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
@@ -1015,7 +1015,7 @@ static inline void __free_one_page(struct page *page,
 	VM_BUG_ON_PAGE(bad_range(zone, page), page);
 
 continue_merging:
-	while (order < max_order - 1) {
+	while (order < max_order) {
 		if (compaction_capture(capc, page, order, migratetype)) {
 			__mod_zone_freepage_state(zone, -(1 << order),
 								migratetype);
@@ -1041,7 +1041,7 @@ static inline void __free_one_page(struct page *page,
 		pfn = combined_pfn;
 		order++;
 	}
-	if (max_order < MAX_ORDER) {
+	if (order < MAX_ORDER - 1) {
 		/* If we are here, it means order is >= pageblock_order.
 		 * We want to prevent merge between freepages on isolate
 		 * pageblock and normal pageblock. Without this, pageblock
@@ -1062,7 +1062,7 @@ static inline void __free_one_page(struct page *page,
 						is_migrate_isolate(buddy_mt)))
 				goto done_merging;
 		}
-		max_order++;
+		max_order = order + 1;
 		goto continue_merging;
 	}
 
-- 
2.11.0

