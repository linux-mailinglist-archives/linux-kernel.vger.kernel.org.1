Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895CC2C80AB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgK3JL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgK3JL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:11:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEFBC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 01:10:40 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kjfCd-00023d-Gs; Mon, 30 Nov 2020 10:10:35 +0100
Received: from sha by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kjfCc-0000T8-OU; Mon, 30 Nov 2020 10:10:34 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-clk@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH resend] clk: si5351: Wait for bit clear after PLL reset
Date:   Mon, 30 Nov 2020 10:10:33 +0100
Message-Id: <20201130091033.1687-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation states that SI5351_PLL_RESET_B and SI5351_PLL_RESET_A bits
are self clearing bits, so wait until they are cleared before
continuing.
This fixes a case when the clock doesn't come up properly after a PLL
reset. It worked properly when the frequency was below 900MHz, but with
900MHz it only works when we are waiting for the bit to clear.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

I've already sent this in October without any reaction, this is just a
resend with +Cc Stephen Boyd and +Cc linux-kernel@vger.kernel.org

 drivers/clk/clk-si5351.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 1e1702e609cb..57e4597cdf4c 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -902,6 +902,10 @@ static int _si5351_clkout_set_disable_state(
 static void _si5351_clkout_reset_pll(struct si5351_driver_data *drvdata, int num)
 {
 	u8 val = si5351_reg_read(drvdata, SI5351_CLK0_CTRL + num);
+	u8 mask = val & SI5351_CLK_PLL_SELECT ? SI5351_PLL_RESET_B :
+						       SI5351_PLL_RESET_A;
+	unsigned int v;
+	int err;
 
 	switch (val & SI5351_CLK_INPUT_MASK) {
 	case SI5351_CLK_INPUT_XTAL:
@@ -909,9 +913,12 @@ static void _si5351_clkout_reset_pll(struct si5351_driver_data *drvdata, int num
 		return;  /* pll not used, no need to reset */
 	}
 
-	si5351_reg_write(drvdata, SI5351_PLL_RESET,
-			 val & SI5351_CLK_PLL_SELECT ? SI5351_PLL_RESET_B :
-						       SI5351_PLL_RESET_A);
+	si5351_reg_write(drvdata, SI5351_PLL_RESET, mask);
+
+	err = regmap_read_poll_timeout(drvdata->regmap, SI5351_PLL_RESET, v,
+				 !(v & mask), 0, 20000);
+	if (err < 0)
+		dev_err(&drvdata->client->dev, "Reset bit didn't clear\n");
 
 	dev_dbg(&drvdata->client->dev, "%s - %s: pll = %d\n",
 		__func__, clk_hw_get_name(&drvdata->clkout[num].hw),
-- 
2.20.1

