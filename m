Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C76283607
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgJENBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgJENBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:01:41 -0400
Received: from smtp3.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CBBC0613B9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 06:01:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id CF76C240188;
        Mon,  5 Oct 2020 15:01:39 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.956
X-Spam-Level: 
X-Spam-Status: No, score=-2.956 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.056, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WDS0V3fuIKuW; Mon,  5 Oct 2020 15:01:38 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 030BC23F417;
        Mon,  5 Oct 2020 15:01:37 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v4 19/32] auxdisplay: Implement hd44780_common_blink
Date:   Mon,  5 Oct 2020 15:01:15 +0200
Message-Id: <20201005130128.3430804-7-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005130128.3430804-1-poeschel@lemonage.de>
References: <20201005130128.3430804-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

Implement a hd44780_common_blink function to turn on or off the blinking
of the cursor. The hd44780 drivers just use this function and charlcd
calls it through its ops function pointer.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c        |  6 ++++++
 drivers/auxdisplay/charlcd.h        |  2 ++
 drivers/auxdisplay/hd44780.c        |  2 ++
 drivers/auxdisplay/hd44780_common.c | 14 ++++++++++++++
 drivers/auxdisplay/hd44780_common.h |  1 +
 drivers/auxdisplay/panel.c          |  3 +++
 6 files changed, 28 insertions(+)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index a2f0becb1a9f..b099897e101b 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -260,10 +260,16 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 		break;
 	case 'B':	/* Blink ON */
 		priv->flags |= LCD_FLAG_B;
+		if (priv->flags != oldflags)
+			lcd->ops->blink(lcd, CHARLCD_ON);
+
 		processed = 1;
 		break;
 	case 'b':	/* Blink OFF */
 		priv->flags &= ~LCD_FLAG_B;
+		if (priv->flags != oldflags)
+			lcd->ops->blink(lcd, CHARLCD_OFF);
+
 		processed = 1;
 		break;
 	case '+':	/* Back light ON */
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index 5aab359ebd91..d9d907db2724 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -62,6 +62,7 @@ struct charlcd {
  * @shift_display: Shift whole display content left or right.
  * @display: Turn display on or off.
  * @cursor: Turn cursor on or off.
+ * @blink: Turn cursor blink on or off.
  */
 struct charlcd_ops {
 	void (*clear_fast)(struct charlcd *lcd);
@@ -75,6 +76,7 @@ struct charlcd_ops {
 	int (*shift_display)(struct charlcd *lcd, enum charlcd_shift_dir dir);
 	int (*display)(struct charlcd *lcd, enum charlcd_onoff on);
 	int (*cursor)(struct charlcd *lcd, enum charlcd_onoff on);
+	int (*blink)(struct charlcd *lcd, enum charlcd_onoff on);
 };
 
 void charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on);
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index d5ce3955b577..a8d6e5483a92 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -135,6 +135,7 @@ static const struct charlcd_ops hd44780_ops_gpio8 = {
 	.shift_display	= hd44780_common_shift_display,
 	.display	= hd44780_common_display,
 	.cursor		= hd44780_common_cursor,
+	.blink		= hd44780_common_blink,
 };
 
 /* Send a command to the LCD panel in 4 bit GPIO mode */
@@ -187,6 +188,7 @@ static const struct charlcd_ops hd44780_ops_gpio4 = {
 	.shift_display	= hd44780_common_shift_display,
 	.display	= hd44780_common_display,
 	.cursor		= hd44780_common_cursor,
+	.blink		= hd44780_common_blink,
 };
 
 static int hd44780_probe(struct platform_device *pdev)
diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index 587385e55bae..5c028f157fc8 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -236,6 +236,20 @@ int hd44780_common_cursor(struct charlcd *lcd, enum charlcd_onoff on)
 }
 EXPORT_SYMBOL_GPL(hd44780_common_cursor);
 
+int hd44780_common_blink(struct charlcd *lcd, enum charlcd_onoff on)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	if (on == CHARLCD_ON)
+		hdc->hd44780_common_flags |= LCD_FLAG_B;
+	else
+		hdc->hd44780_common_flags &= ~LCD_FLAG_B;
+
+	hd44780_common_set_mode(hdc);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_blink);
+
 struct hd44780_common *hd44780_common_alloc(void)
 {
 	struct hd44780_common *hd;
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
index 7327a9b2e997..b46171f21a05 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -26,5 +26,6 @@ int hd44780_common_shift_display(struct charlcd *lcd,
 		enum charlcd_shift_dir dir);
 int hd44780_common_display(struct charlcd *lcd, enum charlcd_onoff on);
 int hd44780_common_cursor(struct charlcd *lcd, enum charlcd_onoff on);
+int hd44780_common_blink(struct charlcd *lcd, enum charlcd_onoff on);
 struct hd44780_common *hd44780_common_alloc(void);
 
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 26fbf91c1501..2d2f59360e1a 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -883,6 +883,7 @@ static const struct charlcd_ops charlcd_serial_ops = {
 	.shift_display	= hd44780_common_shift_display,
 	.display	= hd44780_common_display,
 	.cursor		= hd44780_common_cursor,
+	.blink		= hd44780_common_blink,
 };
 
 static const struct charlcd_ops charlcd_parallel_ops = {
@@ -896,6 +897,7 @@ static const struct charlcd_ops charlcd_parallel_ops = {
 	.shift_display	= hd44780_common_shift_display,
 	.display	= hd44780_common_display,
 	.cursor		= hd44780_common_cursor,
+	.blink		= hd44780_common_blink,
 };
 
 static const struct charlcd_ops charlcd_tilcd_ops = {
@@ -909,6 +911,7 @@ static const struct charlcd_ops charlcd_tilcd_ops = {
 	.shift_display	= hd44780_common_shift_display,
 	.display	= hd44780_common_display,
 	.cursor		= hd44780_common_cursor,
+	.blink		= hd44780_common_blink,
 };
 
 /* initialize the LCD driver */
-- 
2.28.0

