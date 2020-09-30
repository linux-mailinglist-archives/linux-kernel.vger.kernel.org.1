Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1966927F193
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgI3Ss0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:48:26 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:60221 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbgI3SsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:48:22 -0400
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 3A5B9240002;
        Wed, 30 Sep 2020 18:48:17 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] pcmcia: at91_cf: remove platform data support
Date:   Wed, 30 Sep 2020 20:48:03 +0200
Message-Id: <20200930184804.3127757-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930184804.3127757-1-alexandre.belloni@bootlin.com>
References: <20200930184804.3127757-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Board file support has been removed for at91rm9200 back in 2014, make the
CF driver DT only.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/pcmcia/Kconfig   |  1 +
 drivers/pcmcia/at91_cf.c | 38 ++++++++------------------------------
 2 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 82d10b6661c7..884023e88345 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -258,6 +258,7 @@ config OMAP_CF
 config AT91_CF
 	tristate "AT91 CompactFlash Controller"
 	depends on PCI
+	depends on OF
 	depends on PCMCIA && ARCH_AT91
 	help
 	  Say Y here to support the CompactFlash controller on AT91 chips.
diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
index 1d59c7240a09..1fde1735df8c 100644
--- a/drivers/pcmcia/at91_cf.c
+++ b/drivers/pcmcia/at91_cf.c
@@ -220,16 +220,18 @@ static struct pccard_operations at91_cf_ops = {
 
 /*--------------------------------------------------------------------------*/
 
-#if defined(CONFIG_OF)
 static const struct of_device_id at91_cf_dt_ids[] = {
 	{ .compatible = "atmel,at91rm9200-cf" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, at91_cf_dt_ids);
 
-static int at91_cf_dt_init(struct platform_device *pdev)
+static int at91_cf_probe(struct platform_device *pdev)
 {
-	struct at91_cf_data *board;
+	struct at91_cf_socket	*cf;
+	struct at91_cf_data	*board;
+	struct resource		*io;
+	int			status;
 
 	board = devm_kzalloc(&pdev->dev, sizeof(*board), GFP_KERNEL);
 	if (!board)
@@ -240,33 +242,9 @@ static int at91_cf_dt_init(struct platform_device *pdev)
 	board->vcc_pin = of_get_gpio(pdev->dev.of_node, 2);
 	board->rst_pin = of_get_gpio(pdev->dev.of_node, 3);
 
-	pdev->dev.platform_data = board;
-
 	mc = syscon_regmap_lookup_by_compatible("atmel,at91rm9200-sdramc");
-
-	return PTR_ERR_OR_ZERO(mc);
-}
-#else
-static int at91_cf_dt_init(struct platform_device *pdev)
-{
-	return -ENODEV;
-}
-#endif
-
-static int at91_cf_probe(struct platform_device *pdev)
-{
-	struct at91_cf_socket	*cf;
-	struct at91_cf_data	*board = pdev->dev.platform_data;
-	struct resource		*io;
-	int			status;
-
-	if (!board) {
-		status = at91_cf_dt_init(pdev);
-		if (status)
-			return status;
-
-		board = pdev->dev.platform_data;
-	}
+	if (IS_ERR(mc))
+		return PTR_ERR(mc);
 
 	if (!gpio_is_valid(board->det_pin) || !gpio_is_valid(board->rst_pin))
 		return -ENODEV;
@@ -410,7 +388,7 @@ static int at91_cf_resume(struct platform_device *pdev)
 static struct platform_driver at91_cf_driver = {
 	.driver = {
 		.name		= "at91_cf",
-		.of_match_table = of_match_ptr(at91_cf_dt_ids),
+		.of_match_table = at91_cf_dt_ids,
 	},
 	.probe		= at91_cf_probe,
 	.remove		= at91_cf_remove,
-- 
2.26.2

