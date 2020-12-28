Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FF72E3B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 14:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406901AbgL1Nv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 08:51:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10085 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406853AbgL1NvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 08:51:24 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D4Jnf3ZXYzMBT8;
        Mon, 28 Dec 2020 21:49:42 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Mon, 28 Dec 2020 21:50:33 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] iommu: amd: Use DEFINE_SPINLOCK() for spinlock
Date:   Mon, 28 Dec 2020 21:51:12 +0800
Message-ID: <20201228135112.28621-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/iommu/amd/iommu_v2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 5ecc0bc608ec..f8d4ad421e07 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -77,7 +77,7 @@ struct fault {
 };
 
 static LIST_HEAD(state_list);
-static spinlock_t state_lock;
+static DEFINE_SPINLOCK(state_lock);
 
 static struct workqueue_struct *iommu_wq;
 
@@ -938,8 +938,6 @@ static int __init amd_iommu_v2_init(void)
 		return 0;
 	}
 
-	spin_lock_init(&state_lock);
-
 	ret = -ENOMEM;
 	iommu_wq = alloc_workqueue("amd_iommu_v2", WQ_MEM_RECLAIM, 0);
 	if (iommu_wq == NULL)
-- 
2.22.0

