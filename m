Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9B22DC184
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgLPNrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgLPNrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:47:10 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C63C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 05:46:29 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id 51mU2400A4C55Sk011mUC3; Wed, 16 Dec 2020 14:46:28 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kpX8O-00BB80-2W; Wed, 16 Dec 2020 14:46:28 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kpX8N-005YF9-2Q; Wed, 16 Dec 2020 14:46:27 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, Kun Yi <kunyi@google.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/3] ARM: uncompress: Fix dbgadtb size parameter name
Date:   Wed, 16 Dec 2020 14:46:22 +0100
Message-Id: <20201216134626.1323224-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The dbgadtb macro is passed the size of the appended DTB, not the end
address.

Fixes: c03e41470e901123 ("ARM: 9010/1: uncompress: Print the location of appended DTB")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/compressed/head.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 87d6be9340febdc8..835ce64f1674c9a2 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -116,7 +116,7 @@
 		/*
 		 * Debug print of the final appended DTB location
 		 */
-		.macro dbgadtb, begin, end
+		.macro dbgadtb, begin, size
 #ifdef DEBUG
 		kputc   #'D'
 		kputc   #'T'
@@ -129,7 +129,7 @@
 		kputc	#'('
 		kputc	#'0'
 		kputc	#'x'
-		kphex	\end, 8		/* End of appended DTB */
+		kphex	\size, 8	/* Size of appended DTB */
 		kputc	#')'
 		kputc	#'\n'
 #endif
-- 
2.25.1

