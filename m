Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0D42BA18C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 05:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgKTEvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 23:51:55 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52718 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgKTEvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 23:51:37 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 215022A459; Thu, 19 Nov 2020 23:51:36 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Joshua Thompson" <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <effef6339c919a4ef2e81a47e4383f712cdd7626.1605847196.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] m68k/mac: Remove dead code
Date:   Fri, 20 Nov 2020 15:39:56 +1100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Joshua Thompson <funaho@jurai.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/via.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/m68k/mac/via.c b/arch/m68k/mac/via.c
index 66209cb7696f..4226ae2e7501 100644
--- a/arch/m68k/mac/via.c
+++ b/arch/m68k/mac/via.c
@@ -305,21 +305,6 @@ void via_l2_flush(int writeback)
 	local_irq_restore(flags);
 }
 
-/*
- * Return the status of the L2 cache on a IIci
- */
-
-int via_get_cache_disable(void)
-{
-	/* Safeguard against being called accidentally */
-	if (!via2) {
-		printk(KERN_ERR "via_get_cache_disable called on a non-VIA machine!\n");
-		return 1;
-	}
-
-	return (int) via2[gBufB] & VIA2B_vCDis;
-}
-
 /*
  * Initialize VIA2 for Nubus access
  */
-- 
2.26.2

