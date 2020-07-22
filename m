Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0035522A00A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 21:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732596AbgGVTTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 15:19:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:65006 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgGVTTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:19:45 -0400
IronPort-SDR: W0xhMCr/knPge3THpqBw1mbx+n0IZN3pb6tatfIs9p8ElDYAfvkqcCuqDDmh6Jk64dv3EYnAMb
 VhHUL8vbVp2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="149590054"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="149590054"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 12:19:43 -0700
IronPort-SDR: hVzD5+/qvEXJqO5ErIpPN4LTK3KutmMl0RX9PIkAaLwkI5Zrx2qw9Mrl0G3UfL0uDZBjd/mzM7
 oQ2iSCabtv0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="362811897"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 22 Jul 2020 12:19:43 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 3/7] iommu/vt-d: Fix PASID devTLB invalidation
Date:   Wed, 22 Jul 2020 12:26:23 -0700
Message-Id: <1595445987-40095-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595445987-40095-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1595445987-40095-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DevTLB flush can be used for both DMA request with and without PASIDs.
The former uses PASID#0 (RID2PASID), latter uses non-zero PASID for SVA
usage.

This patch adds a check for PASID value such that devTLB flush with
PASID is used for SVA case. This is more efficient in that multiple
PASIDs can be used by a single device, when tearing down a PASID entry
we shall flush only the devTLB specific to a PASID.

Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table")
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel/pasid.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c81f0f17c6ba..fa0154cce537 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -486,7 +486,16 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	qdep = info->ats_qdep;
 	pfsid = info->pfsid;
 
-	qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
+	/*
+	 * When PASID 0 is used, it indicates RID2PASID(DMA request w/o PASID),
+	 * devTLB flush w/o PASID should be used. For non-zero PASID under
+	 * SVA usage, device could do DMA with multiple PASIDs. It is more
+	 * efficient to flush devTLB specific to the PASID.
+	 */
+	if (pasid == PASID_RID2PASID)
+		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
+	else
+		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0, 64 - VTD_PAGE_SHIFT);
 }
 
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
-- 
2.7.4

