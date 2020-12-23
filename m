Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2212E1BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 12:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgLWLRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 06:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgLWLRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 06:17:32 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D5BC0613D6;
        Wed, 23 Dec 2020 03:16:51 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id t22so10204513pfl.3;
        Wed, 23 Dec 2020 03:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FO/vDvgzMK0d0OIeUStk82rgYWacKWwBOU3raTeq56k=;
        b=X2e4wrE8Ll8LjwndWiTt1mXBgEbPTy5C2B9qKoBiQfeJCDdWMCrtX4XmRnMj2RXDiF
         I1N98AinFYe3I4NG/swzWpp9kxpgXSo4KyijkjOSM8EhKOqEtjCQ01aqtMq1K2TD6zem
         xvuMYcuZX1K+T2QUnP/rIAf7Xx8mJvLrseWuxpnW3Ce3aSHj8enHKPNDLpgdimxG6yXL
         sa+gxxPTQaLltytHlUbJdD0pFYxjxgv6oax7TPR0IcZ73JbVyIbGRBLXBIl5cXhBfqqC
         5xRsAEFulfCZn6ZCbf+b88iRrAHtWzc4arSu18pSTsjiISUWYPpGb7jQUc3szUbhImug
         JlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FO/vDvgzMK0d0OIeUStk82rgYWacKWwBOU3raTeq56k=;
        b=UHZrxBg9IOT8K+tidq4S6wW8pmKQxKfic78805gmyDIiSKPfhZ9BURCM00l7HqAL4O
         2T14Pzh8Esi9tYLe6qkWCqLMJulXxC5Hpz1RtXPRFVO1lWlpYALjoYVhFCgEGU4nE5Fc
         h9NTPWfyQZ6khI/Suw7TnGk9IL+gUO2UbpFgy3XhxR1jg4TNTuQgB3/vrpgXlA+AhoQl
         L8rxZgvXfgrrZroHoYvXBFyYes2nN+FsAQGniSCvs8j/R1y8j86uY72xSncvNsETmPgp
         K7inQ9Qz/sI1+/N3CScut3tjZzgbh31wFFxuBpJaYeAIcsKFFp/n79hSMTprh/aZ2/Bv
         +MFA==
X-Gm-Message-State: AOAM530IwGCemoQVg0A4Y0HAi2+/sbzXHLE3MlvxYsbCVHhwDCLYs/Br
        NE9cWeUCiHrHOytJ36pIngE=
X-Google-Smtp-Source: ABdhPJw5ERvI4uvpDrKubm3vzavRmBsVeatceYuFlc3E6nC2jk1rtQdWyGpRAlvqEB1DlE/f/vTi3Q==
X-Received: by 2002:a05:6a00:134d:b029:1ad:b17:dbc4 with SMTP id k13-20020a056a00134db02901ad0b17dbc4mr16522273pfu.53.1608722211255;
        Wed, 23 Dec 2020 03:16:51 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id ga12sm21771023pjb.48.2020.12.23.03.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 03:16:50 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Kevin Tang <kevin.tang@unisoc.com>
Subject: [RFC PATCH 2/2] iommu: add Unisoc iommu basic driver
Date:   Wed, 23 Dec 2020 19:16:33 +0800
Message-Id: <20201223111633.1711477-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201223111633.1711477-1-zhang.lyra@gmail.com>
References: <20201223111633.1711477-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This patch only adds display iommu support, the driver was tested with sprd
dpu.

The iommu support for others would be added once finished tests with those
devices, such as Image codec(jpeg) processor, a few signal processors,
including VSP(video), GSP(graphic), ISP(image), and camera CPP, etc.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/iommu/Kconfig      |  14 ++
 drivers/iommu/Makefile     |   1 +
 drivers/iommu/sprd-iommu.c | 485 +++++++++++++++++++++++++++++++++++++
 3 files changed, 500 insertions(+)
 create mode 100644 drivers/iommu/sprd-iommu.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 04878caf6da4..23e439db28d0 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -401,4 +401,18 @@ config VIRTIO_IOMMU
 
 	  Say Y here if you intend to run this kernel as a guest.
 
