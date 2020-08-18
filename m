Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E732C248489
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 14:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgHRMLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 08:11:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:58734 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgHRMKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:10:09 -0400
IronPort-SDR: wHnB+quMXCyXi0rYu4gAveQmKzhR5x1WSu05Xy55vK24GoqwiUCHUbDYwLXofhJOy/HKEK3swL
 SI1p3sj96nKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="219200384"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="219200384"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 05:10:09 -0700
IronPort-SDR: mWcomqd/MJXA17hLifkgLjB6L8E+ZtGL6e6jrDZQNAujzcQrRjUooBTOsJjTOnmM0y/zDPOYXV
 61pIdopim6vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="326712996"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2020 05:10:07 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 06/13] mei: add a spin lock to protect rd_completed queue
Date:   Tue, 18 Aug 2020 14:51:40 +0300
Message-Id: <20200818115147.2567012-7-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200818115147.2567012-1-tomas.winkler@intel.com>
References: <20200818115147.2567012-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

In order to support vtags we need to access read completed
queue out of driver big lock.
Add a spin lock to protect rd_completed queue.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus.c     |  6 ++---
 drivers/misc/mei/client.c  | 47 +++++++++++++++++++++++++++++++++-----
 drivers/misc/mei/client.h  |  7 ++++--
 drivers/misc/mei/main.c    |  6 ++---
 drivers/misc/mei/mei_dev.h |  2 ++
 5 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 2e7ac53a4152..fc20a0da5c24 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -152,7 +152,7 @@ ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length,
 		if (timeout) {
 			rets = wait_event_interruptible_timeout
 					(cl->rx_wait,
-					(!list_empty(&cl->rd_completed)) ||
+					mei_cl_read_cb(cl, NULL) ||
 					(!mei_cl_is_connected(cl)),
 					msecs_to_jiffies(timeout));
 			if (rets == 0)
@@ -165,7 +165,7 @@ ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length,
 		} else {
 			if (wait_event_interruptible
 					(cl->rx_wait,
-					(!list_empty(&cl->rd_completed)) ||
+					mei_cl_read_cb(cl, NULL) ||
 					(!mei_cl_is_connected(cl)))) {
 				if (signal_pending(current))
 					return -EINTR;
@@ -198,7 +198,7 @@ ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length,
 	rets = r_length;
 
 free:
-	mei_io_cb_free(cb);
+	mei_cl_del_rd_completed(cl, cb);
 out:
 	mutex_unlock(&bus->device_lock);
 
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index a52799590dc7..276021f99666 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -507,15 +507,19 @@ struct mei_cl_cb *mei_cl_enqueue_ctrl_wr_cb(struct mei_cl *cl, size_t length,
  *
  * Return: cb on success, NULL if cb is not found
  */
-struct mei_cl_cb *mei_cl_read_cb(const struct mei_cl *cl, const struct file *fp)
+struct mei_cl_cb *mei_cl_read_cb(struct mei_cl *cl, const struct file *fp)
 {
 	struct mei_cl_cb *cb;
+	struct mei_cl_cb *ret_cb = NULL;
 
+	spin_lock(&cl->rd_completed_lock);
 	list_for_each_entry(cb, &cl->rd_completed, list)
-		if (!fp || fp == cb->fp)
-			return cb;
-
-	return NULL;
+		if (!fp || fp == cb->fp) {
+			ret_cb = cb;
+			break;
+		}
+	spin_unlock(&cl->rd_completed_lock);
+	return ret_cb;
 }
 
 /**
@@ -541,7 +545,9 @@ int mei_cl_flush_queues(struct mei_cl *cl, const struct file *fp)
 	mei_io_list_flush_cl(&cl->dev->ctrl_wr_list, cl);
 	mei_io_list_flush_cl(&cl->dev->ctrl_rd_list, cl);
 	mei_io_list_free_fp(&cl->rd_pending, fp);
+	spin_lock(&cl->rd_completed_lock);
 	mei_io_list_free_fp(&cl->rd_completed, fp);
+	spin_unlock(&cl->rd_completed_lock);
 
 	return 0;
 }
@@ -559,6 +565,7 @@ static void mei_cl_init(struct mei_cl *cl, struct mei_device *dev)
 	init_waitqueue_head(&cl->rx_wait);
 	init_waitqueue_head(&cl->tx_wait);
 	init_waitqueue_head(&cl->ev_wait);
+	spin_lock_init(&cl->rd_completed_lock);
 	INIT_LIST_HEAD(&cl->rd_completed);
 	INIT_LIST_HEAD(&cl->rd_pending);
 	INIT_LIST_HEAD(&cl->link);
@@ -1230,6 +1237,34 @@ static int mei_cl_tx_flow_ctrl_creds_reduce(struct mei_cl *cl)
 	return 0;
 }
 
+/**
+ * mei_cl_add_rd_completed - add read completed callback to list with lock
+ *
+ * @cl: host client
+ * @cb: callback block
+ *
+ */
+void mei_cl_add_rd_completed(struct mei_cl *cl, struct mei_cl_cb *cb)
+{
+	spin_lock(&cl->rd_completed_lock);
+	list_add_tail(&cb->list, &cl->rd_completed);
+	spin_unlock(&cl->rd_completed_lock);
+}
+
+/**
+ * mei_cl_del_rd_completed - free read completed callback with lock
+ *
+ * @cl: host client
+ * @cb: callback block
+ *
+ */
+void mei_cl_del_rd_completed(struct mei_cl *cl, struct mei_cl_cb *cb)
+{
+	spin_lock(&cl->rd_completed_lock);
+	mei_io_cb_free(cb);
+	spin_unlock(&cl->rd_completed_lock);
+}
+
 /**
  *  mei_cl_notify_fop2req - convert fop to proper request
  *
@@ -1897,7 +1932,7 @@ void mei_cl_complete(struct mei_cl *cl, struct mei_cl_cb *cb)
 		break;
 
 	case MEI_FOP_READ:
-		list_add_tail(&cb->list, &cl->rd_completed);
+		mei_cl_add_rd_completed(cl, cb);
 		if (!mei_cl_is_fixed_address(cl) &&
 		    !WARN_ON(!cl->rx_flow_ctrl_creds))
 			cl->rx_flow_ctrl_creds--;
diff --git a/drivers/misc/mei/client.h b/drivers/misc/mei/client.h
index 0d0f36373a4b..bd57c64f6c1a 100644
--- a/drivers/misc/mei/client.h
+++ b/drivers/misc/mei/client.h
@@ -133,8 +133,11 @@ int mei_cl_unlink(struct mei_cl *cl);
 
 struct mei_cl *mei_cl_alloc_linked(struct mei_device *dev);
 
-struct mei_cl_cb *mei_cl_read_cb(const struct mei_cl *cl,
-				 const struct file *fp);
+struct mei_cl_cb *mei_cl_read_cb(struct mei_cl *cl, const struct file *fp);
+
+void mei_cl_add_rd_completed(struct mei_cl *cl, struct mei_cl_cb *cb);
+void mei_cl_del_rd_completed(struct mei_cl *cl, struct mei_cl_cb *cb);
+
 struct mei_cl_cb *mei_cl_alloc_cb(struct mei_cl *cl, size_t length,
 				  enum mei_cb_file_ops type,
 				  const struct file *fp);
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 86ef5c1a7928..441bdea4d4c1 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -178,7 +178,7 @@ static ssize_t mei_read(struct file *file, char __user *ubuf,
 
 	mutex_unlock(&dev->device_lock);
 	if (wait_event_interruptible(cl->rx_wait,
-				     !list_empty(&cl->rd_completed) ||
+				     mei_cl_read_cb(cl, file) ||
 				     !mei_cl_is_connected(cl))) {
 		if (signal_pending(current))
 			return -EINTR;
@@ -229,7 +229,7 @@ static ssize_t mei_read(struct file *file, char __user *ubuf,
 		goto out;
 
 free:
-	mei_io_cb_free(cb);
+	mei_cl_del_rd_completed(cl, cb);
 	*offset = 0;
 
 out:
@@ -572,7 +572,7 @@ static __poll_t mei_poll(struct file *file, poll_table *wait)
 	if (req_events & (EPOLLIN | EPOLLRDNORM)) {
 		poll_wait(file, &cl->rx_wait, wait);
 
-		if (!list_empty(&cl->rd_completed))
+		if (mei_cl_read_cb(cl, file))
 			mask |= EPOLLIN | EPOLLRDNORM;
 		else
 			mei_cl_read_start(cl, mei_cl_mtu(cl), file);
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index fefa5b53a6d0..1219edea3243 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -217,6 +217,7 @@ struct mei_cl_cb {
  * @tx_cb_queued: number of tx callbacks in queue
  * @writing_state: state of the tx
  * @rd_pending: pending read credits
+ * @rd_completed_lock: protects rd_completed queue
  * @rd_completed: completed read
  *
  * @cldev: device on the mei client bus
@@ -242,6 +243,7 @@ struct mei_cl {
 	u8 tx_cb_queued;
 	enum mei_file_transaction_states writing_state;
 	struct list_head rd_pending;
+	spinlock_t rd_completed_lock; /* protects rd_completed queue */
 	struct list_head rd_completed;
 
 	struct mei_cl_device *cldev;
-- 
2.25.4

