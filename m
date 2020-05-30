Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D2B1E9476
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 01:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgE3XUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 May 2020 19:20:41 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51202 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbgE3XUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 19:20:34 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 80AD027F9A; Sat, 30 May 2020 19:20:33 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Message-Id: <b63d56ecb6e75f11a0bf02231f3b2db656a528a3.1590880623.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1590880623.git.fthain@telegraphics.com.au>
References: <cover.1590880623.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 3/8] macintosh/adb-iop: Adopt bus reset algorithm from
 via-macii driver
Date:   Sun, 31 May 2020 09:17:03 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This algorithm is slightly shorter and avoids the surprising
adb_iop_start() call in adb_iop_poll().

Cc: Joshua Thompson <funaho@jurai.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/adb-iop.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index ca3b411b0742..c3089dacf2e2 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -238,24 +238,19 @@ int adb_iop_autopoll(int devs)
 
 void adb_iop_poll(void)
 {
-	if (adb_iop_state == idle)
-		adb_iop_start();
 	iop_ism_irq_poll(ADB_IOP);
 }
 
 int adb_iop_reset_bus(void)
 {
-	struct adb_request req = {
-		.reply_expected = 0,
-		.nbytes = 2,
-		.data = { ADB_PACKET, 0 },
-	};
-
-	adb_iop_write(&req);
-	while (!req.complete) {
-		adb_iop_poll();
-		schedule();
-	}
+	struct adb_request req;
+
+	/* Command = 0, Address = ignored */
+	adb_request(&req, NULL, ADBREQ_NOSEND, 1, ADB_BUSRESET);
+	adb_iop_send_request(&req, 1);
+
+	/* Don't want any more requests during the Global Reset low time. */
+	mdelay(3);
 
 	return 0;
 }
-- 
2.26.2

