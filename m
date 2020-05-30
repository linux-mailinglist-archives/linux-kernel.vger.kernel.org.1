Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970E31E946F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 01:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgE3XQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 May 2020 19:16:32 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51064 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729554AbgE3XQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 19:16:29 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id B2E9127F9A; Sat, 30 May 2020 19:16:28 -0400 (EDT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <09bcb7359a1719a18b551ee515da3c4c3cf709e6.1590880333.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1590880333.git.fthain@telegraphics.com.au>
References: <cover.1590880333.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 2/4] m68k/mac: Fix IOP status/control register writes
Date:   Sun, 31 May 2020 09:12:13 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When writing values to the IOP status/control register make sure those
values do not have any extraneous bits that will clear interrupt flags.

To place the SCC IOP into bypass mode would be desirable but this is not
achieved by writing IOP_DMAINACTIVE | IOP_RUN | IOP_AUTOINC | IOP_BYPASS
to the control register. Drop this ineffective register write.

Remove the flawed and unused iop_bypass() function. Make use of the
unused iop_stop() function.

Cc: Joshua Thompson <funaho@jurai.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/iop.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/m68k/mac/iop.c b/arch/m68k/mac/iop.c
index 22c4e2b8bdf2..5fc3b59ba811 100644
--- a/arch/m68k/mac/iop.c
+++ b/arch/m68k/mac/iop.c
@@ -183,7 +183,7 @@ static __inline__ void iop_writeb(volatile struct mac_iop *iop, __u16 addr, __u8
 
 static __inline__ void iop_stop(volatile struct mac_iop *iop)
 {
-	iop->status_ctrl &= ~IOP_RUN;
+	iop->status_ctrl = IOP_AUTOINC;
 }
 
 static __inline__ void iop_start(volatile struct mac_iop *iop)
@@ -191,14 +191,9 @@ static __inline__ void iop_start(volatile struct mac_iop *iop)
 	iop->status_ctrl = IOP_RUN | IOP_AUTOINC;
 }
 
-static __inline__ void iop_bypass(volatile struct mac_iop *iop)
-{
-	iop->status_ctrl |= IOP_BYPASS;
-}
-
 static __inline__ void iop_interrupt(volatile struct mac_iop *iop)
 {
-	iop->status_ctrl |= IOP_IRQ;
+	iop->status_ctrl = IOP_IRQ | IOP_RUN | IOP_AUTOINC;
 }
 
 static int iop_alive(volatile struct mac_iop *iop)
@@ -244,7 +239,6 @@ void __init iop_preinit(void)
 		} else {
 			iop_base[IOP_NUM_SCC] = (struct mac_iop *) SCC_IOP_BASE_QUADRA;
 		}
-		iop_base[IOP_NUM_SCC]->status_ctrl = 0x87;
 		iop_scc_present = 1;
 	} else {
 		iop_base[IOP_NUM_SCC] = NULL;
@@ -256,7 +250,7 @@ void __init iop_preinit(void)
 		} else {
 			iop_base[IOP_NUM_ISM] = (struct mac_iop *) ISM_IOP_BASE_QUADRA;
 		}
-		iop_base[IOP_NUM_ISM]->status_ctrl = 0;
+		iop_stop(iop_base[IOP_NUM_ISM]);
 		iop_ism_present = 1;
 	} else {
 		iop_base[IOP_NUM_ISM] = NULL;
-- 
2.26.2

