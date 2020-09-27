Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FA3279EE1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 08:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbgI0Gas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 02:30:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:22057 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgI0Gas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 02:30:48 -0400
IronPort-SDR: aLb5WowrdB3N9mvHNQXZAKEjNu0FHSBM6s+xMLzWh2EnYEQ7CkV/a7FHFFBqxFLOZQHkfreoOp
 G7itXf6kCqUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="159192678"
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; 
   d="scan'208";a="159192678"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 23:30:47 -0700
IronPort-SDR: WOFh+0nUCZ3+6tuP2DyVqYsZb0zDP58nPZrIUNWfOuzsAIrLgwGjI5U+ZZGLpebKdxVYyZ0LnR
 1kxdkvp2v4xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; 
   d="scan'208";a="349455750"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Sep 2020 23:30:46 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Fix lockdep splat in iommu_flush_dev_iotlb()
Date:   Sun, 27 Sep 2020 14:24:28 +0800
Message-Id: <20200927062428.13713-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lock(&iommu->lock) without disabling irq causes lockdep warnings.

[   12.703950] ========================================================
[   12.703962] WARNING: possible irq lock inversion dependency detected
[   12.703975] 5.9.0-rc6+ #659 Not tainted
[   12.703983] --------------------------------------------------------
[   12.703995] systemd-udevd/284 just changed the state of lock:
[   12.704007] ffffffffbd6ff4d8 (device_domain_lock){..-.}-{2:2}, at:
               iommu_flush_dev_iotlb.part.57+0x2e/0x90
[   12.704031] but this lock took another, SOFTIRQ-unsafe lock in the past:
[   12.704043]  (&iommu->lock){+.+.}-{2:2}
[   12.704045]

               and interrupts could create inverse lock ordering between
               them.

[   12.704073]
               other info that might help us debug this:
[   12.704085]  Possible interrupt unsafe locking scenario:

[   12.704097]        CPU0                    CPU1
[   12.704106]        ----                    ----
[   12.704115]   lock(&iommu->lock);
[   12.704123]                                local_irq_disable();
[   12.704134]                                lock(device_domain_lock);
[   12.704146]                                lock(&iommu->lock);
[   12.704158]   <Interrupt>
[   12.704164]     lock(device_domain_lock);
[   12.704174]
                *** DEADLOCK ***

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1b7d390beb68..722545f61ba2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2699,7 +2699,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		}
 
 		/* Setup the PASID entry for requests without PASID: */
-		spin_lock(&iommu->lock);
+		spin_lock_irqsave(&iommu->lock, flags);
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
 					dev, PASID_RID2PASID);
@@ -2709,7 +2709,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		else
 			ret = intel_pasid_setup_second_level(iommu, domain,
 					dev, PASID_RID2PASID);
-		spin_unlock(&iommu->lock);
+		spin_unlock_irqrestore(&iommu->lock, flags);
 		if (ret) {
 			dev_err(dev, "Setup RID2PASID failed\n");
 			dmar_remove_one_dev_info(dev);
-- 
2.17.1

