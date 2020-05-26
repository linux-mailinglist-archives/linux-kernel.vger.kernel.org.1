Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7201019DE10
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 20:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404511AbgDCSgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 14:36:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:4674 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbgDCSga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:36:30 -0400
IronPort-SDR: Ng2OfUrDCVzXWee2JsynEPM4Wz8uC1J3qChfGDoeIuWgbAlXBk6wwLHj01F3lcK2PZQo25pSqU
 U4brd9DPa/hA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 11:36:28 -0700
IronPort-SDR: wMt3B4J9v/I5PQ4WsWB+1LIpCwwUgWlTU3YPUqNnHxbnnspqrvYxlAcRVzgX7kH5biYdfLhkaU
 wzG67ZOovcNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; 
   d="scan'208";a="268439833"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 03 Apr 2020 11:36:27 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v11 08/10] iommu/vt-d: Cache virtual command capability register
Date:   Fri,  3 Apr 2020 11:42:12 -0700
Message-Id: <1585939334-21396-9-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtual command registers are used in the guest only, to prevent
vmexit cost, we cache the capability and store it during initialization.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

---
v7 Reviewed by Eric & Baolu
---

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/dmar.c        | 1 +
 include/linux/intel-iommu.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 4d6b7b5b37ee..3b36491c8bbb 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -963,6 +963,7 @@ static int map_iommu(struct intel_iommu *iommu, u64 phys_addr)
 		warn_invalid_dmar(phys_addr, " returns all ones");
 		goto unmap;
 	}
+	iommu->vccap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
 
 	/* the registers might be more than one page */
 	map_size = max_t(int, ecap_max_iotlb_offset(iommu->ecap),
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index f775bb825343..e02a96848586 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -194,6 +194,9 @@
 #define ecap_max_handle_mask(e) ((e >> 20) & 0xf)
 #define ecap_sc_support(e)	((e >> 7) & 0x1) /* Snooping Control */
 
+/* Virtual command interface capability */
+#define vccap_pasid(v)		((v & DMA_VCS_PAS)) /* PASID allocation */
+
 /* IOTLB_REG */
 #define DMA_TLB_FLUSH_GRANU_OFFSET  60
 #define DMA_TLB_GLOBAL_FLUSH (((u64)1) << 60)
@@ -287,6 +290,7 @@
 
 /* PRS_REG */
 #define DMA_PRS_PPR	((u32)1)
+#define DMA_VCS_PAS	((u64)1)
 
 #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
 do {									\
@@ -562,6 +566,7 @@ struct intel_iommu {
 	u64		reg_size; /* size of hw register set */
 	u64		cap;
 	u64		ecap;
+	u64		vccap;
 	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF */
 	raw_spinlock_t	register_lock; /* protect register handling */
 	int		seq_id;	/* sequence id of the iommu */
-- 
2.7.4

