Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CD9303E25
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392256AbhAZNIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:08:45 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11443 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392310AbhAZNI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:08:29 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DQ6Sb2LQ1zjCX4;
        Tue, 26 Jan 2021 21:06:39 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.82.74) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Tue, 26 Jan 2021 21:07:30 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <joro@8bytes.org>, <jean-philippe@linaro.org>, <will@kernel.org>,
        <prime.zeng@hisilicon.com>, <linuxarm@openeuler.org>
Subject: [PATCH] iommu: Check dev->iommu in iommu_dev_xxx functions
Date:   Tue, 26 Jan 2021 13:06:29 +0000
Message-ID: <20210126130629.8928-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.82.74]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device iommu probe/attach might have failed leaving dev->iommu
to NULL and device drivers may still invoke these functions resulting
a crash in iommu vendor driver code. Hence make sure we check that.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ffeebda8d6de..cb68153c5cc0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2867,7 +2867,7 @@ bool iommu_dev_has_feature(struct device *dev, enum iommu_dev_features feat)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 
-	if (ops && ops->dev_has_feat)
+	if (dev->iommu && ops && ops->dev_has_feat)
 		return ops->dev_has_feat(dev, feat);
 
 	return false;
@@ -2878,7 +2878,7 @@ int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 
-	if (ops && ops->dev_enable_feat)
+	if (dev->iommu && ops && ops->dev_enable_feat)
 		return ops->dev_enable_feat(dev, feat);
 
 	return -ENODEV;
@@ -2894,7 +2894,7 @@ int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 
-	if (ops && ops->dev_disable_feat)
+	if (dev->iommu && ops && ops->dev_disable_feat)
 		return ops->dev_disable_feat(dev, feat);
 
 	return -EBUSY;
@@ -2905,7 +2905,7 @@ bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 
-	if (ops && ops->dev_feat_enabled)
+	if (dev->iommu && ops && ops->dev_feat_enabled)
 		return ops->dev_feat_enabled(dev, feat);
 
 	return false;
-- 
2.17.1

