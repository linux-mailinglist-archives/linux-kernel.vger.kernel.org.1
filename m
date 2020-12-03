Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285D52CDDE3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 19:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbgLCSkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 13:40:03 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8242 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731590AbgLCSjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 13:39:53 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cn4NW3qt0zkkVW;
        Fri,  4 Dec 2020 02:38:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 02:39:02 +0800
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <0x7f454c46@gmail.com>,
        <robin.murphy@arm.com>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH 3/3] iommu: Stop exporting free_iova_mem()
Date:   Fri, 4 Dec 2020 02:34:52 +0800
Message-ID: <1607020492-189471-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1607020492-189471-1-git-send-email-john.garry@huawei.com>
References: <1607020492-189471-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has no user outside iova.c

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 3 +--
 include/linux/iova.h | 5 -----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 9fed0b040747..f68fe4c0df28 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -248,12 +248,11 @@ static struct iova *alloc_iova_mem(void)
 	return kmem_cache_zalloc(iova_cache, GFP_ATOMIC | __GFP_NOWARN);
 }
 
-void free_iova_mem(struct iova *iova)
+static void free_iova_mem(struct iova *iova)
 {
 	if (iova->pfn_lo != IOVA_ANCHOR)
 		kmem_cache_free(iova_cache, iova);
 }
-EXPORT_SYMBOL(free_iova_mem);
 
 int iova_cache_get(void)
 {
diff --git a/include/linux/iova.h b/include/linux/iova.h
index d8c011b6d4ed..76e16ae20729 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -136,7 +136,6 @@ static inline unsigned long iova_pfn(struct iova_domain *iovad, dma_addr_t iova)
 int iova_cache_get(void);
 void iova_cache_put(void);
 
-void free_iova_mem(struct iova *iova);
 void free_iova(struct iova_domain *iovad, unsigned long pfn);
 void __free_iova(struct iova_domain *iovad, struct iova *iova);
 struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
@@ -170,10 +169,6 @@ static inline void iova_cache_put(void)
 {
 }
 
-static inline void free_iova_mem(struct iova *iova)
-{
-}
-
 static inline void free_iova(struct iova_domain *iovad, unsigned long pfn)
 {
 }
-- 
2.26.2

