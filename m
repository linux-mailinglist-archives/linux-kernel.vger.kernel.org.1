Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2302292C56
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbgJSRHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730498AbgJSRHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:07:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5309C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:07:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j136so257114wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=alpewE00yXzmI7Wi7PY5Ma42ivdK56tHgSnMNmqIKdI=;
        b=wILwX6IgS/QRLVq6y+au7F8UPimahLdD0MUritsRMgZPZe7QxTBektepkNW4nJC1Ud
         hqdWAh7+pp3jnH8nbWH9wtEqgMzhdGcEDTyPyrmXxZT2GNB5hDtP1FEpZcpF3lrIpSxo
         vnGcVYsA+uGXxVgcctK3oX84iRf+NZDgXXo84TDctnuYuPGNXeFkru+I3ZL5d0U2W7DA
         hp52U6mMyfXKzE2f9OkTZ8n/poUrORTLObezlhihdhg83hKXhzIXMO36PmjeCpoZoHcn
         Jq8XCSMcsi/xdo62pOeCQHGhRMMJepDIcnAjT02chIaUL11OYe7TVJgf70r1d6vsFg7b
         pfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=alpewE00yXzmI7Wi7PY5Ma42ivdK56tHgSnMNmqIKdI=;
        b=Ijpdoka08MvvfI3PFyOFf7CkAGJh3dlzYJzcW80X9rIo1UVFKoSkCfmKahYWs0QSYd
         bZmyA6SR3uCEMbSSR8Njj0GHYv8SyOOGuWTY7hahRbXFTB0vNYK4BRHo3NeY0oKq7WY4
         U4osqYJqBGxeDUVim9K42cyT3kytburQYShkJdqmkEy3XsdoiDcUpy/rEWwmV9Lkxswk
         kJNgBTlRx0oROrXbmur6d2XQlGfmy+7jzraS26tuxOH+/wdzJ0+0veJb5kUpjAFoZMuc
         txaEGzsDBVTppmr8ervQeAedRonbKRGz7jHVqlmoRK7crOfOfYXqEBgwgrpFnWBI1F2L
         5jIQ==
X-Gm-Message-State: AOAM532dpmgZxxjzhfM8KpuZgjtzvNFEPwFHCQtXcgfZmwXUHpb/SlFw
        RRloIjkklIVNpb0G/4ZYagC95Q==
X-Google-Smtp-Source: ABdhPJxXUESfjuL3zj5bPTCDGG2II3qWxLcfUVSBfsea8i53fj8i820FBG0svJsw5lYqPrpSxtjdIQ==
X-Received: by 2002:a1c:55c1:: with SMTP id j184mr208272wmb.180.1603127238604;
        Mon, 19 Oct 2020 10:07:18 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id p9sm242544wma.12.2020.10.19.10.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:07:17 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Pascal Vizeli <pascal.vizeli@nabucasa.com>
Subject: [PATCH] usb: cdc-acm: fix cooldown mechanism
Date:   Mon, 19 Oct 2020 19:07:02 +0200
Message-Id: <20201019170702.150534-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a4e7279cd1d1 ("cdc-acm: introduce a cool down") is causing
regression if there is some USB error, such as -EPROTO.

This has been reported on some samples of the Odroid-N2 using the Combee II
Zibgee USB dongle.

> struct acm *acm = container_of(work, struct acm, work)

is incorrect in case of a delayed work and causes warnings, usually from
the workqueue:

> WARNING: CPU: 0 PID: 0 at kernel/workqueue.c:1474 __queue_work+0x480/0x528.

When this happens, USB eventually stops working completely after a while.
Also the ACM_ERROR_DELAY bit is never set, so the cooldown mechanism
previously introduced cannot be triggered and acm_submit_read_urb() is
never called.

This changes makes the cdc-acm driver use a single delayed work, fixing the
pointer arithmetic in acm_softint() and set the ACM_ERROR_DELAY when the
cooldown mechanism appear to be needed.

Fixes: a4e7279cd1d1 ("cdc-acm: introduce a cool down")
Reported-by: Pascal Vizeli <pascal.vizeli@nabucasa.com>
Cc: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 Hi,

 I tried to fix problem introduced by
 commit a4e7279cd1d1 ("cdc-acm: introduce a cool down") while keeping the
 original intent, or at least what I understand of it.

 A plain revert of the original commit also works for me.

 drivers/usb/class/cdc-acm.c | 12 +++++-------
 drivers/usb/class/cdc-acm.h |  3 +--
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index f1a9043bdfe5..172cd2d21914 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -507,6 +507,7 @@ static void acm_read_bulk_callback(struct urb *urb)
 			"%s - cooling babbling device\n", __func__);
 		usb_mark_last_busy(acm->dev);
 		set_bit(rb->index, &acm->urbs_in_error_delay);
