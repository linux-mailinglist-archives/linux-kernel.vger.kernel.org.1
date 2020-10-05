Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66973283612
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgJENC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgJENBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:01:46 -0400
Received: from smtp3.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A586C0613BD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 06:01:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 71C222402D5;
        Mon,  5 Oct 2020 15:01:42 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.954
X-Spam-Level: 
X-Spam-Status: No, score=-2.954 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.054, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ltkTpY03dYca; Mon,  5 Oct 2020 15:01:40 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 9743323F977;
        Mon,  5 Oct 2020 15:01:40 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v4 23/32] auxdisplay: Remove unnecessary hd44780 from charlcd
Date:   Mon,  5 Oct 2020 15:01:19 +0200
Message-Id: <20201005130128.3430804-11-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005130128.3430804-1-poeschel@lemonage.de>
References: <20201005130128.3430804-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

The last two commits made another chunk of hd44780 code unnecessary
which we remove here.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index d672e4c371e1..29737c3e18f6 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -25,16 +25,8 @@
 /* Keep the backlight on this many seconds for each flash */
 #define LCD_BL_TEMPO_PERIOD	4
 
-/* LCD commands */
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
 
@@ -426,14 +418,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 	if (oldflags == priv->flags)
 		return processed;
 
-	if ((oldflags ^ priv->flags) & (LCD_FLAG_F | LCD_FLAG_N))
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

