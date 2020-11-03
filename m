Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477512A40EF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgKCJ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgKCJ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:58:57 -0500
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2F5C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 01:58:57 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 847CA240013;
        Tue,  3 Nov 2020 10:58:56 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.942
X-Spam-Level: 
X-Spam-Status: No, score=-2.942 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.042, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ieWB_VOv_utu; Tue,  3 Nov 2020 10:58:55 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id CC4C423FF26;
        Tue,  3 Nov 2020 10:58:54 +0100 (CET)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v6 16/25] auxdisplay: cleanup unnecessary hd44780 code in charlcd
Date:   Tue,  3 Nov 2020 10:58:19 +0100
Message-Id: <20201103095828.515831-17-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103095828.515831-1-poeschel@lemonage.de>
References: <20201103095828.515831-1-poeschel@lemonage.de>
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

