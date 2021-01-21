Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942EE2FE94C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbhAULuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:50:00 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:36685 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730101AbhAULUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611228052; x=1642764052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Fdf9OnTBFgfQBR84ixjFKpX80iSmhJBN+KwWlQeFgOU=;
  b=YV7tkdA06AiCDEPhUMb/sVafnQdN3+sCxsmN3s+FuAEs7+yCgZHvUiBQ
   jfUMkzGif9f6Y208eQDTZEylV67nmc/hWH/XKnPVJ2aeTb32osBE/qn6n
   m+my7xQrqzFiZLZ9x46wDd46D19YTeUQvKrJSgEHD5Xgp7cB+abFIY+AD
   6GaCbPEvKZfw7DaIdXJz70R4t5bElmleEgReKNLbbN59TY/71yPRxL3yo
   AcqHZddxf18Ekixduy9kKSN6SRHDzMfb4b5w65m8lA2pBQA77x0NF4OKy
   l90/GkM/MsFvpm+6MhoMqCBXttEnXPiOXIDLeZ/5SUVjDKLYvnbq5v4wA
   Q==;
IronPort-SDR: r6WU6ibkMNbBfCpZhZtX+GAGihYWO1yOhpLoHsBgtkVst0gZ8osLtidtRW9vKvC8gaiSjVEibJ
 bEQpscDtGKkEdYdXBWF8kASXtpyT0qO6Q1rKosm3I3oimwe7aJF3fQETFcFGCoBdGXv2ugsya6
 CNzp++KD7UIl6mN3uhGn1+BWT8yys9onN70ff6U4TgaEeev5j0nbg93R4TXGwN4hQvRTiFvDhp
 E6JpgVWw5oCLN9xfmcZ9q9clqgh1aMtW78uA+Qa2D672k7ht0QI0NBa+dILoxa7Qzi9nkiKAus
 C0k=
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="100892437"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2021 04:19:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 21 Jan 2021 04:19:35 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 21 Jan 2021 04:19:31 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <viresh.kumar@linaro.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/5] clk: at91: pmc: execute suspend/resume only for backup mode
Date:   Thu, 21 Jan 2021 13:19:08 +0200
Message-ID: <1611227951-4590-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611227951-4590-1-git-send-email-claudiu.beznea@microchip.com>
References: <1611227951-4590-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before going to backup mode architecture specific PM code sets the first
word in securam (and it will be cleared in a subsequent commit for the rest
of power saving modes). Thus take this into account when
suspending/resuming clocks. This will avoid executing unnecessary
instructions when suspending to non backup modes. Since the clear of the
1st word in securam will be done in a subsequent commit the current commit
will not broke the current behavior since up to this moment the
suspend/resume were executed for all AT91 PM modes. The difference now
is that the suspend/resume for clocks will be executed for the rest of
AT91 PM modes just after the 1st enter/exit to/from backup mode.
Also this commit changed the postcore_initcall() with subsys_initcall()
to be able to execute of_find_compatible_node() since this was not
available at the moment of postcore_initcall(). This should not alter
the tcb_clksrc since the changes are related to clocks suspend/resume
procedure that will be executed at the user space request, thus long
ago after postcore_initcall().

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/pmc.c | 48 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 77b57c9f5dcb..c226d33cd899 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -8,6 +8,8 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
 #include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -110,13 +112,35 @@ struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
 }
 
 #ifdef CONFIG_PM
+
+/* Address in SECURAM that say if we suspend to backup mode. */
+static void __iomem *at91_pmc_backup_suspend;
+
 static int at91_pmc_suspend(void)
 {
+	unsigned int backup;
+
+	if (!at91_pmc_backup_suspend)
+		return 0;
+
+	backup = *(unsigned int *)at91_pmc_backup_suspend;
+	if (!backup)
+		return 0;
+
 	return clk_save_context();
 }
 
 static void at91_pmc_resume(void)
 {
+	unsigned int backup;
+
+	if (!at91_pmc_backup_suspend)
+		return;
+
+	backup = *(unsigned int *)at91_pmc_backup_suspend;
+	if (!backup)
+		return;
+
 	clk_restore_context();
 }
 
@@ -125,24 +149,30 @@ static struct syscore_ops pmc_syscore_ops = {
 	.resume = at91_pmc_resume,
 };
 
-static const struct of_device_id sama5d2_pmc_dt_ids[] = {
-	{ .compatible = "atmel,sama5d2-pmc" },
-	{ /* sentinel */ }
-};
-
 static int __init pmc_register_ops(void)
 {
+	struct platform_device *pdev;
 	struct device_node *np;
 
-	np = of_find_matching_node(NULL, sama5d2_pmc_dt_ids);
+	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-securam");
 	if (!np)
-		return 0;
+		return -ENODEV;
+
+	pdev = of_find_device_by_node(np);
 	of_node_put(np);
+	if (!pdev)
+		return -ENODEV;
+
+	at91_pmc_backup_suspend = of_iomap(np, 0);
+	if (!at91_pmc_backup_suspend) {
+		pr_warn("%s(): unable to map securam\n", __func__);
+		return -ENOMEM;
+	}
 
 	register_syscore_ops(&pmc_syscore_ops);
 
 	return 0;
 }
-/* This has to happen before arch_initcall because of the tcb_clksrc driver */
-postcore_initcall(pmc_register_ops);
+
+subsys_initcall(pmc_register_ops);
 #endif
-- 
2.7.4

