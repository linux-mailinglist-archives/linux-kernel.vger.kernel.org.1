Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432402EBEEC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbhAFNj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:39:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9721 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbhAFNj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:39:57 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D9r63473jzl1SZ;
        Wed,  6 Jan 2021 21:38:03 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 6 Jan 2021 21:39:03 +0800
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <robin.murphy@arm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 4/6] iommu: Stop exporting iommu_map_sg_atomic()
Date:   Wed, 6 Jan 2021 21:35:09 +0800
Message-ID: <1609940111-28563-5-git-send-email-john.garry@huawei.com>
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

Function iommu_map_sg_atomic() is only referenced in dma-iommu.c, which
can only be built-in, so stop exporting.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ffeebda8d6de..4f4edb087ce6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2586,7 +2586,6 @@ size_t iommu_map_sg_atomic(struct iommu_domain *domain, unsigned long iova,
 {
 	return __iommu_map_sg(domain, iova, sg, nents, prot, GFP_ATOMIC);
 }
-EXPORT_SYMBOL_GPL(iommu_map_sg_atomic);
 
 int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
 			       phys_addr_t paddr, u64 size, int prot)
-- 
2.26.2

