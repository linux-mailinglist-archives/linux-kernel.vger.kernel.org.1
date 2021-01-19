Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE9D2FADEC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 01:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391045AbhASAKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 19:10:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:47356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731557AbhASAKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 19:10:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12CF9AAAE;
        Tue, 19 Jan 2021 00:09:41 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     gregkh@linuxfoundation.org
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] usb: xhci: Replace tasklet with work
Date:   Mon, 18 Jan 2021 16:09:30 -0800
Message-Id: <20210119000930.127469-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tasklets have long been deprecated as being too heavy on the system
by running in irq context - and this is not a performance critical
path. If a higher priority process wants to run, it must wait for
the tasklet to finish before doing so.

dbc_rx_push() will now run in process context and have further
concurrency - tasklets being serialized among themselves, but this
is done holding the port_lock, so it should be fine.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/usb/host/xhci-dbgcap.h |  2 +-
 drivers/usb/host/xhci-dbgtty.c | 19 +++++++++++--------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.h b/drivers/usb/host/xhci-dbgcap.h
index c70b78d504eb..aec66009af51 100644
--- a/drivers/usb/host/xhci-dbgcap.h
+++ b/drivers/usb/host/xhci-dbgcap.h
@@ -104,7 +104,7 @@ struct dbc_port {
 	struct list_head		read_pool;
 	struct list_head		read_queue;
 	unsigned int			n_read;
-	struct tasklet_struct		push;
+	struct work_struct		push;
 
 	struct list_head		write_pool;
 	struct kfifo			write_fifo;
diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index ae4e4ab638b5..50da77d92cf6 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -108,7 +108,7 @@ dbc_read_complete(struct xhci_dbc *dbc, struct dbc_request *req)
 
 	spin_lock_irqsave(&port->port_lock, flags);
 	list_add_tail(&req->list_pool, &port->read_queue);
-	tasklet_schedule(&port->push);
+	schedule_work(&port->push);
 	spin_unlock_irqrestore(&port->port_lock, flags);
 }
 
@@ -272,7 +272,7 @@ static void dbc_tty_unthrottle(struct tty_struct *tty)
 	unsigned long		flags;
 
 	spin_lock_irqsave(&port->port_lock, flags);
-	tasklet_schedule(&port->push);
+	schedule_work(&port->push);
 	spin_unlock_irqrestore(&port->port_lock, flags);
 }
 
@@ -288,15 +288,18 @@ static const struct tty_operations dbc_tty_ops = {
 	.unthrottle		= dbc_tty_unthrottle,
 };
 
-static void dbc_rx_push(struct tasklet_struct *t)
+static void dbc_rx_push(struct work_struct *work)
 {
 	struct dbc_request	*req;
 	struct tty_struct	*tty;
 	unsigned long		flags;
 	bool			do_push = false;
 	bool			disconnect = false;
-	struct dbc_port		*port = from_tasklet(port, t, push);
-	struct list_head	*queue = &port->read_queue;
+	struct dbc_port		*port;
+	struct list_head	*queue;
+
+	port = container_of(work, struct dbc_port, push);
+	queue = &port->read_queue;
 
 	spin_lock_irqsave(&port->port_lock, flags);
 	tty = port->port.tty;
@@ -349,7 +352,7 @@ static void dbc_rx_push(struct tasklet_struct *t)
 	if (!list_empty(queue) && tty) {
 		if (!tty_throttled(tty)) {
 			if (do_push)
-				tasklet_schedule(&port->push);
+				schedule_work(&port->push);
 			else
 				pr_warn("ttyDBC0: RX not scheduled?\n");
 		}
@@ -382,7 +385,7 @@ xhci_dbc_tty_init_port(struct xhci_dbc *dbc, struct dbc_port *port)
 {
 	tty_port_init(&port->port);
 	spin_lock_init(&port->port_lock);
-	tasklet_setup(&port->push, dbc_rx_push);
+	INIT_WORK(&port->push, dbc_rx_push);
 	INIT_LIST_HEAD(&port->read_pool);
 	INIT_LIST_HEAD(&port->read_queue);
 	INIT_LIST_HEAD(&port->write_pool);
@@ -394,7 +397,7 @@ xhci_dbc_tty_init_port(struct xhci_dbc *dbc, struct dbc_port *port)
 static void
 xhci_dbc_tty_exit_port(struct dbc_port *port)
 {
-	tasklet_kill(&port->push);
+	cancel_work_sync(&port->push);
 	tty_port_destroy(&port->port);
 }
 
-- 
2.26.2

