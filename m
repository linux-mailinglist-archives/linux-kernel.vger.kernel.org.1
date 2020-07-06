Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB144215EE6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 20:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgGFSjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 14:39:46 -0400
Received: from muru.com ([72.249.23.125]:60944 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729743AbgGFSjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:39:45 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 9BAF680FE;
        Mon,  6 Jul 2020 18:40:37 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH] mfd: motorola-cpcap: Disable interrupt for suspend
Date:   Mon,  6 Jul 2020 11:39:34 -0700
Message-Id: <20200706183934.26274-1-tony@atomide.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise we get spammed with errors on resume after rtcwake:

cpcap-core spi0.0: Failed to read IRQ status: -108

Note that rtcwake is still capable of waking up the system with
this patch.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

This has always been broken so can be merged whenever.

---
 drivers/mfd/motorola-cpcap.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -214,6 +214,28 @@ static const struct regmap_config cpcap_regmap_config = {
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 };
 
+#ifdef CONFIG_PM_SLEEP
+static int cpcap_suspend(struct device *dev)
+{
+	struct spi_device *spi = to_spi_device(dev);
+
+	disable_irq(spi->irq);
+
+	return 0;
+}
+
+static int cpcap_resume(struct device *dev)
+{
+	struct spi_device *spi = to_spi_device(dev);
+
+	enable_irq(spi->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(cpcap_pm, cpcap_suspend, cpcap_resume);
+
 static const struct mfd_cell cpcap_mfd_devices[] = {
 	{
 		.name          = "cpcap_adc",
@@ -313,6 +335,7 @@ static struct spi_driver cpcap_driver = {
 	.driver = {
 		.name = "cpcap-core",
 		.of_match_table = cpcap_of_match,
+		.pm = &cpcap_pm,
 	},
 	.probe = cpcap_probe,
 };
-- 
2.27.0
