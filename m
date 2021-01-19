Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C7D2FADF9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 01:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732632AbhASAOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 19:14:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:49580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbhASAOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 19:14:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B766CAB9F;
        Tue, 19 Jan 2021 00:13:28 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     gregkh@linuxfoundation.org
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] usb: gadget: u_serial: Remove old tasklet comments
Date:   Mon, 18 Jan 2021 16:13:21 -0800
Message-Id: <20210119001321.127750-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update old comments as of 8b4c62aef6f (usb: gadget: u_serial: process RX
in workqueue instead of tasklet).

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/usb/gadget/function/u_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 2caccbb6e014..6d59f44ef2cd 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -346,7 +346,7 @@ __acquires(&port->port_lock)
 }
 
 /*
- * RX tasklet takes data out of the RX queue and hands it up to the TTY
+ * RX work takes data out of the RX queue and hands it up to the TTY
  * layer until it refuses to take any more data (or is throttled back).
  * Then it issues reads for any further data.
  *
@@ -709,7 +709,7 @@ static void gs_close(struct tty_struct *tty, struct file *file)
 
 	/* Iff we're disconnected, there can be no I/O in flight so it's
 	 * ok to free the circular buffer; else just scrub it.  And don't
-	 * let the push tasklet fire again until we're re-opened.
+	 * let the push async work fire again until we're re-opened.
 	 */
 	if (gser == NULL)
 		kfifo_free(&port->port_write_buf);
-- 
2.26.2

