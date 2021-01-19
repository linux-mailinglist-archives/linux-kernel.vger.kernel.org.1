Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2222FB1E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 07:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388292AbhASFhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 00:37:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:9527 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732905AbhASEpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 23:45:21 -0500
IronPort-SDR: uKoKUC0xO/FgoooBsQV+DWhwkw9xUkTHNAAB8T5RcJJEeL1khE50oGz/xZLZ3foqKlKkF33Ygh
 BPxWCpJBYPgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="158057140"
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="158057140"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:43:27 -0800
IronPort-SDR: NW9dqf6KtdlALryM0MREyu/mJ7SYUtBJxtasRoqhXw9ue89C2l7l4gnor2eIDlzEsaHTQNqIiE
 dq+vV6SPnIDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="466555975"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jan 2021 20:43:24 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Guo Kaijie <Kaijie.Guo@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Correctly check addr alignment in qi_flush_dev_iotlb_pasid()
Date:   Tue, 19 Jan 2021 12:35:00 +0800
Message-Id: <20210119043500.1539596-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An incorrect address mask is being used in the qi_flush_dev_iotlb_pasid()
to check the address alignment. This leads to a lot of spurious kernel
warnings:

[  485.837093] DMAR: Invalidate non-aligned address 7f76f47f9000, order 0
[  485.837098] DMAR: Invalidate non-aligned address 7f76f47f9000, order 0
[  492.494145] qi_flush_dev_iotlb_pasid: 5734 callbacks suppressed
[  492.494147] DMAR: Invalidate non-aligned address 7f7728800000, order 11
[  492.508965] DMAR: Invalidate non-aligned address 7f7728800000, order 11

Fix it by checking the alignment in right way.

Fixes: 288d08e780088 ("iommu/vt-d: Handle non-page aligned address")
Reported-and-tested-by: Guo Kaijie <Kaijie.Guo@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 004feaed3c72..02e7c10a4224 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1496,7 +1496,7 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	 * Max Invs Pending (MIP) is set to 0 for now until we have DIT in
 	 * ECAP.
 	 */
-	if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
+	if (!IS_ALIGNED(addr, VTD_PAGE_SIZE << size_order))
 		pr_warn_ratelimited("Invalidate non-aligned address %llx, order %d\n",
 				    addr, size_order);
 
-- 
2.25.1

