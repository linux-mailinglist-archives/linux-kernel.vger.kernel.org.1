Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BED2CDDE0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 19:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387516AbgLCSjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 13:39:53 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8938 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgLCSjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 13:39:53 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cn4Nn518dzhmFH;
        Fri,  4 Dec 2020 02:38:49 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 02:39:01 +0800
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <0x7f454c46@gmail.com>,
        <robin.murphy@arm.com>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH 2/3] iommu: Stop exporting alloc_iova_mem()
Date:   Fri, 4 Dec 2020 02:34:51 +0800
Message-ID: <1607020492-189471-3-git-send-email-john.garry@huawei.com>
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

It is not used outside iova.c

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 3 +--
 include/linux/iova.h | 6 ------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 4803bd83447d..9fed0b040747 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -243,11 +243,10 @@ static struct kmem_cache *iova_cache;
 static unsigned int iova_cache_users;
 static DEFINE_MUTEX(iova_cache_mutex);
 
-struct iova *alloc_iova_mem(void)
+static struct iova *alloc_iova_mem(void)
 {
 	return kmem_cache_zalloc(iova_cache, GFP_ATOMIC | __GFP_NOWARN);
 }
-EXPORT_SYMBOL(alloc_iova_mem);
 
 void free_iova_mem(struct iova *iova)
 {
diff --git a/include/linux/iova.h b/include/linux/iova.h
index a77add571c50..d8c011b6d4ed 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -136,7 +136,6 @@ static inline unsigned long iova_pfn(struct iova_domain *iovad, dma_addr_t iova)
 int iova_cache_get(void);
 void iova_cache_put(void);
 
-struct iova *alloc_iova_mem(void);
 void free_iova_mem(struct iova *iova);
 void free_iova(struct iova_domain *iovad, unsigned long pfn);
 void __free_iova(struct iova_domain *iovad, struct iova *iova);
@@ -171,11 +170,6 @@ static inline void iova_cache_put(void)
 {
 }
 
-static inline struct iova *alloc_iova_mem(void)
-{
-	return NULL;
-}
-
 static inline void free_iova_mem(struct iova *iova)
 {
 }
-- 
2.26.2

