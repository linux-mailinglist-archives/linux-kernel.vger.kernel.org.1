Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247BC2B8B89
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgKSGTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:19:06 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39962 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726224AbgKSGTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:19:06 -0500
X-UUID: aea9e6e6d67143c5b82407cfc8e7b8e2-20201119
X-UUID: aea9e6e6d67143c5b82407cfc8e7b8e2-20201119
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1688754634; Thu, 19 Nov 2020 14:19:02 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 19 Nov 2020 14:19:00 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 Nov 2020 14:18:59 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <jun.wen@mediatek.com>
Subject: [PATCH v2 2/6] iommu: Add iova and size as parameters in iommu_iotlb_map
Date:   Thu, 19 Nov 2020 14:18:32 +0800
Message-ID: <20201119061836.15238-3-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201119061836.15238-1-yong.wu@mediatek.com>
References: <20201119061836.15238-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iotlb_sync_map allow IOMMU drivers tlb sync after completing the whole
mapping. This patch adds iova and size as the parameters in it. then the
IOMMU driver could flush tlb with the whole range once after iova mapping
to improve performance.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/iommu.c      | 6 +++---
 drivers/iommu/tegra-gart.c | 3 ++-
 include/linux/iommu.h      | 3 ++-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index decef851fa3a..df87c8e825f7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2425,7 +2425,7 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	might_sleep();
 	ret = __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
 	if (ret == 0 && ops->iotlb_sync_map)
-		ops->iotlb_sync_map(domain);
+		ops->iotlb_sync_map(domain, iova, size);
 
 	return ret;
 }
@@ -2439,7 +2439,7 @@ int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
 
 	ret = __iommu_map(domain, iova, paddr, size, prot, GFP_ATOMIC);
 	if (ret == 0 && ops->iotlb_sync_map)
-		ops->iotlb_sync_map(domain);
+		ops->iotlb_sync_map(domain, iova, size);
 
 	return ret;
 }
@@ -2557,7 +2557,7 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 	}
 
 	if (ops->iotlb_sync_map)
-		ops->iotlb_sync_map(domain);
+		ops->iotlb_sync_map(domain, iova, mapped);
 	return mapped;
 
 out_err:
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index fac720273889..d15d13a98ed1 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -261,7 +261,8 @@ static int gart_iommu_of_xlate(struct device *dev,
 	return 0;
 }
 
-static void gart_iommu_sync_map(struct iommu_domain *domain)
+static void gart_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
+				size_t size)
 {
 	FLUSH_GART_REGS(gart_handle);
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b95a6f8db6ff..794d4085edd3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -244,7 +244,8 @@ struct iommu_ops {
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
 		     size_t size, struct iommu_iotlb_gather *iotlb_gather);
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
-	void (*iotlb_sync_map)(struct iommu_domain *domain);
+	void (*iotlb_sync_map)(struct iommu_domain *domain, unsigned long iova,
+			       size_t size);
 	void (*iotlb_sync)(struct iommu_domain *domain,
 			   struct iommu_iotlb_gather *iotlb_gather);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
-- 
2.18.0

