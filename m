Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B202F2E7D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 02:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgLaBDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 20:03:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:3102 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgLaBDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 20:03:17 -0500
IronPort-SDR: zzyu3kruXVmzYLV1R2Eesw/O/RBWV/o0hjEcRIsCsqm60+eovzjgweQ2PmoFP9GGspYVW4Rtu0
 xl5eTtYD5YHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9850"; a="195158329"
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="195158329"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2020 17:01:32 -0800
IronPort-SDR: HfdAZnglGbI/Th0VZeMQpjJL1gRX6ChZ9Gk0rhtYaHUnupDsyAJDH/R61ZkfJmnbXmO6WBEiRG
 yX+o02/zdYuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="460676251"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Dec 2020 17:01:27 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Guo Kaijie <Kaijie.Guo@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Tom Murphy <murphyt7@tcd.ie>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH 4/5] Revert "iommu: Add quirk for Intel graphic devices in map_sg"
Date:   Thu, 31 Dec 2020 08:53:22 +0800
Message-Id: <20201231005323.2178523-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 65f746e8285f0a67d43517d86fedb9e29ead49f2.

As commit 8a473dbadccfc ("drm/i915: Fix DMA mapped scatterlist walks") and
commit 934941ed5a307 ("drm/i915: Fix DMA mapped scatterlist lookup") fixed
the DMA scatterlist limitations in the i915 driver, remove this temporary
workaround.

Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Tom Murphy <murphyt7@tcd.ie>
Cc: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/dma-iommu.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f0305e6aac1b..4078358ed66e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -863,33 +863,6 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 	unsigned int cur_len = 0, max_len = dma_get_max_seg_size(dev);
 	int i, count = 0;
 
-	/*
-	 * The Intel graphic driver is used to assume that the returned
-	 * sg list is not combound. This blocks the efforts of converting
-	 * Intel IOMMU driver to dma-iommu api's. Add this quirk to make the
-	 * device driver work and should be removed once it's fixed in i915
-	 * driver.
-	 */
-	if (IS_ENABLED(CONFIG_DRM_I915) && dev_is_pci(dev) &&
-	    to_pci_dev(dev)->vendor == PCI_VENDOR_ID_INTEL &&
-	    (to_pci_dev(dev)->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
-		for_each_sg(sg, s, nents, i) {
-			unsigned int s_iova_off = sg_dma_address(s);
-			unsigned int s_length = sg_dma_len(s);
-			unsigned int s_iova_len = s->length;
-
-			s->offset += s_iova_off;
-			s->length = s_length;
-			sg_dma_address(s) = dma_addr + s_iova_off;
-			sg_dma_len(s) = s_length;
-			dma_addr += s_iova_len;
-
-			pr_info_once("sg combining disabled due to i915 driver\n");
-		}
-
-		return nents;
-	}
-
 	for_each_sg(sg, s, nents, i) {
 		/* Restore this segment's original unaligned fields first */
 		unsigned int s_iova_off = sg_dma_address(s);
-- 
2.25.1

