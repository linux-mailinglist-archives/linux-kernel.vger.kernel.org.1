Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C302743C1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgIVOAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgIVOAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:00:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEDCC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 07:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Yx8f8GkqtnDFX1ZsrbiU82PuTcVlvAe9aJmHSokocpE=; b=LAK+hx0VgwhamqafHhHwBfYKHN
        +j0fmrQS2tLZ1HDtIXhPvrc1EI/R4d4mDYvIPMY9sbkIztfhGpVz47iNQclmx88S08wQ+jkbWxYHr
        cuTuAql63wyZzIOL+o2YJUKVKWYSTe9ZNVhOzGkDVSMHpxPGFECrdc3YmSjfD4fhtZ4bRbK0zGfKk
        GR/udnDuZ9JBNMyW4pTIsAgYUBayjvc4dbgRfr/k7PNBPs1noOQWSD0Kcpzjap6JXTa2+JEsYsFo8
        VBn+uetkK2R2GTo9gUiSXErrea4aIxCu+WxGYAykDL4NQq20n0ih1V2EirbhlqSq0B9HAa8lJHZ9Q
        h2buQGrw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKiqH-0006t1-Da; Tue, 22 Sep 2020 14:00:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Nick Piggin <npiggin@suse.de>, Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] page_alloc: Fix freeing non-compound pages
Date:   Tue, 22 Sep 2020 15:00:17 +0100
Message-Id: <20200922140017.26387-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a very rare race which leaks memory:

Page P0 is allocated to the page cache.
Page P1 is free.

Thread A		Thread B		Thread C
find_get_entry():
xas_load() returns P0
						Removes P0 from page cache
						Frees P0
						P0 merged with its buddy P1
			alloc_pages(GFP_KERNEL, 1) returns P0
			P0 has refcount 1
page_cache_get_speculative(P0)
P0 has refcount 2
			__free_pages(P0)
			P0 has refcount 1
put_page(P0)
P1 is not freed

Fix this by freeing all the pages in __free_pages() that won't be freed
by the call to put_page().  It's usually not a good idea to split a page,
but this is a very unlikely scenario.

Fixes: e286781d5f2e ("mm: speculative page references")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page_alloc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fab5e97dc9ca..5db74797db39 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4943,10 +4943,19 @@ static inline void free_the_page(struct page *page, unsigned int order)
 		__free_pages_ok(page, order);
 }
 
+/*
+ * If we free a non-compound allocation, another thread may have a
+ * speculative reference to the first page.  It has no way of knowing
+ * about the rest of the allocation, so we have to free all but the
+ * first page here.
+ */
 void __free_pages(struct page *page, unsigned int order)
 {
 	if (put_page_testzero(page))
 		free_the_page(page, order);
+	else
+		while (order-- > 0)
+			free_the_page(page + (1 << order), order);
 }
 EXPORT_SYMBOL(__free_pages);
 
-- 
2.28.0

