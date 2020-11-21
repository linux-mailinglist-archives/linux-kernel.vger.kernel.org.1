Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6492BBF6A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 15:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgKUOD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 09:03:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:14271 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727842AbgKUOD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:03:58 -0500
IronPort-SDR: CGb2S+5uM3FrX8zGjrYhlIaSq8FWJZ0pNP6OJKitz/A+hZdakGMDuvFh1kqQyB28NRWc2xhUPw
 b2mAsUfN2Tnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="158634967"
X-IronPort-AV: E=Sophos;i="5.78,359,1599548400"; 
   d="scan'208";a="158634967"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2020 06:03:58 -0800
IronPort-SDR: SS/i7YFrzP8y/TwSwPj8rVXngNcAgBHP1fa5vzbCW6mXqStuyf/9jpWNz7cEe6JXm078IfA99d
 H9dH3VUga0hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,359,1599548400"; 
   d="scan'208";a="431852759"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2020 06:03:55 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
Cc:     Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@lst.de>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v9 1/4] iommu: Move def_domain type check for untrusted device into core
Date:   Sat, 21 Nov 2020 21:56:17 +0800
Message-Id: <20201121135620.3496419-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201121135620.3496419-1-baolu.lu@linux.intel.com>
References: <20201121135620.3496419-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that the vendor iommu drivers are no more required to provide the
def_domain_type callback to always isolate the untrusted devices.

Link: https://lore.kernel.org/linux-iommu/243ce89c33fe4b9da4c56ba35acebf81@huawei.com/
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c |  7 -------
 drivers/iommu/iommu.c       | 21 ++++++++++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index af3abd285214..6711f78141a4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2916,13 +2916,6 @@ static int device_def_domain_type(struct device *dev)
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
 
-		/*
-		 * Prevent any device marked as untrusted from getting
-		 * placed into the statically identity mapping domain.
-		 */
-		if (pdev->untrusted)
-			return IOMMU_DOMAIN_DMA;
-
 		if ((iommu_identity_mapping & IDENTMAP_AZALIA) && IS_AZALIA(pdev))
 			return IOMMU_DOMAIN_IDENTITY;
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 88b0c9192d8c..3256784c0358 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1457,13 +1457,23 @@ struct iommu_group *fsl_mc_device_group(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 
-static int iommu_get_def_domain_type(struct device *dev)
+/* Get the mandatary def_domain type for device. Otherwise, return 0. */
+static int iommu_get_mandatory_def_domain_type(struct device *dev)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
-	unsigned int type = 0;
+
+	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
+		return IOMMU_DOMAIN_DMA;
 
 	if (ops->def_domain_type)
-		type = ops->def_domain_type(dev);
+		return ops->def_domain_type(dev);
+
+	return 0;
+}
+
+static int iommu_get_def_domain_type(struct device *dev)
+{
+	int type = iommu_get_mandatory_def_domain_type(dev);
 
 	return (type == 0) ? iommu_def_domain_type : type;
 }
@@ -1645,13 +1655,10 @@ struct __group_domain_type {
 
 static int probe_get_default_domain_type(struct device *dev, void *data)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
 	struct __group_domain_type *gtype = data;
 	unsigned int type = 0;
 
-	if (ops->def_domain_type)
-		type = ops->def_domain_type(dev);
-
+	type = iommu_get_mandatory_def_domain_type(dev);
 	if (type) {
 		if (gtype->type && gtype->type != type) {
 			dev_warn(dev, "Device needs domain type %s, but device %s in the same iommu group requires type %s - using default\n",
-- 
2.25.1

