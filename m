Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F062728F1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgIUOsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgIUOsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:48:12 -0400
Received: from smtp1.goneo.de (smtp1.goneo.de [IPv6:2001:1640:5::8:30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF7AC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:48:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 4165223F066;
        Mon, 21 Sep 2020 16:48:11 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.995
X-Spam-Level: 
X-Spam-Status: No, score=-2.995 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.095, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LrVNYQ6MSv6e; Mon, 21 Sep 2020 16:48:09 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPA id 028DB23F04B;
        Mon, 21 Sep 2020 16:48:08 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH v2 27/32] auxdisplay: remove naive display clear impl
Date:   Mon, 21 Sep 2020 16:46:39 +0200
Message-Id: <20200921144645.2061313-28-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921144645.2061313-1-poeschel@lemonage.de>
References: <20191016082430.5955-1-poeschel@lemonage.de>
 <20200921144645.2061313-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

Remove the naive (character after character from upper left to lower
right) display clear implementation in charlcd_clear_fast. It was a
fallback and we fall back to using the clear_display implementation
instead.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index ef448c42abbd..0137e741c5bb 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -127,21 +127,13 @@ static void charlcd_print(struct charlcd *lcd, char c)
 
 static void charlcd_clear_fast(struct charlcd *lcd)
 {
-	int x, y;
-
 	if (lcd->ops->clear_fast)
 		lcd->ops->clear_fast(lcd);
-	else {
-		for (y = 0; y < lcd->height; y++) {
-			lcd->addr.x = 0;
-			lcd->addr.y = y;
-			lcd->ops->gotoxy(lcd);
-			for (x = 0; x < lcd->width; x++)
-				lcd->ops->print(lcd, ' ');
-		}
+	else
+		lcd->ops->clear_display(lcd);
 
-		lcd->ops->home(lcd);
-	}
+	lcd->addr.x = 0;
+	lcd->addr.y = 0;
 }
 
 /*
-- 
2.28.0

