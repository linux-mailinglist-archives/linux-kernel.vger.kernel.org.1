Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F4C1E947C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 01:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgE3XU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 May 2020 19:20:58 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51242 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729553AbgE3XUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 19:20:35 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 4FC8B27FE0; Sat, 30 May 2020 19:20:34 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Message-Id: <dedcdfc62f43e85cc4c2a8d211a7e2fec7bc7c1a.1590880623.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1590880623.git.fthain@telegraphics.com.au>
References: <cover.1590880623.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 6/8] macintosh/adb-iop: Implement idle -> sending state
 transition
Date:   Sun, 31 May 2020 09:17:03 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the present algorithm, the 'idle' state transition does not take
place until there's a bus timeout. Once idle, the driver does not
automatically proceed with the next request.

Change the algorithm so that queued ADB requests will be sent as soon as
the driver becomes idle. This is to take place after the current IOP
message is completed.

Cc: Joshua Thompson <funaho@jurai.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/adb-iop.c | 43 +++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index a2b28e09f2ce..f22792c95d4f 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -54,13 +54,19 @@ struct adb_driver adb_iop_driver = {
 	.reset_bus    = adb_iop_reset_bus
 };
 
-static void adb_iop_end_req(struct adb_request *req, int state)
+static void adb_iop_done(void)
 {
+	struct adb_request *req = current_req;
+
+	adb_iop_state = idle;
+
 	req->complete = 1;
 	current_req = req->next;
 	if (req->done)
 		(*req->done)(req);
-	adb_iop_state = state;
+
+	if (adb_iop_state == idle)
+		adb_iop_start();
 }
 
 /*
@@ -94,37 +100,36 @@ static void adb_iop_complete(struct iop_msg *msg)
 static void adb_iop_listen(struct iop_msg *msg)
 {
 	struct adb_iopmsg *amsg = (struct adb_iopmsg *)msg->message;
-	struct adb_request *req;
 	unsigned long flags;
+	bool req_done = false;
 
 	local_irq_save(flags);
 
-	req = current_req;
-
 	/* Handle a timeout. Timeout packets seem to occur even after
 	 * we've gotten a valid reply to a TALK, presumably because of
 	 * autopolling.
 	 */
 
-	if (amsg->flags & ADB_IOP_TIMEOUT) {
-		msg->reply[0] = ADB_IOP_TIMEOUT | ADB_IOP_AUTOPOLL;
-		msg->reply[1] = 0;
-		msg->reply[2] = 0;
-		if (req && (adb_iop_state != idle)) {
-			adb_iop_end_req(req, idle);
-		}
-	} else {
-		if ((adb_iop_state == awaiting_reply) &&
-		    (amsg->flags & ADB_IOP_EXPLICIT)) {
+	if (amsg->flags & ADB_IOP_EXPLICIT) {
+		if (adb_iop_state == awaiting_reply) {
+			struct adb_request *req = current_req;
+
 			req->reply_len = amsg->count + 1;
 			memcpy(req->reply, &amsg->cmd, req->reply_len);
-		} else {
-			adb_input(&amsg->cmd, amsg->count + 1,
-				  amsg->flags & ADB_IOP_AUTOPOLL);
+
+			req_done = true;
 		}
-		memcpy(msg->reply, msg->message, IOP_MSG_LEN);
+	} else if (!(amsg->flags & ADB_IOP_TIMEOUT)) {
+		adb_input(&amsg->cmd, amsg->count + 1,
+			  amsg->flags & ADB_IOP_AUTOPOLL);
 	}
+
+	msg->reply[0] = ADB_IOP_AUTOPOLL;
 	iop_complete_message(msg);
+
+	if (req_done)
+		adb_iop_done();
+
 	local_irq_restore(flags);
 }
 
-- 
2.26.2

