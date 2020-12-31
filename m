Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5FE2E7D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 02:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgLaBDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 20:03:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:63390 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgLaBDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 20:03:13 -0500
IronPort-SDR: qUXeRyXAIW8b4iOoM1T0uxVNrj3UT5gteDGviLxu9p5rqjZn0IaRUlCDDhmSRPfx6F3EIazyaS
 fVLI7rqZWx0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9850"; a="164367223"
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="164367223"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2020 17:01:27 -0800
IronPort-SDR: bZrafJa6JgKKeMplBEHcCnRpluwTaZIJgv0PlOSSG37PYi7wmJwQjfRq7kqw0bM+9vPtUBWq6H
 eGCLLacmyEZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="460676216"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Dec 2020 17:01:21 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Guo Kaijie <Kaijie.Guo@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/5] iommu/vt-d: Fix misuse of ALIGN in qi_flush_piotlb()
Date:   Thu, 31 Dec 2020 08:53:19 +0800
Message-Id: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use IS_ALIGNED() instead. Otherwise, an unaligned address will be ignored.

Fixes: 33cd6e642d6a7 ("iommu/vt-d: Flush PASID-based iotlb for iova over first level")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index b46dbfa6d0ed..004feaed3c72 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1461,8 +1461,8 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 		int mask = ilog2(__roundup_pow_of_two(npages));
 		unsigned long align = (1ULL << (VTD_PAGE_SHIFT + mask));
 
-		if (WARN_ON_ONCE(!ALIGN(addr, align)))
-			addr &= ~(align - 1);
+		if (WARN_ON_ONCE(!IS_ALIGNED(addr, align)))
+			addr = ALIGN_DOWN(addr, align);
 
 		desc.qw0 = QI_EIOTLB_PASID(pasid) |
 				QI_EIOTLB_DID(did) |
-- 
2.25.1

