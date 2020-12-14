Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DF52D9E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440678AbgLNSKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440637AbgLNSIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 13:08:50 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D58C061794;
        Mon, 14 Dec 2020 10:08:09 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id o19so6844546lfo.1;
        Mon, 14 Dec 2020 10:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xboIL5/mBfOdxGSP39jMm+BFzzRvUU9QIoaNcHU+zr4=;
        b=L8jp/HY00AKkS80PbWYdsv8fNjCkNkGofPvGUQ68XsVPTTDgXQDU20n29ROa3rYKqd
         8fI7waXl8GlYFAIebCve+OjCcu06BfPmc3NK1Q2lpI38QRXA0c0pZKUa+Gz5yohpiZsC
         bmY1iaNIukplY6pIT3OB0RSomLVQqdgJnRnOZBNlCNNbLv9R2QdYzimsgnvUjR1bfwLm
         8vTgtMKuRReMBHPfftePLU2Cwu3fl7JBZiJEi+k/Prg3aFUUCknpH6gv+JsgGUHrAud4
         EYy0O2UvZ4NMhmzh/1ZLisBk4dzhbMZWMJW4DCtEFdTOn1NiYHLq1mZuk3wTw7Y6Foom
         Nc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xboIL5/mBfOdxGSP39jMm+BFzzRvUU9QIoaNcHU+zr4=;
        b=NCTS4xAhv9euP+GxxKatZc300uGOL1SErbm0VxMoV4K/bjiXVrvXSdiiFfG4gy9ZMa
         MbegT+3kSfK588QlVO1eWHkra8dwuIDdZnzRtIgUdwvxlc7DhjPiCFix4MxlOx1KyEvY
         7YjnZGk492wz0U/Wi9hhBgSWtXNqN4zMHMhD7heWyGb8jmNlGSYWbg4yn1ZkZME6fjXQ
         c7akkB8XSMNGp0Na8NjdTm5MXSGsMoGNs5TbTxdMj2g4zUU4GJwl78hlmc3KYGkqAGmH
         wmzXKDUibA0ZRBsO8ioyal3KrarNum8HQCIgU8/FOx5Fhl8OpukTD9ewCoo776k97fSX
         09Jw==
X-Gm-Message-State: AOAM530UfDFhp5iz6u2slMZG7k4rA1Is/rwIMG83A1G75ec9rIKxOHV7
        kmgreNpSTjfgR4Yunf1WUC4=
X-Google-Smtp-Source: ABdhPJxSMHGK+xsNaHWa5q5P/Hf/oliIoFxbF0Gx6RA6U8iFiJmiYbLL8Q1o7iAdc63s/Qg1j2FGYQ==
X-Received: by 2002:a2e:898a:: with SMTP id c10mr8607436lji.241.1607969287199;
        Mon, 14 Dec 2020 10:08:07 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id t26sm2422349ljo.16.2020.12.14.10.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 10:08:06 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 2/2] soc: bcm: add PM driver for Broadcom's PMB
Date:   Mon, 14 Dec 2020 19:07:43 +0100
Message-Id: <20201214180743.14584-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201214180743.14584-1-zajec5@gmail.com>
References: <20201214180743.14584-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

PMB originally comes from BCM63138 but can be also found on many other
chipsets (e.g. BCM4908). It's needed to power on and off SoC blocks like
PCIe, SATA, USB.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Use drivers/soc/bcm/bcm63xx/
    Add help to the config BCM_PMB
    Drop debugging print
