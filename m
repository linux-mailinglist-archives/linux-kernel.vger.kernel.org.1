Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933F12FDF8B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436784AbhAUC0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:26:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:31113 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389436AbhAUB6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 20:58:10 -0500
IronPort-SDR: Eel21chMWO+df4GH/8jz9vn70NHL5002gHYOOAy+sByKq3t6K+X5s4wFFk3b+48TRfXN5at0fu
 R8s8CcsC49gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="243275406"
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="243275406"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 17:53:39 -0800
IronPort-SDR: QNr0O4qpQMTHS7ga7fh2HdCPLX6cLjIEWA7Dfi+bY5r8+391q/1SYFco6bS6gXkO6Ym3Cn9XNe
 gYyS8ZtGQc+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="391762270"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by orsmga007.jf.intel.com with ESMTP; 20 Jan 2021 17:53:37 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/3] iommu/vt-d: Use INVALID response code instead of FAILURE
Date:   Thu, 21 Jan 2021 09:45:05 +0800
Message-Id: <20210121014505.1659166-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121014505.1659166-1-baolu.lu@linux.intel.com>
References: <20210121014505.1659166-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VT-d IOMMU response RESPONSE_FAILURE for a page request in below
cases:

- When it gets a Page_Request with no PASID;
- When it gets a Page_Request with PASID that is not in use for this
  device.

This is allowed by the spec, but IOMMU driver doesn't support such cases
today. When the device receives RESPONSE_FAILURE, it sends the device
state machine to HALT state. Now if we try to unload the driver, it hangs
since the device doesn't send any outbound transactions to host when the
driver is trying to clear things up. The only possible responses would be
for invalidation requests.

Let's use RESPONSE_INVALID instead for now, so that the device state
machine doesn't enter HALT state.

Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 77509a0a863e..021f58899c16 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -907,10 +907,8 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		u64 address;
 
 		handled = 1;
-
 		req = &iommu->prq[head / sizeof(*req)];
-
-		result = QI_RESP_FAILURE;
+		result = QI_RESP_INVALID;
 		address = (u64)req->addr << VTD_PAGE_SHIFT;
 		if (!req->pasid_present) {
 			pr_err("%s: Page request without PASID: %08llx %08llx\n",
@@ -948,7 +946,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			rcu_read_unlock();
 		}
 
-		result = QI_RESP_INVALID;
 		/* Since we're using init_mm.pgd directly, we should never take
 		 * any faults on kernel addresses. */
 		if (!svm->mm)
-- 
2.25.1

