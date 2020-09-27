Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3893A279EF9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 08:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgI0Gpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 02:45:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:36243 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730215AbgI0Gpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 02:45:52 -0400
IronPort-SDR: FC/p30r3Jo7b7WDzA58Ua28OQL28O6RwZjIhpye9R/Z0mLTZnIWmznzjoK3wC9gNli+Ndvk/Xa
 Y73ijSvpRiWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="141863658"
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; 
   d="scan'208";a="141863658"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 23:40:59 -0700
IronPort-SDR: yyetCEI92Vkdd2fRiKN80N6g9H2K2NQHrZbVcqIWn0izUB6WNFRqFcmOKCQXnZIiqRk8dK+FQy
 I+xxWqijzaiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; 
   d="scan'208";a="349457836"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Sep 2020 23:40:57 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Intel-gfx@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 4/7] iommu: Add quirk for Intel graphic devices in map_sg
Date:   Sun, 27 Sep 2020 14:34:34 +0800
Message-Id: <20200927063437.13988-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200927063437.13988-1-baolu.lu@linux.intel.com>
References: <20200927063437.13988-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/dma-iommu.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 3526db774611..e7e4d758f51a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -879,6 +879,33 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
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
2.17.1

