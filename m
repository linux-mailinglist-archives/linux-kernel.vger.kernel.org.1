Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71D42CBCD0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgLBMVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgLBMVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:21:09 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AF1C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 04:20:23 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id o7so891054pjj.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 04:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7FKe5u39kZa3azkaY3U9g1f4IsOfUHKX7jY6pnUAmOY=;
        b=V3xlJkKZ70acNNBym+d6CYtKp1yDDc4ID6bmQ6KHu8jjBR61rLRA/1N/Ch62RjkzT8
         SB0iV7jebdkFq/+sFyWs4GSTf3g+I6R4qkhXUXPAdC7UPrV9Jspern7G72Baamtx0fhf
         1D2RTFqb9VExlgYlhkSeu1u9U0pMVXt+D17FGVhDmilkOKAMOUeeD+7omPQMztjpd3yS
         RGAI3GKCD3b/DrvlNiHWNiD4L4scifVM1cm0pe8CswTLjofiaIkPqZn9cTPxqOlgwrvf
         1xBLgBsjdwVOZu2S8xqnpULrVGBeJ6EFhJrNJiltJiX9FuH0AQHSTS1/FtsSkPoXgomm
         mTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7FKe5u39kZa3azkaY3U9g1f4IsOfUHKX7jY6pnUAmOY=;
        b=qVn7CBIrIzqcyE6MeiON/8NWPWvQxTJiMmWFxN3li4rPecUDTc7FZc1gcM+kRXvtwT
         JxGL+E9lCyYfBxCZYzRmYLM7s10n+3P/vCxt5y1v1ESjmi0cg3G0KsNufndksVtRfrX9
         sCwASf1omp1T2t090G6kldVV/nl9oGELxNGABfrFht8Ufs4NJahsoYnZ+cLDRg7ubgv9
         CErFqBKX8MfBBc3VlhyeI7h9KXmrHUX7miRM1iEzP189XrvH8Hl5nn9GVDySDybnuiEY
         xvn4Y/4v1Q21ABpTids7oVTZth5Qd3K95goHHyxftihQYj5Hu3qO0pRDp0qdqSnU6WqC
         0DcQ==
X-Gm-Message-State: AOAM531kMlQrwUFcH5ZHj970QA1JgvMpFuy9SJ6buYXUVbALqNA//V2G
        YQ31oyRG6N0sXC7JeKXrS5nQWg==
X-Google-Smtp-Source: ABdhPJysL+XklWYuRtEfA6QYEVT41b0A/ZoAWdmup3o7oQPNXQ9BGs9HvZUlvd5q/8z49Sg10YEijg==
X-Received: by 2002:a17:90a:f0c1:: with SMTP id fa1mr1963337pjb.148.1606911622703;
        Wed, 02 Dec 2020 04:20:22 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id d68sm2320129pfc.135.2020.12.02.04.20.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 04:20:22 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm/page_alloc: speeding up the iteration of max_order
Date:   Wed,  2 Dec 2020 20:18:38 +0800
Message-Id: <20201202121838.75218-1-songmuchun@bytedance.com>
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
 mm/page_alloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 141f12e5142c..959541234e1d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1041,7 +1041,7 @@ static inline void __free_one_page(struct page *page,
 		pfn = combined_pfn;
 		order++;
 	}
-	if (max_order < MAX_ORDER) {
+	if (max_order < MAX_ORDER && order < MAX_ORDER - 1) {
 		/* If we are here, it means order is >= pageblock_order.
 		 * We want to prevent merge between freepages on isolate
 		 * pageblock and normal pageblock. Without this, pageblock
@@ -1062,6 +1062,8 @@ static inline void __free_one_page(struct page *page,
 						is_migrate_isolate(buddy_mt)))
 				goto done_merging;
 		}
+		if (unlikely(order != max_order - 1))
+			max_order = order + 1;
 		max_order++;
 		goto continue_merging;
 	}
-- 
2.11.0

