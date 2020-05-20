Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B491DA961
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 06:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgETElp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 00:41:45 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:60640 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgETElo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 00:41:44 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id A7DAD299CC; Wed, 20 May 2020 00:41:42 -0400 (EDT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Joshua Thompson" <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <bfbb71db52c5e162d3afa25a28fc5d535ca87138.1589949122.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] m68k/mac: Avoid stuck ISM IOP interrupt on Quadra 900/950
Date:   Wed, 20 May 2020 14:32:02 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a Quadra 900/950, the ISM IOP IRQ output pin is connected to an
edge-triggered input on VIA2. It is theoretically possible that this
signal could fail to produce the expected VIA2 interrupt.

The two IOP interrupt flags can be asserted in any order but the logic
in iop_ism_irq() does not allow for that. In particular, INT0 can be
asserted right after INT0 is checked and before INT1 is cleared.

Such an interrupt would produce no new edge and VIA2 would detect no
further interrupts from the IOP. Avoid this by looping over the INT0/1
handlers so an edge can be produced.

Cc: Joshua Thompson <funaho@jurai.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/iop.c | 50 +++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/arch/m68k/mac/iop.c b/arch/m68k/mac/iop.c
index 9bfa17015768..100e5112fd9e 100644
--- a/arch/m68k/mac/iop.c
+++ b/arch/m68k/mac/iop.c
@@ -566,36 +566,42 @@ irqreturn_t iop_ism_irq(int irq, void *dev_id)
 	uint iop_num = (uint) dev_id;
 	volatile struct mac_iop *iop = iop_base[iop_num];
 	int i,state;
+	u8 events = iop->status_ctrl & (IOP_INT0 | IOP_INT1);
 
 	iop_pr_debug("status %02X\n", iop->status_ctrl);
 
-	/* INT0 indicates a state change on an outgoing message channel */
-
-	if (iop->status_ctrl & IOP_INT0) {
-		iop->status_ctrl = IOP_INT0 | IOP_RUN | IOP_AUTOINC;
-		iop_pr_debug("new status %02X, send states", iop->status_ctrl);
-		for (i = 0 ; i < NUM_IOP_CHAN  ; i++) {
-			state = iop_readb(iop, IOP_ADDR_SEND_STATE + i);
-			iop_pr_cont(" %02X", state);
-			if (state == IOP_MSG_COMPLETE) {
-				iop_handle_send(iop_num, i);
+	do {
+		/* INT0 indicates state change on an outgoing message channel */
+		if (events & IOP_INT0) {
+			iop->status_ctrl = IOP_INT0 | IOP_RUN | IOP_AUTOINC;
+			iop_pr_debug("new status %02X, send states",
+			             iop->status_ctrl);
+			for (i = 0; i < NUM_IOP_CHAN; i++) {
+				state = iop_readb(iop, IOP_ADDR_SEND_STATE + i);
+				iop_pr_cont(" %02X", state);
+				if (state == IOP_MSG_COMPLETE)
+					iop_handle_send(iop_num, i);
 			}
+			iop_pr_cont("\n");
 		}
-		iop_pr_cont("\n");
-	}
 
-	if (iop->status_ctrl & IOP_INT1) {	/* INT1 for incoming msgs */
-		iop->status_ctrl = IOP_INT1 | IOP_RUN | IOP_AUTOINC;
-		iop_pr_debug("new status %02X, recv states", iop->status_ctrl);
-		for (i = 0 ; i < NUM_IOP_CHAN ; i++) {
-			state = iop_readb(iop, IOP_ADDR_RECV_STATE + i);
-			iop_pr_cont(" %02X", state);
-			if (state == IOP_MSG_NEW) {
-				iop_handle_recv(iop_num, i);
+		/* INT1 for incoming messages */
+		if (events & IOP_INT1) {
+			iop->status_ctrl = IOP_INT1 | IOP_RUN | IOP_AUTOINC;
+			iop_pr_debug("new status %02X, recv states",
+			             iop->status_ctrl);
+			for (i = 0; i < NUM_IOP_CHAN; i++) {
+				state = iop_readb(iop, IOP_ADDR_RECV_STATE + i);
+				iop_pr_cont(" %02X", state);
+				if (state == IOP_MSG_NEW)
+					iop_handle_recv(iop_num, i);
 			}
+			iop_pr_cont("\n");
 		}
-		iop_pr_cont("\n");
-	}
+
+		events = iop->status_ctrl & (IOP_INT0 | IOP_INT1);
+	} while (events);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.26.2

