Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DF32E7D90
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 02:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgLaBEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 20:04:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:63390 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgLaBEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 20:04:33 -0500
IronPort-SDR: EvRS8GqkcwcbNHBAR+N0rZGGxvTp73pGCwZR514dV7r4rkSD8tKMqYJC2pidan9OOvjlMrejlt
 pVvad0NUwFjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9850"; a="164367224"
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="164367224"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2020 17:01:27 -0800
IronPort-SDR: QjJke4P2SbrVBJ0IJWOh0rgwcSZ/vVEY2SYmPQiZ54DoUU1xFs4hmajQQ38go6o71mNL1Qzy5R
 T8+z6BH9ZQhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="460676225"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Dec 2020 17:01:23 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Guo Kaijie <Kaijie.Guo@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/5] iommu/vt-d: Fix unaligned addresses for intel_flush_svm_range_dev()
Date:   Thu, 31 Dec 2020 08:53:20 +0800
Message-Id: <20201231005323.2178523-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VT-d hardware will ignore those Addr bits which have been masked by
the AM field in the PASID-based-IOTLB invalidation descriptor. As the
result, if the starting address in the descriptor is not aligned with
the address mask, some IOTLB caches might not invalidate. Hence people
will see below errors.

[ 1093.704661] dmar_fault: 29 callbacks suppressed
[ 1093.704664] DMAR: DRHD: handling fault status reg 3
[ 1093.712738] DMAR: [DMA Read] Request device [7a:02.0] PASID 2
               fault addr 7f81c968d000 [fault reason 113]
               SM: Present bit in first-level paging entry is clear

Fix this by using aligned address for PASID-based-IOTLB invalidation.

Fixes: 1c4f88b7f1f92 ("iommu/vt-d: Shared virtual address in scalable mode")
Reported-and-tested-by: Guo Kaijie <Kaijie.Guo@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 69566695d032..b16a4791acfb 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -118,8 +118,10 @@ void intel_svm_check(struct intel_iommu *iommu)
 	iommu->flags |= VTD_FLAG_SVM_CAPABLE;
 }
 
-static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_dev *sdev,
-				unsigned long address, unsigned long pages, int ih)
+static void __flush_svm_range_dev(struct intel_svm *svm,
+				  struct intel_svm_dev *sdev,
+				  unsigned long address,
+				  unsigned long pages, int ih)
 {
 	struct qi_desc desc;
 
@@ -170,6 +172,22 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
 	}
 }
 
+static void intel_flush_svm_range_dev(struct intel_svm *svm,
+				      struct intel_svm_dev *sdev,
+				      unsigned long address,
+				      unsigned long pages, int ih)
+{
+	unsigned long shift = ilog2(__roundup_pow_of_two(pages));
+	unsigned long align = (1ULL << (VTD_PAGE_SHIFT + shift));
+	unsigned long start = ALIGN_DOWN(address, align);
+	unsigned long end = ALIGN(address + (pages << VTD_PAGE_SHIFT), align);
+
+	while (start < end) {
+		__flush_svm_range_dev(svm, sdev, start, align >> VTD_PAGE_SHIFT, ih);
+		start += align;
+	}
+}
+
 static void intel_flush_svm_range(struct intel_svm *svm, unsigned long address,
 				unsigned long pages, int ih)
 {
-- 
2.25.1

