Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35112EBEEB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbhAFNj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:39:57 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9720 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbhAFNj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:39:56 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D9r633xVzzl1B5;
        Wed,  6 Jan 2021 21:38:03 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 6 Jan 2021 21:39:03 +0800
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <robin.murphy@arm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 5/6] iommu: Delete iommu_domain_window_disable()
Date:   Wed, 6 Jan 2021 21:35:10 +0800
Message-ID: <1609940111-28563-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1609940111-28563-1-git-send-email-john.garry@huawei.com>
References: <1609940111-28563-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function iommu_domain_window_disable() is not referenced in the tree, so
delete it.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iommu.c | 9 ---------
 include/linux/iommu.h | 6 ------
 2 files changed, 15 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4f4edb087ce6..20201ef97b8f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2598,15 +2598,6 @@ int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
 }
 EXPORT_SYMBOL_GPL(iommu_domain_window_enable);
 
-void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr)
-{
-	if (unlikely(domain->ops->domain_window_disable == NULL))
-		return;
-
-	return domain->ops->domain_window_disable(domain, wnd_nr);
-}
-EXPORT_SYMBOL_GPL(iommu_domain_window_disable);
-
 /**
  * report_iommu_fault() - report about an IOMMU fault to the IOMMU framework
  * @domain: the iommu domain where the fault has happened
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b3f0e2018c62..72059fcfa108 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -514,7 +514,6 @@ extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
 extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
 				      phys_addr_t offset, u64 size,
 				      int prot);
-extern void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr);
 
 extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 			      unsigned long iova, int flags);
@@ -746,11 +745,6 @@ static inline int iommu_domain_window_enable(struct iommu_domain *domain,
 	return -ENODEV;
 }
 
-static inline void iommu_domain_window_disable(struct iommu_domain *domain,
-					       u32 wnd_nr)
-{
-}
-
 static inline phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 {
 	return 0;
-- 
2.26.2

