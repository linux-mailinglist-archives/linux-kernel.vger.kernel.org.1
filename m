Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A04D2EBB8D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 10:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbhAFJHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 04:07:19 -0500
Received: from ptr.189.cn ([183.61.185.104]:11122 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726301AbhAFJHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:07:10 -0500
HMM_SOURCE_IP: 10.64.10.37:53476.2129512322
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.10.37])
        by 189.cn (HERMES) with SMTP id 1DF7C100785;
        Wed,  6 Jan 2021 17:04:15 +0800 (CST)
Received: from  ([10.64.8.34])
        by gateway-151646-dep-54888d799-th9t2 with ESMTP id 1cf8cf80e2d742e289891543a81b04e9 for greg@kroah.com;
        Wed Jan  6 17:04:16 2021
X-Transaction-ID: 1cf8cf80e2d742e289891543a81b04e9
X-filter-score: 
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 10.64.8.34
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     greg@kroah.com, linux-kernel@vger.kernel.org, jkc@redhat.com,
        sparmaintainer@unisys.com
Cc:     Song Chen <chensong_2000@189.cn>
Subject: [PATCH] staging: unisys: visorhba: enhance visorhba to use channel_interrupt
Date:   Wed,  6 Jan 2021 17:04:23 +0800
Message-Id: <1609923863-6650-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

visorhba uses kthread to obtain the responses from the IO
Service Partition periodically, on the other hand, visorbus
provides periodic work to serve such request, therefore,
kthread should be replaced by channel_interrupt.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 drivers/staging/unisys/visorhba/visorhba_main.c | 90 +++++--------------------
 1 file changed, 16 insertions(+), 74 deletions(-)

diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c b/drivers/staging/unisys/visorhba/visorhba_main.c
index 7ae5306..4455d26 100644
--- a/drivers/staging/unisys/visorhba/visorhba_main.c
+++ b/drivers/staging/unisys/visorhba/visorhba_main.c
@@ -74,14 +74,10 @@ struct visorhba_devdata {
 	unsigned long long interrupts_notme;
 	unsigned long long interrupts_disabled;
 	u64 __iomem *flags_addr;
-	atomic_t interrupt_rcvd;
-	wait_queue_head_t rsp_queue;
 	struct visordisk_info head;
 	unsigned int max_buff_len;
 	int devnum;
-	struct task_struct *thread;
-	int thread_wait_ms;
-
+	struct uiscmdrsp *cmdrsp;
 	/*
 	 * allows us to pass int handles back-and-forth between us and
 	 * iovm, instead of raw pointers
@@ -97,39 +93,6 @@ struct visorhba_devices_open {
 };
 
 /*
- * visor_thread_start - Starts a thread for the device
- * @threadfn:   Function the thread starts
- * @thrcontext: Context to pass to the thread, i.e. devdata
- * @name:	String describing name of thread
- *
- * Starts a thread for the device.
- *
- * Return: The task_struct * denoting the thread on success,
- *	   or NULL on failure
- */
-static struct task_struct *visor_thread_start(int (*threadfn)(void *),
-					      void *thrcontext, char *name)
-{
-	struct task_struct *task;
-
-	task = kthread_run(threadfn, thrcontext, "%s", name);
-	if (IS_ERR(task)) {
-		pr_err("visorbus failed to start thread\n");
-		return NULL;
-	}
-	return task;
-}
-
-/*
- * visor_thread_stop - Stops the thread if it is running
- * @task: Description of process to stop
- */
-static void visor_thread_stop(struct task_struct *task)
-{
-	kthread_stop(task);
-}
-
-/*
  * add_scsipending_entry - Save off io command that is pending in
  *			   Service Partition
  * @devdata: Pointer to devdata
@@ -730,7 +693,7 @@ static void visorhba_serverdown_complete(struct visorhba_devdata *devdata)
 	/* Stop using the IOVM response queue (queue should be drained
 	 * by the end)
 	 */
-	visor_thread_stop(devdata->thread);
+	visorbus_disable_channel_interrupts(devdata->dev);
 
 	/* Fail commands that weren't completed */
 	spin_lock_irqsave(&devdata->privlock, flags);
@@ -952,37 +915,18 @@ static void drain_queue(struct uiscmdrsp *cmdrsp,
 }
 
 /*
- * process_incoming_rsps - Process responses from IOSP
- * @v:  Void pointer to visorhba_devdata
- *
- * Main function for the thread that processes the responses
- * from the IO Service Partition. When the queue is empty, wait
- * to check to see if it is full again.
- *
- * Return: 0 on success, -ENOMEM on failure
+ * This is used only when this driver is active as an hba driver in the
+ * client guest partition.  It is called periodically so we can obtain
+ * and process the command respond from the IO Service Partition periodically.
  */
-static int process_incoming_rsps(void *v)
+static void visorhba_channel_interrupt(struct visor_device *dev)
 {
-	struct visorhba_devdata *devdata = v;
-	struct uiscmdrsp *cmdrsp = NULL;
-	const int size = sizeof(*cmdrsp);
+	struct visorhba_devdata *devdata = dev_get_drvdata(&dev->device);
 
-	cmdrsp = kmalloc(size, GFP_ATOMIC);
-	if (!cmdrsp)
-		return -ENOMEM;
+	if (!devdata)
+		return;
 
-	while (1) {
-		if (kthread_should_stop())
-			break;
-		wait_event_interruptible_timeout(
-			devdata->rsp_queue, (atomic_read(
-					     &devdata->interrupt_rcvd) == 1),
-				msecs_to_jiffies(devdata->thread_wait_ms));
-		/* drain queue */
-		drain_queue(cmdrsp, devdata);
-	}
-	kfree(cmdrsp);
-	return 0;
+	drain_queue(devdata->cmdrsp, devdata);
 }
 
 /*
@@ -1028,8 +972,7 @@ static int visorhba_resume(struct visor_device *dev,
 	if (devdata->serverdown && !devdata->serverchangingstate)
 		devdata->serverchangingstate = true;
 
-	devdata->thread = visor_thread_start(process_incoming_rsps, devdata,
-					     "vhba_incming");
+	visorbus_enable_channel_interrupts(dev);
 	devdata->serverdown = false;
 	devdata->serverchangingstate = false;
 
@@ -1095,7 +1038,6 @@ static int visorhba_probe(struct visor_device *dev)
 		goto err_debugfs_dir;
 	}
 
-	init_waitqueue_head(&devdata->rsp_queue);
 	spin_lock_init(&devdata->privlock);
 	devdata->serverdown = false;
 	devdata->serverchangingstate = false;
@@ -1113,9 +1055,8 @@ static int visorhba_probe(struct visor_device *dev)
 
 	idr_init(&devdata->idr);
 
-	devdata->thread_wait_ms = 2;
-	devdata->thread = visor_thread_start(process_incoming_rsps, devdata,
-					     "vhba_incoming");
+	devdata->cmdrsp = kmalloc(sizeof(*devdata->cmdrsp), GFP_ATOMIC);
+	visorbus_enable_channel_interrupts(dev);
 
 	scsi_scan_host(scsihost);
 
@@ -1150,7 +1091,8 @@ static void visorhba_remove(struct visor_device *dev)
 		return;
 
 	scsihost = devdata->scsihost;
-	visor_thread_stop(devdata->thread);
+	kfree(devdata->cmdrsp);
+	visorbus_disable_channel_interrupts(dev);
 	scsi_remove_host(scsihost);
 	scsi_host_put(scsihost);
 
@@ -1173,7 +1115,7 @@ static struct visor_driver visorhba_driver = {
 	.remove = visorhba_remove,
 	.pause = visorhba_pause,
 	.resume = visorhba_resume,
-	.channel_interrupt = NULL,
+	.channel_interrupt = visorhba_channel_interrupt,
 };
 
 /*
-- 
2.7.4

