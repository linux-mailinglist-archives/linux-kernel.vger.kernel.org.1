Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EDF2BA18A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 05:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgKTEvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 23:51:52 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52758 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgKTEvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 23:51:38 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 508152A45D; Thu, 19 Nov 2020 23:51:37 -0500 (EST)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Joshua Thompson" <funaho@jurai.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-Id: <0f0a25855391e7eaa53a50f651aea0124e8525dd.1605847196.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] macintosh/adb-iop: Always wait for reply message from IOP
Date:   Fri, 20 Nov 2020 15:39:56 +1100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent patch incorrectly altered the adb-iop state machine behaviour
and introduced a regression that can appear intermittently as a
malfunctioning ADB input device. This seems to be caused when reply
packets from different ADB commands become mixed up, especially during
the adb bus scan. Fix this by unconditionally entering the awaiting_reply
state after sending an explicit command, even when the ADB command won't
generate a reply from the ADB device.

Cc: Joshua Thompson <funaho@jurai.org>
Fixes: e2954e5f727f ("macintosh/adb-iop: Implement sending -> idle state transition")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/adb-iop.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index 6b26b6a2c463..0ee327249150 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -84,10 +84,7 @@ static void adb_iop_complete(struct iop_msg *msg)
 
 	local_irq_save(flags);
 
-	if (current_req->reply_expected)
-		adb_iop_state = awaiting_reply;
-	else
-		adb_iop_done();
+	adb_iop_state = awaiting_reply;
 
 	local_irq_restore(flags);
 }
@@ -95,8 +92,9 @@ static void adb_iop_complete(struct iop_msg *msg)
 /*
  * Listen for ADB messages from the IOP.
  *
- * This will be called when unsolicited messages (usually replies to TALK
- * commands or autopoll packets) are received.
+ * This will be called when unsolicited IOP messages are received.
+ * These IOP messages can carry ADB autopoll responses and also occur
+ * after explicit ADB commands.
  */
 
 static void adb_iop_listen(struct iop_msg *msg)
@@ -123,8 +121,10 @@ static void adb_iop_listen(struct iop_msg *msg)
 		if (adb_iop_state == awaiting_reply) {
 			struct adb_request *req = current_req;
 
-			req->reply_len = amsg->count + 1;
-			memcpy(req->reply, &amsg->cmd, req->reply_len);
+			if (req->reply_expected) {
+				req->reply_len = amsg->count + 1;
+				memcpy(req->reply, &amsg->cmd, req->reply_len);
+			}
 
 			req_done = true;
 		}
-- 
2.26.2

