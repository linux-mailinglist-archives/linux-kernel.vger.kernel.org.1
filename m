Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCABE1F6F35
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 23:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgFKVMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 17:12:05 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:58636 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbgFKVMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 17:12:03 -0400
Received: from [78.134.85.74] (port=40536 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jjUUP-000C9m-7w; Thu, 11 Jun 2020 23:11:57 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-fpga@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 5/5] fpga manager: xilinx-spi: check INIT_B pin during write_init
Date:   Thu, 11 Jun 2020 23:11:44 +0200
Message-Id: <20200611211144.9421-5-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200611211144.9421-1-luca@lucaceresoli.net>
References: <20200611211144.9421-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The INIT_B reports the status during startup and after the end of the
programming process. However the current driver completely ignores it.

Check the pin status during startup to make sure programming is never
started too early and also to detect any hardware issues in the FPGA
connection.

This is optional for backward compatibility. If INIT_B is not passed by
device tree, just fallback to the old udelays.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/fpga/xilinx-spi.c | 54 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 799ae04301be..2710a15ed16b 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -23,6 +23,7 @@
 struct xilinx_spi_conf {
 	struct spi_device *spi;
 	struct gpio_desc *prog_b;
+	struct gpio_desc *init_b;
 	struct gpio_desc *done;
 };
 
@@ -36,11 +37,44 @@ static enum fpga_mgr_states xilinx_spi_state(struct fpga_manager *mgr)
 	return FPGA_MGR_STATE_UNKNOWN;
 }
 
+/**
+ * wait_for_init_b - wait for the INIT_B pin to have a given state, or wait
+ * a given delay if the pin is unavailable
+ *
+ * @mgr        The FPGA manager object
+ * @value      Value INIT_B to wait for (1 = asserted = low)
+ * @act_udelay Delay to wait if the INIT_B pin is not available
+ *
+ * Returns 0 when the pin reached the given state or -ETIMEDOUT if too much
+ * time passed waiting for that. If there is no INIT_B, always return 0.
+ */
+static int wait_for_init_b(struct fpga_manager *mgr, int value,
+			   unsigned long backup_udelay)
+{
+	struct xilinx_spi_conf *conf = mgr->priv;
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
+
+	if (conf->init_b) {
+		while (time_before(jiffies, timeout)) {
+			/* dump_state(conf, "wait for init_d .."); */
+			if (gpiod_get_value(conf->init_b) == value)
+				return 0;
+			usleep_range(100, 400);
+		}
+		return -ETIMEDOUT;
+	}
+
+	udelay(backup_udelay);
+
+	return 0;
+}
+
 static int xilinx_spi_write_init(struct fpga_manager *mgr,
 				 struct fpga_image_info *info,
 				 const char *buf, size_t count)
 {
 	struct xilinx_spi_conf *conf = mgr->priv;
+	int err;
 
 	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
 		dev_err(&mgr->dev, "Partial reconfiguration not supported.\n");
@@ -49,10 +83,21 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
 
 	gpiod_set_value(conf->prog_b, 1);
 
-	udelay(1); /* min is 500 ns */
+	err = wait_for_init_b(mgr, 1, 1); /* min is 500 ns */
+	if (err) {
+		dev_err(&mgr->dev, "INIT_B pin did not go low\n");
+		gpiod_set_value(conf->prog_b, 0);
+		return err;
+	}
 
 	gpiod_set_value(conf->prog_b, 0);
 
+	err = wait_for_init_b(mgr, 0, 0);
+	if (err) {
+		dev_err(&mgr->dev, "INIT_B pin did not go high\n");
+		return err;
+	}
+
 	if (gpiod_get_value(conf->done)) {
 		dev_err(&mgr->dev, "Unexpected DONE pin state...\n");
 		return -EIO;
@@ -154,6 +199,13 @@ static int xilinx_spi_probe(struct spi_device *spi)
 		return PTR_ERR(conf->prog_b);
 	}
 
+	conf->init_b = devm_gpiod_get_optional(&spi->dev, "init_b", GPIOD_IN);
+	if (IS_ERR(conf->init_b)) {
+		dev_err(&spi->dev, "Failed to get INIT_B gpio: %ld\n",
+			PTR_ERR(conf->init_b));
+		return PTR_ERR(conf->init_b);
+	}
+
 	conf->done = devm_gpiod_get(&spi->dev, "done", GPIOD_IN);
 	if (IS_ERR(conf->done)) {
 		dev_err(&spi->dev, "Failed to get DONE gpio: %ld\n",
-- 
2.27.0

