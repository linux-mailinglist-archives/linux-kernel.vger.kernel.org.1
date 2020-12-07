Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E22E2D0EE8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgLGLYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:24:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9112 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgLGLYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:24:11 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CqLWm1h5RzM1Tb;
        Mon,  7 Dec 2020 19:22:44 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 19:23:15 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <jean-philippe@linaro.org>, <Jonathan.Cameron@huawei.com>,
        <song.bao.hua@hisilicon.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iommu/arm-smmu-v3: Fix not checking return value about devm_add_action
Date:   Mon, 7 Dec 2020 19:23:29 +0800
Message-ID: <1607340209-51539-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_add_action_or_reset to avoid the situation where the release
function is not called when devm_add_action returns an error.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

v2:
check the return value about evm_add_action_or_reset()
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2ddf5ec..76c28e7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2680,7 +2680,8 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
 		ret = -ENOMEM;
 	} else {
 		cmdq->valid_map = bitmap;
-		devm_add_action(smmu->dev, arm_smmu_cmdq_free_bitmap, bitmap);
+		ret = devm_add_action_or_reset(smmu->dev,
+					       arm_smmu_cmdq_free_bitmap, bitmap);
 	}
 
 	return ret;
@@ -2938,7 +2939,7 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	}
 
 	/* Add callback to free MSIs on teardown */
-	devm_add_action(dev, arm_smmu_free_msis, dev);
+	devm_add_action_or_reset(dev, arm_smmu_free_msis, dev);
 }
 
 static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
-- 
2.7.4

