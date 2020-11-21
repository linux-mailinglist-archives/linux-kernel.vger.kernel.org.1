Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF022BBD13
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 05:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgKUEuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 23:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgKUEuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 23:50:08 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BB9C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 20:50:08 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id q28so9159189pgk.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 20:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GHpNF24q+TKBy5NU/YkjHOD8mOY77JiRU3YsnIt/B8o=;
        b=DCrKMrkRfr7pIobw9eFJ61OTFy8o6Mk8c8usKaJebs3hYGzyI5mm34lx1W72BDn0UK
         dKdVA/2b9wj9YUyc9BfAwlnPFRJr22kYTlUxkWP63lnGSM2R19BlOAk8Lhubi33p6YpL
         kXuTKlemDSfqrc1QgkebjmI37vhXwgvwEP1jBfPOommMfZx/kgfGlYw9nnm8JmY3HyAV
         6HeKjrzWn1NdMz+c1iEKZg+0Lmu8981vgxxf/ZNA0TtWE2Cs/b4MuEuD9P2Q+RhHg7VK
         j0MbY+VVkmT/L2UXflqd/WIknCoxH15HI5OUthHmf1uRAfLVqVwytjq8VsJF3DHT8CPk
         vRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GHpNF24q+TKBy5NU/YkjHOD8mOY77JiRU3YsnIt/B8o=;
        b=acSP0YfgHCABm6xXBfcAQ8pms81+b2AtWE06p8X8VJYSJbPBhefrc5RQyYYUD/42Gx
         VcJH9IUI48w5GYJLPRSRosHe21Td3XsHPpCoMjk4cpJsUoGbC3b70ctTO2LjObzT1OTS
         Fe9HfsbqDPRyn2MI72voE/EBQ7HcgYFQ04hNSbTkWtWIx8SecI3Pxtvf8wQBp3N2p+98
         ZNfv3Imxowats4W2Eb6Hf8z6btdpN3xdw80wN8u8yR3QUI6/3YYUrDV1nXMPnQLuHxVy
         IUSZeWwWxmsJYtEomx9VmILhq4I8xUn1pw+uum7NrGWPaGe/zPUlolqtxW+Fw3P4As2h
         8UkA==
X-Gm-Message-State: AOAM532qszEsROy0eLD3YeDEQfmBC5kpMo1PrwXMY35c77giIyITzlNy
        06Z1zKlVjAwxFbUd7S93bpg1Cc5wuw4rWQ==
X-Google-Smtp-Source: ABdhPJxSUX5Zw8O37YM9KJak58EF62vq3SMAbc0DS/2cMEpBj1/bbfbSKiiRQQWrDtlqY+wdoqzfSw==
X-Received: by 2002:a17:90a:12cc:: with SMTP id b12mr13258284pjg.150.1605934207573;
        Fri, 20 Nov 2020 20:50:07 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id w196sm5407692pfd.177.2020.11.20.20.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 20:50:07 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        =?UTF-8?q?=C3=98rjan=20Eide?= <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v6 5/5] dma-buf: system_heap: Allocate higher order pages if available
Date:   Sat, 21 Nov 2020 04:49:55 +0000
Message-Id: <20201121044955.58215-6-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201121044955.58215-1-john.stultz@linaro.org>
References: <20201121044955.58215-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the system heap can return non-contiguous pages,
try to allocate larger order pages if possible.

This will allow slight performance gains and make implementing
page pooling easier.

Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Laura Abbott <labbott@kernel.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Daniel Mentz <danielmentz@google.com>
Cc: Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc: Ørjan Eide <orjan.eide@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ezequiel Garcia <ezequiel@collabora.com>
Cc: Simon Ser <contact@emersion.fr>
Cc: James Jones <jajones@nvidia.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Brian Starkey <brian.starkey@arm.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3:
* Use page_size() rather then opencoding it
v5:
* Add comment explaining order size rational
---
 drivers/dma-buf/heaps/system_heap.c | 89 +++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 18 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index b1a7b355132f..de275b7ff1ed 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -40,6 +40,20 @@ struct dma_heap_attachment {
 	bool mapped;
 };
 
