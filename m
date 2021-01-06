Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981A82EBEEF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbhAFNkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:40:15 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10029 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbhAFNkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:40:14 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D9r6L5Dv0zj05V;
        Wed,  6 Jan 2021 21:38:18 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 6 Jan 2021 21:39:04 +0800
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <robin.murphy@arm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 6/6] iommu: Delete iommu_dev_has_feature()
Date:   Wed, 6 Jan 2021 21:35:11 +0800
Message-ID: <1609940111-28563-7-git-send-email-john.garry@huawei.com>
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

Function iommu_dev_has_feature() has never been referenced in the tree,
and there does not appear to be anything coming soon to use it, so delete
it.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iommu.c | 11 -----------
 include/linux/iommu.h |  7 -------
 2 files changed, 18 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 20201ef97b8f..91f7871f5a37 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2853,17 +2853,6 @@ EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
 /*
  * Per device IOMMU features.
  */
-bool iommu_dev_has_feature(struct device *dev, enum iommu_dev_features feat)
-{
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
-
-	if (ops && ops->dev_has_feat)
-		return ops->dev_has_feat(dev, feat);
-
-	return false;
-}
-EXPORT_SYMBOL_GPL(iommu_dev_has_feature);
-
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 72059fcfa108..91d94c014f47 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -626,7 +626,6 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
 int iommu_probe_device(struct device *dev);
 void iommu_release_device(struct device *dev);
 
-bool iommu_dev_has_feature(struct device *dev, enum iommu_dev_features f);
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
 bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features f);
@@ -975,12 +974,6 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
-static inline bool
-iommu_dev_has_feature(struct device *dev, enum iommu_dev_features feat)
-{
-	return false;
-}
-
 static inline bool
 iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
 {
-- 
2.26.2

