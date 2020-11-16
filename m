Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778472B44E4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgKPNlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 08:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgKPNlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:41:36 -0500
Received: from smtp1.goneo.de (smtp1.goneo.de [IPv6:2001:1640:5::8:30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B18C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 05:41:35 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 7980F23F0BD;
        Mon, 16 Nov 2020 14:41:33 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.981
X-Spam-Level: 
X-Spam-Status: No, score=-2.981 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.081, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id go-UBYOuATGE; Mon, 16 Nov 2020 14:41:32 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPA id E906F23F1F9;
        Mon, 16 Nov 2020 14:41:31 +0100 (CET)
From:   poeschel@lemonage.de
To:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH] auxdisplay: panel: Remove redundant charlcd_ops structures
Date:   Mon, 16 Nov 2020 14:41:21 +0100
Message-Id: <20201116134121.587563-1-poeschel@lemonage.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

The three struct charlcd_ops contain the same data, so we only need one
of this structures. The other two are removed.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/panel.c | 42 ++++----------------------------------
 1 file changed, 4 insertions(+), 38 deletions(-)

diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 36848e464d1f..ff5755ee5694 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -808,41 +808,7 @@ static void lcd_write_data_tilcd(struct hd44780_common *hdc, int data)
 	spin_unlock_irq(&pprt_lock);
 }
 
-static const struct charlcd_ops charlcd_serial_ops = {
-	.backlight	= lcd_backlight,
-	.print		= hd44780_common_print,
-	.gotoxy		= hd44780_common_gotoxy,
-	.home		= hd44780_common_home,
-	.clear_display	= hd44780_common_clear_display,
-	.init_display	= hd44780_common_init_display,
-	.shift_cursor	= hd44780_common_shift_cursor,
-	.shift_display	= hd44780_common_shift_display,
-	.display	= hd44780_common_display,
-	.cursor		= hd44780_common_cursor,
-	.blink		= hd44780_common_blink,
-	.fontsize	= hd44780_common_fontsize,
-	.lines		= hd44780_common_lines,
-	.redefine_char	= hd44780_common_redefine_char,
-};
-
-static const struct charlcd_ops charlcd_parallel_ops = {
-	.backlight	= lcd_backlight,
-	.print		= hd44780_common_print,
-	.gotoxy		= hd44780_common_gotoxy,
-	.home		= hd44780_common_home,
-	.clear_display	= hd44780_common_clear_display,
-	.init_display	= hd44780_common_init_display,
-	.shift_cursor	= hd44780_common_shift_cursor,
-	.shift_display	= hd44780_common_shift_display,
-	.display	= hd44780_common_display,
-	.cursor		= hd44780_common_cursor,
-	.blink		= hd44780_common_blink,
-	.fontsize	= hd44780_common_fontsize,
-	.lines		= hd44780_common_lines,
-	.redefine_char	= hd44780_common_redefine_char,
-};
-
-static const struct charlcd_ops charlcd_tilcd_ops = {
+static const struct charlcd_ops charlcd_ops = {
 	.backlight	= lcd_backlight,
 	.print		= hd44780_common_print,
 	.gotoxy		= hd44780_common_gotoxy,
@@ -984,7 +950,7 @@ static void lcd_init(void)
 		charlcd->height = DEFAULT_LCD_HEIGHT;
 
 	if (lcd.proto == LCD_PROTO_SERIAL) {	/* SERIAL */
-		charlcd->ops = &charlcd_serial_ops;
+		charlcd->ops = &charlcd_ops;
 		hdc->write_data = lcd_write_data_s;
 		hdc->write_cmd = lcd_write_cmd_s;
 
@@ -994,7 +960,7 @@ static void lcd_init(void)
 			lcd.pins.da = DEFAULT_LCD_PIN_SDA;
 
 	} else if (lcd.proto == LCD_PROTO_PARALLEL) {	/* PARALLEL */
-		charlcd->ops = &charlcd_parallel_ops;
+		charlcd->ops = &charlcd_ops;
 		hdc->write_data = lcd_write_data_p8;
 		hdc->write_cmd = lcd_write_cmd_p8;
 
@@ -1005,7 +971,7 @@ static void lcd_init(void)
 		if (lcd.pins.rw == PIN_NOT_SET)
 			lcd.pins.rw = DEFAULT_LCD_PIN_RW;
 	} else {
-		charlcd->ops = &charlcd_tilcd_ops;
+		charlcd->ops = &charlcd_ops;
 		hdc->write_data = lcd_write_data_tilcd;
 		hdc->write_cmd = lcd_write_cmd_tilcd;
 	}
-- 
2.29.2

