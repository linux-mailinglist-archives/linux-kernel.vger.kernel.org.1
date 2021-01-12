Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49122F29FF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405355AbhALI2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:28:34 -0500
Received: from ptr.189.cn ([183.61.185.104]:11124 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbhALI2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:28:33 -0500
HMM_SOURCE_IP: 10.64.10.46:49010.1823646948
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.10.46])
        by 189.cn (HERMES) with SMTP id C3ABF100AFB;
        Tue, 12 Jan 2021 16:25:32 +0800 (CST)
Received: from  ([10.64.8.34])
        by gateway-151646-dep-54888d799-2jgfg with ESMTP id 2ec5775e536145798a0befc194f7c49b for greg@kroah.com;
        Tue Jan 12 16:25:33 2021
X-Transaction-ID: 2ec5775e536145798a0befc194f7c49b
X-filter-score: 
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 10.64.8.34
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     greg@kroah.com, linux-kernel@vger.kernel.org, jkc@redhat.com,
        sparmaintainer@unisys.com
Cc:     Song Chen <chensong_2000@189.cn>
Subject: [PATCH] staging: unisys: visornic: enhance visornic to use channel_interrupt
Date:   Tue, 12 Jan 2021 16:25:40 +0800
Message-Id: <1610439940-5590-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

visornic uses timer to check the response queue and drain
it if needed periodically. On the other hand, visorbus
provides periodic work to serve such request, therefore,
timer should be replaced by channel_interrupt.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 drivers/staging/unisys/visornic/visornic_main.c | 32 +++++++++----------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/unisys/visornic/visornic_main.c b/drivers/staging/unisys/visornic/visornic_main.c
index 0433536..09d86156 100644
--- a/drivers/staging/unisys/visornic/visornic_main.c
+++ b/drivers/staging/unisys/visornic/visornic_main.c
@@ -122,7 +122,6 @@ struct chanstat {
  * @n_rcv_packets_not_accepted:     # bogs rcv packets.
  * @queuefullmsg_logged:
  * @struct chstat:
- * @struct irq_poll_timer:
  * @struct napi:
  * @struct cmdrsp:
  */
@@ -183,7 +182,6 @@ struct visornic_devdata {
 
 	int queuefullmsg_logged;
 	struct chanstat chstat;
-	struct timer_list irq_poll_timer;
 	struct napi_struct napi;
 	struct uiscmdrsp cmdrsp[SIZEOF_CMDRSP];
 };
@@ -341,7 +339,7 @@ static void visornic_serverdown_complete(struct visornic_devdata *devdata)
 	struct net_device *netdev = devdata->netdev;
 
 	/* Stop polling for interrupts */
-	del_timer_sync(&devdata->irq_poll_timer);
+	visorbus_disable_channel_interrupts(devdata->dev);
 
 	rtnl_lock();
 	dev_close(netdev);
@@ -1749,17 +1747,17 @@ static int visornic_poll(struct napi_struct *napi, int budget)
 	return rx_count;
 }
 
-/* poll_for_irq	- checks the status of the response queue
- * @t: pointer to the 'struct timer_list' from which we can retrieve the
- *     the visornic devdata struct.
+/* visornic_channel_interrupt	- checks the status of the response queue
  *
  * Main function of the vnic_incoming thread. Periodically check the response
  * queue and drain it if needed.
  */
-static void poll_for_irq(struct timer_list *t)
+static void visornic_channel_interrupt(struct visor_device *dev)
 {
-	struct visornic_devdata *devdata = from_timer(devdata, t,
-						      irq_poll_timer);
+	struct visornic_devdata *devdata = dev_get_drvdata(&dev->device);
+
+	if (!devdata)
+		return;
 
 	if (!visorchannel_signalempty(
 				   devdata->dev->visorchannel,
@@ -1768,7 +1766,6 @@ static void poll_for_irq(struct timer_list *t)
 
 	atomic_set(&devdata->interrupt_rcvd, 0);
 
-	mod_timer(&devdata->irq_poll_timer, msecs_to_jiffies(2));
 }
 
 /* visornic_probe - probe function for visornic devices
@@ -1890,13 +1887,6 @@ static int visornic_probe(struct visor_device *dev)
 	/* Let's start our threads to get responses */
 	netif_napi_add(netdev, &devdata->napi, visornic_poll, NAPI_WEIGHT);
 
-	timer_setup(&devdata->irq_poll_timer, poll_for_irq, 0);
-	/* Note: This time has to start running before the while
-	 * loop below because the napi routine is responsible for
-	 * setting enab_dis_acked
-	 */
-	mod_timer(&devdata->irq_poll_timer, msecs_to_jiffies(2));
-
 	channel_offset = offsetof(struct visor_io_channel,
 				  channel_header.features);
 	err = visorbus_read_channel(dev, channel_offset, &features, 8);
@@ -1949,7 +1939,7 @@ static int visornic_probe(struct visor_device *dev)
 	unregister_netdev(netdev);
 
 cleanup_napi_add:
-	del_timer_sync(&devdata->irq_poll_timer);
+	visorbus_disable_channel_interrupts(dev);
 	netif_napi_del(&devdata->napi);
 
 cleanup_xmit_cmdrsp:
@@ -2017,7 +2007,7 @@ static void visornic_remove(struct visor_device *dev)
 	/* this will call visornic_close() */
 	unregister_netdev(netdev);
 
-	del_timer_sync(&devdata->irq_poll_timer);
+	visorbus_disable_channel_interrupts(devdata->dev);
 	netif_napi_del(&devdata->napi);
 
 	dev_set_drvdata(&dev->device, NULL);
@@ -2091,7 +2081,7 @@ static int visornic_resume(struct visor_device *dev,
 	 * we can start using the device again.
 	 * TODO: State transitions
 	 */
-	mod_timer(&devdata->irq_poll_timer, msecs_to_jiffies(2));
+	visorbus_enable_channel_interrupts(dev);
 
 	rtnl_lock();
 	dev_open(netdev, NULL);
@@ -2113,7 +2103,7 @@ static struct visor_driver visornic_driver = {
 	.remove = visornic_remove,
 	.pause = visornic_pause,
 	.resume = visornic_resume,
-	.channel_interrupt = NULL,
+	.channel_interrupt = visornic_channel_interrupt,
 };
 
 /* visornic_init - init function
-- 
2.7.4

