Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA26B2C1FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbgKXI2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:28:37 -0500
Received: from mga14.intel.com ([192.55.52.115]:63905 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730457AbgKXI2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:28:36 -0500
IronPort-SDR: 7GRFUazgsBJ19R5t5f7ME7PAri2ZEkNbyI3pbfsZzj00SVkx2UFRWUz6hYBH5nZ2scJ+iY9wfK
 9JSMuwob+0HA==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="171129632"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="171129632"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 00:28:36 -0800
IronPort-SDR: m2cASxMPzGxe11ez01bnMrrUe3Z7qWU/qW3zg0lE4xrVKiXtv571H7QtxuanjexQapCiuJJQ0D
 /gJ9TxPjaGMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="432539728"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Nov 2020 00:28:33 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH v6 4/7] iommu: Add quirk for Intel graphic devices in map_sg
Date:   Tue, 24 Nov 2020 16:20:54 +0800
Message-Id: <20201124082057.2614359-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124082057.2614359-1-baolu.lu@linux.intel.com>
References: <20201124082057.2614359-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combining the sg segments exposes a bug in the Intel i915 driver which
causes visual artifacts and the screen to freeze. This is most likely
because of how the i915 handles the returned list. It probably doesn't
respect the returned value specifying the number of elements in the list
and instead depends on the previous behaviour of the Intel iommu driver
which would return the same number of elements in the output list as in
the input list.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/iommu/dma-iommu.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 83eb99bfb990..5f49ed653f98 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -878,6 +878,33 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 	unsigned int cur_len = 0, max_len = dma_get_max_seg_size(dev);
 	int i, count = 0;
 
+	/*
+	 * The Intel graphic driver is used to assume that the returned
+	 * sg list is not combound. This blocks the efforts of converting
+	 * Intel IOMMU driver to dma-iommu api's. Add this quirk to make the
+	 * device driver work and should be removed once it's fixed in i915
+	 * driver.
+	 */
+	if (IS_ENABLED(CONFIG_DRM_I915) && dev_is_pci(dev) &&
+	    to_pci_dev(dev)->vendor == PCI_VENDOR_ID_INTEL &&
+	    (to_pci_dev(dev)->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
+		for_each_sg(sg, s, nents, i) {
+			unsigned int s_iova_off = sg_dma_address(s);
+			unsigned int s_length = sg_dma_len(s);
+			unsigned int s_iova_len = s->length;
+
+			s->offset += s_iova_off;
+			s->length = s_length;
+			sg_dma_address(s) = dma_addr + s_iova_off;
+			sg_dma_len(s) = s_length;
+			dma_addr += s_iova_len;
+
+			pr_info_once("sg combining disabled due to i915 driver\n");
+		}
+
+		return nents;
+	}
+
 	for_each_sg(sg, s, nents, i) {
 		/* Restore this segment's original unaligned fields first */
 		unsigned int s_iova_off = sg_dma_address(s);
-- 
2.25.1

