Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221572A40F5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgKCJ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbgKCJ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:59:02 -0500
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E330C061A48
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 01:59:01 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 6B1AC23F71A;
        Tue,  3 Nov 2020 10:59:00 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.941
X-Spam-Level: 
X-Spam-Status: No, score=-2.941 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.041, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id owBxcprFNdx3; Tue,  3 Nov 2020 10:58:58 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 157BB23FB43;
        Tue,  3 Nov 2020 10:58:57 +0100 (CET)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH v6 20/25] auxdisplay: hd44780: Remove clear_fast
Date:   Tue,  3 Nov 2020 10:58:23 +0100
Message-Id: <20201103095828.515831-21-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103095828.515831-1-poeschel@lemonage.de>
References: <20201103095828.515831-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

We remove the hd44780_clear_fast (display) clear implementation. With
the new timeout the normal clear_display is reasonably fast. So there is
no need for a clear_fast anymore.

Link: https://lore.kernel.org/lkml/20200922092121.GG16421@1wt.eu/

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
Changes in v3:
- This patch is squashed together from 26, 27 and 28 from previous patch
  set:
Link: https://lore.kernel.org/lkml/20200921144645.2061313-27-poeschel@lemonage.de/
Link: https://lore.kernel.org/lkml/20200921144645.2061313-28-poeschel@lemonage.de/
Link: https://lore.kernel.org/lkml/20200921144645.2061313-29-poeschel@lemonage.de/

- Additionally this now removes clear_fast from charlcd_ops and from
  panel driver.
---
 drivers/auxdisplay/charlcd.c | 21 ++++-------
 drivers/auxdisplay/charlcd.h |  7 ++--
 drivers/auxdisplay/panel.c   | 67 ------------------------------------
 3 files changed, 8 insertions(+), 87 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 0f0568a4bd35..077c01e87127 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -125,20 +125,11 @@ static void charlcd_print(struct charlcd *lcd, char c)
 		lcd->ops->gotoxy(lcd);
 }
 
-static void charlcd_clear_fast(struct charlcd *lcd)
+static void charlcd_clear_display(struct charlcd *lcd)
 {
-	struct hd44780_common *hdc = lcd->drvdata;
-	int pos;
-
-	charlcd_home(lcd);
-
-	if (lcd->ops->clear_fast)
-		lcd->ops->clear_fast(lcd);
-	else
-		for (pos = 0; pos < min(2, lcd->height) * hdc->hwidth; pos++)
-			lcd->ops->print(lcd, ' ');
-
-	charlcd_home(lcd);
+	lcd->ops->clear_display(lcd);
+	lcd->addr.x = 0;
+	lcd->addr.y = 0;
 }
 
 /*
@@ -409,7 +400,7 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
 			break;
 		case '\f':
 			/* quickly clear the display */
-			charlcd_clear_fast(lcd);
+			charlcd_clear_display(lcd);
 			break;
 		case '\n':
 			/*
@@ -448,7 +439,7 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
 
 		if (!strcmp(priv->esc_seq.buf, "[2J")) {
 			/* clear the display */
