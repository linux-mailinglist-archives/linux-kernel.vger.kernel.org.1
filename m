Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4912DB607
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 22:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbgLOVsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 16:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730086AbgLOVsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 16:48:21 -0500
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0354C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 13:47:40 -0800 (PST)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kpIAU-0087WL-Bn
        for linux-kernel@vger.kernel.org; Tue, 15 Dec 2020 22:47:38 +0100
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kpI9w-0087Sm-L3; Tue, 15 Dec 2020 22:47:04 +0100
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kpI9w-002j4z-6D; Tue, 15 Dec 2020 22:47:04 +0100
From:   Bert Vermeulen <bert@biot.com>
To:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, broonie@kernel.org,
        john.garry@huawei.com, bbrezillon@kernel.org, gch981213@gmail.com,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Bert Vermeulen <bert@biot.com>
Subject: [PATCH] Add spi-nor driver for Realtek RTL838x/RTL839x switch SoCs
Date:   Tue, 15 Dec 2020 22:46:56 +0100
Message-Id: <20201215214656.649896-1-bert@biot.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver supports the spiflash core in all RTL838x/RTL839x SoCs,
and likely some older models as well (RTL8196C).

Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 drivers/mtd/spi-nor/controllers/Kconfig       |   7 +
 drivers/mtd/spi-nor/controllers/Makefile      |   1 +
 .../spi-nor/controllers/rtl8380-spiflash.c    | 347 ++++++++++++++++++
 .../spi-nor/controllers/rtl8380-spiflash.h    |  34 ++
 4 files changed, 389 insertions(+)
 create mode 100644 drivers/mtd/spi-nor/controllers/rtl8380-spiflash.c
 create mode 100644 drivers/mtd/spi-nor/controllers/rtl8380-spiflash.h

diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
index 5c0e0ec2e6d1..1e035c511ea5 100644
--- a/drivers/mtd/spi-nor/controllers/Kconfig
+++ b/drivers/mtd/spi-nor/controllers/Kconfig
@@ -62,3 +62,10 @@ config SPI_INTEL_SPI_PLATFORM
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel-spi-platform.
+
+config SPI_REALTEK_RTL8380
+	tristate "Realtek RTL8380 SPI flash controller"
+	depends on MACH_REALTEK
+	help
+	  This enables support for the SPI flash controller in the Realtek
+	  RTL8380 series SoCs.
diff --git a/drivers/mtd/spi-nor/controllers/Makefile b/drivers/mtd/spi-nor/controllers/Makefile
index e7abba491d98..f03a79e88a78 100644
--- a/drivers/mtd/spi-nor/controllers/Makefile
+++ b/drivers/mtd/spi-nor/controllers/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_SPI_NXP_SPIFI)	+= nxp-spifi.o
 obj-$(CONFIG_SPI_INTEL_SPI)	+= intel-spi.o
 obj-$(CONFIG_SPI_INTEL_SPI_PCI)	+= intel-spi-pci.o
 obj-$(CONFIG_SPI_INTEL_SPI_PLATFORM)	+= intel-spi-platform.o
