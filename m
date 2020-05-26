Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5B41CA040
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 03:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgEHBqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 21:46:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50896 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbgEHBqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 21:46:10 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9AC1CDE8277282167DC2;
        Fri,  8 May 2020 09:46:09 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 09:46:00 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH -next] iommu/arm-smmu-v3: remove set but not used variable 'smmu'
Date:   Fri, 8 May 2020 09:49:55 +0800
Message-ID: <20200508014955.87630-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/iommu/arm-smmu-v3.c:2989:26:
warning: variable ‘smmu’ set but not used [-Wunused-but-set-variable]
  struct arm_smmu_device *smmu;

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 42e1ee7e5197..89ee9c5d8b88 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2986,13 +2986,11 @@ static void arm_smmu_release_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_master *master;
-	struct arm_smmu_device *smmu;
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
 		return;
 
 	master = dev_iommu_priv_get(dev);
-	smmu = master->smmu;
 	arm_smmu_detach_dev(master);
 	arm_smmu_disable_pasid(master);
 	kfree(master);
-- 
2.20.1

