Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D5C2C50EE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 10:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389155AbgKZJN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 04:13:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:55742 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732910AbgKZJNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:13:25 -0500
IronPort-SDR: MorjxH7inJBOHI5/qMuq0+suf/ZpM190MeCzaU25CWzu+Dy5jjNrkGUCcvg85R1g/+EWVg7VNs
 roGcyecM9cOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="152093744"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="152093744"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 01:13:25 -0800
IronPort-SDR: 1W98j++zDlKY+Uyu1ROvcdDJOJF1MCSg4O2+mApuDwET4gmPwUg6O9xBS/6ofTHijiyvhxdySz
 a6EHzU3NcBqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="433221130"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2020 01:13:23 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu: Fix htmldocs warnings in sysfs-kernel-iommu_groups
Date:   Thu, 26 Nov 2020 17:06:03 +0800
Message-Id: <20201126090603.1511589-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below warnings are fixed:

Documentation/ABI/testing/sysfs-kernel-iommu_groups:38: WARNING: Unexpected indentation.
Documentation/ABI/testing/sysfs-kernel-iommu_groups:38: WARNING: Block quote ends without a blank line; unexpected unindent.
Documentation/ABI/testing/sysfs-kernel-iommu_groups:38: WARNING: Enumerated list ends without a blank line; unexpected unindent.
Documentation/ABI/testing/sysfs-kernel-iommu_groups:38: WARNING: Unexpected indentation.
Documentation/ABI/testing/sysfs-kernel-iommu_groups:38: WARNING: Block quote ends without a blank line; unexpected unindent.

Fixes: 63a816749d86 ("iommu: Document usage of "/sys/kernel/iommu_groups/<grp_id>/type" file")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/linux-next/20201126174851.200e0e58@canb.auug.org.au/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 .../ABI/testing/sysfs-kernel-iommu_groups     | 33 ++++++++++---------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
index 407b1628d7fd..0fedbb0f94e4 100644
--- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
+++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
@@ -40,23 +40,24 @@ KernelVersion:	v5.11
 Contact:	Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
 Description:	/sys/kernel/iommu_groups/<grp_id>/type shows the type of default
 		domain in use by iommu for this group. See include/linux/iommu.h
-		for possible values. A privileged user could request kernel to
-		change the group type by writing to this file. Presently, only
-		three types of request are supported:
-		1. DMA: All the DMA transactions from the device in this group
-			are translated by the iommu.
-		2. identity: All the DMA transactions from the device in this
-			     group are *not* translated by the iommu.
-		3. auto: Change to the type the device was booted with.
-		Note:
-		-----
+		for possible read values. A privileged user could request kernel to
+		change the group type by writing to this file. Valid write values:
+
+		========  ======================================================
+		DMA       All the DMA transactions from the device in this group
+		          are translated by the iommu.
+		identity  All the DMA transactions from the device in this group
+		          are not translated by the iommu.
+		auto      Change to the type the device was booted with.
+		========  ======================================================
+
 		The default domain type of a group may be modified only when
-		1. The group has *only* one device
-		2. The device in the group is not bound to any device driver.
-		   So, the users must unbind the appropriate driver before
-		   changing the default domain type.
-		Caution:
-		--------
+
+		- The group has only one device.
+		- The device in the group is not bound to any device driver.
+		  So, the users must unbind the appropriate driver before
+		  changing the default domain type.
+
 		Unbinding a device driver will take away the driver's control
 		over the device and if done on devices that host root file
 		system could lead to catastrophic effects (the users might
-- 
2.25.1

