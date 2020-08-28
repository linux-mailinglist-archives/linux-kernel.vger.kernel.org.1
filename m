Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DCC2561BC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 21:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgH1T65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 15:58:57 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:50248 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726146AbgH1T6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:58:23 -0400
Received: from [78.134.86.56] (port=54992 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kBkVw-0008I1-I6; Fri, 28 Aug 2020 21:58:20 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-fpga@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v3 3/5] fpga manager: xilinx-spi: fix write_complete timeout handling
Date:   Fri, 28 Aug 2020 21:58:06 +0200
Message-Id: <20200828195808.27975-3-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200828195808.27975-1-luca@lucaceresoli.net>
References: <20200828195808.27975-1-luca@lucaceresoli.net>
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

If this routine sleeps because it was scheduled out, it might miss DONE
going asserted and consider it a timeout. This would potentially make the
code return an error even when programming succeeded. Rewrite the loop to
always check DONE after checking if timeout expired so this cannot happen
anymore.

While there, also add error checking for gpiod_get_value(). Also avoid
checking the DONE GPIO in two places, which would make the error-checking
code duplicated and more annoying.

The new loop it written to still guarantee that we apply 8 extra CCLK
cycles after DONE has gone asserted, which is required by the hardware.

Reported-by: Tom Rix <trix@redhat.com>
Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes in v3:
 - completely rewrite the loop after Tom pointed out the 'sleep' bug

This patch is new in v2
---
 drivers/fpga/xilinx-spi.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 01f494172379..a7b919eb0b2a 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -151,22 +151,29 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
 				     struct fpga_image_info *info)
 {
 	struct xilinx_spi_conf *conf = mgr->priv;
-	unsigned long timeout;
+	unsigned long timeout = jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
+	bool expired;
+	int done;
 	int ret;
 
-	if (gpiod_get_value(conf->done))
-		return xilinx_spi_apply_cclk_cycles(conf);
+	/*
+	 * This loop is carefully written such that if the driver is
+	 * scheduled out for more than 'timeout', we still check for DONE
+	 * before giving up and we apply 8 extra CCLK cycles in all cases.
+	 */
+	while (!expired) {
+		expired = time_after(jiffies, timeout);
 
-	timeout = jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
-
-	while (time_before(jiffies, timeout)) {
+		done = get_done_gpio(mgr);
+		if (done < 0)
+			return done;
 
 		ret = xilinx_spi_apply_cclk_cycles(conf);
 		if (ret)
 			return ret;
 
-		if (gpiod_get_value(conf->done))
-			return xilinx_spi_apply_cclk_cycles(conf);
+		if (done)
+			return 0;
 	}
 
 	dev_err(&mgr->dev, "Timeout after config data transfer\n");
-- 
2.28.0

