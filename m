Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0982D9926
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbgLNNp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:45:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9527 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440003AbgLNNo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:44:58 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CvjK90zgmzhtBs;
        Mon, 14 Dec 2020 21:43:41 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:44:09 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] iommu/amd/init: convert comma to semicolon
Date:   Mon, 14 Dec 2020 21:44:38 +0800
Message-ID: <20201214134438.4776-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/iommu/amd/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 23a790f8f550..dad011e88268 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2053,8 +2053,8 @@ static int iommu_init_intcapxt(struct amd_iommu *iommu)
 	 * whenever the irq affinity is changed from user-space.
 	 */
 	notify->irq = iommu->dev->irq;
-	notify->notify = _irq_notifier_notify,
-	notify->release = _irq_notifier_release,
+	notify->notify = _irq_notifier_notify;
+	notify->release = _irq_notifier_release;
 	ret = irq_set_affinity_notifier(iommu->dev->irq, notify);
 	if (ret) {
 		pr_err("Failed to register irq affinity notifier (devid=%#x, irq %d)\n",
-- 
2.22.0

