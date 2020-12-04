Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E262CF13C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbgLDPwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgLDPv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:51:59 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB7FC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 07:51:19 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id m5so3374687pjv.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 07:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n5W6880DKqAIq9417CXiZaILeavNMzWEyfMm3u4YBRE=;
        b=09RJ7j13Vuz2H2XyZMov0ihLgHO7ayJoLXI8ilqaksMNwAhdRcn43F2QXpQ3A2gd0+
         07ks051irH922qS/kso+dQmpyR4jv4VOem3NsaHrBR5NyntmE7VU6EdPVDrct+CJZrR9
         ORTuNz256TD8L4mhU5tFqK/zVVV3MDpQJLVHrM0Id3l/naW1571tc6tkWZcS6y1jtOs1
         CMKpMKE74A/kEYdJDeUqMx61yTIjlTdiyuyencXRJ5AKleLzpSx0Rgx8fJICdbjzf1Ft
         ORe52RyMXqtU3Lt6x2T+PAPE6+W/B6ioQtJsPcSEN/ZyENEus3JIBybaNxNFDs7hmoH3
         wixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n5W6880DKqAIq9417CXiZaILeavNMzWEyfMm3u4YBRE=;
        b=uBvh9FZOj7utDiDaIEDRT6Kb6amSSAlXdC4AQwab/FWn7OjG4+3sxm7HioABZy2SO1
         1C/OEEY2bE6bnPY/DkEDCmyAtoyzBnGBorw8gqCneFkeu2jidkLLBDwBGz3ls07JZDva
         7gRVwoxiSTGxGGL44eLOSQFhIGfJSNZ/jA63vnoLyFvZO4+QF2Z2BV4edsmYZpdo1qF3
         LBkgV59Ncs6blbFNDgi/2cCoKASTmD6ozkqkrcgdZvRWWpJen5zWw3uy5ArplPv42Z8t
         /cvBGUkeyV7dmLaeqYSgOeU6XQc2fH2APpSGzHs03SWfTHtQ6dS63G6yyqrC3NVUIKW/
         aQtA==
X-Gm-Message-State: AOAM530obUw3Ilfd9u4mf/TD66w3n1XcDWEN7HRJ+O/Pkm7LK6XrKcNw
        Jq6Qo/MLG0gNRPMBwLBKrNKNVQ==
X-Google-Smtp-Source: ABdhPJwCc0IIsjbR0gYu1dcq7gxf9VoEsp2MROjWpOwTMgKpWPZ+lXyQsgYg/lRkxsgL+7tC4KQuzw==
X-Received: by 2002:a17:90a:940c:: with SMTP id r12mr4592347pjo.201.1607097079193;
        Fri, 04 Dec 2020 07:51:19 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id m7sm5626617pfh.72.2020.12.04.07.51.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2020 07:51:18 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3] mm/page_alloc: speeding up the iteration of max_order
Date:   Fri,  4 Dec 2020 23:51:09 +0800
Message-Id: <20201204155109.55451-1-songmuchun@bytedance.com>
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

We also should not be checking migratetype of buddy when "order ==
MAX_ORDER - 1" as the buddy pfn may be invalid, so adjust the condition.
With the new check, we don't need the max_order check anymore, so we
replace it.

Also adjust max_order initialization so that it's lower by one than
previously, which makes the code hopefully more clear.

Fixes: d9dddbf55667 ("mm/page_alloc: prevent merging between isolated and other pageblocks")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
Changes in v3:
 - Update commit log.

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

