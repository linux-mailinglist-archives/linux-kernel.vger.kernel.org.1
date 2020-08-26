Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9156425310B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 16:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgHZOSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 10:18:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10267 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727879AbgHZOSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:18:11 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E1FAA4CF80D800D64A53;
        Wed, 26 Aug 2020 22:18:07 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.226) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 26 Aug 2020 22:18:00 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] iommu/arm-smmu-v3: Fix l1 stream table size in the error message
Date:   Wed, 26 Aug 2020 22:17:58 +0800
Message-ID: <20200826141758.341-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actual size of level-1 stream table is l1size. This looks like an
oversight on commit d2e88e7c081ef ("iommu/arm-smmu: Fix LOG2SIZE setting
for 2-level stream tables") which forgot to update the @size in error
message as well.

As memory allocation failure is already bad enough, nothing worse would
happen. But let's be careful.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c192544e874b..bb458d0c7b73 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3280,7 +3280,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 	if (!strtab) {
 		dev_err(smmu->dev,
 			"failed to allocate l1 stream table (%u bytes)\n",
-			size);
+			l1size);
 		return -ENOMEM;
 	}
 	cfg->strtab = strtab;
-- 
2.19.1

