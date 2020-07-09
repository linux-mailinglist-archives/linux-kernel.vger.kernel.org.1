Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E20A21A495
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 18:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgGIQTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 12:19:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:39146 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbgGIQTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:19:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EA3F0AEC8;
        Thu,  9 Jul 2020 16:19:33 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     hch@lst.de, Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dma-pool: Introduce dma_guess_pool()
Date:   Thu,  9 Jul 2020 18:19:03 +0200
Message-Id: <20200709161903.26229-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709161903.26229-1-nsaenzjulienne@suse.de>
References: <20200709161903.26229-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma-pool's dev_to_pool() creates the false impression that there is a
way to grantee a mapping between a device's DMA constraints and an
atomic pool. It tuns out it's just a guess, and the device might need to
use an atomic pool containing memory from a 'safer' (or lower) memory
zone.

To help mitigate this, introduce dma_guess_pool() which can be fed a
device's DMA constraints or an atomic pool already known to be faulty in
order for it to provide a better guess at which pool to use.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 kernel/dma/pool.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 7363640fc91c..3d518de07617 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -203,7 +203,7 @@ static int __init dma_atomic_pool_init(void)
 }
 postcore_initcall(dma_atomic_pool_init);
 
-static inline struct gen_pool *dev_to_pool(struct device *dev)
+static inline struct gen_pool *dma_guess_pool_from_device(struct device *dev)
 {
 	u64 phys_mask;
 	gfp_t gfp;
@@ -217,10 +217,30 @@ static inline struct gen_pool *dev_to_pool(struct device *dev)
 	return atomic_pool_kernel;
 }
 
+static inline struct gen_pool *dma_get_safer_pool(struct gen_pool *bad_pool)
+{
+	if (bad_pool == atomic_pool_kernel)
+		return atomic_pool_dma32 ? : atomic_pool_dma;
+
+	if (bad_pool == atomic_pool_dma32)
+		return atomic_pool_dma;
+
+	return NULL;
+}
+
+static inline struct gen_pool *dma_guess_pool(struct device *dev,
+					      struct gen_pool *bad_pool)
+{
+	if (bad_pool)
+		return dma_get_safer_pool(bad_pool);
+
+	return dma_guess_pool_from_device(dev);
+}
+
 void *dma_alloc_from_pool(struct device *dev, size_t size,
 			  struct page **ret_page, gfp_t flags)
 {
-	struct gen_pool *pool = dev_to_pool(dev);
+	struct gen_pool *pool = dma_guess_pool(dev, NULL);
 	unsigned long val;
 	void *ptr = NULL;
 
@@ -245,7 +265,7 @@ void *dma_alloc_from_pool(struct device *dev, size_t size,
 
 bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 {
-	struct gen_pool *pool = dev_to_pool(dev);
+	struct gen_pool *pool = dma_guess_pool(dev, NULL);
 
 	if (!pool || !gen_pool_has_addr(pool, (unsigned long)start, size))
 		return false;
-- 
2.27.0

