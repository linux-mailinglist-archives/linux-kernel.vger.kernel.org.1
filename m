Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A4D27F73B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbgJABWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730736AbgJABWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:22:03 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89661C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:22:03 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id l18so1011945pjz.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qUE/bFNhODNtHNRsHvBXEA45DqCyOEgbacD10q/Sq0U=;
        b=Q/wAFM39Rms4Cg6R01+pxD55x29L4ewoWoUZ+S7Z7mxiKyj0RhW8lBRNyebd0Ajsym
         ZbWsnFfYqThP83i3+/O/No7rhMIGxfFX6rUVBre1ij8ck79HtDUre+cgDGwlT/LebKd7
         Z3N6vqdd6ZmYucEAMJrXw+K3tDHLxHrDTyNJVfWV1DLgF+3nMTuE4dzlFKe0dKyXgZ/L
         +YAOOxe1PoUmw4iwulvRAjtdjroKFzeUaT4zyNguSy9k1VnVUyRr4qZJuGyX9ZzlMCk8
         SxRTLFymBz/46QTBHNI0oHkoPII+NSPNBePPKABgP1ToD/AnhtbNl6ONJ8Y5597Es9Hc
         vLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qUE/bFNhODNtHNRsHvBXEA45DqCyOEgbacD10q/Sq0U=;
        b=frUbAqmuexR0Cq60vQmLNtSVjGEDoCaagZKyiYVC5JDdeOxmmVcUPySg1Ew8HraOLY
         cov1l6M0ZPH+NSco6itQ3AXNnV5C8dEqAqMViwg8Gg2vKHVybtz/np8IG85v4bQkSP0d
         pvqfY03P5ERQ3B5QDHVdpXOk7RZwWpzQXBq7CfiZ2YsVpQvFIaW1sYlVB075Y1APYjUE
         8XLS+A7KKE4ImvmTbcIQ28A23Elvrtp+dcbZFHNMRjrYOE9y5iXC1U0a/pjYIbDtLtQf
         1sEZlIOPf2xLQCPEyqe1xtDyf328OAD7yWBLhRBFJvex00wic4qLCeh/Vg9WOmY+sLDQ
         9FuA==
X-Gm-Message-State: AOAM530lEgatvuth/UTYCfeWGSekXuTvj2TYUHq9w6yO3Mde5fVsbFls
        2+zGNsM8Mht2rkQ2cy0Tdhg/ykF8rMdtiQ==
X-Google-Smtp-Source: ABdhPJyJUcXPh+NYEvxLYkahDBmDEif30rbaBRcZGNLXe+O6HphWKSvRYIFKc6clx1LMc0IZE+eKKg==
X-Received: by 2002:a17:90b:950:: with SMTP id dw16mr3201939pjb.200.1601515322827;
        Wed, 30 Sep 2020 18:22:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id s187sm4229372pfc.134.2020.09.30.18.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 18:22:02 -0700 (PDT)
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
        =?UTF-8?q?=C3=98rjan=20Eide?= <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 5/6] dma-buf: system_heap: Add pagepool support to system heap
Date:   Thu,  1 Oct 2020 01:21:50 +0000
Message-Id: <20201001012151.21149-6-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001012151.21149-1-john.stultz@linaro.org>
References: <20201001012151.21149-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse/abuse the pagepool code from the network code to speed
up allocation performance.

This is similar to the ION pagepool usage, but tries to
utilize generic code instead of a custom implementation.

Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Laura Abbott <labbott@kernel.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Ørjan Eide <orjan.eide@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ezequiel Garcia <ezequiel@collabora.com>
Cc: Simon Ser <contact@emersion.fr>
Cc: James Jones <jajones@nvidia.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/dma-buf/heaps/Kconfig       |  1 +
 drivers/dma-buf/heaps/system_heap.c | 32 +++++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
index a5eef06c4226..f13cde4321b1 100644
--- a/drivers/dma-buf/heaps/Kconfig
+++ b/drivers/dma-buf/heaps/Kconfig
@@ -1,6 +1,7 @@
 config DMABUF_HEAPS_SYSTEM
 	bool "DMA-BUF System Heap"
 	depends on DMABUF_HEAPS
+	select PAGE_POOL
 	help
 	  Choose this option to enable the system dmabuf heap. The system heap
 	  is backed by pages from the buddy allocator. If in doubt, say Y.
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index d18937fa5b18..f30904345cce 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -20,6 +20,7 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <net/page_pool.h>
 
 struct dma_heap *sys_heap;
 
@@ -46,6 +47,7 @@ struct dma_heap_attachment {
 static gfp_t order_flags[] = {HIGH_ORDER_GFP, LOW_ORDER_GFP, LOW_ORDER_GFP};
 static const unsigned int orders[] = {8, 4, 0};
 #define NUM_ORDERS ARRAY_SIZE(orders)
+struct page_pool *pools[NUM_ORDERS];
 
 static struct sg_table *dup_sg_table(struct sg_table *table)
 {
@@ -265,13 +267,17 @@ static void system_heap_dma_buf_release(struct dma_buf *dmabuf)
 	struct system_heap_buffer *buffer = dmabuf->priv;
 	struct sg_table *table;
 	struct scatterlist *sg;
-	int i;
+	int i, j;
 
 	table = &buffer->sg_table;
 	for_each_sg(table->sgl, sg, table->nents, i) {
 		struct page *page = sg_page(sg);
 
-		__free_pages(page, compound_order(page));
+		for (j = 0; j < NUM_ORDERS; j++) {
+			if (compound_order(page) == orders[j])
+				break;
+		}
+		page_pool_put_full_page(pools[j], page, false);
 	}
 	sg_free_table(table);
 	kfree(buffer);
@@ -301,8 +307,7 @@ static struct page *alloc_largest_available(unsigned long size,
 			continue;
 		if (max_order < orders[i])
 			continue;
-
-		page = alloc_pages(order_flags[i], orders[i]);
+		page = page_pool_alloc_pages(pools[i], order_flags[i]);
 		if (!page)
 			continue;
 		return page;
@@ -407,6 +412,25 @@ static const struct dma_heap_ops system_heap_ops = {
 static int system_heap_create(void)
 {
 	struct dma_heap_export_info exp_info;
+	int i;
+
+	for (i = 0; i < NUM_ORDERS; i++) {
+		struct page_pool_params pp;
+
+		memset(&pp, 0, sizeof(pp));
+		pp.order = orders[i];
+		pp.dma_dir = DMA_BIDIRECTIONAL;
+		pools[i] = page_pool_create(&pp);
+
+		if (IS_ERR(pools[i])) {
+			int j;
+
+			pr_err("%s: page pool creation failed!\n", __func__);
+			for (j = 0; j < i; j++)
+				page_pool_destroy(pools[j]);
+			return PTR_ERR(pools[i]);
+		}
+	}
 
 	exp_info.name = "system";
 	exp_info.ops = &system_heap_ops;
-- 
2.17.1