---
 MAINTAINERS                       |  10 +
 drivers/soc/bcm/Makefile          |   2 +-
 drivers/soc/bcm/bcm63xx/Kconfig   |   9 +
 drivers/soc/bcm/bcm63xx/Makefile  |   1 +
 drivers/soc/bcm/bcm63xx/bcm-pmb.c | 333 ++++++++++++++++++++++++++++++
 5 files changed, 354 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/bcm/bcm63xx/bcm-pmb.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b75f29..75140f0d1541 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3656,6 +3656,16 @@ L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	drivers/firmware/broadcom/*
 
+BROADCOM PMB (POWER MANAGEMENT BUS) DRIVER
+M:	Rafał Miłecki <rafal@milecki.pl>
+M:	Florian Fainelli <f.fainelli@gmail.com>
+M:	bcm-kernel-feedback-list@broadcom.com
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+T:	git git://github.com/broadcom/stblinux.git
+F:	drivers/soc/bcm/bcm-pmb.c
+F:	include/dt-bindings/soc/bcm-pmb.h
+
 BROADCOM SPECIFIC AMBA DRIVER (BCMA)
 M:	Rafał Miłecki <zajec5@gmail.com>
 L:	linux-wireless@vger.kernel.org
diff --git a/drivers/soc/bcm/Makefile b/drivers/soc/bcm/Makefile
index 7bc90e0bd773..0f0efa28d92b 100644
--- a/drivers/soc/bcm/Makefile
+++ b/drivers/soc/bcm/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_BCM2835_POWER)	+= bcm2835-power.o
 obj-$(CONFIG_RASPBERRYPI_POWER)	+= raspberrypi-power.o
-obj-$(CONFIG_SOC_BCM63XX)	+= bcm63xx/
+obj-y				+= bcm63xx/
 obj-$(CONFIG_SOC_BRCMSTB)	+= brcmstb/
diff --git a/drivers/soc/bcm/bcm63xx/Kconfig b/drivers/soc/bcm/bcm63xx/Kconfig
index 16f648a6c70a..9e501c8ac5ce 100644
--- a/drivers/soc/bcm/bcm63xx/Kconfig
+++ b/drivers/soc/bcm/bcm63xx/Kconfig
@@ -10,3 +10,12 @@ config BCM63XX_POWER
 	  BCM6318, BCM6328, BCM6362 and BCM63268 SoCs.
 
 endif # SOC_BCM63XX
+
+config BCM_PMB
+	bool "Broadcom PMB (Power Management Bus) driver"
+	depends on ARCH_BCM4908 || (COMPILE_TEST && OF)
+	default ARCH_BCM4908
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for the Broadcom's PMB (Power Management Bus) that
+	  is used for disabling and enabling SoC devices.
diff --git a/drivers/soc/bcm/bcm63xx/Makefile b/drivers/soc/bcm/bcm63xx/Makefile
index 0710d5e018cc..557eed3d67bd 100644
--- a/drivers/soc/bcm/bcm63xx/Makefile
+++ b/drivers/soc/bcm/bcm63xx/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_BCM63XX_POWER) += bcm63xx-power.o
+obj-$(CONFIG_BCM_PMB)		+= bcm-pmb.o
diff --git a/drivers/soc/bcm/bcm63xx/bcm-pmb.c b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
new file mode 100644
index 000000000000..c223023dc64f
--- /dev/null
+++ b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2013 Broadcom
+ * Copyright (C) 2020 Rafał Miłecki <rafal@milecki.pl>
+ */
+
+#include <dt-bindings/soc/bcm-pmb.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/reset/bcm63xx_pmb.h>
+
+#define BPCM_ID_REG					0x00
+#define BPCM_CAPABILITIES				0x04
+#define  BPCM_CAP_NUM_ZONES				0x000000ff
+#define  BPCM_CAP_SR_REG_BITS				0x0000ff00
+#define  BPCM_CAP_PLLTYPE				0x00030000
+#define  BPCM_CAP_UBUS					0x00080000
+#define BPCM_CONTROL					0x08
+#define BPCM_STATUS					0x0c
+#define BPCM_ROSC_CONTROL				0x10
+#define BPCM_ROSC_THRESH_H				0x14
+#define BPCM_ROSC_THRESHOLD_BCM6838			0x14
+#define BPCM_ROSC_THRESH_S				0x18
+#define BPCM_ROSC_COUNT_BCM6838				0x18
+#define BPCM_ROSC_COUNT					0x1c
+#define BPCM_PWD_CONTROL_BCM6838			0x1c
+#define BPCM_PWD_CONTROL				0x20
+#define BPCM_SR_CONTROL_BCM6838				0x20
+#define BPCM_PWD_ACCUM_CONTROL				0x24
+#define BPCM_SR_CONTROL					0x28
+#define BPCM_GLOBAL_CONTROL				0x2c
+#define BPCM_MISC_CONTROL				0x30
+#define BPCM_MISC_CONTROL2				0x34
+#define BPCM_SGPHY_CNTL					0x38
+#define BPCM_SGPHY_STATUS				0x3c
+#define BPCM_ZONE0					0x40
+#define  BPCM_ZONE_CONTROL				0x00
+#define   BPCM_ZONE_CONTROL_MANUAL_CLK_EN		0x00000001
+#define   BPCM_ZONE_CONTROL_MANUAL_RESET_CTL		0x00000002
+#define   BPCM_ZONE_CONTROL_FREQ_SCALE_USED		0x00000004	/* R/O */
+#define   BPCM_ZONE_CONTROL_DPG_CAPABLE			0x00000008	/* R/O */
+#define   BPCM_ZONE_CONTROL_MANUAL_MEM_PWR		0x00000030
+#define   BPCM_ZONE_CONTROL_MANUAL_ISO_CTL		0x00000040
+#define   BPCM_ZONE_CONTROL_MANUAL_CTL			0x00000080
+#define   BPCM_ZONE_CONTROL_DPG_CTL_EN			0x00000100
+#define   BPCM_ZONE_CONTROL_PWR_DN_REQ			0x00000200
+#define   BPCM_ZONE_CONTROL_PWR_UP_REQ			0x00000400
+#define   BPCM_ZONE_CONTROL_MEM_PWR_CTL_EN		0x00000800
+#define   BPCM_ZONE_CONTROL_BLK_RESET_ASSERT		0x00001000
+#define   BPCM_ZONE_CONTROL_MEM_STBY			0x00002000
+#define   BPCM_ZONE_CONTROL_RESERVED			0x0007c000
+#define   BPCM_ZONE_CONTROL_PWR_CNTL_STATE		0x00f80000
+#define   BPCM_ZONE_CONTROL_FREQ_SCALAR_DYN_SEL		0x01000000	/* R/O */
+#define   BPCM_ZONE_CONTROL_PWR_OFF_STATE		0x02000000	/* R/O */
+#define   BPCM_ZONE_CONTROL_PWR_ON_STATE		0x04000000	/* R/O */
+#define   BPCM_ZONE_CONTROL_PWR_GOOD			0x08000000	/* R/O */
+#define   BPCM_ZONE_CONTROL_DPG_PWR_STATE		0x10000000	/* R/O */
+#define   BPCM_ZONE_CONTROL_MEM_PWR_STATE		0x20000000	/* R/O */
+#define   BPCM_ZONE_CONTROL_ISO_STATE			0x40000000	/* R/O */
+#define   BPCM_ZONE_CONTROL_RESET_STATE			0x80000000	/* R/O */
+#define  BPCM_ZONE_CONFIG1				0x04
+#define  BPCM_ZONE_CONFIG2				0x08
+#define  BPCM_ZONE_FREQ_SCALAR_CONTROL			0x0c
+#define  BPCM_ZONE_SIZE					0x10
+
+struct bcm_pmb {
+	struct device *dev;
+	void __iomem *base;
+	spinlock_t lock;
+	bool little_endian;
+	struct genpd_onecell_data genpd_onecell_data;
+};
+
+struct bcm_pmb_pd_data {
+	const char * const name;
+	int id;
+	u8 bus;
+	u8 device;
+};
+
+struct bcm_pmb_pm_domain {
+	struct bcm_pmb *pmb;
+	const struct bcm_pmb_pd_data *data;
+	struct generic_pm_domain genpd;
+};
+
+static int bcm_pmb_bpcm_read(struct bcm_pmb *pmb, int bus, u8 device,
+			     int offset, u32 *val)
+{
+	void __iomem *base = pmb->base + bus * 0x20;
+	unsigned long flags;
+	int err;
+
+	spin_lock_irqsave(&pmb->lock, flags);
+	err = bpcm_rd(base, device, offset, val);
+	spin_unlock_irqrestore(&pmb->lock, flags);
+
+	if (!err)
+		*val = pmb->little_endian ? le32_to_cpu(*val) : be32_to_cpu(*val);
+
+	return err;
+}
+
+static int bcm_pmb_bpcm_write(struct bcm_pmb *pmb, int bus, u8 device,
+			      int offset, u32 val)
+{
+	void __iomem *base = pmb->base + bus * 0x20;
+	unsigned long flags;
+	int err;
+
+	val = pmb->little_endian ? cpu_to_le32(val) : cpu_to_be32(val);
+
+	spin_lock_irqsave(&pmb->lock, flags);
+	err = bpcm_wr(base, device, offset, val);
+	spin_unlock_irqrestore(&pmb->lock, flags);
+
+	return err;
+}
+
+static int bcm_pmb_power_off_zone(struct bcm_pmb *pmb, int bus, u8 device,
+				  int zone)
+{
+	int offset;
+	u32 val;
+	int err;
+
+	offset = BPCM_ZONE0 + zone * BPCM_ZONE_SIZE + BPCM_ZONE_CONTROL;
+
+	err = bcm_pmb_bpcm_read(pmb, bus, device, offset, &val);
+	if (err)
+		return err;
+
+	val |= BPCM_ZONE_CONTROL_PWR_DN_REQ;
+	val &= ~BPCM_ZONE_CONTROL_PWR_UP_REQ;
+
+	err = bcm_pmb_bpcm_write(pmb, bus, device, offset, val);
+
+	return err;
+}
+
+static int bcm_pmb_power_on_zone(struct bcm_pmb *pmb, int bus, u8 device,
+				 int zone)
+{
+	int offset;
+	u32 val;
+	int err;
+
+	offset = BPCM_ZONE0 + zone * BPCM_ZONE_SIZE + BPCM_ZONE_CONTROL;
+
+	err = bcm_pmb_bpcm_read(pmb, bus, device, offset, &val);
+	if (err)
+		return err;
+
+	if (!(val & BPCM_ZONE_CONTROL_PWR_ON_STATE)) {
+		val &= ~BPCM_ZONE_CONTROL_PWR_DN_REQ;
+		val |= BPCM_ZONE_CONTROL_DPG_CTL_EN;
+		val |= BPCM_ZONE_CONTROL_PWR_UP_REQ;
+		val |= BPCM_ZONE_CONTROL_MEM_PWR_CTL_EN;
+		val |= BPCM_ZONE_CONTROL_BLK_RESET_ASSERT;
+
+		err = bcm_pmb_bpcm_write(pmb, bus, device, offset, val);
+	}
+
+	return err;
+}
+
+static int bcm_pmb_power_off_device(struct bcm_pmb *pmb, int bus, u8 device)
+{
+	int offset;
+	u32 val;
+	int err;
+
+	/* Entire device can be powered off by powering off the 0th zone */
+	offset = BPCM_ZONE0 + BPCM_ZONE_CONTROL;
+
+	err = bcm_pmb_bpcm_read(pmb, bus, device, offset, &val);
+	if (err)
+		return err;
+
+	if (!(val & BPCM_ZONE_CONTROL_PWR_OFF_STATE)) {
+		val = BPCM_ZONE_CONTROL_PWR_DN_REQ;
+
+		err = bcm_pmb_bpcm_write(pmb, bus, device, offset, val);
+	}
+
+	return err;
+}
+
+static int bcm_pmb_power_on_device(struct bcm_pmb *pmb, int bus, u8 device)
+{
+	u32 val;
+	int err;
+	int i;
+
+	err = bcm_pmb_bpcm_read(pmb, bus, device, BPCM_CAPABILITIES, &val);
+	if (err)
+		return err;
+
+	for (i = 0; i < (val & BPCM_CAP_NUM_ZONES); i++) {
+		err = bcm_pmb_power_on_zone(pmb, bus, device, i);
+		if (err)
+			return err;
+	}
+
+	return err;
+}
+
+static int bcm_pmb_power_on(struct generic_pm_domain *genpd)
+{
+	struct bcm_pmb_pm_domain *pd = container_of(genpd, struct bcm_pmb_pm_domain, genpd);
+	const struct bcm_pmb_pd_data *data = pd->data;
+	struct bcm_pmb *pmb = pd->pmb;
+
+	switch (data->id) {
+	case BCM_PMB_PCIE0:
+	case BCM_PMB_PCIE1:
+	case BCM_PMB_PCIE2:
+		return bcm_pmb_power_on_zone(pmb, data->bus, data->device, 0);
+	case BCM_PMB_HOST_USB:
+		return bcm_pmb_power_on_device(pmb, data->bus, data->device);
+	default:
+		dev_err(pmb->dev, "unsupported device id: %d\n", data->id);
+		return -EINVAL;
+	}
+}
+
+static int bcm_pmb_power_off(struct generic_pm_domain *genpd)
+{
+	struct bcm_pmb_pm_domain *pd = container_of(genpd, struct bcm_pmb_pm_domain, genpd);
+	const struct bcm_pmb_pd_data *data = pd->data;
+	struct bcm_pmb *pmb = pd->pmb;
+
+	switch (data->id) {
+	case BCM_PMB_PCIE0:
+	case BCM_PMB_PCIE1:
+	case BCM_PMB_PCIE2:
+		return bcm_pmb_power_off_zone(pmb, data->bus, data->device, 0);
+	case BCM_PMB_HOST_USB:
+		return bcm_pmb_power_off_device(pmb, data->bus, data->device);
+	default:
+		dev_err(pmb->dev, "unsupported device id: %d\n", data->id);
+		return -EINVAL;
+	}
+}
+
+static int bcm_pmb_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct bcm_pmb_pd_data *table;
+	const struct bcm_pmb_pd_data *e;
+	struct resource *res;
+	struct bcm_pmb *pmb;
+	int max_id;
+	int err;
+
+	pmb = devm_kzalloc(dev, sizeof(*pmb), GFP_KERNEL);
+	if (!pmb)
+		return -ENOMEM;
+
+	pmb->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pmb->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pmb->base))
+		return PTR_ERR(pmb->base);
+
+	spin_lock_init(&pmb->lock);
+
+	pmb->little_endian = !of_device_is_big_endian(dev->of_node);
+
+	table = of_device_get_match_data(dev);
+	if (!table)
+		return -EINVAL;
+
+	max_id = 0;
+	for (e = table; e->name; e++)
+		max_id = max(max_id, e->id);
+
+	pmb->genpd_onecell_data.num_domains = max_id + 1;
+	pmb->genpd_onecell_data.domains =
+		devm_kcalloc(dev, pmb->genpd_onecell_data.num_domains,
+			     sizeof(struct generic_pm_domain *), GFP_KERNEL);
+	if (!pmb->genpd_onecell_data.domains)
+		return -ENOMEM;
+
+	for (e = table; e->name; e++) {
+		struct bcm_pmb_pm_domain *pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
+
+		pd->pmb = pmb;
+		pd->data = e;
+		pd->genpd.name = e->name;
+		pd->genpd.power_on = bcm_pmb_power_on;
+		pd->genpd.power_off = bcm_pmb_power_off;
+
+		pm_genpd_init(&pd->genpd, NULL, true);
+		pmb->genpd_onecell_data.domains[e->id] = &pd->genpd;
+	}
+
+	err = of_genpd_add_provider_onecell(dev->of_node, &pmb->genpd_onecell_data);
+	if (err) {
+		dev_err(dev, "failed to add genpd provider: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static const struct bcm_pmb_pd_data bcm_pmb_bcm4908_data[] = {
+	{ .name = "pcie2", .id = BCM_PMB_PCIE2, .bus = 0, .device = 2, },
+	{ .name = "pcie0", .id = BCM_PMB_PCIE0, .bus = 1, .device = 14, },
+	{ .name = "pcie1", .id = BCM_PMB_PCIE1, .bus = 1, .device = 15, },
+	{ .name = "usb", .id = BCM_PMB_HOST_USB, .bus = 1, .device = 17, },
+	{ },
+};
+
+static const struct of_device_id bcm_pmb_of_match[] = {
+	{ .compatible = "brcm,bcm4908-pmb", .data = &bcm_pmb_bcm4908_data, },
+	{ },
+};
+
+static struct platform_driver bcm_pmb_driver = {
+	.driver = {
+		.name = "bcm-pmb",
+		.of_match_table = bcm_pmb_of_match,
+	},
+	.probe  = bcm_pmb_probe,
+};
+
+builtin_platform_driver(bcm_pmb_driver);
-- 
2.26.2

