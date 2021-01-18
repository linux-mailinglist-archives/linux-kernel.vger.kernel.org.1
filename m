Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F72F2F9E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390344AbhARLd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390270AbhARLbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:31:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E6EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:30:56 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1l1SkC-0001Ck-Vn; Mon, 18 Jan 2021 12:30:48 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1l1SkC-0005bF-He; Mon, 18 Jan 2021 12:30:48 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: imx6q: demote warning about pre-boot ldb_di_clk reparenting
Date:   Mon, 18 Jan 2021 12:30:32 +0100
Message-Id: <20210118113032.21178-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 5d283b083800 ("clk: imx6: Fix procedure to switch the parent
of LDB_DI_CLK"), the clock driver warns if ldb_di\d_sel is changed
from reset value on system boot. This warning is printed even if
the bootloader (or a previous kernel that did kexec) followed the
correct procedure for glitch-free reparenting.

As such systems are doing everything correctly, a warning is too
harsh. Demote to a notice, so users are still alerted, but without
cluttering a loglevel=5 boot.

While at it, add the words "possible glitch" into the log message, to
make it more user-friendly.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
Cc: Fabio Estevam <fabio.estevam@nxp.com>

v1 -> v2:
  - added "possile glitch" to error message to make more useful
    (Stephen)
---
 drivers/clk/imx/clk-imx6q.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index b2ff187cedab..521d6136d22c 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -338,10 +338,10 @@ static void init_ldb_clks(struct device_node *np, void __iomem *ccm_base)
 	of_assigned_ldb_sels(np, &sel[0][3], &sel[1][3]);
 
 	for (i = 0; i < 2; i++) {
-		/* Warn if a glitch might have been introduced already */
+		/* Print a notice if a glitch might have been introduced already */
 		if (sel[i][0] != 3) {
-			pr_warn("ccm: ldb_di%d_sel already changed from reset value: %d\n",
-				i, sel[i][0]);
+			pr_notice("ccm: possible glitch: ldb_di%d_sel already changed from reset value: %d\n",
+				  i, sel[i][0]);
 		}
 
 		if (sel[i][0] == sel[i][3])
-- 
2.30.0

