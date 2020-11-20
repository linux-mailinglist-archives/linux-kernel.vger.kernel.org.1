Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602A82BA187
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 05:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgKTEvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 23:51:48 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52754 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgKTEvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 23:51:38 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 199702A45B; Thu, 19 Nov 2020 23:51:36 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Joshua Thompson" <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <0a7b09f5e5f48e270b82041c19e8f20f54c69216.1605847196.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] m68k/mac: Refactor iop_preinit() and iop_init()
Date:   Fri, 20 Nov 2020 15:39:56 +1100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea behind iop_preinit() was to put the SCC IOP into bypass mode.
However, that remains unimplemented and implementing it would be
difficult. Let the comments and code reflect this. Even if iop_preinit()
worked as described in the comments, it gets called immediately before
iop_init() so it might as well part of iop_init().

Cc: Joshua Thompson <funaho@jurai.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/config.c |  8 -------
 arch/m68k/mac/iop.c    | 54 ++++++++++++++----------------------------
 2 files changed, 18 insertions(+), 44 deletions(-)

diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 2bea1799b8de..f66944909be9 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -55,7 +55,6 @@ struct mac_booter_data mac_bi_data;
 static unsigned long mac_orig_videoaddr;
 
 extern int mac_hwclk(int, struct rtc_time *);
-extern void iop_preinit(void);
 extern void iop_init(void);
 extern void via_init(void);
 extern void via_init_clock(irq_handler_t func);
@@ -836,13 +835,6 @@ static void __init mac_identify(void)
 		break;
 	}
 
-	/*
-	 * We need to pre-init the IOPs, if any. Otherwise
-	 * the serial console won't work if the user had
-	 * the serial ports set to "Faster" mode in MacOS.
-	 */
-	iop_preinit();
-
 	pr_info("Detected Macintosh model: %d\n", model);
 
 	/*
diff --git a/arch/m68k/mac/iop.c b/arch/m68k/mac/iop.c
index c669a7644301..de156a027f5b 100644
--- a/arch/m68k/mac/iop.c
+++ b/arch/m68k/mac/iop.c
@@ -47,6 +47,10 @@
  *
  * TODO:
  *
+ * o The SCC IOP has to be placed in bypass mode before the serial console
+ *   gets initialized. iop_init() would be one place to do that. Or the
+ *   bootloader could do that. For now, the Serial Switch control panel
+ *   is needed for that -- contrary to the changelog above.
  * o Something should be periodically checking iop_alive() to make sure the
  *   IOP hasn't died.
  * o Some of the IOP manager routines need better error checking and
@@ -224,40 +228,6 @@ static struct iop_msg *iop_get_unused_msg(void)
 	return NULL;
 }
 
-/*
- * This is called by the startup code before anything else. Its purpose
- * is to find and initialize the IOPs early in the boot sequence, so that
- * the serial IOP can be placed into bypass mode _before_ we try to
- * initialize the serial console.
- */
-
-void __init iop_preinit(void)
-{
-	if (macintosh_config->scc_type == MAC_SCC_IOP) {
-		if (macintosh_config->ident == MAC_MODEL_IIFX) {
-			iop_base[IOP_NUM_SCC] = (struct mac_iop *) SCC_IOP_BASE_IIFX;
-		} else {
-			iop_base[IOP_NUM_SCC] = (struct mac_iop *) SCC_IOP_BASE_QUADRA;
-		}
-		iop_scc_present = 1;
-	} else {
-		iop_base[IOP_NUM_SCC] = NULL;
-		iop_scc_present = 0;
-	}
-	if (macintosh_config->adb_type == MAC_ADB_IOP) {
-		if (macintosh_config->ident == MAC_MODEL_IIFX) {
-			iop_base[IOP_NUM_ISM] = (struct mac_iop *) ISM_IOP_BASE_IIFX;
-		} else {
-			iop_base[IOP_NUM_ISM] = (struct mac_iop *) ISM_IOP_BASE_QUADRA;
-		}
-		iop_stop(iop_base[IOP_NUM_ISM]);
-		iop_ism_present = 1;
-	} else {
-		iop_base[IOP_NUM_ISM] = NULL;
-		iop_ism_present = 0;
-	}
-}
-
 /*
  * Initialize the IOPs, if present.
  */
@@ -266,11 +236,23 @@ void __init iop_init(void)
 {
 	int i;
 
-	if (iop_scc_present) {
+	if (macintosh_config->scc_type == MAC_SCC_IOP) {
+		if (macintosh_config->ident == MAC_MODEL_IIFX)
+			iop_base[IOP_NUM_SCC] = (struct mac_iop *)SCC_IOP_BASE_IIFX;
+		else
+			iop_base[IOP_NUM_SCC] = (struct mac_iop *)SCC_IOP_BASE_QUADRA;
+		iop_scc_present = 1;
 		pr_debug("SCC IOP detected at %p\n", iop_base[IOP_NUM_SCC]);
 	}
-	if (iop_ism_present) {
+	if (macintosh_config->adb_type == MAC_ADB_IOP) {
+		if (macintosh_config->ident == MAC_MODEL_IIFX)
+			iop_base[IOP_NUM_ISM] = (struct mac_iop *)ISM_IOP_BASE_IIFX;
+		else
+			iop_base[IOP_NUM_ISM] = (struct mac_iop *)ISM_IOP_BASE_QUADRA;
+		iop_ism_present = 1;
 		pr_debug("ISM IOP detected at %p\n", iop_base[IOP_NUM_ISM]);
+
+		iop_stop(iop_base[IOP_NUM_ISM]);
 		iop_start(iop_base[IOP_NUM_ISM]);
 		iop_alive(iop_base[IOP_NUM_ISM]); /* clears the alive flag */
 	}
-- 
2.26.2

