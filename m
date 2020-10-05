Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31230283582
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgJEMNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgJEMMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:12:35 -0400
Received: from smtp2-2.goneo.de (smtp2.goneo.de [IPv6:2001:1640:5::8:33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA0DC0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 05:12:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id B5A11241A54;
        Mon,  5 Oct 2020 14:12:33 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.985
X-Spam-Level: 
X-Spam-Status: No, score=-2.985 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.085, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6SnMfvbkiRsT; Mon,  5 Oct 2020 14:12:31 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp2.goneo.de (Postfix) with ESMTPA id 8C92C241509;
        Mon,  5 Oct 2020 14:12:31 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v3 20/32] auxdisplay: cleanup unnecessary hd44780 code in charlcd
Date:   Mon,  5 Oct 2020 14:11:48 +0200
Message-Id: <20201005121200.3427363-21-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005121200.3427363-1-poeschel@lemonage.de>
References: <20201005121200.3427363-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

This cleans up now unnecessary hd44780 specific code from charlcd. We
obsoleted this with the last three patches. So another chunk of hd44780
code can be dropped.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index b099897e101b..c04aaa4d66a5 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -26,11 +26,6 @@
 #define LCD_BL_TEMPO_PERIOD	4
 
 /* LCD commands */
-#define LCD_CMD_DISPLAY_CTRL	0x08	/* Display control */
-#define LCD_CMD_DISPLAY_ON	0x04	/* Set display on */
-#define LCD_CMD_CURSOR_ON	0x02	/* Set cursor on */
-#define LCD_CMD_BLINK_ON	0x01	/* Set blink on */
-
 #define LCD_CMD_FUNCTION_SET	0x20	/* Set function */
 #define LCD_CMD_DATA_LEN_8BITS	0x10	/* Set data length to 8 bits */
 #define LCD_CMD_TWO_LINES	0x08	/* Set to two display lines */
@@ -419,17 +414,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
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
+	if ((oldflags ^ priv->flags) & (LCD_FLAG_F | LCD_FLAG_N))
 		hdc->write_cmd(hdc,
 			LCD_CMD_FUNCTION_SET |
 			((hdc->ifwidth == 8) ? LCD_CMD_DATA_LEN_8BITS : 0) |
-- 
2.28.0

