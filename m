Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4568304DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388581AbhAZXX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:23:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:1979 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbhAZFqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 00:46:35 -0500
IronPort-SDR: rcpU67Nqbv4yo69/NGU57F3NVwCNLgFOH8bbQOIsfYpMJnT1F6iGrgi/N6/ZQEaU3j/9za+Vv6
 nk8Rvx9IAMRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="179997341"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="179997341"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:40:41 -0800
IronPort-SDR: RAybm0TA10DcBTXCPvJgTthVSpm9AidYYpAzXDq3vhs4r0l5/L72dxVkbkFbIPKK+qKOqh3ehV
 mxMLgttfY+ew==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="410039124"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:40:40 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 99A2B6374;
        Mon, 25 Jan 2021 21:40:40 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 8DBBF3630D4; Mon, 25 Jan 2021 21:40:40 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH v3 09/34] misc: xlink-pcie: lh: Add PCIe EPF driver for Local Host
Date:   Mon, 25 Jan 2021 21:40:11 -0800
Message-Id: <20210126054036.61587-10-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126054036.61587-1-mgross@linux.intel.com>
References: <20210126054036.61587-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srikanth Thokala <srikanth.thokala@intel.com>

Add PCIe EPF driver for local host (lh) to configure BAR's and other
HW resources. Underlying PCIe HW controller is a Synopsys DWC PCIe core.

Cc: Derek Kiernan <derek.kiernan@xilinx.com>
Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
---
 MAINTAINERS                                 |   6 +
 drivers/misc/Kconfig                        |   1 +
 drivers/misc/Makefile                       |   1 +
 drivers/misc/xlink-pcie/Kconfig             |   9 +
 drivers/misc/xlink-pcie/Makefile            |   1 +
 drivers/misc/xlink-pcie/local_host/Makefile |   2 +
 drivers/misc/xlink-pcie/local_host/epf.c    | 373 ++++++++++++++++++++
 drivers/misc/xlink-pcie/local_host/epf.h    |  37 ++
 drivers/misc/xlink-pcie/local_host/xpcie.h  |  38 ++
 9 files changed, 468 insertions(+)
 create mode 100644 drivers/misc/xlink-pcie/Kconfig
 create mode 100644 drivers/misc/xlink-pcie/Makefile
 create mode 100644 drivers/misc/xlink-pcie/local_host/Makefile
 create mode 100644 drivers/misc/xlink-pcie/local_host/epf.c
 create mode 100644 drivers/misc/xlink-pcie/local_host/epf.h
 create mode 100644 drivers/misc/xlink-pcie/local_host/xpcie.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6742a1827cd9..3ca6c8c6341b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1961,6 +1961,12 @@ F:	Documentation/devicetree/bindings/arm/intel,keembay.yaml
 F:	arch/arm64/boot/dts/intel/keembay-evm.dts
 F:	arch/arm64/boot/dts/intel/keembay-soc.dtsi
 
+ARM KEEM BAY XLINK PCIE SUPPORT
+M:	Srikanth Thokala <srikanth.thokala@intel.com>
+M:	Mark Gross <mgross@linux.intel.com>
+S:	Supported
+F:	drivers/misc/xlink-pcie/
+
 ARM/INTEL RESEARCH IMOTE/STARGATE 2 MACHINE SUPPORT
 M:	Jonathan Cameron <jic23@cam.ac.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index fafa8b0d8099..dfb98e444c6e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -481,4 +481,5 @@ source "drivers/misc/ocxl/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
 source "drivers/misc/uacce/Kconfig"
