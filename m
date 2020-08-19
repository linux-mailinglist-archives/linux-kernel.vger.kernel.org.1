Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BA6249DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 14:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgHSMd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 08:33:59 -0400
Received: from auth-smtp.nebula.fi ([217.149.52.145]:44748 "EHLO
        auth-smtp.nebula.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbgHSMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:33:03 -0400
X-Greylist: delayed 651 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Aug 2020 08:32:58 EDT
Received: from developer-Precision-3630-Tower (82-203-173-204.bb.dnainternet.fi [82.203.173.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: xipheracom)
        by auth-smtp.nebula.fi (Postfix) with ESMTPSA id 86AEA4455;
        Wed, 19 Aug 2020 15:22:07 +0300 (EEST)
From:   Atte Tommiska <atte.tommiska@xiphera.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Atte Tommiska <atte.tommiska@xiphera.com>
Subject: [PATCH 3/3] hwrng: xiphera-trng: add support for XIP8001B hwrng
Date:   Wed, 19 Aug 2020 15:21:35 +0300
Message-Id: <20200819122135.25316-4-atte.tommiska@xiphera.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819122135.25316-1-atte.tommiska@xiphera.com>
References: <20200819122135.25316-1-atte.tommiska@xiphera.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=8.0 tests=none autolearn=unavailable
        autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        authsmtp1-hki2.nebula.fi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiphera XIP8001B is an FPGA-based True Random Number Generator
Intellectual Property (IP) Core which can be instantiated in
multiple FPGA families. This driver adds Linux support for it through
the hwrng interface.

Signed-off-by: Atte Tommiska <atte.tommiska@xiphera.com>
---
 drivers/char/hw_random/Kconfig        |  10 ++
 drivers/char/hw_random/Makefile       |   1 +
 drivers/char/hw_random/xiphera-trng.c | 151 ++++++++++++++++++++++++++
 3 files changed, 162 insertions(+)
 create mode 100644 drivers/char/hw_random/xiphera-trng.c

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index f976a49e1fb5..007d765a9253 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -512,6 +512,16 @@ config HW_RANDOM_CCTRNG
 	  will be called cctrng.
 	  If unsure, say 'N'.
 
+config HW_RANDOM_XIPHERA
+	tristate "Xiphera FPGA based True Random Number Generator support"
+	depends on HAS_IOMEM
+	help
+	  This driver provides kernel-side support for Xiphera True Random
+	  Number Generator Intellectual Property Core.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called xiphera-trng.
+
 endif # HW_RANDOM
 
 config UML_RANDOM
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index 26ae06844f09..dfdcac81e384 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -44,3 +44,4 @@ obj-$(CONFIG_HW_RANDOM_KEYSTONE) += ks-sa-rng.o
 obj-$(CONFIG_HW_RANDOM_OPTEE) += optee-rng.o
 obj-$(CONFIG_HW_RANDOM_NPCM) += npcm-rng.o
 obj-$(CONFIG_HW_RANDOM_CCTRNG) += cctrng.o
+obj-$(CONFIG_HW_RANDOM_XIPHERA) += xiphera-trng.o
diff --git a/drivers/char/hw_random/xiphera-trng.c b/drivers/char/hw_random/xiphera-trng.c
new file mode 100644
index 000000000000..2f082eb8e8a5
--- /dev/null
+++ b/drivers/char/hw_random/xiphera-trng.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2020 Xiphera Ltd. */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/hw_random.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+
+#define CONTROL_REG			0x00000000
+#define STATUS_REG			0x00000004
+#define RAND_REG			0x00000000
+
+#define HOST_TO_TRNG_RESET		0x00000001
+#define HOST_TO_TRNG_RELEASE_RESET	0x00000002
+#define HOST_TO_TRNG_ENABLE		0x80000000
+#define HOST_TO_TRNG_ZEROIZE		0x80000004
+#define HOST_TO_TRNG_ACK_ZEROIZE	0x80000008
+#define HOST_TO_TRNG_READ		0x8000000F
+
+/* trng statuses */
+#define TRNG_ACK_RESET			0x000000AC
+#define TRNG_SUCCESSFUL_STARTUP		0x00000057
+#define TRNG_FAILED_STARTUP		0x000000FA
+#define TRNG_NEW_RAND_AVAILABLE		0x000000ED
+
+struct xiphera_trng {
+	void __iomem *mem;
+	struct hwrng rng;
+};
+
+static int xiphera_trng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
+{
+	struct xiphera_trng *trng = container_of(rng, struct xiphera_trng, rng);
+	int ret = 0;
+
+	while (max >= sizeof(u32)) {
+		/* check for data */
+		if (readl(trng->mem + STATUS_REG) == TRNG_NEW_RAND_AVAILABLE) {
+			*(u32 *)buf = readl(trng->mem + RAND_REG);
+			/*
+			 * Inform the trng of the read
+			 * and re-enable it to produce a new random number
+			 */
+			writel(HOST_TO_TRNG_READ, trng->mem + CONTROL_REG);
+			writel(HOST_TO_TRNG_ENABLE, trng->mem + CONTROL_REG);
+			ret += sizeof(u32);
+			buf += sizeof(u32);
+			max -= sizeof(u32);
+		} else {
+			break;
+		}
+	}
+	return ret;
+}
+
+static int xiphera_trng_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct xiphera_trng *trng;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+
+	trng = devm_kzalloc(dev, sizeof(*trng), GFP_KERNEL);
+	if (!trng)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	trng->mem = devm_ioremap_resource(dev, res);
+	if (IS_ERR(trng->mem))
+		return PTR_ERR(trng->mem);
+
+	/*
+	 * the trng needs to be reset first which might not happen in time,
+	 * hence we incorporate a small delay to ensure proper behaviour
+	 */
+	writel(HOST_TO_TRNG_RESET, trng->mem + CONTROL_REG);
+	usleep_range(100, 200);
+
+	if (readl(trng->mem + STATUS_REG) != TRNG_ACK_RESET) {
+		/*
+		 * there is a small chance the trng is just not ready yet,
+		 * so we try one more time. If the second time fails, we give up
+		 */
+		usleep_range(100, 200);
+		if (readl(trng->mem + STATUS_REG) != TRNG_ACK_RESET) {
+			dev_err(dev, "failed to reset the trng ip\n");
+			return -ENODEV;
+		}
+	}
+
+	/*
+	 * once again, to ensure proper behaviour we sleep
+	 * for a while after zeroizing the trng
+	 */
+	writel(HOST_TO_TRNG_RELEASE_RESET, trng->mem + CONTROL_REG);
+	writel(HOST_TO_TRNG_ENABLE, trng->mem + CONTROL_REG);
+	writel(HOST_TO_TRNG_ZEROIZE, trng->mem + CONTROL_REG);
+	msleep(20);
+
+	if (readl(trng->mem + STATUS_REG) != TRNG_SUCCESSFUL_STARTUP) {
+		/* diagnose the reason for the failure */
+		if (readl(trng->mem + STATUS_REG) == TRNG_FAILED_STARTUP) {
+			dev_err(dev, "trng ip startup-tests failed\n");
+			return -ENODEV;
+		}
+		dev_err(dev, "startup-tests yielded no response\n");
+		return -ENODEV;
+	}
+
+	writel(HOST_TO_TRNG_ACK_ZEROIZE, trng->mem + CONTROL_REG);
+
+	trng->rng.name = pdev->name;
+	trng->rng.read = xiphera_trng_read;
+	trng->rng.quality = 900;
+
+	ret = devm_hwrng_register(dev, &trng->rng);
+	if (ret) {
+		dev_err(dev, "failed to register rng device: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, trng);
+
+	return 0;
+}
+
+static const struct of_device_id xiphera_trng_of_match[] = {
+	{ .compatible = "xiphera,xip8001b-trng", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xiphera_trng_of_match);
+
+static struct platform_driver xiphera_trng_driver = {
+	.driver = {
+		.name = "xiphera-trng",
+		.owner = THIS_MODULE,
+		.of_match_table	= xiphera_trng_of_match,
+	},
+	.probe = xiphera_trng_probe,
+};
+
+module_platform_driver(xiphera_trng_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Atte Tommiska");
+MODULE_DESCRIPTION("Xiphera FPGA-based true random number generator driver");
-- 
2.28.0