+config SPRD_IOMMU
+	bool "Unisoc IOMMU Support"
+	depends on ARCH_SPRD
+	select ARM_DMA_USE_IOMMU
+	select IOMMU_API
+	select MEMORY
+	help
+	  Support for IOMMU on Unisoc's SoCs on which multi-media subsystems
+	  need IOMMU, such as DPU, Image codec(jpeg) processor, and a few
+	  signal processors, including VSP(video), GSP(graphic), ISP(image), and
+	  CPP, etc.
+
+	  Say Y here if you want multi-media functions.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 11f1771104f3..cc71fc46c55c 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -27,3 +27,4 @@ obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
+obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
new file mode 100644
index 000000000000..cc53a68f1b2e
--- /dev/null
+++ b/drivers/iommu/sprd-iommu.c
@@ -0,0 +1,485 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Unisoc IOMMU driver
+ *
+ * Copyright (C) 2020 Unisoc, Inc.
+ * Author: Chunyan Zhang <chunyan.zhang@unisoc.com>
+ */
+
+#include <linux/device.h>
+#include <linux/dma-iommu.h>
+#include <linux/errno.h>
+#include <linux/iommu.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+
+/* SPRD IOMMU page is 4K size alignment */
+#define SPRD_IOMMU_PAGE_SHIFT	12
+#define SPRD_IOMMU_PAGE_SIZE	SZ_4K
+
+#define SPRD_IOMMU_REG_OFFSET	0x800
+#define SPRD_REG_CFG		(SPRD_IOMMU_REG_OFFSET + 0x0)
+#define SPRD_IOMMU_VAOR_BYPASS	BIT(4)
+#define SPRD_IOMMU_GATE_EN	BIT(1)
+#define SPRD_IOMMU_EN		BIT(0)
+#define SPRD_REG_UPDATE		(SPRD_IOMMU_REG_OFFSET + 0x4)
+#define SPRD_REG_FIRST_VPN	(SPRD_IOMMU_REG_OFFSET + 0x8)
+#define SPRD_REG_VPN_RANGE	(SPRD_IOMMU_REG_OFFSET + 0xc)
+#define SPRD_REG_FIRST_PPN	(SPRD_IOMMU_REG_OFFSET + 0x10)
+#define SPRD_REG_DEFAULT_PPN	(SPRD_IOMMU_REG_OFFSET + 0x14)
+#define SPRD_REG_PPN_RANGE	(SPRD_IOMMU_REG_OFFSET + 0x30)
+#define SPRD_REG_ARQOS_CFG	(SPRD_IOMMU_REG_OFFSET + 0x34)
+
+enum sprd_iommu_id {
+	SPRD_IOMMU_DISP,
+	SPRD_IOMMU_VSP,
+};
+
+/*
+ * struct sprd_iommu_match_data - sprd iommu configurations which serves
+ *				  for different master devices
+ *
+ * @id:		sprd iommu device id
+ * @iova_start:	the first address that can be mapped
+ * @iova_size:	the largest address range that can be mapped
+ *
+ * iova_start and iova_size are designed for debug purpose, that says different
+ * masters use different ranges of virtual address.
+ */
+struct sprd_iommu_match_data {
+	enum sprd_iommu_id id;
+	unsigned long iova_start;
+	unsigned long iova_size;
+};
+
+/*
+ * struct sprd_iommu_device - high-level sprd iommu device representation,
+ * including hardware information and configuration, also driver data, etc
+ *
+ * @mdata:	hardware configuration and information
+ * @prot_page:	protect page base address, data would be written to here
+ *		while translation fault
+ * @base:	mapped base address for accessing registers
+ * @dev:	pointer to basic device structure
+ * @iommu:	IOMMU core representation
+ * @group:	IOMMU group
+ */
+struct sprd_iommu_device {
+	const struct sprd_iommu_match_data *mdata;
+	phys_addr_t		prot_page;
+	void __iomem			*base;
+	struct device			*dev;
+	struct iommu_device		iommu;
+	struct iommu_group		*group;
+};
+
+struct sprd_iommu_domain {
+	spinlock_t		pgtlock; /* lock for page table */
+	struct iommu_domain	domain;
+	u32			*pgt_va; /* page table virtual address base */
+	struct sprd_iommu_device	*sdev;
+};
+
+static const struct iommu_ops sprd_iommu_ops;
+
+static struct sprd_iommu_domain *to_sprd_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct sprd_iommu_domain, domain);
+}
+
+static inline void
+iommu_writel(struct sprd_iommu_device *sdev, unsigned int reg, u32 val)
+{
+	writel_relaxed(val, sdev->base + reg);
+}
+
+static inline u32
+iommu_readl(struct sprd_iommu_device *sdev, unsigned int reg)
+{
+	return readl_relaxed(sdev->base + reg);
+}
+
+static inline void
+iommu_update_bits(struct sprd_iommu_device *sdev, unsigned int reg,
+		  u32 mask, u32 shift, u32 val)
+{
+	u32 t = iommu_readl(sdev, reg);
+
+	t = (t & (~(mask << shift))) | ((val & mask) << shift);
+	iommu_writel(sdev, reg, t);
+}
+
+static dma_addr_t sprd_iommu_dma_addr(void *va)
+{
+	return (dma_addr_t)virt_to_phys(va);
+}
+
+static unsigned long
+sprd_iommu_pgt_size(const struct sprd_iommu_match_data *mdata)
+{
+	return (mdata->iova_size >> SPRD_IOMMU_PAGE_SHIFT) * 4;
+}
+
+static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
+{
+	struct sprd_iommu_domain *dom;
+
+	if (domain_type != IOMMU_DOMAIN_DMA && domain_type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+
+	dom = kzalloc(sizeof(*dom), GFP_KERNEL);
+	if (!dom)
+		return NULL;
+
+	if (iommu_get_dma_cookie(&dom->domain)) {
+		kfree(dom);
+		return NULL;
+	}
+
+	spin_lock_init(&dom->pgtlock);
+
+	return &dom->domain;
+}
+
+static void sprd_iommu_domain_free(struct iommu_domain *domain)
+{
+	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+	struct sprd_iommu_device *sdev = dom->sdev;
+	size_t pgt_size = (size_t)sprd_iommu_pgt_size(sdev->mdata);
+
+	dma_free_coherent(sdev->dev, pgt_size, dom->pgt_va,
+			  sprd_iommu_dma_addr(dom->pgt_va));
+	kfree(dom);
+}
+
+static void sprd_iommu_first_vpn(struct sprd_iommu_device *sdev)
+{
+	u32 val = (u32)sdev->mdata->iova_start;
+
+	val = val >> SPRD_IOMMU_PAGE_SHIFT;
+	iommu_writel(sdev, SPRD_REG_FIRST_VPN, val);
+}
+
+static void sprd_iommu_vpn_range(struct sprd_iommu_device *sdev)
+{
+	u32 val = (u32)sdev->mdata->iova_size;
+
+	val = (val >> SPRD_IOMMU_PAGE_SHIFT) - 1;
+	iommu_writel(sdev, SPRD_REG_VPN_RANGE, val);
+}
+
+static void sprd_iommu_first_ppn(struct sprd_iommu_domain *dom)
+{
+	u32 val = sprd_iommu_dma_addr(dom->pgt_va) >> SPRD_IOMMU_PAGE_SHIFT;
+	struct sprd_iommu_device *sdev = dom->sdev;
+
+	iommu_writel(sdev, SPRD_REG_FIRST_PPN, val);
+}
+
+static void sprd_iommu_default_ppn(struct sprd_iommu_device *sdev)
+{
+	u32 val = (u32)sdev->prot_page;
+
+	val = val >> SPRD_IOMMU_PAGE_SHIFT;
+	iommu_writel(sdev, SPRD_REG_DEFAULT_PPN, val);
+}
+
+static void sprd_iommu_hw_cfg(struct sprd_iommu_device *sdev)
+{
+	/* enable mmu, clk gate, vaor bypass */
+	iommu_writel(sdev, SPRD_REG_CFG, SPRD_IOMMU_EN | SPRD_IOMMU_GATE_EN |
+		     SPRD_IOMMU_VAOR_BYPASS);
+
+	/* clear iommu TLB buffer after page table updated */
+	iommu_writel(sdev, SPRD_REG_UPDATE, 0xffffffff);
+}
+
+static int sprd_iommu_attach_device(struct iommu_domain *domain,
+				    struct device *dev)
+{
+	struct sprd_iommu_device *sdev = dev_iommu_priv_get(dev);
+	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+	size_t pgt_size = (size_t)sprd_iommu_pgt_size(sdev->mdata);
+
+	dom->pgt_va = (u32 *)__get_free_pages(GFP_KERNEL, get_order(pgt_size));
+	if (!dom->pgt_va) {
+		dev_err(sdev->dev, "Fail to alloc pages.\n");
+		return -ENOMEM;
+	}
+
+	dom->domain.geometry.aperture_start = sdev->mdata->iova_start;
+	dom->domain.geometry.aperture_end = sdev->mdata->iova_start +
+					    sdev->mdata->iova_size - 1;
+	dom->sdev = sdev;
+
+	sprd_iommu_first_ppn(dom);
+	sprd_iommu_first_vpn(sdev);
+	sprd_iommu_vpn_range(sdev);
+	sprd_iommu_default_ppn(sdev);
+	sprd_iommu_hw_cfg(sdev);
+
+	return 0;
+}
+
+static void sprd_iommu_detach_device(struct iommu_domain *domain,
+					     struct device *dev)
+{
+	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+
+	dom->sdev = NULL;
+}
+
+static int sprd_iommu_map(struct iommu_domain *domain, unsigned long iova,
+			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+	const struct sprd_iommu_match_data *mdata;
+	unsigned int page_num = size >> SPRD_IOMMU_PAGE_SHIFT;
+	unsigned long flags;
+	unsigned int i;
+	u32 *pgt_base_iova;
+	u32 pabase = (u32)paddr;
+	int map_size = 0;
+
+	if (!dom->sdev) {
+		pr_err("No sprd_iommu_device attached to the domain\n");
+		return -EINVAL;
+	}
+
+	mdata = dom->sdev->mdata;
+	if ((iova + size) > (mdata->iova_start + mdata->iova_size) ||
+	    iova < mdata->iova_start) {
+		dev_err(dom->sdev->dev, "(iova(0x%lx) + sixe(0x%lx)) are not in the range!\n",
+			iova, size);
+		return -EINVAL;
+	}
+
+	pgt_base_iova = dom->pgt_va +
+		((iova - mdata->iova_start) >> SPRD_IOMMU_PAGE_SHIFT);
+
+	spin_lock_irqsave(&dom->pgtlock, flags);
+	for (i = 0; i < page_num; i++) {
+		pgt_base_iova[i] = pabase >> SPRD_IOMMU_PAGE_SHIFT;
+		pabase += SPRD_IOMMU_PAGE_SIZE;
+		map_size += SPRD_IOMMU_PAGE_SIZE;
+	}
+	spin_unlock_irqrestore(&dom->pgtlock, flags);
+
+	return map_size == size ? 0 : -EEXIST;
+}
+
+static size_t sprd_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
+			size_t size, struct iommu_iotlb_gather *iotlb_gather)
+{
+	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+	const struct sprd_iommu_match_data *mdata = dom->sdev->mdata;
+	unsigned long flags;
+	u32 *pgt_base_iova;
+	unsigned int page_num = size >> SPRD_IOMMU_PAGE_SHIFT;
+
+	if ((iova + size) > (mdata->iova_start + mdata->iova_size) ||
+	    iova < mdata->iova_start)
+		return -EINVAL;
+
+	pgt_base_iova = dom->pgt_va +
+		((iova - mdata->iova_start) >> SPRD_IOMMU_PAGE_SHIFT);
+
+	spin_lock_irqsave(&dom->pgtlock, flags);
+	memset(pgt_base_iova, 0, page_num * sizeof(u32));
+	spin_unlock_irqrestore(&dom->pgtlock, flags);
+
+	return 0;
+}
+
+static void sprd_iommu_sync_map(struct iommu_domain *domain)
+{
+	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+
+	iommu_writel(dom->sdev, SPRD_REG_UPDATE, 0xffffffff);
+}
+
+static phys_addr_t sprd_iommu_iova_to_phys(struct iommu_domain *domain,
+					   dma_addr_t iova)
+{
+	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+	const struct sprd_iommu_match_data *mdata = dom->sdev->mdata;
+	unsigned long flags;
+	phys_addr_t pa;
+	unsigned long start = mdata->iova_start;
+	unsigned long end = mdata->iova_start + mdata->iova_size - 1;
+
+	if (iova < start || iova > end)
+		pr_err("iova (0x%llx) exceed the vpn range[0x%lx-0x%lx]!\n",
+		       iova, start, end);
+
+	spin_lock_irqsave(&dom->pgtlock, flags);
+	pa = *(dom->pgt_va + ((iova - mdata->iova_start) >> SPRD_IOMMU_PAGE_SHIFT));
+	pa = pa << SPRD_IOMMU_PAGE_SHIFT;
+	spin_unlock_irqrestore(&dom->pgtlock, flags);
+
+	return pa;
+}
+
+static struct iommu_device *sprd_iommu_probe_device(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct sprd_iommu_device *sdev;
+
+	if (!fwspec || fwspec->ops != &sprd_iommu_ops)
+		return ERR_PTR(-ENODEV);
+
+	sdev = dev_iommu_priv_get(dev);
+
+	return &sdev->iommu;
+}
+
+static void sprd_iommu_release_device(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (!fwspec || fwspec->ops != &sprd_iommu_ops)
+		return;
+
+	iommu_fwspec_free(dev);
+}
+
+static struct iommu_group *sprd_iommu_device_group(struct device *dev)
+{
+	struct sprd_iommu_device *sdev = dev_iommu_priv_get(dev);
+
+	if (!sdev)
+		return ERR_PTR(-ENODEV);
+
+	/* All the client devices are in the same iommu-group */
+	if (!sdev->group) {
+		sdev->group = iommu_group_alloc();
+		if (IS_ERR(sdev->group))
+			dev_err(dev, "Failed to allocate IOMMU group\n");
+	}
+
+	return sdev->group;
+}
+
+static int sprd_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
+{
+	struct platform_device *pdev;
+
+	if (args->args_count != 0) {
+		dev_err(dev, "invalid #iommu-cells(%d) property for IOMMU\n",
+			args->args_count);
+		return -EINVAL;
+	}
+
+	if (!dev_iommu_priv_get(dev)) {
+		pdev = of_find_device_by_node(args->np);
+		if (WARN_ON(!pdev))
+			return -EINVAL;
+
+		dev_iommu_priv_set(dev, platform_get_drvdata(pdev));
+	}
+
+	return iommu_fwspec_add_ids(dev, args->args, 1);
+}
+
+
+static const struct iommu_ops sprd_iommu_ops = {
+	.domain_alloc	= sprd_iommu_domain_alloc,
+	.domain_free	= sprd_iommu_domain_free,
+	.attach_dev	= sprd_iommu_attach_device,
+	.detach_dev	= sprd_iommu_detach_device,
+	.map		= sprd_iommu_map,
+	.unmap		= sprd_iommu_unmap,
+	.iotlb_sync_map = sprd_iommu_sync_map,
+	.iova_to_phys	= sprd_iommu_iova_to_phys,
+	.probe_device	= sprd_iommu_probe_device,
+	.release_device	= sprd_iommu_release_device,
+	.device_group	= sprd_iommu_device_group,
+	.of_xlate	= sprd_iommu_of_xlate,
+	.pgsize_bitmap	= ~0UL << SPRD_IOMMU_PAGE_SHIFT,
+};
+
+static const struct sprd_iommu_match_data sprd_iommu_disp = {
+	.id = SPRD_IOMMU_DISP,
+	.iova_start = 0x30000000,
+	.iova_size = 0x10000000,
+};
+
+static const struct of_device_id sprd_iommu_of_match[] = {
+	{ .compatible = "sprd,iommu-disp",
+	  .data = &sprd_iommu_disp },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sprd_iommu_of_match);
+
+static int sprd_iommu_probe(struct platform_device *pdev)
+{
+	struct sprd_iommu_device *sdev;
+	struct device *dev = &pdev->dev;
+	void *p;
+	int ret;
+
+	sdev = devm_kzalloc(dev, sizeof(*sdev), GFP_KERNEL);
+	if (!sdev)
+		return -ENOMEM;
+
+	sdev->base = devm_platform_ioremap_resource(pdev, 0);
+
+	sdev->mdata = device_get_match_data(dev);
+
+	p = (void *)__get_free_page(GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+	sdev->prot_page = virt_to_phys(p);
+	sdev->dev = dev;
+
+	platform_set_drvdata(pdev, sdev);
+
+	ret = iommu_device_sysfs_add(&sdev->iommu, &pdev->dev, NULL,
+				     dev_name(&pdev->dev));
+	if (ret)
+		return ret;
+
+	iommu_device_set_ops(&sdev->iommu, &sprd_iommu_ops);
+	iommu_device_set_fwnode(&sdev->iommu, &pdev->dev.of_node->fwnode);
+
+	ret = iommu_device_register(&sdev->iommu);
+	if (ret)
+		return ret;
+
+	if (!iommu_present(&platform_bus_type))
+		bus_set_iommu(&platform_bus_type,  &sprd_iommu_ops);
+
+	return 0;
+}
+
+static int sprd_iommu_remove(struct platform_device *pdev)
+{
+	struct sprd_iommu_device *sdev = platform_get_drvdata(pdev);
+
+	if (sdev->group)
+		iommu_group_put(sdev->group);
+
+	bus_set_iommu(&platform_bus_type, NULL);
+
+	platform_set_drvdata(pdev, NULL);
+	iommu_device_sysfs_remove(&sdev->iommu);
+	iommu_device_unregister(&sdev->iommu);
+
+	return 0;
+}
+
+static struct platform_driver sprd_iommu_driver = {
+	.driver	= {
+		.name			= "sprd-iommu",
+		.of_match_table		= sprd_iommu_of_match,
+
+	},
+	.probe	= sprd_iommu_probe,
+	.remove	= sprd_iommu_remove,
+};
+module_platform_driver(sprd_iommu_driver);
+
+MODULE_DESCRIPTION("IOMMU driver for Unisoc SoCs");
+MODULE_ALIAS("platform:sprd-iommu");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

