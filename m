Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9246B2C67B6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 15:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbgK0OTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 09:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730796AbgK0OTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 09:19:11 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEE1C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 06:19:09 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id k11so4477676pgq.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 06:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZVrd6qs4ki2UlD5jguyTyXf7x5AtIUQVbvxCxPiXfO0=;
        b=aDNLbwXmYnolsPDaydC++XyPfDwRIFKddL8MhZ3YwIlBZaLqYvleF/yDFEj4d76t7l
         oNYpJMwMQV/8jTi1A4YNWeeb0KWuoMWn+F2II6Z8/9aNgA0xhkmV93kBnHSQBqwWZDQo
         ZsVZvpJIebdADw8olIZ1x2TCPfRZoAVPmHSxZo2s6X+C7IQrf7AQhQBB1JiceDo2cDWg
         SpxabpvYsVtqkn+EHy9q4RlyPj4BKzybOQt3N/TG7VzoPTBM41FBahaRX8vFNl72ndg7
         vTnI97WKczdYrOxgHsRdiPnaiXa8bU0pQdNAuX79oMlwaNDZE0EHMBxmB3k96SRQy1as
         33oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZVrd6qs4ki2UlD5jguyTyXf7x5AtIUQVbvxCxPiXfO0=;
        b=eSvXHuP8Eeg7+SXCdKnRK6WoX/khwrSKTX+YzhqcvrU161KmRaO4jxEqJFAlfnbDJa
         8Unl32nGZQ4UiprPfWqRy8sdAI0JgofZ23ME5zNhOCecK/77Mc/VdrmqzUfcM7kGtHmU
         sKKvdtjQL24UhOgQlh45QYz+l3DRpWXA/N+ULxhnlCLhE7z05n8+sDU0pg+W8AZ7Zhez
         N39+EmyHICa6fpGfWmcXnbclfMH2z8Ef3N0ZlvAlCXoa5BvK3ytgL2AvJD91d2iKzINF
         h/I9kjchab9BABWNBIYKmpRDydjWpHMEccQJISpsa+GNltBtDls54YbOkrlYNWkzLfBX
         PBpw==
X-Gm-Message-State: AOAM532orr+uDMcTNJrkWYAbrVdKJwsQwTtII+8lvJmXNO7yxHPHgVD3
        VyUmith2UzcaJEwo+jzDkh/q4g==
X-Google-Smtp-Source: ABdhPJyYuKLf2waW3TRKRuKyMAOfAM66cBhkMb6c6Sr5LP/M7lAjsaZB95K7oeA4k3fWyXHCIaxInA==
X-Received: by 2002:a63:4a0e:: with SMTP id x14mr6853146pga.376.1606486749013;
        Fri, 27 Nov 2020 06:19:09 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id z126sm7945117pfz.120.2020.11.27.06.19.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Nov 2020 06:19:08 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm/page_alloc: Do not isolate redundant pageblock
Date:   Fri, 27 Nov 2020 22:19:00 +0800
Message-Id: <20201127141900.43348-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current pageblock isolation logic could isolate each pageblock individually
since commit d9dddbf55667 ("mm/page_alloc: prevent merging between isolated
and other pageblocks"). So we not need to concern about page allocator
merges buddies from different pageblocks and changes MIGRATE_ISOLATE to
some other migration type.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/page_alloc.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cefbef32bf4a..608a2c2b8ab7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8313,16 +8313,14 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 }
 
 #ifdef CONFIG_CONTIG_ALLOC
-static unsigned long pfn_max_align_down(unsigned long pfn)
+static unsigned long pfn_align_down(unsigned long pfn)
 {
-	return pfn & ~(max_t(unsigned long, MAX_ORDER_NR_PAGES,
-			     pageblock_nr_pages) - 1);
+	return pfn & ~(pageblock_nr_pages - 1);
 }
 
-static unsigned long pfn_max_align_up(unsigned long pfn)
+static unsigned long pfn_align_up(unsigned long pfn)
 {
-	return ALIGN(pfn, max_t(unsigned long, MAX_ORDER_NR_PAGES,
-				pageblock_nr_pages));
+	return ALIGN(pfn, pageblock_nr_pages);
 }
 
 /* [start, end) must belong to a single zone. */
@@ -8415,14 +8413,6 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	INIT_LIST_HEAD(&cc.migratepages);
 
 	/*
-	 * What we do here is we mark all pageblocks in range as
-	 * MIGRATE_ISOLATE.  Because pageblock and max order pages may
-	 * have different sizes, and due to the way page allocator
-	 * work, we align the range to biggest of the two pages so
-	 * that page allocator won't try to merge buddies from
-	 * different pageblocks and change MIGRATE_ISOLATE to some
-	 * other migration type.
-	 *
 	 * Once the pageblocks are marked as MIGRATE_ISOLATE, we
 	 * migrate the pages from an unaligned range (ie. pages that
 	 * we are interested in).  This will put all the pages in
@@ -8438,8 +8428,8 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
 
-	ret = start_isolate_page_range(pfn_max_align_down(start),
-				       pfn_max_align_up(end), migratetype, 0);
+	ret = start_isolate_page_range(pfn_align_down(start), pfn_align_up(end),
+				       migratetype, 0);
 	if (ret)
 		return ret;
 
@@ -8522,8 +8512,8 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 		free_contig_range(end, outer_end - end);
 
 done:
-	undo_isolate_page_range(pfn_max_align_down(start),
-				pfn_max_align_up(end), migratetype);
+	undo_isolate_page_range(pfn_align_down(start), pfn_align_up(end),
+				migratetype);
 	return ret;
 }
 EXPORT_SYMBOL(alloc_contig_range);
-- 
2.11.0