+source "drivers/misc/xlink-pcie/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d23231e73330..d17621fc43d5 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
+obj-y                           += xlink-pcie/
diff --git a/drivers/misc/xlink-pcie/Kconfig b/drivers/misc/xlink-pcie/Kconfig
new file mode 100644
index 000000000000..46aa401d79b7
--- /dev/null
+++ b/drivers/misc/xlink-pcie/Kconfig
@@ -0,0 +1,9 @@
+config XLINK_PCIE_LH_DRIVER
+	tristate "XLink PCIe Local Host driver"
+	depends on PCI_ENDPOINT && ARCH_KEEMBAY
+	help
+	  This option enables XLink PCIe Local Host driver.
+
+	  Choose M here to compile this driver as a module, name is mxlk_ep.
+	  This driver is used for XLink communication over PCIe and is to be
+	  loaded on the Intel Keem Bay platform.
diff --git a/drivers/misc/xlink-pcie/Makefile b/drivers/misc/xlink-pcie/Makefile
new file mode 100644
index 000000000000..d693d382e9c6
--- /dev/null
+++ b/drivers/misc/xlink-pcie/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_XLINK_PCIE_LH_DRIVER) += local_host/
diff --git a/drivers/misc/xlink-pcie/local_host/Makefile b/drivers/misc/xlink-pcie/local_host/Makefile
new file mode 100644
index 000000000000..514d3f0c91bc
--- /dev/null
+++ b/drivers/misc/xlink-pcie/local_host/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_XLINK_PCIE_LH_DRIVER) += mxlk_ep.o
+mxlk_ep-objs := epf.o
diff --git a/drivers/misc/xlink-pcie/local_host/epf.c b/drivers/misc/xlink-pcie/local_host/epf.c
new file mode 100644
index 000000000000..0234756e89ae
--- /dev/null
+++ b/drivers/misc/xlink-pcie/local_host/epf.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Keem Bay XLink PCIe Driver
+ *
+ * Copyright (C) 2021 Intel Corporation
+ */
+
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "epf.h"
+
+#define BAR2_MIN_SIZE			SZ_16K
+#define BAR4_MIN_SIZE			SZ_16K
+
+#define PCIE_REGS_PCIE_INTR_ENABLE	0x18
+#define PCIE_REGS_PCIE_INTR_FLAGS	0x1C
+#define LBC_CII_EVENT_FLAG		BIT(18)
+#define PCIE_REGS_PCIE_ERR_INTR_FLAGS	0x24
+#define LINK_REQ_RST_FLG		BIT(15)
+
+static struct pci_epf_header xpcie_header = {
+	.vendorid = PCI_VENDOR_ID_INTEL,
+	.deviceid = PCI_DEVICE_ID_INTEL_KEEMBAY,
+	.baseclass_code = PCI_BASE_CLASS_MULTIMEDIA,
+	.subclass_code = 0x0,
+	.subsys_vendor_id = 0x0,
+	.subsys_id = 0x0,
+};
+
+static const struct pci_epf_device_id xpcie_epf_ids[] = {
+	{
+		.name = "mxlk_pcie_epf",
+	},
+	{},
+};
+
+static irqreturn_t intel_xpcie_err_interrupt(int irq, void *args)
+{
+	struct xpcie_epf *xpcie_epf;
+	struct xpcie *xpcie = args;
+	u32 val;
+
+	xpcie_epf = container_of(xpcie, struct xpcie_epf, xpcie);
+	val = ioread32(xpcie_epf->apb_base + PCIE_REGS_PCIE_ERR_INTR_FLAGS);
+
+	iowrite32(val, xpcie_epf->apb_base + PCIE_REGS_PCIE_ERR_INTR_FLAGS);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t intel_xpcie_host_interrupt(int irq, void *args)
+{
+	struct xpcie_epf *xpcie_epf;
+	struct xpcie *xpcie = args;
+	u32 val;
+
+	xpcie_epf = container_of(xpcie, struct xpcie_epf, xpcie);
+	val = ioread32(xpcie_epf->apb_base + PCIE_REGS_PCIE_INTR_FLAGS);
+	if (val & LBC_CII_EVENT_FLAG) {
+		iowrite32(LBC_CII_EVENT_FLAG,
+			  xpcie_epf->apb_base + PCIE_REGS_PCIE_INTR_FLAGS);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void
+intel_xpcie_configure_bar(struct pci_epf *epf,
+			  const struct pci_epc_features *epc_features)
+{
+	struct pci_epf_bar *epf_bar;
+	bool bar_fixed_64bit;
+	int i;
+
+	for (i = BAR_0; i <= BAR_5; i++) {
+		epf_bar = &epf->bar[i];
+		bar_fixed_64bit = !!(epc_features->bar_fixed_64bit & (1 << i));
+		if (bar_fixed_64bit)
+			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+		if (epc_features->bar_fixed_size[i])
+			epf_bar->size = epc_features->bar_fixed_size[i];
+	}
+}
+
+static void intel_xpcie_cleanup_bar(struct pci_epf *epf, enum pci_barno barno)
+{
+	struct xpcie_epf *xpcie_epf = epf_get_drvdata(epf);
+	struct pci_epc *epc = epf->epc;
+
+	if (xpcie_epf->vaddr[barno]) {
+		pci_epc_clear_bar(epc, epf->func_no, &epf->bar[barno]);
+		pci_epf_free_space(epf, xpcie_epf->vaddr[barno], barno);
+		xpcie_epf->vaddr[barno] = NULL;
+	}
+}
+
+static void intel_xpcie_cleanup_bars(struct pci_epf *epf)
+{
+	struct xpcie_epf *xpcie_epf = epf_get_drvdata(epf);
+
+	intel_xpcie_cleanup_bar(epf, BAR_2);
+	intel_xpcie_cleanup_bar(epf, BAR_4);
+	xpcie_epf->xpcie.mmio = NULL;
+	xpcie_epf->xpcie.bar4 = NULL;
+}
+
+static int intel_xpcie_setup_bar(struct pci_epf *epf, enum pci_barno barno,
+				 size_t min_size, size_t align)
+{
+	struct xpcie_epf *xpcie_epf = epf_get_drvdata(epf);
+	struct pci_epf_bar *bar = &epf->bar[barno];
+	struct pci_epc *epc = epf->epc;
+	void *vaddr;
+	int ret;
+
+	bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+	if (!bar->size)
+		bar->size = min_size;
+
+	if (barno == BAR_4)
+		bar->flags |= PCI_BASE_ADDRESS_MEM_PREFETCH;
+
+	vaddr = pci_epf_alloc_space(epf, bar->size, barno, align);
+	if (!vaddr) {
+		dev_err(&epf->dev, "Failed to map BAR%d\n", barno);
+		return -ENOMEM;
+	}
+
+	ret = pci_epc_set_bar(epc, epf->func_no, bar);
+	if (ret) {
+		pci_epf_free_space(epf, vaddr, barno);
+		dev_err(&epf->dev, "Failed to set BAR%d\n", barno);
+		return ret;
+	}
+
+	xpcie_epf->vaddr[barno] = vaddr;
+
+	return 0;
+}
+
+static int intel_xpcie_setup_bars(struct pci_epf *epf, size_t align)
+{
+	int ret;
+
+	struct xpcie_epf *xpcie_epf = epf_get_drvdata(epf);
+
+	ret = intel_xpcie_setup_bar(epf, BAR_2, BAR2_MIN_SIZE, align);
+	if (ret)
+		return ret;
+
+	ret = intel_xpcie_setup_bar(epf, BAR_4, BAR4_MIN_SIZE, align);
+	if (ret) {
+		intel_xpcie_cleanup_bar(epf, BAR_2);
+		return ret;
+	}
+
+	xpcie_epf->comm_bar = BAR_2;
+	xpcie_epf->xpcie.mmio = (void *)xpcie_epf->vaddr[BAR_2] +
+				XPCIE_MMIO_OFFSET;
+
+	xpcie_epf->bar4 = BAR_4;
+	xpcie_epf->xpcie.bar4 = xpcie_epf->vaddr[BAR_4];
+
+	return 0;
+}
+
+static int intel_xpcie_epf_get_platform_data(struct device *dev,
+					     struct xpcie_epf *xpcie_epf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct device_node *soc_node, *version_node;
+	struct resource *res;
+	const char *prop;
+	int prop_size;
+
+	xpcie_epf->irq_dma = platform_get_irq_byname(pdev, "intr");
+	if (xpcie_epf->irq_dma < 0) {
+		dev_err(&xpcie_epf->epf->dev, "failed to get IRQ: %d\n",
+			xpcie_epf->irq_dma);
+		return -EINVAL;
+	}
+
+	xpcie_epf->irq_err = platform_get_irq_byname(pdev, "err_intr");
+	if (xpcie_epf->irq_err < 0) {
+		dev_err(&xpcie_epf->epf->dev, "failed to get erroe IRQ: %d\n",
+			xpcie_epf->irq_err);
+		return -EINVAL;
+	}
+
+	xpcie_epf->irq = platform_get_irq_byname(pdev, "ev_intr");
+	if (xpcie_epf->irq < 0) {
+		dev_err(&xpcie_epf->epf->dev, "failed to get event IRQ: %d\n",
+			xpcie_epf->irq);
+		return -EINVAL;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb");
+	xpcie_epf->apb_base =
+		devm_ioremap(dev, res->start, resource_size(res));
+	if (IS_ERR(xpcie_epf->apb_base))
+		return PTR_ERR(xpcie_epf->apb_base);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
+	xpcie_epf->dbi_base =
+		devm_ioremap(dev, res->start, resource_size(res));
+	if (IS_ERR(xpcie_epf->dbi_base))
+		return PTR_ERR(xpcie_epf->dbi_base);
+
+	memcpy(xpcie_epf->stepping, "B0", 2);
+	soc_node = of_get_parent(pdev->dev.of_node);
+	if (soc_node) {
+		version_node = of_get_child_by_name(soc_node, "version-info");
+		if (version_node) {
+			prop = of_get_property(version_node, "stepping",
+					       &prop_size);
+			if (prop && prop_size <= KEEMBAY_XPCIE_STEPPING_MAXLEN)
+				memcpy(xpcie_epf->stepping, prop, prop_size);
+			of_node_put(version_node);
+		}
+		of_node_put(soc_node);
+	}
+
+	return 0;
+}
+
+static int intel_xpcie_epf_bind(struct pci_epf *epf)
+{
+	struct xpcie_epf *xpcie_epf = epf_get_drvdata(epf);
+	const struct pci_epc_features *features;
+	struct pci_epc *epc = epf->epc;
+	struct device *dev;
+	size_t align = SZ_16K;
+	int ret;
+
+	if (WARN_ON_ONCE(!epc))
+		return -EINVAL;
+
+	dev = epc->dev.parent;
+	features = pci_epc_get_features(epc, epf->func_no);
+	xpcie_epf->epc_features = features;
+	if (features) {
+		align = features->align;
+		intel_xpcie_configure_bar(epf, features);
+	}
+
+	ret = intel_xpcie_setup_bars(epf, align);
+	if (ret) {
+		dev_err(&epf->dev, "BAR initialization failed\n");
+		return ret;
+	}
+
+	ret = intel_xpcie_epf_get_platform_data(dev, xpcie_epf);
+	if (ret) {
+		dev_err(&epf->dev, "Unable to get platform data\n");
+		return -EINVAL;
+	}
+
+	if (!strcmp(xpcie_epf->stepping, "A0")) {
+		xpcie_epf->xpcie.legacy_a0 = true;
+		iowrite32(1, (void __iomem *)xpcie_epf->xpcie.mmio +
+			     XPCIE_MMIO_LEGACY_A0);
+	} else {
+		xpcie_epf->xpcie.legacy_a0 = false;
+		iowrite32(0, (void __iomem *)xpcie_epf->xpcie.mmio +
+			     XPCIE_MMIO_LEGACY_A0);
+	}
+
+	/* Enable interrupt */
+	writel(LBC_CII_EVENT_FLAG,
+	       xpcie_epf->apb_base + PCIE_REGS_PCIE_INTR_ENABLE);
+	ret = devm_request_irq(&epf->dev, xpcie_epf->irq,
+			       &intel_xpcie_host_interrupt, 0,
+			       XPCIE_DRIVER_NAME, &xpcie_epf->xpcie);
+	if (ret) {
+		dev_err(&epf->dev, "failed to request irq\n");
+		goto err_cleanup_bars;
+	}
+
+	ret = devm_request_irq(&epf->dev, xpcie_epf->irq_err,
+			       &intel_xpcie_err_interrupt, 0,
+			       XPCIE_DRIVER_NAME, &xpcie_epf->xpcie);
+	if (ret) {
+		dev_err(&epf->dev, "failed to request error irq\n");
+		goto err_cleanup_bars;
+	}
+
+	return 0;
+
+err_cleanup_bars:
+	intel_xpcie_cleanup_bars(epf);
+
+	return ret;
+}
+
+static void intel_xpcie_epf_unbind(struct pci_epf *epf)
+{
+	struct xpcie_epf *xpcie_epf = epf_get_drvdata(epf);
+	struct pci_epc *epc = epf->epc;
+
+	free_irq(xpcie_epf->irq, &xpcie_epf->xpcie);
+	free_irq(xpcie_epf->irq_err, &xpcie_epf->xpcie);
+
+	pci_epc_stop(epc);
+
+	intel_xpcie_cleanup_bars(epf);
+}
+
+static int intel_xpcie_epf_probe(struct pci_epf *epf)
+{
+	struct device *dev = &epf->dev;
+	struct xpcie_epf *xpcie_epf;
+
+	xpcie_epf = devm_kzalloc(dev, sizeof(*xpcie_epf), GFP_KERNEL);
+	if (!xpcie_epf)
+		return -ENOMEM;
+
+	epf->header = &xpcie_header;
+	xpcie_epf->epf = epf;
+	epf_set_drvdata(epf, xpcie_epf);
+
+	return 0;
+}
+
+static void intel_xpcie_epf_shutdown(struct device *dev)
+{
+	struct pci_epf *epf = to_pci_epf(dev);
+	struct xpcie_epf *xpcie_epf;
+
+	xpcie_epf = epf_get_drvdata(epf);
+
+	/* Notify host in case PCIe hot plug not supported */
+	if (xpcie_epf)
+		pci_epc_raise_irq(epf->epc, epf->func_no, PCI_EPC_IRQ_MSI, 1);
+}
+
+static struct pci_epf_ops ops = {
+	.bind = intel_xpcie_epf_bind,
+	.unbind = intel_xpcie_epf_unbind,
+};
+
+static struct pci_epf_driver xpcie_epf_driver = {
+	.driver.name = "mxlk_pcie_epf",
+	.driver.shutdown = intel_xpcie_epf_shutdown,
+	.probe = intel_xpcie_epf_probe,
+	.id_table = xpcie_epf_ids,
+	.ops = &ops,
+	.owner = THIS_MODULE,
+};
+
+static int __init intel_xpcie_epf_init(void)
+{
+	int ret;
+
+	ret = pci_epf_register_driver(&xpcie_epf_driver);
+	if (ret) {
+		pr_err("Failed to register xlink pcie epf driver: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(intel_xpcie_epf_init);
+
+static void __exit intel_xpcie_epf_exit(void)
+{
+	pci_epf_unregister_driver(&xpcie_epf_driver);
+}
+module_exit(intel_xpcie_epf_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION(XPCIE_DRIVER_DESC);
diff --git a/drivers/misc/xlink-pcie/local_host/epf.h b/drivers/misc/xlink-pcie/local_host/epf.h
new file mode 100644
index 000000000000..a60cd43fe555
--- /dev/null
+++ b/drivers/misc/xlink-pcie/local_host/epf.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Intel Keem Bay XLink PCIe Driver
+ *
+ * Copyright (C) 2021 Intel Corporation
+ */
+
+#ifndef XPCIE_EPF_HEADER_
+#define XPCIE_EPF_HEADER_
+
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+
+#include "xpcie.h"
+
+#define XPCIE_DRIVER_NAME "mxlk_pcie_epf"
+#define XPCIE_DRIVER_DESC "Intel(R) xLink PCIe endpoint function driver"
+
+#define KEEMBAY_XPCIE_STEPPING_MAXLEN 8
+
+struct xpcie_epf {
+	struct pci_epf *epf;
+	void *vaddr[BAR_5 + 1];
+	enum pci_barno comm_bar;
+	enum pci_barno bar4;
+	const struct pci_epc_features *epc_features;
+	struct xpcie xpcie;
+	int irq;
+	int irq_dma;
+	int irq_err;
+	void __iomem *apb_base;
+	void __iomem *dma_base;
+	void __iomem *dbi_base;
+	char stepping[KEEMBAY_XPCIE_STEPPING_MAXLEN];
+};
+
+#endif /* XPCIE_EPF_HEADER_ */
diff --git a/drivers/misc/xlink-pcie/local_host/xpcie.h b/drivers/misc/xlink-pcie/local_host/xpcie.h
new file mode 100644
index 000000000000..0745e6dfee10
--- /dev/null
+++ b/drivers/misc/xlink-pcie/local_host/xpcie.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*****************************************************************************
+ *
+ * Intel Keem Bay XLink PCIe Driver
+ *
+ * Copyright (C) 2020 Intel Corporation
+ *
+ ****************************************************************************/
+
+#ifndef XPCIE_HEADER_
+#define XPCIE_HEADER_
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci_ids.h>
+
+#ifndef PCI_DEVICE_ID_INTEL_KEEMBAY
+#define PCI_DEVICE_ID_INTEL_KEEMBAY 0x6240
+#endif
+
+#define XPCIE_IO_COMM_SIZE SZ_16K
+#define XPCIE_MMIO_OFFSET SZ_4K
+
+/* MMIO layout and offsets shared between device and host */
+struct xpcie_mmio {
+	u8 legacy_a0;
+} __packed;
+
+#define XPCIE_MMIO_LEGACY_A0	(offsetof(struct xpcie_mmio, legacy_a0))
+
+struct xpcie {
+	u32 status;
+	bool legacy_a0;
+	void *mmio;
+	void *bar4;
+};
+
+#endif /* XPCIE_HEADER_ */
-- 
2.17.1

