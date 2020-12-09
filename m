Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856842D4169
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbgLILvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730978AbgLILvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:51:22 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A0DC061794
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 03:50:41 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id 2Bqd2400K4C55Sk06Bqdn9; Wed, 09 Dec 2020 12:50:38 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kmxzR-009AiG-AW; Wed, 09 Dec 2020 12:50:37 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kmwUB-009G5Z-2q; Wed, 09 Dec 2020 11:14:15 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] ARM: uncompress: atags_to_fdt: Spelling s/REturn/Return/
Date:   Wed,  9 Dec 2020 11:14:13 +0100
Message-Id: <20201209101413.2206744-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a capitalization typo.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/compressed/atags_to_fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index 8452753efebe5621..503ad35a251a115e 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -120,7 +120,7 @@ static void hex_str(char *out, uint32_t value)
 /*
  * Convert and fold provided ATAGs into the provided FDT.
  *
- * REturn values:
+ * Return values:
  *    = 0 -> pretend success
  *    = 1 -> bad ATAG (may retry with another possible ATAG pointer)
  *    < 0 -> error from libfdt
-- 
2.25.1

