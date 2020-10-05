Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39C1283613
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgJENCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgJENBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:01:46 -0400
Received: from smtp3.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3518C0610CF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 06:01:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 762552402A1;
        Mon,  5 Oct 2020 15:01:44 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.954
X-Spam-Level: 
X-Spam-Status: No, score=-2.954 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.054, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 76m9is3wG2YP; Mon,  5 Oct 2020 15:01:42 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 537982402D3;
        Mon,  5 Oct 2020 15:01:42 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH v4 26/32] auxdisplay: hd44780_common: Reduce clear_display timeout
Date:   Mon,  5 Oct 2020 15:01:22 +0200
Message-Id: <20201005130128.3430804-14-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005130128.3430804-1-poeschel@lemonage.de>
References: <20201005130128.3430804-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

Digging in the hd44780 datasheet revealed that the timeout needed after
clearing the whole display is only 1,64ms not 15ms. So we can reduce
that timeout.

Link: https://lore.kernel.org/lkml/20200922092121.GG16421@1wt.eu/
Link: https://www.crystalfontz.com/controllers/Hitachi/HD44780/433/

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
Changes in v3:
- This patch is new in v3
---
 drivers/auxdisplay/hd44780_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index 82afae78f46e..fbce8835a650 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -83,8 +83,8 @@ int hd44780_common_clear_display(struct charlcd *lcd)
 	struct hd44780_common *hdc = lcd->drvdata;
 
 	hdc->write_cmd(hdc, LCD_CMD_DISPLAY_CLEAR);
-	/* we must wait a few milliseconds (15) */
-	long_sleep(15);
+	/* datasheet says to wait 1,64 milliseconds */
+	long_sleep(2);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(hd44780_common_clear_display);
-- 
2.28.0

