Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9351A300821
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 17:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbhAVQCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 11:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbhAVQBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:01:49 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDC6C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 08:01:08 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id Ks142400U4C55Sk06s14us; Fri, 22 Jan 2021 17:01:07 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l2yrw-005qfR-C7; Fri, 22 Jan 2021 17:01:04 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l2yrv-00C4Yp-LL; Fri, 22 Jan 2021 17:01:03 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Lars Poeschel <poeschel@lemonage.de>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc:     Willy Tarreau <w@1wt.eu>, Miguel Ojeda <ojeda@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] auxdisplay: Fix duplicate CHARLCD config symbol
Date:   Fri, 22 Jan 2021 17:01:02 +0100
Message-Id: <20210122160102.2877424-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A second CHARLCD config symbol was added instead of moving the existing
one.  Fix this by removing the old one.

Fixes: 718e05ed92ecac0d ("auxdisplay: Introduce hd44780_common.[ch]")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/auxdisplay/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index a2b59b84bb881c82..1509cb74705a30ad 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -507,6 +507,3 @@ config PANEL
 	depends on PARPORT
 	select AUXDISPLAY
 	select PARPORT_PANEL
-
-config CHARLCD
-	tristate "Character LCD core support" if COMPILE_TEST
-- 
2.25.1