+#define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
+				| __GFP_NORETRY) & ~__GFP_RECLAIM) \
+				| __GFP_COMP)
+#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
+static gfp_t order_flags[] = {HIGH_ORDER_GFP, LOW_ORDER_GFP, LOW_ORDER_GFP};
+/*
+ * The selection of the orders used for allocation (1MB, 64K, 4K) is designed
+ * to match with the sizes often found in IOMMUs. Using order 4 pages instead
+ * of order 0 pages can significantly improve the performance of many IOMMUs
+ * by reducing TLB pressure and time spent updating page tables.
+ */
+static const unsigned int orders[] = {8, 4, 0};
+#define NUM_ORDERS ARRAY_SIZE(orders)
+
 static struct sg_table *dup_sg_table(struct sg_table *table)
 {
 	struct sg_table *new_table;
@@ -272,8 +286,11 @@ static void system_heap_dma_buf_release(struct dma_buf *dmabuf)
 	int i;
 
 	table = &buffer->sg_table;
-	for_each_sgtable_sg(table, sg, i)
-		__free_page(sg_page(sg));
+	for_each_sg(table->sgl, sg, table->nents, i) {
+		struct page *page = sg_page(sg);
+
+		__free_pages(page, compound_order(page));
+	}
 	sg_free_table(table);
 	kfree(buffer);
 }
@@ -291,6 +308,26 @@ static const struct dma_buf_ops system_heap_buf_ops = {
 	.release = system_heap_dma_buf_release,
 };
 
+static struct page *alloc_largest_available(unsigned long size,
+					    unsigned int max_order)
+{
+	struct page *page;
+	int i;
+
+	for (i = 0; i < NUM_ORDERS; i++) {
+		if (size <  (PAGE_SIZE << orders[i]))
+			continue;
+		if (max_order < orders[i])
+			continue;
+
+		page = alloc_pages(order_flags[i], orders[i]);
+		if (!page)
+			continue;
+		return page;
+	}
+	return NULL;
+}
+
 static int system_heap_allocate(struct dma_heap *heap,
 				unsigned long len,
 				unsigned long fd_flags,
@@ -298,11 +335,13 @@ static int system_heap_allocate(struct dma_heap *heap,
 {
 	struct system_heap_buffer *buffer;
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	unsigned long size_remaining = len;
+	unsigned int max_order = orders[0];
 	struct dma_buf *dmabuf;
 	struct sg_table *table;
 	struct scatterlist *sg;
-	pgoff_t pagecount;
-	pgoff_t pg;
+	struct list_head pages;
+	struct page *page, *tmp_page;
 	int i, ret = -ENOMEM;
 
 	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
@@ -314,25 +353,35 @@ static int system_heap_allocate(struct dma_heap *heap,
 	buffer->heap = heap;
 	buffer->len = len;
 
-	table = &buffer->sg_table;
-	pagecount = len / PAGE_SIZE;
-	if (sg_alloc_table(table, pagecount, GFP_KERNEL))
-		goto free_buffer;
-
-	sg = table->sgl;
-	for (pg = 0; pg < pagecount; pg++) {
-		struct page *page;
+	INIT_LIST_HEAD(&pages);
+	i = 0;
+	while (size_remaining > 0) {
 		/*
 		 * Avoid trying to allocate memory if the process
 		 * has been killed by SIGKILL
 		 */
 		if (fatal_signal_pending(current))
-			goto free_pages;
-		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+			goto free_buffer;
+
+		page = alloc_largest_available(size_remaining, max_order);
 		if (!page)
-			goto free_pages;
+			goto free_buffer;
+
+		list_add_tail(&page->lru, &pages);
+		size_remaining -= page_size(page);
+		max_order = compound_order(page);
+		i++;
+	}
+
+	table = &buffer->sg_table;
+	if (sg_alloc_table(table, i, GFP_KERNEL))
+		goto free_buffer;
+
+	sg = table->sgl;
+	list_for_each_entry_safe(page, tmp_page, &pages, lru) {
 		sg_set_page(sg, page, page_size(page), 0);
 		sg = sg_next(sg);
+		list_del(&page->lru);
 	}
 
 	/* create the dmabuf */
@@ -352,14 +401,18 @@ static int system_heap_allocate(struct dma_heap *heap,
 		/* just return, as put will call release and that will free */
 		return ret;
 	}
-
 	return ret;
 
 free_pages:
-	for_each_sgtable_sg(table, sg, i)
-		__free_page(sg_page(sg));
+	for_each_sgtable_sg(table, sg, i) {
+		struct page *p = sg_page(sg);
+
+		__free_pages(p, compound_order(p));
+	}
 	sg_free_table(table);
 free_buffer:
+	list_for_each_entry_safe(page, tmp_page, &pages, lru)
+		__free_pages(page, compound_order(page));
 	kfree(buffer);
 
 	return ret;
-- 
2.17.1

