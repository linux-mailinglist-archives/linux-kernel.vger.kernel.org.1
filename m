Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AF7283615
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgJENCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgJENBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:01:46 -0400
Received: from smtp3.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64BAC0613BE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 06:01:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 8B50F2401A0;
        Mon,  5 Oct 2020 15:01:43 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.954
X-Spam-Level: 
X-Spam-Status: No, score=-2.954 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.054, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JC7hBe3TvV6Y; Mon,  5 Oct 2020 15:01:41 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 6510E24029E;
        Mon,  5 Oct 2020 15:01:41 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v4 24/32] auxdisplay: Move char redefine code to hd44780_common
Date:   Mon,  5 Oct 2020 15:01:20 +0200
Message-Id: <20201005130128.3430804-12-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005130128.3430804-1-poeschel@lemonage.de>
References: <20201005130128.3430804-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

Take the code to redefine characters out of charlcd and move it to
hd44780_common, as this is hd44780 specific.
There is now a function hd44780_common_redefine_char that drivers use
and charlcd calls it through its ops function pointer.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c        | 60 +++------------------------
 drivers/auxdisplay/charlcd.h        |  2 +
 drivers/auxdisplay/hd44780.c        |  2 +
 drivers/auxdisplay/hd44780_common.c | 63 +++++++++++++++++++++++++++++
 drivers/auxdisplay/hd44780_common.h |  1 +
 drivers/auxdisplay/panel.c          |  3 ++
 6 files changed, 76 insertions(+), 55 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 29737c3e18f6..dca1b138a239 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -25,8 +25,6 @@
 /* Keep the backlight on this many seconds for each flash */
 #define LCD_BL_TEMPO_PERIOD	4
 
-#define LCD_CMD_SET_CGRAM_ADDR	0x40	/* Set char generator RAM address */
-
 #define LCD_ESCAPE_LEN		24	/* Max chars for LCD escape command */
 #define LCD_ESCAPE_CHAR		27	/* Use char 27 for escape command */
 
@@ -344,61 +342,13 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 			LCD_FLAG_C | LCD_FLAG_B;
 		processed = 1;
 		break;
-	case 'G': {
-		/* Generator : LGcxxxxx...xx; must have <c> between '0'
-		 * and '7', representing the numerical ASCII code of the
-		 * redefined character, and <xx...xx> a sequence of 16
-		 * hex digits representing 8 bytes for each character.
-		 * Most LCDs will only use 5 lower bits of the 7 first
-		 * bytes.
-		 */
-
-		unsigned char cgbytes[8];
-		unsigned char cgaddr;
-		int cgoffset;
-		int shift;
-		char value;
-		int addr;
-
-		if (!strchr(esc, ';'))
-			break;
-
-		esc++;
-
-		cgaddr = *(esc++) - '0';
-		if (cgaddr > 7) {
+	case 'G':
+		if (lcd->ops->redefine_char)
+			processed = lcd->ops->redefine_char(lcd, esc);
+		else
 			processed = 1;
-			break;
-		}
-
-		cgoffset = 0;
-		shift = 0;
-		value = 0;
-		while (*esc && cgoffset < 8) {
-			int half;
-
-			shift ^= 4;
-
-			half = hex_to_bin(*esc++);
-			if (half < 0)
-				continue;
-
-			value |= half << shift;
-			if (shift == 0) {
-				cgbytes[cgoffset++] = value;
-				value = 0;
-			}
-		}
-
-		hdc->write_cmd(hdc, LCD_CMD_SET_CGRAM_ADDR | (cgaddr * 8));
-		for (addr = 0; addr < cgoffset; addr++)
-			hdc->write_data(hdc, cgbytes[addr]);
-
-		/* ensures that we stop writing to CGRAM */
-		lcd->ops->gotoxy(lcd);
-		processed = 1;
 		break;
-	}
+
 	case 'x':	/* gotoxy : LxXXX[yYYY]; */
 	case 'y':	/* gotoxy : LyYYY[xXXX]; */
 		if (priv->esc_seq.buf[priv->esc_seq.len - 1] != ';')
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index 5b0717c7482b..83fa989d37fa 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -74,6 +74,7 @@ struct charlcd {
  * @cursor: Turn cursor on or off.
  * @blink: Turn cursor blink on or off.
  * @lines: One or two lines.
+ * @redefine_char: Redefine the actual pixel matrix of character.
  */
 struct charlcd_ops {
 	void (*clear_fast)(struct charlcd *lcd);
@@ -90,6 +91,7 @@ struct charlcd_ops {
 	int (*blink)(struct charlcd *lcd, enum charlcd_onoff on);
 	int (*fontsize)(struct charlcd *lcd, enum charlcd_fontsize size);
 	int (*lines)(struct charlcd *lcd, enum charlcd_lines lines);
+	int (*redefine_char)(struct charlcd *lcd, char *esc);
 };
 
 void charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on);
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 7b7b28d72198..2e5e7c993933 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -138,6 +138,7 @@ static const struct charlcd_ops hd44780_ops_gpio8 = {
 	.blink		= hd44780_common_blink,
 	.fontsize	= hd44780_common_fontsize,
 	.lines		= hd44780_common_lines,
+	.redefine_char	= hd44780_common_redefine_char,
 };
 
 /* Send a command to the LCD panel in 4 bit GPIO mode */
@@ -193,6 +194,7 @@ static const struct charlcd_ops hd44780_ops_gpio4 = {
 	.blink		= hd44780_common_blink,
 	.fontsize	= hd44780_common_fontsize,
 	.lines		= hd44780_common_lines,
+	.redefine_char	= hd44780_common_redefine_char,
 };
 
 static int hd44780_probe(struct platform_device *pdev)
diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index 2df2410f3874..82afae78f46e 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -26,6 +26,8 @@
 #define LCD_CMD_TWO_LINES	0x08	/* Set to two display lines */
 #define LCD_CMD_FONT_5X10_DOTS	0x04	/* Set char font to 5x10 dots */
 
+#define LCD_CMD_SET_CGRAM_ADDR	0x40	/* Set char generator RAM address */
+
 #define LCD_CMD_SET_DDRAM_ADDR	0x80	/* Set display data RAM address */
 
 /* sleeps that many milliseconds with a reschedule */
@@ -289,6 +291,67 @@ int hd44780_common_lines(struct charlcd *lcd, enum charlcd_lines lines)
 }
 EXPORT_SYMBOL_GPL(hd44780_common_lines);
 
