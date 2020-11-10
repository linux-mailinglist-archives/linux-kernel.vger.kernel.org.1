Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D742AE04F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbgKJTzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731870AbgKJTys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:54:48 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500D1C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:54:48 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id y9so6265076ilb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SsdquKpb2MTdzpMvchgk/jHcbpfk/HyDtyPNBkZppjk=;
        b=R4NkmuHT4YSWsy//2JxbqyFYkO13nWHofHbrJ/kmLPPNeWj1vUqIKanquYGl8Gqb5t
         KSETTKSV9j9i/r3iGosJDNuZOEUMC/CWKjlkWGUqVU53+ySB9mitgDIIe1/VWpj+r2YE
         cd+s2qQrUc7Hm4xfOvDLwQ8eW1n92c6fNGexQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SsdquKpb2MTdzpMvchgk/jHcbpfk/HyDtyPNBkZppjk=;
        b=sGw+DzcdF0byLpCMdlWJkVlQN8xTUKrFreEEMOA/soyZ/uIKi84nTi0x/ijpGdsFoZ
         kqWx+6Trr0Zw7A07J1vOWzv5PBOcoW2JtaXQhG0/AzmkC9Ak4y69MkpE/DoiU+KXdecj
         pNJFWkSfVb7hVVDMjnz+MuQxI1weLCZgX+5SJ42Susli5bSFytXWOwIGrjZ3TVDBgXxp
         iz7ouZHxBSF4WQhG1HYKNTNWUSr60btJcEl2j2UawhRLcvgOnJhe251fllC3S2CBImaE
         VsENNdT514BhZ6Ui9zgne7d3LaPwMoqpKfINpW7jppQWdGUBYByQ/qsG2XlFItnuapeD
         N82A==
X-Gm-Message-State: AOAM532sHcWQitWDi6rDce6apJO9dSVKlShcDEzkNmS/RFV6I7zRtHSF
        KNYNQ9maELgFTqwVzGK1YmIOnw==
X-Google-Smtp-Source: ABdhPJwgxpeHOe8JZ4oOTAsIqWfrbLiVauVYbPXUR1uTEcViRspiQt+NRqNoOPJkGn0UYxJK+oXwQw==
X-Received: by 2002:a92:cb4e:: with SMTP id f14mr14322996ilq.122.1605038087718;
        Tue, 10 Nov 2020 11:54:47 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o14sm123971ilg.71.2020.11.10.11.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:54:47 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] usb: usbip/vhci: convert seqno to seqnum_ops
Date:   Tue, 10 Nov 2020 12:53:36 -0700
Message-Id: <712082d8bd92cab57865b65d853b3206c004a92c.1605027593.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605027593.git.skhan@linuxfoundation.org>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seqnum_ops api is introduced to be used when a variable is used as
a sequence/stat counter and doesn't guard object lifetimes. This
clearly differentiates atomic_t usages that guard object lifetimes.

seqnum32 variables wrap around to INT_MIN when it overflows and
should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

Convert it to use seqnum_ops. This conversion replaces inc_return()
with _inc() followed by _read().

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/usb/usbip/vhci.h     | 3 ++-
 drivers/usb/usbip/vhci_hcd.c | 9 ++++++---
 drivers/usb/usbip/vhci_rx.c  | 3 ++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/usbip/vhci.h b/drivers/usb/usbip/vhci.h
index 5659dce1526e..cb76747f423b 100644
--- a/drivers/usb/usbip/vhci.h
+++ b/drivers/usb/usbip/vhci.h
@@ -15,6 +15,7 @@
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 #include <linux/wait.h>
+#include <linux/seqnum_ops.h>
 
 struct vhci_device {
 	struct usb_device *udev;
@@ -108,7 +109,7 @@ struct vhci_hcd {
 	unsigned resuming:1;
 	unsigned long re_timeout;
 
-	atomic_t seqnum;
+	struct seqnum32 seqnum;
 
 	/*
 	 * NOTE:
diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 66cde5e5f796..0d854d9707e5 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/seqnum_ops.h>
 
 #include "usbip_common.h"
 #include "vhci.h"
@@ -665,7 +666,8 @@ static void vhci_tx_urb(struct urb *urb, struct vhci_device *vdev)
 
 	spin_lock_irqsave(&vdev->priv_lock, flags);
 
-	priv->seqnum = atomic_inc_return(&vhci_hcd->seqnum);
+	seqnum32_inc(&vhci_hcd->seqnum);
+	priv->seqnum = seqnum32_read(&vhci_hcd->seqnum);
 	if (priv->seqnum == 0xffff)
 		dev_info(&urb->dev->dev, "seqnum max\n");
 
@@ -921,7 +923,8 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 			return -ENOMEM;
 		}
 
-		unlink->seqnum = atomic_inc_return(&vhci_hcd->seqnum);
+		seqnum32_inc(&vhci_hcd->seqnum);
+		unlink->seqnum = seqnum32_read(&vhci_hcd->seqnum);
 		if (unlink->seqnum == 0xffff)
 			pr_info("seqnum max\n");
 
@@ -1181,7 +1184,7 @@ static int vhci_start(struct usb_hcd *hcd)
 		vdev->rhport = rhport;
 	}
 
-	atomic_set(&vhci_hcd->seqnum, 0);
+	seqnum32_set(&vhci_hcd->seqnum, 0);
 
 	hcd->power_budget = 0; /* no limit */
 	hcd->uses_new_polling = 1;
diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
index 266024cbb64f..0d0def7ccfee 100644
--- a/drivers/usb/usbip/vhci_rx.c
+++ b/drivers/usb/usbip/vhci_rx.c
@@ -5,6 +5,7 @@
 
 #include <linux/kthread.h>
 #include <linux/slab.h>
+#include <linux/seqnum_ops.h>
 
 #include "usbip_common.h"
 #include "vhci.h"
@@ -68,7 +69,7 @@ static void vhci_recv_ret_submit(struct vhci_device *vdev,
 	if (!urb) {
 		pr_err("cannot find a urb of seqnum %u max seqnum %d\n",
 			pdu->base.seqnum,
-			atomic_read(&vhci_hcd->seqnum));
+			seqnum32_read(&vhci_hcd->seqnum));
 		usbip_event_add(ud, VDEV_EVENT_ERROR_TCP);
 		return;
 	}
-- 
2.27.0

