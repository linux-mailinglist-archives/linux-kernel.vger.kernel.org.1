Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69CF2E9B44
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 17:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbhADQpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 11:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbhADQpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 11:45:46 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A218C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 08:45:06 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id Cgl32400H4C55Sk01gl3d3; Mon, 04 Jan 2021 17:45:03 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kwSyc-001AP6-Th; Mon, 04 Jan 2021 17:45:02 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kwSyc-005V5O-BI; Mon, 04 Jan 2021 17:45:02 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>
Cc:     Gabriel Somlo <gsomlo@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] drivers/soc/litex: Add restart handler
Date:   Mon,  4 Jan 2021 17:45:00 +0100
Message-Id: <20210104164500.1311091-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the LiteX SoC Controller a register a restart handler, which resets
the LiteX SoC by writing 1 to CSR_CTRL_RESET_ADDR.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Tested with linux-on-litex-vexriscv.

This patch is based on upstream, i.e. not on top of Gabriel Somlo's
"[PATCH v5 0/4] drivers/soc/litex: support 32-bit subregisters, 64-bit
CPUs"
(https://lore.kernel.org/lkml/20201227161320.2194830-1-gsomlo@gmail.com/)

v2:
  - Rebase on top of v5.11-rc1,
  - Change reset handler priority to recommended default value of 128
    (was 192).

(v1 was not sent to a mailing list)
---
 drivers/soc/litex/litex_soc_ctrl.c | 33 +++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
index 1217cafdfd4d1d2b..d729ad50d4ffca5e 100644
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
 
 /*
  * LiteX SoC Generator, depending on the configuration, can split a single
@@ -136,8 +141,20 @@ static int litex_check_csr_access(void __iomem *reg_addr)
 	return 0;
 }
 
-struct litex_soc_ctrl_device {
+static struct litex_soc_ctrl_device {
 	void __iomem *base;
+} *soc_ctrl_dev;
+
+static int litex_reset_handler(struct notifier_block *this, unsigned long mode,
+			       void *cmd)
+{
+	litex_write32(soc_ctrl_dev->base + RESET_REG_OFF, RESET_REG_VALUE);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block litex_reset_nb = {
+	.notifier_call = litex_reset_handler,
+	.priority = 128,
 };
 
 static const struct of_device_id litex_soc_ctrl_of_match[] = {
@@ -149,7 +166,7 @@ MODULE_DEVICE_TABLE(of, litex_soc_ctrl_of_match);
 
 static int litex_soc_ctrl_probe(struct platform_device *pdev)
 {
-	struct litex_soc_ctrl_device *soc_ctrl_dev;
+	int error;
 
 	soc_ctrl_dev = devm_kzalloc(&pdev->dev, sizeof(*soc_ctrl_dev), GFP_KERNEL);
 	if (!soc_ctrl_dev)
@@ -159,7 +176,17 @@ static int litex_soc_ctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(soc_ctrl_dev->base))
 		return PTR_ERR(soc_ctrl_dev->base);
 
-	return litex_check_csr_access(soc_ctrl_dev->base);
+	error = litex_check_csr_access(soc_ctrl_dev->base);
+	if (error)
+		return error;
+
+	error = register_restart_handler(&litex_reset_nb);
+	if (error) {
+		dev_warn(&pdev->dev, "cannot register restart handler: %d\n",
+			 error);
+	}
+
+	return 0;
 }
 
 static struct platform_driver litex_soc_ctrl_driver = {
-- 
2.25.1

