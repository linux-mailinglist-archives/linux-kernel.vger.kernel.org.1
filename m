Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7882C365B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 02:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgKYBsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 20:48:55 -0500
Received: from mga05.intel.com ([192.55.52.43]:2112 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgKYBsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 20:48:54 -0500
IronPort-SDR: anhyO9rGCMTUmEgAPkSrTfHIZYqJTOSDkekdu4/6Na6Xk53hBI8I1oOf7fNW3Q5EiKjqieI0aG
 y6hShEYYxKkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="256756524"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="256756524"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 17:48:53 -0800
IronPort-SDR: lLsI0hy9SsZX2QlnfXuv70HYqqiD3wE1AuChYo9GDZOlaJotK29qLJ3gTU5hLWAIPRKVFLktWB
 TimRb0p8obLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="536689747"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga005.fm.intel.com with ESMTP; 24 Nov 2020 17:48:51 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Ning Sun <ning.sun@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
Cc:     Ashok Raj <ashok.raj@intel.com>, x86@kernel.org,
        tboot-devel@lists.sourceforge.net,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 1/1] x86/tboot: Don't disable swiotlb when iommu is forced on
Date:   Wed, 25 Nov 2020 09:41:24 +0800
Message-Id: <20201125014124.4070776-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 327d5b2fee91c ("iommu/vt-d: Allow 32bit devices to uses DMA
domain"), swiotbl could also be used for direct memory access if IOMMU
is enabled but a device is configured to pass through the DMA translation.
Keep swiotlb when IOMMU is forced on, otherwise, some devices won't work
if "iommu=pt" kernel parameter is used.

Fixes: 327d5b2fee91c ("iommu/vt-d: Allow 32bit devices to uses DMA domain")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=210237
Reported-and-tested-by: Adrian Huang <ahuang12@lenovo.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/x86/kernel/tboot.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 420be871d9d4..ae64f98ec2ab 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -514,13 +514,10 @@ int tboot_force_iommu(void)
 	if (!tboot_enabled())
 		return 0;
 
-	if (no_iommu || swiotlb || dmar_disabled)
+	if (no_iommu || dmar_disabled)
 		pr_warn("Forcing Intel-IOMMU to enabled\n");
 
 	dmar_disabled = 0;
-#ifdef CONFIG_SWIOTLB
-	swiotlb = 0;
-#endif
 	no_iommu = 0;
 
 	return 1;
-- 
2.25.1

