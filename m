Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3D429E815
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgJ2J7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgJ2J6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:58:09 -0400
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C645CC0613D8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 02:58:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id AE35824028F;
        Thu, 29 Oct 2020 10:58:07 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.946
X-Spam-Level: 
X-Spam-Status: No, score=-2.946 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.046, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QvieMOjMEKDX; Thu, 29 Oct 2020 10:58:06 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id EAB622402BB;
        Thu, 29 Oct 2020 10:58:05 +0100 (CET)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH v5 19/25] auxdisplay: hd44780_common: Reduce clear_display timeout
Date:   Thu, 29 Oct 2020 10:57:23 +0100
Message-Id: <20201029095731.311528-18-poeschel@lemonage.de>
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
index c528fb8e8808..bd93a4d3367e 100644
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

