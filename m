Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057D63045A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbhAZRq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:46:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:7333 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389782AbhAZITj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:19:39 -0500
IronPort-SDR: uDN8176gYOARHe6iWzMZbdsF9TeSBErCNHz9/H4j2JmSDF3rrIMdtN7jlGFirut+pmCgBZGqH7
 pY737H1bs/eQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="179946990"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="179946990"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 00:15:54 -0800
IronPort-SDR: Xbaohphle2A6hpHinYJoUconS6x3/FL5WMaizLC41NrzyYieCTl+f02AmYtWxYBe0TX6gj0V3w
 hEF+PN320ANA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="577725469"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jan 2021 00:15:52 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 2/2] iommu/vt-d: Use INVALID response code instead of FAILURE
Date:   Tue, 26 Jan 2021 16:07:30 +0800
Message-Id: <20210126080730.2232859-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126080730.2232859-1-baolu.lu@linux.intel.com>
References: <20210126080730.2232859-1-baolu.lu@linux.intel.com>
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
index d7c98c5fa4e7..574a7e657a9a 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -911,10 +911,8 @@ static irqreturn_t prq_event_thread(int irq, void *d)
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
@@ -952,7 +950,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			rcu_read_unlock();
 		}
 
-		result = QI_RESP_INVALID;
 		/* Since we're using init_mm.pgd directly, we should never take
 		 * any faults on kernel addresses. */
 		if (!svm->mm)
-- 
2.25.1

