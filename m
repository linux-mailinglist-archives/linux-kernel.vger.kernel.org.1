Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453F528360E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgJENCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgJENBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:01:47 -0400
Received: from smtp3.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FACC0613BA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 06:01:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 0415823F343;
        Mon,  5 Oct 2020 15:01:46 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.953
X-Spam-Level: 
X-Spam-Status: No, score=-2.953 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.053, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2q1g1bXZFTYP; Mon,  5 Oct 2020 15:01:44 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 8107B23F08B;
        Mon,  5 Oct 2020 15:01:44 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v4 30/32] auxdisplay: charlcd: Do not print chars at end of line
Date:   Mon,  5 Oct 2020 15:01:26 +0200
Message-Id: <20201005130128.3430804-18-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005130128.3430804-1-poeschel@lemonage.de>
References: <20201005130128.3430804-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

Skip printing characters at the end of a display line. This fits to the
behaviour we already had, that the cursor is nailed to last position of
a line.
This might slightly change behaviour.
On hd44780 displays with one or two lines the previous implementation
did still write characters to the buffer of the display even if they are
currently not visible. The shift_display command could be used so set
the "viewing window" to a new position in the buffer and then you could
see the characters previously written.
This described behaviour does not work for hd44780 displays with more
than two display lines. There simply is not enough buffer.
So the behaviour was a bit inconsistens across different displays.
The new behaviour is to stop writing character at the end of a visible
line, even if there would be room in the buffer. This allows us to have
an easy implementation, that should behave equal on all supported
displays. This is not hd44780 hardware dependents anymore.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
Changes in v3:
- Better patch description
---
 drivers/auxdisplay/charlcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index ef10b5ca0e16..f43430e9dcee 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -111,6 +111,9 @@ static void charlcd_home(struct charlcd *lcd)
 
 static void charlcd_print(struct charlcd *lcd, char c)
 {
+	if (lcd->addr.x >= lcd->width)
+		return;
+
 	if (lcd->char_conv)
 		c = lcd->char_conv[(unsigned char)c];
 
-- 
2.28.0

