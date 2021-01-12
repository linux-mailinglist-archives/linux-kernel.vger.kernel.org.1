Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFB12F270F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 05:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbhALE2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 23:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730406AbhALE2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 23:28:47 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62D4C061794;
        Mon, 11 Jan 2021 20:28:06 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id iq13so819130pjb.3;
        Mon, 11 Jan 2021 20:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ED4ZTcgH+L6zZjCMNVfxWMC//gKIptz3jtsYKqnT/Lk=;
        b=o1hP0hubgQkovujeTlHJ756uTpGLM8a3tX7Oq+9Zl4FEdxbTkwYm2kvCrBl0pmjWP5
         7krNeSPYy0QPwPQWACSc4mab3Twte29MwGhye5EFJhW+Ysbo7LoUgHPsxFtOkKrC33ms
         iAPWW58ZoKs1rW6CSsEy9jaSoUq+/MRg9KyGwjq78U4d6jKnZSFffGHBTzPiRIXK8hgR
         Q/7k1AFg2sXAI+ymYECIgo+knUu0Ra2Rr+bdpxzcg1BdBYtLVhIuv23wPGro1ibyg65R
         hryiPa/TcRhMwmKP/Cdv8+NYOkeOsVH6rhmaNgspPhniSBrITyx0onGmGBgBQEvta4Jk
         Skzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ED4ZTcgH+L6zZjCMNVfxWMC//gKIptz3jtsYKqnT/Lk=;
        b=n/h+062iBC4UMs1uny9FYBiGNXe04kqBDuUBOAvwyJsK8Mrkshbe5y1t2bqilmFn7t
         cofaBO/I0EzjltfRwwwMx6GAd7bA8Zwsl1p0oFqaA2z+TgS0BpkHjB/r1m5lt+y3gd6W
         0QzomLS9dCj+aGRi1WIWSPHEHyIaEZZ6xx5tiSnAynWRrr+w0TRxTGq3eSlKoP1lXbr7
         FYzc3DMmlsJfhs/2oeuoQ9mhN3r35W++RUKMhQZwVRqqGSkEkf+0EpOoo3yLp76WqO2M
         rZfB5VKXdZ7iMAca8cOHb2RIPQHo4mxRd4MdPBOyzbth+XFFAltvbpfZfC71WOVRKCoP
         oFFA==
X-Gm-Message-State: AOAM533iBOM3AmJghe56xHHeGPGY64Wma5qVlfw1v4QNwg2HYBiO245b
        jR56QNM62vjxfYli6WZUJwNxahuXXAV7tLOsgaU=
X-Google-Smtp-Source: ABdhPJwnNaCNAb3PeaSznqZ3hRx6rxRcY2LzF2emc6mhk58YfVmlK4UvyL2zsqzY8Joc4UgozBHQlw==
X-Received: by 2002:a17:90b:8d5:: with SMTP id ds21mr2352167pjb.5.1610425685916;
        Mon, 11 Jan 2021 20:28:05 -0800 (PST)
Received: from android.asia-east2-a.c.savvy-summit-295307.internal (204.60.92.34.bc.googleusercontent.com. [34.92.60.204])
        by smtp.googlemail.com with ESMTPSA id b1sm1036174pjh.54.2021.01.11.20.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 20:28:05 -0800 (PST)
From:   Bui Quang Minh <minhquangbui99@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     oneukum@suse.de, a.darwish@linutronix.de, bigeasy@linutronix.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, minhquangbui99@gmail.com
Subject: [PATCH v3] can: mcba_usb: Fix memory leak when cancelling urb
Date:   Tue, 12 Jan 2021 04:27:55 +0000
Message-Id: <20210112042755.21421-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mcba_usb_read_bulk_callback(), when we don't resubmit or fails to
resubmit the urb, we need to deallocate the transfer buffer that is
allocated in mcba_usb_start().

On some architectures, usb_free_coherent() cannot be called in interrupt
context, create a usb_anchor to keep track of these urbs and free them
later.

