Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7460290AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390564AbgJPRa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731737AbgJPRaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:30:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA73C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 10:30:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id j8so1888319pjy.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 10:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LkpxYpHOUh6wWOIUN82AjP6Fw85m2v3htFNaqQxO/5A=;
        b=lroJG7Sa2/n+Pm3E/imxwkcvy1qhI24bxdO7S3msAaNvwtM7v7F1m6eZvIiuLQMyOG
         CJbnu11Yt9R/hTlpc0HNsmBFgYCQYYiEDbKglUhRQtBoZuN6YKwdv91XZ0gDvxAgzEsc
         qLxfLbsyFPMoOKFw2i0kQ7G2FLR3f2cI0LlYtfDg5rsX1nCV2e8Oj1jpa8N0X4N/+bpL
         e1QEG24lkO1XtKO9AqRqSCms7cTOLaRsaGkzUscSYf7iVos24lBmy6UJXo3FFjIWbzb+
         8TfsZX3jv3F2lszHO1HMWsphZq906YxkPoGulGWPxDCPVFDz3q4YYYd6HG2WeXEYvVXz
         EqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LkpxYpHOUh6wWOIUN82AjP6Fw85m2v3htFNaqQxO/5A=;
        b=Pm4jRJ4syDpiu5eCDethxeL0xf2V7PXTbdWVI66c13QomDeqvMUuQR6jVjC52iq0CR
         G8pXLpEeCjlx0zZbT2YnvnjXmF87j5YACWytXjjD7AoSf7wVtTAH7oE2sreHPHuF09uJ
         I3xRdbZz0RDLzSx1olpBe9LHeUr0rUqm9LPaA8tiOhVO5ZY1WVm7NFnmJbZII4vhN34e
         KBEjTyaP0jY6NKrsfUbtV1ShwPCg1843rXjFUY4f6blolCFQpX9uNb3JN9kKaO5E0iA3
         v6ZcPTEqXSRJ47Tw+d3/iAGUVlpcH1ltT+VhGp//TQ3DoEoFJ/nQhZapkQt19dnoXVhR
         Q2Xw==
X-Gm-Message-State: AOAM530HlLA7NXE2tqahRQNBgjctkUkkuYIK7l5tE1p9U1UDVR9lz7Ur
        g2benESC+U99qYqWVSccNBXSn3z7U2g=
X-Google-Smtp-Source: ABdhPJwclqbg+gtWSGEcRJ5TA2g06LpmhR3sr00rrCicZcy6R7gm/FKrjktQ24YJCgeBfuHf8an+Ug==
X-Received: by 2002:a17:90a:dc0c:: with SMTP id i12mr5346362pjv.191.1602869425011;
        Fri, 16 Oct 2020 10:30:25 -0700 (PDT)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id nh4sm3668126pjb.1.2020.10.16.10.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 10:30:24 -0700 (PDT)
From:   jassisinghbrar@gmail.com
To:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     jbrunet@baylibre.com, ionela.voinescu@arm.com,
        khilman@baylibre.com, da@libre.computer, sudeep.holla@arm.com,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH] mailbox: avoid timer start from callback
Date:   Fri, 16 Oct 2020 12:30:20 -0500
Message-Id: <20201016173020.12686-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

If the txdone is done by polling, it is possible for msg_submit() to start
the timer while txdone_hrtimer() callback is running. If the timer needs
recheduling, it could already be enqueued by the time hrtimer_forward_now()
is called, leading hrtimer to loudly complain.

WARNING: CPU: 3 PID: 74 at kernel/time/hrtimer.c:932 hrtimer_forward+0xc4/0x110
CPU: 3 PID: 74 Comm: kworker/u8:1 Not tainted 5.9.0-rc2-00236-gd3520067d01c-dirty #5
Hardware name: Libre Computer AML-S805X-AC (DT)
Workqueue: events_freezable_power_ thermal_zone_device_check
pstate: 20000085 (nzCv daIf -PAN -UAO BTYPE=--)
pc : hrtimer_forward+0xc4/0x110
lr : txdone_hrtimer+0xf8/0x118
[...]

This can be fixed by not starting the timer from the callback path. Which
requires the timer reloading as long as any message is queued on the
channel, and not just when current tx is not done yet.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 drivers/mailbox/mailbox.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 0b821a5b2db8..a093a6ecaa66 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -82,9 +82,12 @@ static void msg_submit(struct mbox_chan *chan)
 exit:
 	spin_unlock_irqrestore(&chan->lock, flags);
 
-	if (!err && (chan->txdone_method & TXDONE_BY_POLL))
-		/* kick start the timer immediately to avoid delays */
-		hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
+	/* kick start the timer immediately to avoid delays */
+	if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
+		/* but only if not already active */
+		if (!hrtimer_active(&chan->mbox->poll_hrt))
+			hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
+	}
 }
 
 static void tx_tick(struct mbox_chan *chan, int r)
@@ -122,11 +125,10 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
 		struct mbox_chan *chan = &mbox->chans[i];
 
 		if (chan->active_req && chan->cl) {
+			resched = true;
 			txdone = chan->mbox->ops->last_tx_done(chan);
 			if (txdone)
 				tx_tick(chan, 0);
-			else
-				resched = true;
 		}
 	}
 
-- 
2.25.1

