Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F122B5723
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 03:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgKQCyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 21:54:20 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7633 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgKQCyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 21:54:20 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CZrB46mNWz15LKF;
        Tue, 17 Nov 2020 10:54:04 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 17 Nov 2020
 10:54:08 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     <joro@8bytes.org>, <yangyingliang@huawei.com>
Subject: [PATCH] iommu: fix return error code in iommu_probe_device()
Date:   Tue, 17 Nov 2020 10:52:38 +0800
Message-ID: <20201117025238.3425422-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If iommu_group_get() failed, it need return error code
in iommu_probe_device().

Fixes: cf193888bfbd ("iommu: Move new probe_device path...")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iommu/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b53446bb8c6b..6f4a32df90f6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -253,8 +253,10 @@ int iommu_probe_device(struct device *dev)
 		goto err_out;
 
 	group = iommu_group_get(dev);
-	if (!group)
+	if (!group) {
+		ret = -ENODEV;
 		goto err_release;
+	}
 
 	/*
 	 * Try to allocate a default domain - needs support from the
-- 
2.25.1

