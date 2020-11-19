Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8892B8B39
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKSF6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 00:58:36 -0500
Received: from mga14.intel.com ([192.55.52.115]:55243 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgKSF6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 00:58:36 -0500
IronPort-SDR: /Y0tw42zccpnrGb9oasb3MfjqtJfUTQ8N6lWmV4UkE3zr35TrJJVNm9Zfft05Crn0aI/8BUnP+
 6xfAG8XTlVyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="170455612"
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="170455612"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 21:58:35 -0800
IronPort-SDR: s9meoi1P7Q22K3FC62cjIaPmRut2VXtfLVImt0gET1ADZL/bjcsfFM1n2JtFjfqqbUOhQ9mWcN
 MYAabKsc8Rtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="431120296"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 Nov 2020 21:58:33 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Fix compile error with CONFIG_PCI_ATS not set
Date:   Thu, 19 Nov 2020 13:51:19 +0800
Message-Id: <20201119055119.2862701-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the compile error below (CONFIG_PCI_ATS not set):

drivers/iommu/intel/dmar.c: In function ‘vf_inherit_msi_domain’:
drivers/iommu/intel/dmar.c:338:59: error: ‘struct pci_dev’ has no member named ‘physfn’; did you mean ‘is_physfn’?
  338 |  dev_set_msi_domain(&pdev->dev, dev_get_msi_domain(&pdev->physfn->dev));
      |                                                           ^~~~~~
      |                                                           is_physfn

Link: https://lore.kernel.org/linux-iommu/CAMuHMdXA7wfJovmfSH2nbAhN0cPyCiFHodTvg4a8Hm9rx5Dj-w@mail.gmail.com/
Fixes: ff828729be446 ("iommu/vt-d: Cure VF irqdomain hickup")
Cc: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index b2e804473209..11319e4dce4a 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -335,7 +335,9 @@ static void  dmar_pci_bus_del_dev(struct dmar_pci_notify_info *info)
 
 static inline void vf_inherit_msi_domain(struct pci_dev *pdev)
 {
-	dev_set_msi_domain(&pdev->dev, dev_get_msi_domain(&pdev->physfn->dev));
+	struct pci_dev *physfn = pci_physfn(pdev);
+
+	dev_set_msi_domain(&pdev->dev, dev_get_msi_domain(&physfn->dev));
 }
 
 static int dmar_pci_bus_notifier(struct notifier_block *nb,
-- 
2.25.1

