Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357441D6037
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 12:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgEPKKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 May 2020 06:10:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4852 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbgEPKKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 06:10:00 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7DC1A5D1BEDB315367B0;
        Sat, 16 May 2020 18:09:49 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.237) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Sat, 16 May 2020
 18:09:38 +0800
To:     Christoph Hellwig <hch@lst.de>, <m.szyprowski@samsung.com>,
        <robin.murphy@arm.com>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] dma-coherent: switch to bitmap_zalloc() in
 dma_init_coherent_memory()
Message-ID: <1b02b07b-617e-bc5c-8619-7a46fba5a512@huawei.com>
Date:   Sat, 16 May 2020 18:09:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to bitmap_zalloc() to show clearly in dma_init_coherent_memory().

No functional change.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 kernel/dma/coherent.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 2a0c4985f38e..794b31e61ca0 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -44,7 +44,6 @@ static int dma_init_coherent_memory(phys_addr_t phys_addr,
 	struct dma_coherent_mem *dma_mem = NULL;
 	void *mem_base = NULL;
 	int pages = size >> PAGE_SHIFT;
-	int bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
 	int ret;

 	if (!size) {
@@ -62,7 +61,7 @@ static int dma_init_coherent_memory(phys_addr_t phys_addr,
 		ret = -ENOMEM;
 		goto out;
 	}
-	dma_mem->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
+	dma_mem->bitmap = bitmap_zalloc(pages, GFP_KERNEL);
 	if (!dma_mem->bitmap) {
 		ret = -ENOMEM;
 		goto out;
@@ -90,7 +89,7 @@ static void dma_release_coherent_memory(struct dma_coherent_mem *mem)
 		return;

 	memunmap(mem->virt_base);
-	kfree(mem->bitmap);
+	bitmap_free(mem->bitmap);
 	kfree(mem);
 }

-- 
1.8.3.1