+		set_bit(ACM_ERROR_DELAY, &acm->flags);
 		cooldown = true;
 		break;
 	default:
@@ -532,7 +533,7 @@ static void acm_read_bulk_callback(struct urb *urb)
 
 	if (stopped || stalled || cooldown) {
 		if (stalled)
-			schedule_work(&acm->work);
+			schedule_delayed_work(&acm->dwork, 0);
 		else if (cooldown)
 			schedule_delayed_work(&acm->dwork, HZ / 2);
 		return;
@@ -562,13 +563,13 @@ static void acm_write_bulk(struct urb *urb)
 	acm_write_done(acm, wb);
 	spin_unlock_irqrestore(&acm->write_lock, flags);
 	set_bit(EVENT_TTY_WAKEUP, &acm->flags);
-	schedule_work(&acm->work);
+	schedule_delayed_work(&acm->dwork, 0);
 }
 
 static void acm_softint(struct work_struct *work)
 {
 	int i;
-	struct acm *acm = container_of(work, struct acm, work);
+	struct acm *acm = container_of(work, struct acm, dwork.work);
 
 	if (test_bit(EVENT_RX_STALL, &acm->flags)) {
 		smp_mb(); /* against acm_suspend() */
@@ -584,7 +585,7 @@ static void acm_softint(struct work_struct *work)
 	if (test_and_clear_bit(ACM_ERROR_DELAY, &acm->flags)) {
 		for (i = 0; i < acm->rx_buflimit; i++)
 			if (test_and_clear_bit(i, &acm->urbs_in_error_delay))
-					acm_submit_read_urb(acm, i, GFP_NOIO);
+				acm_submit_read_urb(acm, i, GFP_KERNEL);
 	}
 
 	if (test_and_clear_bit(EVENT_TTY_WAKEUP, &acm->flags))
@@ -1352,7 +1353,6 @@ static int acm_probe(struct usb_interface *intf,
 	acm->ctrlsize = ctrlsize;
 	acm->readsize = readsize;
 	acm->rx_buflimit = num_rx_buf;
-	INIT_WORK(&acm->work, acm_softint);
 	INIT_DELAYED_WORK(&acm->dwork, acm_softint);
 	init_waitqueue_head(&acm->wioctl);
 	spin_lock_init(&acm->write_lock);
@@ -1562,7 +1562,6 @@ static void acm_disconnect(struct usb_interface *intf)
 	}
 
 	acm_kill_urbs(acm);
-	cancel_work_sync(&acm->work);
 	cancel_delayed_work_sync(&acm->dwork);
 
 	tty_unregister_device(acm_tty_driver, acm->minor);
@@ -1605,7 +1604,6 @@ static int acm_suspend(struct usb_interface *intf, pm_message_t message)
 		return 0;
 
 	acm_kill_urbs(acm);
-	cancel_work_sync(&acm->work);
 	cancel_delayed_work_sync(&acm->dwork);
 	acm->urbs_in_error_delay = 0;
 
diff --git a/drivers/usb/class/cdc-acm.h b/drivers/usb/class/cdc-acm.h
index cd5e9d8ab237..b95ff769072e 100644
--- a/drivers/usb/class/cdc-acm.h
+++ b/drivers/usb/class/cdc-acm.h
@@ -112,8 +112,7 @@ struct acm {
 #		define ACM_ERROR_DELAY	3
 	unsigned long urbs_in_error_delay;		/* these need to be restarted after a delay */
 	struct usb_cdc_line_coding line;		/* bits, stop, parity */
-	struct work_struct work;			/* work queue entry for various purposes*/
-	struct delayed_work dwork;			/* for cool downs needed in error recovery */
+	struct delayed_work dwork;		        /* work queue entry for various purposes */
 	unsigned int ctrlin;				/* input control lines (DCD, DSR, RI, break, overruns) */
 	unsigned int ctrlout;				/* output control lines (DTR, RTS) */
 	struct async_icount iocount;			/* counters for control line changes */
-- 
2.25.4

