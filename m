Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1AC1E4091
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 13:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbgE0Lx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 07:53:58 -0400
Received: from 8bytes.org ([81.169.241.247]:44914 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728717AbgE0Lx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:53:28 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A66554F0; Wed, 27 May 2020 13:53:24 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        jroedel@suse.de
Subject: [PATCH 09/10] iommu/amd: Store dev_data as device iommu private data
Date:   Wed, 27 May 2020 13:53:12 +0200
Message-Id: <20200527115313.7426-10-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527115313.7426-1-joro@8bytes.org>
References: <20200527115313.7426-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Do not use dev->archdata.iommu anymore and switch to using the private
per-device pointer provided by the IOMMU core code.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/iommu.c | 44 +++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e3fdc7a0e853..2504aa184837 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -279,11 +279,6 @@ static struct iommu_dev_data *find_dev_data(u16 devid)
 	return dev_data;
 }
 
-static struct iommu_dev_data *get_dev_data(struct device *dev)
-{
-	return dev->archdata.iommu;
-}
-
 /*
 * Find or create an IOMMU group for a acpihid device.
 */
@@ -334,7 +329,7 @@ static bool pdev_pri_erratum(struct pci_dev *pdev, u32 erratum)
 {
 	struct iommu_dev_data *dev_data;
 
-	dev_data = get_dev_data(&pdev->dev);
+	dev_data = dev_iommu_priv_get(&pdev->dev);
 
 	return dev_data->errata & (1 << erratum) ? true : false;
 }
@@ -369,7 +364,7 @@ static int iommu_init_device(struct device *dev)
 	struct iommu_dev_data *dev_data;
 	int devid;
 
-	if (dev->archdata.iommu)
+	if (dev_iommu_priv_get(dev))
 		return 0;
 
 	devid = get_device_id(dev);
@@ -396,7 +391,7 @@ static int iommu_init_device(struct device *dev)
 		dev_data->iommu_v2 = iommu->is_iommu_v2;
 	}
 
-	dev->archdata.iommu = dev_data;
+	dev_iommu_priv_set(dev, dev_data);
 
 	return 0;
 }
@@ -431,6 +426,8 @@ static void amd_iommu_uninit_device(struct device *dev)
 	if (dev_data->domain)
 		detach_device(dev);
 
+	dev_iommu_priv_set(dev, NULL);
+
 	/*
 	 * We keep dev_data around for unplugged devices and reuse it when the
 	 * device is re-plugged - not doing so would introduce a ton of races.
@@ -493,7 +490,7 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
 					   devid & 0xff);
 	if (pdev)
-		dev_data = get_dev_data(&pdev->dev);
+		dev_data = dev_iommu_priv_get(&pdev->dev);
 
 	if (dev_data && __ratelimit(&dev_data->rs)) {
 		pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
@@ -2033,7 +2030,7 @@ static int attach_device(struct device *dev,
 
 	spin_lock_irqsave(&domain->lock, flags);
 
-	dev_data = get_dev_data(dev);
+	dev_data = dev_iommu_priv_get(dev);
 
 	spin_lock(&dev_data->lock);
 
@@ -2097,7 +2094,7 @@ static void detach_device(struct device *dev)
 	struct iommu_dev_data *dev_data;
 	unsigned long flags;
 
-	dev_data = get_dev_data(dev);
+	dev_data = dev_iommu_priv_get(dev);
 	domain   = dev_data->domain;
 
 	spin_lock_irqsave(&domain->lock, flags);
@@ -2146,7 +2143,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 
 	iommu = amd_iommu_rlookup_table[devid];
 
-	if (get_dev_data(dev))
+	if (dev_iommu_priv_get(dev))
 		return &iommu->iommu;
 
 	ret = iommu_init_device(dev);
@@ -2435,7 +2432,7 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 static void amd_iommu_detach_device(struct iommu_domain *dom,
 				    struct device *dev)
 {
-	struct iommu_dev_data *dev_data = dev->archdata.iommu;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu;
 	int devid;
 
@@ -2473,7 +2470,7 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	if (!check_device(dev))
 		return -EINVAL;
 
-	dev_data = dev->archdata.iommu;
+	dev_data = dev_iommu_priv_get(dev);
 	dev_data->defer_attach = false;
 
 	iommu = amd_iommu_rlookup_table[dev_data->devid];
@@ -2632,7 +2629,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
 				  struct device *dev)
 {
-	struct iommu_dev_data *dev_data = dev->archdata.iommu;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 
 	return dev_data->defer_attach;
 }
@@ -2659,7 +2656,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
 
-	dev_data = get_dev_data(dev);
+	dev_data = dev_iommu_priv_get(dev);
 	if (!dev_data)
 		return 0;
 
@@ -2992,7 +2989,7 @@ int amd_iommu_complete_ppr(struct pci_dev *pdev, int pasid,
 	struct amd_iommu *iommu;
 	struct iommu_cmd cmd;
 
-	dev_data = get_dev_data(&pdev->dev);
+	dev_data = dev_iommu_priv_get(&pdev->dev);
 	iommu    = amd_iommu_rlookup_table[dev_data->devid];
 
 	build_complete_ppr(&cmd, dev_data->devid, pasid, status,
@@ -3005,16 +3002,19 @@ EXPORT_SYMBOL(amd_iommu_complete_ppr);
 struct iommu_domain *amd_iommu_get_v2_domain(struct pci_dev *pdev)
 {
 	struct protection_domain *pdomain;
-	struct iommu_domain *io_domain;
+	struct iommu_dev_data *dev_data;
 	struct device *dev = &pdev->dev;
+	struct iommu_domain *io_domain;
 
 	if (!check_device(dev))
 		return NULL;
 
-	pdomain   = get_dev_data(dev)->domain;
+	dev_data  = dev_iommu_priv_get(&pdev->dev);
+	pdomain   = dev_data->domain;
 	io_domain = iommu_get_domain_for_dev(dev);
-	if (pdomain == NULL && get_dev_data(dev)->defer_attach) {
-		get_dev_data(dev)->defer_attach = false;
+
+	if (pdomain == NULL && dev_data->defer_attach) {
+		dev_data->defer_attach = false;
 		pdomain = to_pdomain(io_domain);
 		attach_device(dev, pdomain);
 	}
@@ -3040,7 +3040,7 @@ void amd_iommu_enable_device_erratum(struct pci_dev *pdev, u32 erratum)
 	if (!amd_iommu_v2_supported())
 		return;
 
-	dev_data = get_dev_data(&pdev->dev);
+	dev_data = dev_iommu_priv_get(&pdev->dev);
 	dev_data->errata |= (1 << erratum);
 }
 EXPORT_SYMBOL(amd_iommu_enable_device_erratum);
-- 
2.17.1

