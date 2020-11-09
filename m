Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5752AB39E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbgKIJcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKIJcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:32:23 -0500
Received: from smtp1.goneo.de (smtp1.goneo.de [IPv6:2001:1640:5::8:30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEC6C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 01:32:22 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 04E4923F150;
        Mon,  9 Nov 2020 10:32:19 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.983
X-Spam-Level: 
X-Spam-Status: No, score=-2.983 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.083, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EYVf58zyV78p; Mon,  9 Nov 2020 10:32:17 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPA id CF0D323F2DC;
        Mon,  9 Nov 2020 10:32:16 +0100 (CET)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] auxdisplay: hd44780_common: Fix build error
Date:   Mon,  9 Nov 2020 10:31:54 +0100
Message-Id: <20201109093154.1080024-1-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <76f9cd1b-3ace-e8a8-aaee-8d64e0900603@infradead.org>
References: <76f9cd1b-3ace-e8a8-aaee-8d64e0900603@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

When building the hd44780_common driver without a driver that actually
uses it like panel or hd44780 you got a build error, because
hd44780_common uses charlcd, but did not select it. It's users did
select it.
This is fixed now. hd4478_common now selects charlcd in Kconfig and
panel and hd44780 do not. They only select hd44780_common.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index a69623124a26..a2b59b84bb88 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -27,6 +27,7 @@ config CHARLCD
 
 config HD44780_COMMON
 	tristate "Common functions for HD44780 (and compatibles) LCD displays" if COMPILE_TEST
+	select CHARLCD
 	help
 	  This is a module with the common symbols for HD44780 (and compatibles)
 	  displays. This is the code that multiple other modules use. It is not
@@ -37,7 +38,6 @@ config HD44780_COMMON
 config HD44780
 	tristate "HD44780 Character LCD support"
 	depends on GPIOLIB || COMPILE_TEST
-	select CHARLCD
 	select HD44780_COMMON
 	help
 	  Enable support for Character LCDs using a HD44780 controller.
@@ -196,7 +196,6 @@ config ARM_CHARLCD
 menuconfig PARPORT_PANEL
 	tristate "Parallel port LCD/Keypad Panel support"
 	depends on PARPORT
-	select CHARLCD
 	select HD44780_COMMON
 	help
 	  Say Y here if you have an HD44780 or KS-0074 LCD connected to your
-- 
2.28.0