+obj-$(CONFIG_SPI_REALTEK_RTL8380)	+= rtl8380-spiflash.o
diff --git a/drivers/mtd/spi-nor/controllers/rtl8380-spiflash.c b/drivers/mtd/spi-nor/controllers/rtl8380-spiflash.c
new file mode 100644
index 000000000000..cd1f48f1e3d0
--- /dev/null
+++ b/drivers/mtd/spi-nor/controllers/rtl8380-spiflash.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/spi-nor.h>
+
+#include "rtl8380-spiflash.h"
+
+
+extern struct realtek_soc_info soc_info;
+
+static int rtl8380_nor_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf, size_t len);
+static int rtl8380_nor_write_reg(struct spi_nor *nor, u8 opcode, const u8 *buf, size_t len);
+
+
+static inline u32 rtl8380_read(struct rtl8380_nor *rtnor, u32 reg, bool wait)
+{
+	if (wait)
+		while (!(readl(rtnor->base + RTL8380_SPI_SFCSR) & RTL8380_SPI_SFCSR_RDY))
+			;
+	return readl(rtnor->base + reg);
+}
+
+static inline void rtl8380_write(struct rtl8380_nor *rtnor, u32 reg, u32 value, bool wait)
+{
+	if (wait)
+		while (!(readl(rtnor->base + RTL8380_SPI_SFCSR) & RTL8380_SPI_SFCSR_RDY))
+			;
+	writel(value, rtnor->base + reg);
+}
+
+/*
+ * Deactivate both chip selects and return base SFCSR register settings: correct
+ * CS, data length 1, IO width 1.
+ */
+static uint32_t spi_prep(struct rtl8380_nor *rtnor)
+{
+	uint32_t init, ret;
+
+	/* Deactivate CS0 and CS1 first */
+	init = (RTL8380_SPI_SFCSR_CSB0 | RTL8380_SPI_SFCSR_CSB1) & RTL8380_SPI_SFCSR_LEN_MASK;
+	rtl8380_write(rtnor, RTL8380_SPI_SFCSR, init, true);
+
+	/* CS bitfield is active low, so reversed logic */
+	if (rtnor->cs == 0)
+		ret = RTL8380_SPI_SFCSR_LEN1 | RTL8380_SPI_SFCSR_CSB1;
+	else
+		ret = RTL8380_SPI_SFCSR_LEN1 | RTL8380_SPI_SFCSR_CSB0 | RTL8380_SPI_SFCSR_CS;
+
+	return ret;
+}
+
+static int rtl8380_nor_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf, size_t len)
+{
+	struct rtl8380_nor *rtnor = nor->priv;
+	uint32_t sfcsr;
+
+	sfcsr = spi_prep(rtnor);
+	sfcsr &= RTL8380_SPI_SFCSR_LEN_MASK | RTL8380_SPI_SFCSR_LEN1;
+
+	rtl8380_write(rtnor, RTL8380_SPI_SFCSR, sfcsr, true);
+	rtl8380_write(rtnor, RTL8380_SPI_SFDR, opcode << 24, true);
+
+	while (len > 0) {
+		*(buf) = rtl8380_read(rtnor, RTL8380_SPI_SFDR, true) >> 24;
+		buf++;
+		len--;
+	}
+
+	return 0;
+}
+
+static int rtl8380_nor_write_reg(struct spi_nor *nor, u8 opcode, const u8 *buf,
+				 size_t len)
+{
+	struct rtl8380_nor *rtnor = nor->priv;
+	uint32_t sfcsr, sfdr, len_bits;
+
+	sfcsr = spi_prep(rtnor);
+	sfdr = opcode << 24;
+
+	if (len == 0) {
+		len_bits = RTL8380_SPI_SFCSR_LEN1;
+	} else if (len == 1) {
+		sfdr |= buf[0] << 16;
+		len_bits = RTL8380_SPI_SFCSR_LEN2;
+	} else if (len == 2) {
+		sfdr |= buf[0] << 16;
+		sfdr |= buf[1] << 8;
+		len_bits = RTL8380_SPI_SFCSR_LEN3;
+	} else {
+		return -EINVAL;
+	}
+	sfcsr |= len_bits;
+
+	rtl8380_write(rtnor, RTL8380_SPI_SFCSR, sfcsr, true);
+	rtl8380_write(rtnor, RTL8380_SPI_SFDR, sfdr, true);
+
+	return 0;
+}
+
+static ssize_t rtl8380_nor_read(struct spi_nor *nor, loff_t from, size_t len,
+				u_char *buf)
+{
+	struct rtl8380_nor *rtnor = nor->priv;
+	uint32_t sfcsr;
+	ssize_t ret = 0;
+	int sfcsr_addrlen_bits, i;
+
+	if (rtnor->nor.addr_width == 4) {
+		sfcsr_addrlen_bits = 0x03;
+	} else {
+		sfcsr_addrlen_bits = 0x02;
+		from <<= 8;
+	}
+
+	sfcsr = spi_prep(rtnor);
+	sfcsr &= RTL8380_SPI_SFCSR_LEN_MASK;
+
+	/* Send read command */
+	rtl8380_write(rtnor, RTL8380_SPI_SFCSR, sfcsr | RTL8380_SPI_SFCSR_LEN1, true);
+	rtl8380_write(rtnor, RTL8380_SPI_SFDR, rtnor->nor.read_opcode << 24, false);
+
+	/* Send address */
+	rtl8380_write(rtnor, RTL8380_SPI_SFCSR, sfcsr | (sfcsr_addrlen_bits << 28), true);
+	rtl8380_write(rtnor, RTL8380_SPI_SFDR, from, false);
+
+	/* Dummy cycles */
+	for (i = 0; i < nor->read_dummy / 8; i++) {
+		rtl8380_write(rtnor, RTL8380_SPI_SFCSR, sfcsr, true);
+		rtl8380_write(rtnor, RTL8380_SPI_SFDR, 0, false);
+	}
+
+	/* Read 4 bytes at a time */
+	rtl8380_write(rtnor, RTL8380_SPI_SFCSR, sfcsr | RTL8380_SPI_SFCSR_LEN4, true);
+	while (len >= 4){
+		*((uint32_t*) buf) = rtl8380_read(rtnor, RTL8380_SPI_SFDR, false);
+		buf += 4;
+		len -= 4;
+		ret += 4;
+	}
+
+	/* Read remainder 1 byte at a time */
+	rtl8380_write(rtnor, RTL8380_SPI_SFCSR, sfcsr | RTL8380_SPI_SFCSR_LEN1, true);
+	while (len > 0) {
+		*(buf) = rtl8380_read(rtnor, RTL8380_SPI_SFDR, false) >> 24;
+		buf++;
+		len--;
+		ret++;
+	}
+
+	return ret;
+}
+
+static ssize_t rtl8380_nor_write(struct spi_nor *nor, loff_t to, size_t len,
+				 const u_char *buf)
+{
+	struct rtl8380_nor *rtnor = nor->priv;
+	uint32_t sfcsr;
+	ssize_t ret = 0;
+	int sfcsr_addrlen_bits;
+
+	if (rtnor->nor.addr_width == 4) {
+		sfcsr_addrlen_bits = 0x03;
+	} else {
+		sfcsr_addrlen_bits = 0x02;
+		to <<= 8;
+	}
+
+	sfcsr = spi_prep(rtnor);
+	sfcsr &= RTL8380_SPI_SFCSR_LEN_MASK;
+
+	/* Send write command */
+	rtl8380_write(rtnor, RTL8380_SPI_SFCSR, sfcsr | RTL8380_SPI_SFCSR_LEN1, true);
+	rtl8380_write(rtnor, RTL8380_SPI_SFDR, nor->program_opcode << 24, false);
+
+	/* Send address */
+	rtl8380_write(rtnor, RTL8380_SPI_SFCSR, sfcsr | (sfcsr_addrlen_bits << 28), true);
+	rtl8380_write(rtnor, RTL8380_SPI_SFDR, to, false);
+
+	/* Write 4 bytes at a time */
+	rtl8380_write(rtnor, RTL8380_SPI_SFCSR, sfcsr | RTL8380_SPI_SFCSR_LEN4, true);
+	while (len >= 4) {
+		rtl8380_write(rtnor, RTL8380_SPI_SFDR, *((uint32_t*)buf), true);
+		buf += 4;
+		len -= 4;
+		ret += 4;
+	}
+
+	/* Write remainder 1 byte at a time */
+	rtl8380_write(rtnor, RTL8380_SPI_SFCSR, sfcsr | RTL8380_SPI_SFCSR_LEN1, true);
+	while (len > 0) {
+		rtl8380_write(rtnor, RTL8380_SPI_SFDR, *buf << 24, true);
+		buf++;
+		len--;
+		ret++;
+	}
+
+	return ret;
+}
+
+static int rtl8380_erase(struct spi_nor *nor, loff_t offset)
+{
+	struct rtl8380_nor *rtnor = nor->priv;
+	uint32_t sfcsr;
+	int sfcsr_addrlen_bits;
+
+	if (rtnor->nor.addr_width == 4) {
+		sfcsr_addrlen_bits = 0x03;
+	} else {
+		sfcsr_addrlen_bits = 0x02;
+		offset <<= 8;
+	}
+
+	sfcsr = spi_prep(rtnor);
+
+	/* Send erase command */
+	rtl8380_write(rtnor, RTL8380_SPI_SFCSR, sfcsr | RTL8380_SPI_SFCSR_LEN1, true);
+	rtl8380_write(rtnor, RTL8380_SPI_SFDR, nor->erase_opcode << 24, false);
+
+	/* Send address */
+	rtl8380_write(rtnor, RTL8380_SPI_SFCSR, sfcsr | (sfcsr_addrlen_bits << 28), true);
+	rtl8380_write(rtnor, RTL8380_SPI_SFDR, offset, false);
+
+	return 0;
+}
+
+static const struct spi_nor_controller_ops rtl8380_controller_ops = {
+	.read_reg = rtl8380_nor_read_reg,
+	.write_reg = rtl8380_nor_write_reg,
+	.read = rtl8380_nor_read,
+	.write = rtl8380_nor_write,
+	.erase = rtl8380_erase,
+};
+
+static int rtl8380_spi_nor_scan(struct spi_nor *nor)
+{
+	struct rtl8380_nor *rtnor = nor->priv;
+	static const struct spi_nor_hwcaps hwcaps = {
+		.mask = SNOR_HWCAPS_READ | SNOR_HWCAPS_READ_FAST | SNOR_HWCAPS_PP
+	};
+	u32 sfcr;
+	int ret;
+
+	/* Turn on big-endian byte ordering */
+	sfcr = rtl8380_read(rtnor, RTL8380_SPI_SFCR, true);
+	sfcr |= RTL8380_SPI_SFCR_RBO | RTL8380_SPI_SFCR_WBO;
+	rtl8380_write(rtnor, RTL8380_SPI_SFCR, sfcr, true);
+
+	ret = spi_nor_scan(nor, NULL, &hwcaps);
+
+	return ret;
+}
+
+static int rtl8380_nor_init(struct rtl8380_nor *rtnor,
+		     struct device_node *flash_node)
+{
+	struct spi_nor *nor;
+	int ret;
+
+	nor = &rtnor->nor;
+	nor->priv = rtnor;
+	spi_nor_set_flash_node(nor, flash_node);
+	nor->controller_ops = &rtl8380_controller_ops;
+	nor->mtd.name = "rtl8380-spiflash";
+
+	ret = rtl8380_spi_nor_scan(nor);
+	if (ret)
+		return ret;
+	pr_info("SPI flash address width is %d bytes\n", nor->addr_width);
+
+	ret = mtd_device_parse_register(&nor->mtd, NULL, NULL, NULL, 0);
+
+	return ret;
+}
+
+static int rtl8380_nor_drv_probe(struct platform_device *pdev)
+{
+	struct device_node *flash_np;
+	struct resource *res;
+	struct rtl8380_nor *rtnor;
+	int ret;
+
+	if (!pdev->dev.of_node) {
+		dev_err(&pdev->dev, "No DT found\n");
+		return -EINVAL;
+	}
+
+	rtnor = devm_kzalloc(&pdev->dev, sizeof(*rtnor), GFP_KERNEL);
+	if (!rtnor)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, rtnor);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	rtnor->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(rtnor->base))
+		return PTR_ERR(rtnor->base);
+
+	rtnor->nor.dev = &pdev->dev;
+
+	/* Only support one attached flash */
+	flash_np = of_get_next_available_child(pdev->dev.of_node, NULL);
+	if (!flash_np) {
+		dev_err(&pdev->dev, "no SPI flash device to configure\n");
+		return -ENODEV;
+	}
+
+	/* Optional chip select, defaults to 0 */
+	ret = of_property_read_u32(flash_np, "reg", &rtnor->cs);
+	if (ret)
+		rtnor->cs = 0;
+
+	ret = rtl8380_nor_init(rtnor, flash_np);
+
+	return ret;
+}
+
+static int rtl8380_nor_drv_remove(struct platform_device *pdev)
+{
+	struct rtl8380_nor *rtnor;
+
+	rtnor = platform_get_drvdata(pdev);
+	mtd_device_unregister(&rtnor->nor.mtd);
+
+	return 0;
+}
+
+static const struct of_device_id rtl8380_nor_of_ids[] = {
+	{ .compatible = "realtek,rtl8380-spiflash"},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rtl8380_nor_of_ids);
+
+static struct platform_driver rtl8380_nor_driver = {
+	.probe = rtl8380_nor_drv_probe,
+	.remove = rtl8380_nor_drv_remove,
+	.driver = {
+		.name = "rtl8380-spiflash",
+		.pm = NULL,
+		.of_match_table = rtl8380_nor_of_ids,
+	},
+};
+
+module_platform_driver(rtl8380_nor_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("RTL8380 SPI NOR Flash Driver");
diff --git a/drivers/mtd/spi-nor/controllers/rtl8380-spiflash.h b/drivers/mtd/spi-nor/controllers/rtl8380-spiflash.h
new file mode 100644
index 000000000000..754e67087ed1
--- /dev/null
+++ b/drivers/mtd/spi-nor/controllers/rtl8380-spiflash.h
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#ifndef _RTL8380_SPIFLASH_H_
+#define _RTL8380_SPIFLASH_H_
+
+struct rtl8380_nor {
+	struct spi_nor nor;
+	void __iomem *base;
+	u32 cs;
+};
+
+/* SPI Flash Configuration Register */
+#define RTL8380_SPI_SFCR		0x00
+#define RTL8380_SPI_SFCR_RBO		BIT(28)
+#define RTL8380_SPI_SFCR_WBO		BIT(27)
+
+/* SPI Flash Control and Status Register */
+#define RTL8380_SPI_SFCSR		0x08
+#define RTL8380_SPI_SFCSR_CSB0		BIT(31)
+#define RTL8380_SPI_SFCSR_CSB1		BIT(30)
+#define RTL8380_SPI_SFCSR_RDY		BIT(27)
+#define RTL8380_SPI_SFCSR_CS		BIT(24)
+#define RTL8380_SPI_SFCSR_LEN_MASK	~(0x03 << 28)
+#define RTL8380_SPI_SFCSR_LEN1		(0x00 << 28)
+#define RTL8380_SPI_SFCSR_LEN2		(0x01 << 28)
+#define RTL8380_SPI_SFCSR_LEN3		(0x02 << 28)
+#define RTL8380_SPI_SFCSR_LEN4		(0x03 << 28)
+
+/* SPI Flash Data Registers */
+#define RTL8380_SPI_SFDR	0x0c
+#define RTL8380_SPI_SFDR2	0x10
+
+#endif /* _RTL8380_SPIFLASH_H_ */
+
-- 
2.25.1

