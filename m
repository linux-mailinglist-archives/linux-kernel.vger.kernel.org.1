Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B932B847B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 20:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgKRTNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 14:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgKRTNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:13:22 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC81C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 11:13:21 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id tvDJ2300H4C55Sk01vDJp7; Wed, 18 Nov 2020 20:13:19 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kfStK-003eaX-97; Wed, 18 Nov 2020 20:13:18 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kfStJ-00Grlg-9U; Wed, 18 Nov 2020 20:13:17 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: uncompress: Fix dbgadtb size parameter name
Date:   Wed, 18 Nov 2020 20:13:14 +0100
Message-Id: <20201118191314.4019887-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dbgadtb macro is passed the size of the appended DTB, not the end
address.

Fixes: c03e41470e901123 ("ARM: 9010/1: uncompress: Print the location of appended DTB")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/compressed/head.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 9905fb7560df215d..265c029c261bc8a1 100644
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

