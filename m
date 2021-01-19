Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14FD2FB3C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 09:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbhASILE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 03:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbhASIK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:10:27 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00BCC061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 00:09:45 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id JY9g2400H4C55Sk01Y9gdg; Tue, 19 Jan 2021 09:09:43 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l1m56-004oHH-3o; Tue, 19 Jan 2021 09:09:40 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l1m55-007gn0-Dl; Tue, 19 Jan 2021 09:09:39 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>
Cc:     Gabriel Somlo <gsomlo@gmail.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v4] drivers/soc/litex: Add restart handler
Date:   Tue, 19 Jan 2021 09:09:38 +0100
Message-Id: <20210119080938.1832733-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the LiteX SoC Controller register a restart handler, which resets
the LiteX SoC by writing 1 to CSR_CTRL_RESET_ADDR.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v4:
  - Drop bogus "a" from description,
  - Get rid of static litex_soc_ctrl_device and litex_reset_nb
    instances,
  - Unregister handler on driver unbind,

v3:
  - Rebase on top of openrisc/for-next,

v2:
  - Rebase on top of v5.11-rc1,
  - Change reset handler priority to recommended default value of 128
    (was 192).

(v1 was not sent to a mailing list)
---
 drivers/soc/litex/litex_soc_ctrl.c | 42 +++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
index da17ba56b7956c84..a7dd5be9fd5bd8ad 100644
--- a/drivers/soc/litex/litex_soc_ctrl.c
+++ b/drivers/soc/litex/litex_soc_ctrl.c
@@ -15,6 +15,11 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <linux/reboot.h>
+
+/* reset register located at the base address */
+#define RESET_REG_OFF           0x00
+#define RESET_REG_VALUE         0x00000001
 
 #define SCRATCH_REG_OFF         0x04
 #define SCRATCH_REG_VALUE       0x12345678
@@ -66,8 +71,19 @@ static int litex_check_csr_access(void __iomem *reg_addr)
 
 struct litex_soc_ctrl_device {
 	void __iomem *base;
+	struct notifier_block reset_nb;
 };
 
+static int litex_reset_handler(struct notifier_block *this, unsigned long mode,
+			       void *cmd)
+{
+	struct litex_soc_ctrl_device *soc_ctrl_dev =
+		container_of(this, struct litex_soc_ctrl_device, reset_nb);
+
+	litex_write32(soc_ctrl_dev->base + RESET_REG_OFF, RESET_REG_VALUE);
+	return NOTIFY_DONE;
+}
+
 static const struct of_device_id litex_soc_ctrl_of_match[] = {
 	{.compatible = "litex,soc-controller"},
 	{},
@@ -78,6 +94,7 @@ MODULE_DEVICE_TABLE(of, litex_soc_ctrl_of_match);
 static int litex_soc_ctrl_probe(struct platform_device *pdev)
 {
 	struct litex_soc_ctrl_device *soc_ctrl_dev;
+	int error;
 
 	soc_ctrl_dev = devm_kzalloc(&pdev->dev, sizeof(*soc_ctrl_dev), GFP_KERNEL);
 	if (!soc_ctrl_dev)
@@ -87,7 +104,29 @@ static int litex_soc_ctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(soc_ctrl_dev->base))
 		return PTR_ERR(soc_ctrl_dev->base);
 
-	return litex_check_csr_access(soc_ctrl_dev->base);
+	error = litex_check_csr_access(soc_ctrl_dev->base);
+	if (error)
+		return error;
+
+	platform_set_drvdata(pdev, soc_ctrl_dev);
+
+	soc_ctrl_dev->reset_nb.notifier_call = litex_reset_handler;
+	soc_ctrl_dev->reset_nb.priority = 128;
+	error = register_restart_handler(&soc_ctrl_dev->reset_nb);
+	if (error) {
+		dev_warn(&pdev->dev, "cannot register restart handler: %d\n",
+			 error);
+	}
+
+	return 0;
+}
+
+static int litex_soc_ctrl_remove(struct platform_device *pdev)
+{
+	struct litex_soc_ctrl_device *soc_ctrl_dev = platform_get_drvdata(pdev);
+
+	unregister_restart_handler(&soc_ctrl_dev->reset_nb);
+	return 0;
 }
 
 static struct platform_driver litex_soc_ctrl_driver = {
@@ -96,6 +135,7 @@ static struct platform_driver litex_soc_ctrl_driver = {
 		.of_match_table = of_match_ptr(litex_soc_ctrl_of_match)
 	},
 	.probe = litex_soc_ctrl_probe,
+	.remove = litex_soc_ctrl_remove,
 };
 
 module_platform_driver(litex_soc_ctrl_driver);
-- 
2.25.1

