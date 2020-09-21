Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EC52735EE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 00:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgIUWqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 18:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbgIUWqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 18:46:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649AEC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/CL2jZW4pePP0RHRCCOv32Ria9oi2v/yKP8cKvax75g=; b=Q4dXJoQqauOLxi9+sOeBKQE6L1
        ZSP3emcO3AK49qoInKdtP03kH0/1eTBGJaCt22W2TcpER3yhxslDBprt2ZyquiUi4gUArpu/MJrMO
        y3pWk5vNZo31mPDRbG/eBL5eY9Ei7etSQvNRMS4wOqSn8QzdKAHeLw2mmZntF93SsTZ6Z0KZy0HD1
        IeiIRgIWmxz5Dt97XGatwDDzWuEU4/ZTeTje90sGKrfMZmEkRpEeYmgv2w2XqvV4fWObwBBPh33DQ
        oxUeR/PzVPs2pay2khX6HW20mUG2XA31KzGdfBake/OZGBzntjzO74XhJaewq3JWfVzm+WTjy9I3+
        BokN+RZw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKUZq-0005Oz-1d; Mon, 21 Sep 2020 22:46:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, hch@lst.de,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH 1/2] vmalloc: Free pages as a batch
Date:   Mon, 21 Sep 2020 23:46:27 +0100
Message-Id: <20200921224628.20704-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use release_pages() to free the pages allocated by vmalloc().  This is
slightly more efficient in terms of disabling and enabling IRQs once
per batch instead of once per page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/vmalloc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index be4724b916b3..3893fc8915c4 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2263,16 +2263,8 @@ static void __vunmap(const void *addr, int deallocate_pages)
 	vm_remove_mappings(area, deallocate_pages);
 
 	if (deallocate_pages) {
-		int i;
-
-		for (i = 0; i < area->nr_pages; i++) {
-			struct page *page = area->pages[i];
-
-			BUG_ON(!page);
-			__free_pages(page, 0);
-		}
+		release_pages(area->pages, area->nr_pages);
 		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
-
 		kvfree(area->pages);
 	}
 
-- 
2.28.0

