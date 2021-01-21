Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98752FDF87
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436738AbhAUCYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:24:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:31116 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393000AbhAUBzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 20:55:32 -0500
IronPort-SDR: YBS2wxNTOU+6lK20imfGq1ENK5NtgPr+hvexJtxlWrl3bwb9reiF26fJEaRrItk91UD68hGzE+
 L+xrd5/E5YEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="243275398"
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="243275398"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 17:53:34 -0800
IronPort-SDR: 3k9uywaSMdFyyUz24lP5uLRP7uCP4WNv3wP7iolkairLK8NJct3J3L4ui6vbBD8ln0LrPnDqV5
 6f3DtT4t2N8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="391762248"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by orsmga007.jf.intel.com with ESMTP; 20 Jan 2021 17:53:32 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/3] iommu/vt-d: Add rate limited information when PRQ overflows
Date:   Thu, 21 Jan 2021 09:45:03 +0800
Message-Id: <20210121014505.1659166-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121014505.1659166-1-baolu.lu@linux.intel.com>
References: <20210121014505.1659166-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that the uses could get chances to know what happened.

Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 033b25886e57..f49fe715477b 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -895,6 +895,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	struct intel_iommu *iommu = d;
 	struct intel_svm *svm = NULL;
 	int head, tail, handled = 0;
+	struct page_req_dsc *req;
 
 	/* Clear PPR bit before reading head/tail registers, to
 	 * ensure that we get a new interrupt if needed. */
@@ -904,7 +905,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
 	while (head != tail) {
 		struct vm_area_struct *vma;
-		struct page_req_dsc *req;
 		struct qi_desc resp;
 		int result;
 		vm_fault_t ret;
@@ -1042,8 +1042,14 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	 * Clear the page request overflow bit and wake up all threads that
 	 * are waiting for the completion of this handling.
 	 */
-	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO)
+	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
+		head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
+		req = &iommu->prq[head / sizeof(*req)];
+		pr_warn_ratelimited("IOMMU: %s: Page request overflow: HEAD: %08llx %08llx",
+				    iommu->name, ((unsigned long long *)req)[0],
+				    ((unsigned long long *)req)[1]);
 		writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
+	}
 
 	if (!completion_done(&iommu->prq_complete))
 		complete(&iommu->prq_complete);
-- 
2.25.1

