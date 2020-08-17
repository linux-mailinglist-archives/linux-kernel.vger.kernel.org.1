Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384812477B3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 21:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbgHQTwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 15:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbgHQTwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 15:52:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32A9C061389;
        Mon, 17 Aug 2020 12:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/50Vf226YKYxDgzVuszalUGR1bKVm91XXFmViiVkF8g=; b=LfnIXtg265gHoZPo/q2evzspn4
        8IBVqBha4asgKp8oT2B0wntbg+OySyIehJR0xQ2fgRG+uYzia9WB8LRpFBW0VuUCD8unqiQ5edJTj
        ArjeYTKSW8dsxLAQg5T/zNk7rsAcxw0EfKxV7ams9wvCpWUrFctdHoeIWNKpEyiIRMUoQ3WwWUwPb
        M9k77jNMrUrU08XKTSb45Ln9UT0f5rNZQP8CxhA6lILpQcYFIfvmJcxNyzUrxkJUomLY0jzaWs2fz
        i4tA24VUw/DJ27xdWmzTVFFS3olmdIjumfWLZm2xci0XaEAUrWOemRZ3vkW1huSbbWsYGeWj3fxnE
        pvLn7zeA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7lAw-0003xl-QK; Mon, 17 Aug 2020 19:52:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: Fix page_is_mergeable() for compound pages
Date:   Mon, 17 Aug 2020 20:52:06 +0100
Message-Id: <20200817195206.15172-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we pass in an offset which is larger than PAGE_SIZE, then
page_is_mergeable() thinks it's not mergeable with the previous bio_vec,
leading to a large number of bio_vecs being used.  Use a slightly more
obvious test that the two pages are compatible with each other.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Fixes: 52d52d1c98a9 ("block: only allow contiguous page structs in a bio_vec")

---
 block/bio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index c63ba04bd629..a9931f23d933 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -740,8 +740,8 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 		struct page *page, unsigned int len, unsigned int off,
 		bool *same_page)
 {
-	phys_addr_t vec_end_addr = page_to_phys(bv->bv_page) +
-		bv->bv_offset + bv->bv_len - 1;
+	size_t bv_end = bv->bv_offset + bv->bv_len;
+	phys_addr_t vec_end_addr = page_to_phys(bv->bv_page) + bv_end - 1;
 	phys_addr_t page_addr = page_to_phys(page);
 
 	if (vec_end_addr + 1 != page_addr + off)
@@ -750,9 +750,9 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 		return false;
 
 	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
-	if (!*same_page && pfn_to_page(PFN_DOWN(vec_end_addr)) + 1 != page)
-		return false;
-	return true;
+	if (*same_page)
+		return true;
+	return (bv->bv_page + bv_end / PAGE_SIZE) == (page + off / PAGE_SIZE);
 }
 
 /*
-- 
2.28.0