-			charlcd_clear_fast(lcd);
+			charlcd_clear_display(lcd);
 			processed = 1;
 		} else if (!strcmp(priv->esc_seq.buf, "[H")) {
 			/* cursor to home */
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index 3339e8c2554e..e7e9b12b1e99 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -55,8 +55,6 @@ struct charlcd {
 /**
  * struct charlcd_ops - Functions used by charlcd. Drivers have to implement
  * these.
- * @clear_fast: Clear the whole display and set cursor to position 0, 0.
- * Optional.
  * @backlight: Turn backlight on or off. Optional.
  * @print: Print one character to the display at current cursor position.
  * The buffered cursor position is advanced by charlcd. The cursor should not
@@ -65,8 +63,8 @@ struct charlcd {
  * previously set in addr.x and addr.y by charlcd.
  * @home: Set cursor to 0, 0. The values in addr.x and addr.y are set to 0, 0 by
  * charlcd prior to calling this function.
- * @clear_display: Again clear the whole display, set the cursor to 0, 0. The
- * values in addr.x and addr.y are set to 0, 0 by charlcd prior to calling this
+ * @clear_display: Clear the whole display and set the cursor to 0, 0. The
+ * values in addr.x and addr.y are set to 0, 0 by charlcd after to calling this
  * function.
  * @init_display: Initialize the display.
  * @shift_cursor: Shift cursor left or right one position.
@@ -78,7 +76,6 @@ struct charlcd {
  * @redefine_char: Redefine the actual pixel matrix of character.
  */
 struct charlcd_ops {
-	void (*clear_fast)(struct charlcd *lcd);
 	void (*backlight)(struct charlcd *lcd, enum charlcd_onoff on);
 	int (*print)(struct charlcd *lcd, int c);
 	int (*gotoxy)(struct charlcd *lcd);
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index b0d2ae5b9be8..e07fadac281d 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -808,72 +808,7 @@ static void lcd_write_data_tilcd(struct hd44780_common *hdc, int data)
 	spin_unlock_irq(&pprt_lock);
 }
 
-/* fills the display with spaces and resets X/Y */
-static void lcd_clear_fast_s(struct charlcd *charlcd)
-{
-	struct hd44780_common *hdc = charlcd->drvdata;
-	int pos;
-
-	spin_lock_irq(&pprt_lock);
-	for (pos = 0; pos < charlcd->height * hdc->hwidth; pos++) {
-		lcd_send_serial(0x5F);	/* R/W=W, RS=1 */
-		lcd_send_serial(' ' & 0x0F);
-		lcd_send_serial((' ' >> 4) & 0x0F);
-		/* the shortest data takes at least 40 us */
-		udelay(40);
-	}
-	spin_unlock_irq(&pprt_lock);
-}
-
-/* fills the display with spaces and resets X/Y */
-static void lcd_clear_fast_p8(struct charlcd *charlcd)
-{
-	struct hd44780_common *hdc = charlcd->drvdata;
-	int pos;
-
-	spin_lock_irq(&pprt_lock);
-	for (pos = 0; pos < charlcd->height * hdc->hwidth; pos++) {
-		/* present the data to the data port */
-		w_dtr(pprt, ' ');
-
-		/* maintain the data during 20 us before the strobe */
-		udelay(20);
-
-		set_bit(LCD_BIT_E, bits);
-		set_bit(LCD_BIT_RS, bits);
-		clear_bit(LCD_BIT_RW, bits);
-		set_ctrl_bits();
-
-		/* maintain the strobe during 40 us */
-		udelay(40);
-
-		clear_bit(LCD_BIT_E, bits);
-		set_ctrl_bits();
-
-		/* the shortest data takes at least 45 us */
-		udelay(45);
-	}
-	spin_unlock_irq(&pprt_lock);
-}
-
-/* fills the display with spaces and resets X/Y */
-static void lcd_clear_fast_tilcd(struct charlcd *charlcd)
-{
-	struct hd44780_common *hdc = charlcd->drvdata;
-	int pos;
-
-	spin_lock_irq(&pprt_lock);
-	for (pos = 0; pos < charlcd->height * hdc->hwidth; pos++) {
-		/* present the data to the data port */
-		w_dtr(pprt, ' ');
-		udelay(60);
-	}
-
-	spin_unlock_irq(&pprt_lock);
-}
-
 static const struct charlcd_ops charlcd_serial_ops = {
-	.clear_fast	= lcd_clear_fast_s,
 	.backlight	= lcd_backlight,
 	.gotoxy		= hd44780_common_gotoxy,
 	.home		= hd44780_common_home,
@@ -890,7 +825,6 @@ static const struct charlcd_ops charlcd_serial_ops = {
 };
 
 static const struct charlcd_ops charlcd_parallel_ops = {
-	.clear_fast	= lcd_clear_fast_p8,
 	.backlight	= lcd_backlight,
 	.gotoxy		= hd44780_common_gotoxy,
 	.home		= hd44780_common_home,
@@ -907,7 +841,6 @@ static const struct charlcd_ops charlcd_parallel_ops = {
 };
 
 static const struct charlcd_ops charlcd_tilcd_ops = {
-	.clear_fast	= lcd_clear_fast_tilcd,
 	.backlight	= lcd_backlight,
 	.gotoxy		= hd44780_common_gotoxy,
 	.home		= hd44780_common_home,
-- 
2.28.0

