Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA38283606
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgJENBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgJENBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:01:43 -0400
Received: from smtp3.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037B0C0613BC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 06:01:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id E33F124004E;
        Mon,  5 Oct 2020 15:01:41 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.955
X-Spam-Level: 
X-Spam-Status: No, score=-2.955 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.055, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id COQksnZ2n_ys; Mon,  5 Oct 2020 15:01:40 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 1E7AB23F343;
        Mon,  5 Oct 2020 15:01:40 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v4 22/32] auxdisplay: Implement hd44780_common_lines
Date:   Mon,  5 Oct 2020 15:01:18 +0200
Message-Id: <20201005130128.3430804-10-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005130128.3430804-1-poeschel@lemonage.de>
References: <20201005130128.3430804-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

This implements hd44780_common_lines to switch the display between one
and two lines mode. The hd44780 drivers use this function by adding it
to their ops structure and charlcd now calls through its ops function
pointer.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c        |  6 ++++++
 drivers/auxdisplay/charlcd.h        |  7 +++++++
 drivers/auxdisplay/hd44780.c        |  2 ++
 drivers/auxdisplay/hd44780_common.c | 14 ++++++++++++++
 drivers/auxdisplay/hd44780_common.h |  1 +
 drivers/auxdisplay/panel.c          |  3 +++
 6 files changed, 33 insertions(+)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index f4400a2c1ba5..d672e4c371e1 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -295,10 +295,16 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 		break;
 	case 'n':	/* One Line */
 		priv->flags &= ~LCD_FLAG_N;
+		if (priv->flags != oldflags)
+			lcd->ops->lines(lcd, CHARLCD_LINES_1);
+
 		processed = 1;
 		break;
 	case 'N':	/* Two Lines */
 		priv->flags |= LCD_FLAG_N;
+		if (priv->flags != oldflags)
+			lcd->ops->lines(lcd, CHARLCD_LINES_2);
+
 		processed = 1;
 		break;
 	case 'l':	/* Shift Cursor Left */
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index ff223ed59bd9..5b0717c7482b 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -31,6 +31,11 @@ enum charlcd_fontsize {
 	CHARLCD_FONTSIZE_LARGE,
 };
 
+enum charlcd_lines {
+	CHARLCD_LINES_1,
+	CHARLCD_LINES_2,
+};
+
 struct charlcd {
 	const struct charlcd_ops *ops;
 	const unsigned char *char_conv;	/* Optional */
@@ -68,6 +73,7 @@ struct charlcd {
  * @display: Turn display on or off.
  * @cursor: Turn cursor on or off.
  * @blink: Turn cursor blink on or off.
+ * @lines: One or two lines.
  */
 struct charlcd_ops {
 	void (*clear_fast)(struct charlcd *lcd);
@@ -83,6 +89,7 @@ struct charlcd_ops {
 	int (*cursor)(struct charlcd *lcd, enum charlcd_onoff on);
 	int (*blink)(struct charlcd *lcd, enum charlcd_onoff on);
 	int (*fontsize)(struct charlcd *lcd, enum charlcd_fontsize size);
+	int (*lines)(struct charlcd *lcd, enum charlcd_lines lines);
 };
 
 void charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on);
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 2b5f8984fcd4..7b7b28d72198 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -137,6 +137,7 @@ static const struct charlcd_ops hd44780_ops_gpio8 = {
 	.cursor		= hd44780_common_cursor,
 	.blink		= hd44780_common_blink,
 	.fontsize	= hd44780_common_fontsize,
+	.lines		= hd44780_common_lines,
 };
 
 /* Send a command to the LCD panel in 4 bit GPIO mode */
@@ -191,6 +192,7 @@ static const struct charlcd_ops hd44780_ops_gpio4 = {
 	.cursor		= hd44780_common_cursor,
 	.blink		= hd44780_common_blink,
 	.fontsize	= hd44780_common_fontsize,
+	.lines		= hd44780_common_lines,
 };
 
 static int hd44780_probe(struct platform_device *pdev)
diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index 112285f8f414..2df2410f3874 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -275,6 +275,20 @@ int hd44780_common_fontsize(struct charlcd *lcd, enum charlcd_fontsize size)
 }
 EXPORT_SYMBOL_GPL(hd44780_common_fontsize);
 
+int hd44780_common_lines(struct charlcd *lcd, enum charlcd_lines lines)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	if (lines == CHARLCD_LINES_2)
+		hdc->hd44780_common_flags |= LCD_FLAG_N;
+	else
+		hdc->hd44780_common_flags &= ~LCD_FLAG_N;
+
+	hd44780_common_set_function(hdc);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_lines);
+
 struct hd44780_common *hd44780_common_alloc(void)
 {
 	struct hd44780_common *hd;
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
index 65d513efcc43..419065bfaea2 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -28,5 +28,6 @@ int hd44780_common_display(struct charlcd *lcd, enum charlcd_onoff on);
 int hd44780_common_cursor(struct charlcd *lcd, enum charlcd_onoff on);
 int hd44780_common_blink(struct charlcd *lcd, enum charlcd_onoff on);
 int hd44780_common_fontsize(struct charlcd *lcd, enum charlcd_fontsize size);
+int hd44780_common_lines(struct charlcd *lcd, enum charlcd_lines lines);
 struct hd44780_common *hd44780_common_alloc(void);
 
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 6e13806af497..3d33d7cc979c 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -885,6 +885,7 @@ static const struct charlcd_ops charlcd_serial_ops = {
 	.cursor		= hd44780_common_cursor,
 	.blink		= hd44780_common_blink,
 	.fontsize	= hd44780_common_fontsize,
+	.lines		= hd44780_common_lines,
 };
 
 static const struct charlcd_ops charlcd_parallel_ops = {
@@ -900,6 +901,7 @@ static const struct charlcd_ops charlcd_parallel_ops = {
 	.cursor		= hd44780_common_cursor,
 	.blink		= hd44780_common_blink,
 	.fontsize	= hd44780_common_fontsize,
+	.lines		= hd44780_common_lines,
 };
 
 static const struct charlcd_ops charlcd_tilcd_ops = {
@@ -915,6 +917,7 @@ static const struct charlcd_ops charlcd_tilcd_ops = {
 	.cursor		= hd44780_common_cursor,
 	.blink		= hd44780_common_blink,
 	.fontsize	= hd44780_common_fontsize,
+	.lines		= hd44780_common_lines,
 };
 
 /* initialize the LCD driver */
-- 
2.28.0