+int hd44780_common_redefine_char(struct charlcd *lcd, char *esc)
+{
+	/* Generator : LGcxxxxx...xx; must have <c> between '0'
+	 * and '7', representing the numerical ASCII code of the
+	 * redefined character, and <xx...xx> a sequence of 16
+	 * hex digits representing 8 bytes for each character.
+	 * Most LCDs will only use 5 lower bits of the 7 first
+	 * bytes.
+	 */
+
+	struct hd44780_common *hdc = lcd->drvdata;
+	unsigned char cgbytes[8];
+	unsigned char cgaddr;
+	int cgoffset;
+	int shift;
+	char value;
+	int addr;
+
+	if (!strchr(esc, ';'))
+		return 0;
+
+	esc++;
+
+	cgaddr = *(esc++) - '0';
+	if (cgaddr > 7)
+		return 1;
+
+	cgoffset = 0;
+	shift = 0;
+	value = 0;
+	while (*esc && cgoffset < 8) {
+		shift ^= 4;
+		if (*esc >= '0' && *esc <= '9') {
+			value |= (*esc - '0') << shift;
+		} else if (*esc >= 'A' && *esc <= 'F') {
+			value |= (*esc - 'A' + 10) << shift;
+		} else if (*esc >= 'a' && *esc <= 'f') {
+			value |= (*esc - 'a' + 10) << shift;
+		} else {
+			esc++;
+			continue;
+		}
+
+		if (shift == 0) {
+			cgbytes[cgoffset++] = value;
+			value = 0;
+		}
+
+		esc++;
+	}
+
+	hdc->write_cmd(hdc, LCD_CMD_SET_CGRAM_ADDR | (cgaddr * 8));
+	for (addr = 0; addr < cgoffset; addr++)
+		hdc->write_data(hdc, cgbytes[addr]);
+
+	/* ensures that we stop writing to CGRAM */
+	lcd->ops->gotoxy(lcd);
+	return 1;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_redefine_char);
+
 struct hd44780_common *hd44780_common_alloc(void)
 {
 	struct hd44780_common *hd;
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
index 419065bfaea2..d3758230b7fd 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -29,5 +29,6 @@ int hd44780_common_cursor(struct charlcd *lcd, enum charlcd_onoff on);
 int hd44780_common_blink(struct charlcd *lcd, enum charlcd_onoff on);
 int hd44780_common_fontsize(struct charlcd *lcd, enum charlcd_fontsize size);
 int hd44780_common_lines(struct charlcd *lcd, enum charlcd_lines lines);
+int hd44780_common_redefine_char(struct charlcd *lcd, char *esc);
 struct hd44780_common *hd44780_common_alloc(void);
 
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 3d33d7cc979c..b0d2ae5b9be8 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -886,6 +886,7 @@ static const struct charlcd_ops charlcd_serial_ops = {
 	.blink		= hd44780_common_blink,
 	.fontsize	= hd44780_common_fontsize,
 	.lines		= hd44780_common_lines,
+	.redefine_char	= hd44780_common_redefine_char,
 };
 
 static const struct charlcd_ops charlcd_parallel_ops = {
@@ -902,6 +903,7 @@ static const struct charlcd_ops charlcd_parallel_ops = {
 	.blink		= hd44780_common_blink,
 	.fontsize	= hd44780_common_fontsize,
 	.lines		= hd44780_common_lines,
+	.redefine_char	= hd44780_common_redefine_char,
 };
 
 static const struct charlcd_ops charlcd_tilcd_ops = {
@@ -918,6 +920,7 @@ static const struct charlcd_ops charlcd_tilcd_ops = {
 	.blink		= hd44780_common_blink,
 	.fontsize	= hd44780_common_fontsize,
 	.lines		= hd44780_common_lines,
+	.redefine_char	= hd44780_common_redefine_char,
 };
 
 /* initialize the LCD driver */
-- 
2.28.0

