Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434FB2C1FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgKXI2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:28:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:63905 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730457AbgKXI2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:28:38 -0500
IronPort-SDR: DPH3YEo3NRTkAYC5b25mzvf2ih0hj5cCt4f7oZcym48ho4aDIvzsLNzdAJELvEJCZkELfE3eMu
 7VmdGwyEOAxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="171129636"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="171129636"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 00:28:38 -0800
IronPort-SDR: sklvKHCRdGqiZhGdwGMjXhLTPSgalMb1wwlqSOlex3vd4uAkKkmrN+idQ47MzHahLbv8BaVsfn
 MfqryfqyWMqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="432539732"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Nov 2020 00:28:36 -0800
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
Subject: [PATCH v6 5/7] iommu/vt-d: Update domain geometry in iommu_ops.at(de)tach_dev
Date:   Tue, 24 Nov 2020 16:20:55 +0800
Message-Id: <20201124082057.2614359-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124082057.2614359-1-baolu.lu@linux.intel.com>
References: <20201124082057.2614359-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu-dma constrains IOVA allocation based on the domain geometry
that the driver reports. Update domain geometry everytime a domain is
attached to or detached from a device.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/iommu/intel/iommu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 414b4321fb61..5f7d8148f1d6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -67,8 +67,8 @@
 #define MAX_AGAW_WIDTH 64
 #define MAX_AGAW_PFN_WIDTH	(MAX_AGAW_WIDTH - VTD_PAGE_SHIFT)
 
-#define __DOMAIN_MAX_PFN(gaw)  ((((uint64_t)1) << (gaw-VTD_PAGE_SHIFT)) - 1)
-#define __DOMAIN_MAX_ADDR(gaw) ((((uint64_t)1) << gaw) - 1)
+#define __DOMAIN_MAX_PFN(gaw)  ((((uint64_t)1) << ((gaw) - VTD_PAGE_SHIFT)) - 1)
+#define __DOMAIN_MAX_ADDR(gaw) ((((uint64_t)1) << (gaw)) - 1)
 
 /* We limit DOMAIN_MAX_PFN to fit in an unsigned long, and DOMAIN_MAX_ADDR
    to match. That way, we can use 'unsigned long' for PFNs with impunity. */
@@ -739,6 +739,18 @@ static void domain_update_iommu_cap(struct dmar_domain *domain)
 	 */
 	if (domain->nid == NUMA_NO_NODE)
 		domain->nid = domain_update_device_node(domain);
+
+	/*
+	 * First-level translation restricts the input-address to a
+	 * canonical address (i.e., address bits 63:N have the same
+	 * value as address bit [N-1], where N is 48-bits with 4-level
+	 * paging and 57-bits with 5-level paging). Hence, skip bit
+	 * [N-1].
+	 */
+	if (domain_use_first_level(domain))
+		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw - 1);
+	else
+		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw);
 }
 
 struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
-- 
2.25.1

