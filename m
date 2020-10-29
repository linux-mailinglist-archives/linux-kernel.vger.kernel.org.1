Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E69D29E7FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgJ2J6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgJ2J6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:58:07 -0400
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A43C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 02:58:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id AE4FC2402B7;
        Thu, 29 Oct 2020 10:58:05 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.947
X-Spam-Level: 
X-Spam-Status: No, score=-2.947 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.047, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3lQv1WA_tuMP; Thu, 29 Oct 2020 10:58:04 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 263EA2402BB;
        Thu, 29 Oct 2020 10:58:04 +0100 (CET)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v5 16/25] auxdisplay: cleanup unnecessary hd44780 code in charlcd
Date:   Thu, 29 Oct 2020 10:57:20 +0100
Message-Id: <20201029095731.311528-15-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029095731.311528-1-poeschel@lemonage.de>
References: <20201029095231.311083-1-poeschel@lemonage.de>
 <20201029095731.311528-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

This cleans up now unnecessary hd44780 specific code from charlcd. We
obsoleted this with the last patch. So another chunk of hd44780 specific
code can be dropped from charlcd.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
Changes in v5:
- combined two cleanup patches
---
 drivers/auxdisplay/charlcd.c | 32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 281a3259c144..29737c3e18f6 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -25,21 +25,8 @@
 /* Keep the backlight on this many seconds for each flash */
 #define LCD_BL_TEMPO_PERIOD	4
 
-/* LCD commands */
-#define LCD_CMD_DISPLAY_CTRL	0x08	/* Display control */
-#define LCD_CMD_DISPLAY_ON	0x04	/* Set display on */
-#define LCD_CMD_CURSOR_ON	0x02	/* Set cursor on */
-#define LCD_CMD_BLINK_ON	0x01	/* Set blink on */
-
-#define LCD_CMD_FUNCTION_SET	0x20	/* Set function */
-#define LCD_CMD_DATA_LEN_8BITS	0x10	/* Set data length to 8 bits */
-#define LCD_CMD_TWO_LINES	0x08	/* Set to two display lines */
-#define LCD_CMD_FONT_5X10_DOTS	0x04	/* Set char font to 5x10 dots */
-
 #define LCD_CMD_SET_CGRAM_ADDR	0x40	/* Set char generator RAM address */
 
-#define LCD_CMD_SET_DDRAM_ADDR 0x80    /* Set display data RAM address */
-
 #define LCD_ESCAPE_LEN		24	/* Max chars for LCD escape command */
 #define LCD_ESCAPE_CHAR		27	/* Use char 27 for escape command */
 
@@ -431,24 +418,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 	if (oldflags == priv->flags)
 		return processed;
 
-	/* check whether one of B,C,D flags were changed */
-	if ((oldflags ^ priv->flags) &
-	    (LCD_FLAG_B | LCD_FLAG_C | LCD_FLAG_D))
-		/* set display mode */
-		hdc->write_cmd(hdc,
-			LCD_CMD_DISPLAY_CTRL |
-			((priv->flags & LCD_FLAG_D) ? LCD_CMD_DISPLAY_ON : 0) |
-			((priv->flags & LCD_FLAG_C) ? LCD_CMD_CURSOR_ON : 0) |
-			((priv->flags & LCD_FLAG_B) ? LCD_CMD_BLINK_ON : 0));
-	/* check whether one of F,N flags was changed */
-	else if ((oldflags ^ priv->flags) & (LCD_FLAG_F | LCD_FLAG_N))
-		hdc->write_cmd(hdc,
-			LCD_CMD_FUNCTION_SET |
-			((hdc->ifwidth == 8) ? LCD_CMD_DATA_LEN_8BITS : 0) |
-			((priv->flags & LCD_FLAG_F) ? LCD_CMD_FONT_5X10_DOTS : 0) |
-			((priv->flags & LCD_FLAG_N) ? LCD_CMD_TWO_LINES : 0));
-	/* check whether L flag was changed */
-	else if ((oldflags ^ priv->flags) & LCD_FLAG_L)
+	if ((oldflags ^ priv->flags) & LCD_FLAG_L)
 		charlcd_backlight(lcd, !!(priv->flags & LCD_FLAG_L));
 
 	return processed;
-- 
2.28.0