Reported-by: syzbot+57281c762a3922e14dfe@syzkaller.appspotmail.com
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
v1: add memory leak fix when not resubmitting urb
v2: add memory leak fix when failing to resubmit urb
v3: remove usb_free_coherent() calls in interrupt context

 drivers/net/can/usb/mcba_usb.c | 48 +++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index df54eb7d4b36..8025db484a22 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -77,6 +77,7 @@ struct mcba_priv {
 	struct net_device *netdev;
 	struct usb_anchor tx_submitted;
 	struct usb_anchor rx_submitted;
+	struct usb_anchor urbs_cleanup;
 	struct can_berr_counter bec;
 	bool usb_ka_first_pass;
 	bool can_ka_first_pass;
@@ -220,14 +221,17 @@ static void mcba_usb_write_bulk_callback(struct urb *urb)
 {
 	struct mcba_usb_ctx *ctx = urb->context;
 	struct net_device *netdev;
+	struct mcba_priv *priv;
 
 	WARN_ON(!ctx);
 
 	netdev = ctx->priv->netdev;
+	priv = netdev_priv(netdev);
 
-	/* free up our allocated buffer */
-	usb_free_coherent(urb->dev, urb->transfer_buffer_length,
-			  urb->transfer_buffer, urb->transfer_dma);
+	/* On some architectures, usb_free_coherent() cannot be called in
+	 * interrupt context, queue the urb for later cleanup
+	 */
+	usb_anchor_urb(urb, &priv->urbs_cleanup);
 
 	if (ctx->can) {
 		if (!netif_device_present(netdev))
@@ -291,8 +295,11 @@ static netdev_tx_t mcba_usb_xmit(struct mcba_priv *priv,
 
 failed:
 	usb_unanchor_urb(urb);
-	usb_free_coherent(priv->udev, MCBA_USB_TX_BUFF_SIZE, buf,
-			  urb->transfer_dma);
+
+	/* On some architectures, usb_free_coherent() cannot be called in
+	 * interrupt context, queue the urb for later cleanup
+	 */
+	usb_anchor_urb(urb, &priv->urbs_cleanup);
 
 	if (err == -ENODEV)
 		netif_device_detach(priv->netdev);
@@ -584,7 +591,7 @@ static void mcba_usb_read_bulk_callback(struct urb *urb)
 	case -EPIPE:
 	case -EPROTO:
 	case -ESHUTDOWN:
-		return;
+		goto free;
 
 	default:
 		netdev_info(netdev, "Rx URB aborted (%d)\n", urb->status);
@@ -615,11 +622,20 @@ static void mcba_usb_read_bulk_callback(struct urb *urb)
 
 	retval = usb_submit_urb(urb, GFP_ATOMIC);
 
-	if (retval == -ENODEV)
-		netif_device_detach(netdev);
-	else if (retval)
+	if (retval < 0) {
 		netdev_err(netdev, "failed resubmitting read bulk urb: %d\n",
 			   retval);
+		if (retval == -ENODEV)
+			netif_device_detach(netdev);
+		goto free;
+	}
+
+	return;
+free:
+	/* On some architectures, usb_free_coherent() cannot be called in
+	 * interrupt context, queue the urb for later cleanup
+	 */
+	usb_anchor_urb(urb, &priv->urbs_cleanup);
 }
 
 /* Start USB device */
@@ -706,6 +722,17 @@ static int mcba_usb_open(struct net_device *netdev)
 	return 0;
 }
 
+static void mcba_urb_cleanup(struct mcba_priv *priv)
+{
+	struct urb *urb;
+
+	while ((urb = usb_get_from_anchor(&priv->urbs_cleanup))) {
+		usb_free_coherent(urb->dev, urb->transfer_buffer_length,
+				  urb->transfer_buffer, urb->transfer_dma);
+		usb_free_urb(urb);
+	}
+}
+
 static void mcba_urb_unlink(struct mcba_priv *priv)
 {
 	usb_kill_anchored_urbs(&priv->rx_submitted);
@@ -723,6 +750,7 @@ static int mcba_usb_close(struct net_device *netdev)
 
 	/* Stop polling */
 	mcba_urb_unlink(priv);
+	mcba_urb_cleanup(priv);
 
 	close_candev(netdev);
 	can_led_event(netdev, CAN_LED_EVENT_STOP);
@@ -812,6 +840,7 @@ static int mcba_usb_probe(struct usb_interface *intf,
 
 	init_usb_anchor(&priv->rx_submitted);
 	init_usb_anchor(&priv->tx_submitted);
+	init_usb_anchor(&priv->urbs_cleanup);
 
 	usb_set_intfdata(intf, priv);
 
@@ -877,6 +906,7 @@ static void mcba_usb_disconnect(struct usb_interface *intf)
 
 	unregister_candev(priv->netdev);
 	mcba_urb_unlink(priv);
+	mcba_urb_cleanup(priv);
 	free_candev(priv->netdev);
 }
 
-- 
2.17.1

