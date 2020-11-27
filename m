Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316652C5E91
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 02:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392135AbgK0Bki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 20:40:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:45269 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388130AbgK0Bki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 20:40:38 -0500
IronPort-SDR: fFzJq94Yz+yeE5+ly7alTdH66IY75qqwOHKqWOyUk28gPTNIPhedtWy3l4vALiGmreECNA0k1L
 TMsiQ5onic7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9817"; a="257047340"
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="257047340"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 17:40:37 -0800
IronPort-SDR: luTU8T4gGrJ+vN0Tv7JZLe7oT+Nn79S7H6CmHj0LDER5vank1jJsa/uHNMPirlRiAITy28qwGO
 rDr0n2OTakPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="535902890"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga006.fm.intel.com with ESMTP; 26 Nov 2020 17:40:35 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Remove set but not used variable
Date:   Fri, 27 Nov 2020 09:33:08 +0800
Message-Id: <20201127013308.1833610-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/iommu/intel/iommu.c:5643:27: warning: variable 'last_pfn' set but not used [-Wunused-but-set-variable]
5643 |  unsigned long start_pfn, last_pfn;
     |                           ^~~~~~~~

This variable is never used, so remove it.

Fixes: 2a2b8eaa5b256 ("iommu: Handle freelists when using deferred flushing in iommu drivers")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f9379b4a32fb..8c6c3c0812d2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4942,13 +4942,12 @@ static void intel_iommu_tlb_sync(struct iommu_domain *domain,
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	unsigned long iova_pfn = IOVA_PFN(gather->start);
 	size_t size = gather->end - gather->start;
-	unsigned long start_pfn, last_pfn;
+	unsigned long start_pfn;
 	unsigned long nrpages;
 	int iommu_id;
 
 	nrpages = aligned_nrpages(gather->start, size);
 	start_pfn = mm_to_dma_pfn(iova_pfn);
-	last_pfn = start_pfn + nrpages - 1;
 
 	for_each_domain_iommu(iommu_id, dmar_domain)
 		iommu_flush_iotlb_psi(g_iommus[iommu_id], dmar_domain,
-- 
2.25.1

