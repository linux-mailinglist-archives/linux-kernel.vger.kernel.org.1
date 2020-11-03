Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCBB2A40EB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgKCJ6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgKCJ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:58:49 -0500
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BFCC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 01:58:48 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 7FA8623F82F;
        Tue,  3 Nov 2020 10:58:47 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.944
X-Spam-Level: 
X-Spam-Status: No, score=-2.944 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.044, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6mu2-s3NjC9r; Tue,  3 Nov 2020 10:58:46 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 9337F23F2AD;
        Tue,  3 Nov 2020 10:58:45 +0100 (CET)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v6 04/25] auxdisplay: Move ifwidth to struct hd44780_common
Date:   Tue,  3 Nov 2020 10:58:07 +0100
Message-Id: <20201103095828.515831-5-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103095828.515831-1-poeschel@lemonage.de>
References: <20201103095828.515831-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

Move struct charlcd member ifwidth to our new struct hd44780_common.
ifwidth is hd44780 device specific and is used by two drivers at the
moment, so we move it to a common place, where both can use this.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c        | 12 ++++++------
 drivers/auxdisplay/charlcd.h        |  1 -
 drivers/auxdisplay/hd44780.c        |  2 +-
 drivers/auxdisplay/hd44780_common.c |  1 +
 drivers/auxdisplay/hd44780_common.h |  1 +
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 02392336d7d3..59e0a815bf3d 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -223,9 +223,10 @@ static int charlcd_init_display(struct charlcd *lcd)
 {
 	void (*write_cmd_raw)(struct charlcd *lcd, int cmd);
 	struct charlcd_priv *priv = charlcd_to_priv(lcd);
+	struct hd44780_common *hdc = lcd->drvdata;
 	u8 init;
 
-	if (lcd->ifwidth != 4 && lcd->ifwidth != 8)
+	if (hdc->ifwidth != 4 && hdc->ifwidth != 8)
 		return -EINVAL;
 
 	priv->flags = ((lcd->height > 1) ? LCD_FLAG_N : 0) | LCD_FLAG_D |
@@ -238,7 +239,7 @@ static int charlcd_init_display(struct charlcd *lcd)
 	 * the LCD is in 8-bit mode afterwards
 	 */
 	init = LCD_CMD_FUNCTION_SET | LCD_CMD_DATA_LEN_8BITS;
-	if (lcd->ifwidth == 4) {
+	if (hdc->ifwidth == 4) {
 		init >>= 4;
 		write_cmd_raw = lcd->ops->write_cmd_raw4;
 	} else {
@@ -251,7 +252,7 @@ static int charlcd_init_display(struct charlcd *lcd)
 	write_cmd_raw(lcd, init);
 	long_sleep(10);
 
-	if (lcd->ifwidth == 4) {
+	if (hdc->ifwidth == 4) {
 		/* Switch to 4-bit mode, 1 line, small fonts */
 		lcd->ops->write_cmd_raw4(lcd, LCD_CMD_FUNCTION_SET >> 4);
 		long_sleep(10);
@@ -260,7 +261,7 @@ static int charlcd_init_display(struct charlcd *lcd)
 	/* set font height and lines number */
 	lcd->ops->write_cmd(lcd,
 		LCD_CMD_FUNCTION_SET |
-		((lcd->ifwidth == 8) ? LCD_CMD_DATA_LEN_8BITS : 0) |
+		((hdc->ifwidth == 8) ? LCD_CMD_DATA_LEN_8BITS : 0) |
 		((priv->flags & LCD_FLAG_F) ? LCD_CMD_FONT_5X10_DOTS : 0) |
 		((priv->flags & LCD_FLAG_N) ? LCD_CMD_TWO_LINES : 0));
 	long_sleep(10);
@@ -543,7 +544,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 	else if ((oldflags ^ priv->flags) & (LCD_FLAG_F | LCD_FLAG_N))
 		lcd->ops->write_cmd(lcd,
 			LCD_CMD_FUNCTION_SET |
-			((lcd->ifwidth == 8) ? LCD_CMD_DATA_LEN_8BITS : 0) |
+			((hdc->ifwidth == 8) ? LCD_CMD_DATA_LEN_8BITS : 0) |
 			((priv->flags & LCD_FLAG_F) ? LCD_CMD_FONT_5X10_DOTS : 0) |
 			((priv->flags & LCD_FLAG_N) ? LCD_CMD_TWO_LINES : 0));
 	/* check whether L flag was changed */
@@ -794,7 +795,6 @@ struct charlcd *charlcd_alloc(void)
 	priv->esc_seq.len = -1;
 
 	lcd = &priv->lcd;
-	lcd->ifwidth = 8;
 
 	return lcd;
 }
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index 2a12d07705a3..5dce9dd36562 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -18,7 +18,6 @@ struct charlcd {
 	const struct charlcd_ops *ops;
 	const unsigned char *char_conv;	/* Optional */
 
-	int ifwidth;			/* 4-bit or 8-bit (default) */
 	int height;
 	int width;
 
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 0603af8f2336..f6786239c36f 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -275,7 +275,7 @@ static int hd44780_probe(struct platform_device *pdev)
 	/* Optional properties */
 	device_property_read_u32(dev, "internal-buffer-width", &hdc->bwidth);
 
-	lcd->ifwidth = ifwidth;
+	hdc->ifwidth = ifwidth;
 	lcd->ops = ifwidth == 8 ? &hd44780_ops_gpio8 : &hd44780_ops_gpio4;
 
 	ret = charlcd_register(lcd);
diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index 3a05fd30cae0..4968461f0c4a 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -12,6 +12,7 @@ struct hd44780_common *hd44780_common_alloc(void)
 	if (!hd)
 		return NULL;
 
+	hd->ifwidth = 8;
 	hd->bwidth = DEFAULT_LCD_BWIDTH;
 	hd->hwidth = DEFAULT_LCD_HWIDTH;
 	return hd;
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
index 9647d24c4490..54cbe5a489d7 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -4,6 +4,7 @@
 #define DEFAULT_LCD_HWIDTH      64
 
 struct hd44780_common {
+	int ifwidth;			/* 4-bit or 8-bit (default) */
 	int bwidth;			/* Default set by hd44780_alloc() */
 	int hwidth;			/* Default set by hd44780_alloc() */
 	void *hd44780;
-- 
2.28.0

