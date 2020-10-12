Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A28428BECB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404120AbgJLRJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403963AbgJLRI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:08:56 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C2BC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:08:56 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id b6so9525361wrn.17
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=GiteUeefhedmcujA7Gl+XRhg8qxQ0VOJlBmMbUTsQlA=;
        b=UQwrqnNl9bttN2st5o+e1I97Ik31gSsTuOTKKWjJwjtJdLsV6uXmL76RIk4YLIOuRD
         mG6ob4SY5zR57ce6fvfvscLHfREXGARHVhHJAMhDu5KhmgGey5v4ThO3xH19stea6i5Y
         3hfMyt0wG78qw5hnPmmsP73SlzsJ7MwjaCliEYDhsuu/tBDrkmM7fO/CadHEflBvplIm
         LItUvxoPYV6CXQZQJCA3ZVv27iZ5zZuSvfEBBtFs71cNCTzteliZc6RMR2M/a8bLhWiv
         adTWhqzet90tJ1tZF1IdRKCfz5B4K5HMqknUyX07eNqYSz+c0MTc9l4Evb5cRxyAYO9d
         V63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=GiteUeefhedmcujA7Gl+XRhg8qxQ0VOJlBmMbUTsQlA=;
        b=eZqDdVrq0PS+0hidFftQx7gjnRohQqtX0SWBpFaYmyf9xyy6pEJfwUdwVVgDofnDre
         8n+xXGG611JmAlfvLs7UQRtl4Y75w6eNYUlJSwpG8cXM6Gv3MTRsFT2Tf+U655lpu+2H
         4VoIqtajWwhfSsKCPphiZSTN1KUwF7rXcN2NT6g3K7YgQhj9hN19veusYp6KxxPzUfpH
         83syitaLKB09mxOwGC4yZLCLy90sHPF3EuW4GkXxcYDf5n/l+8JpzI6UdD9wSl3zEQFE
         6UdUgWMKnA24fF40ghDB26lUnbD4UDEfxMnuJf7LGISSb0F7OgxX4U5AlCSiSMi9LWaN
         m5tw==
X-Gm-Message-State: AOAM532qZ2XeiUemEYsUy060h04nA9gsTj0z7ZttG2VEyOsJFWiXu5H6
        NqzU1nE6Basoz/8Trc/TJpBvTeQq6t4QtWyj
X-Google-Smtp-Source: ABdhPJw8Nay4C7k703MetiSSMrQWLpB/N5fHBuREXZOnZ++6Izul9okxKMTHUt/nEdPX0Nlgup5jgsERTvGmG2hM
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c156:: with SMTP id
 z22mr2912419wmi.0.1602522534241; Mon, 12 Oct 2020 10:08:54 -0700 (PDT)
Date:   Mon, 12 Oct 2020 19:08:35 +0200
Message-Id: <c07a2deae7a75e394de272c1a33cfcc1f667af92.1602522185.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v2] kcov, usbip: collect coverage from vhci_rx_loop
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nazime Hande Harputluoglu <handeharput@gmail.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nazime Hande Harputluoglu <handeharputlu@google.com>

Add kcov_remote_start()/kcov_remote_stop() annotations to the
vhci_rx_loop() function, which is responsible for parsing USB/IP packets
coming into USB/IP client.

Since vhci_rx_loop() threads are spawned per vhci_hcd device instance, the
common kcov handle is used for kcov_remote_start()/stop() annotations
(see Documentation/dev-tools/kcov.rst for details). As the result kcov
can now be used to collect coverage from vhci_rx_loop() threads.

Signed-off-by: Nazime Hande Harputluoglu <handeharputlu@google.com>
---

Changes v1->v2:
- Fix spacing issues.
- Add ifdef CONFIG_KCOV around kcov_handle in usbip_device struct.

---
 drivers/usb/usbip/usbip_common.h |  4 ++++
 drivers/usb/usbip/vhci_rx.c      |  3 +++
 drivers/usb/usbip/vhci_sysfs.c   | 12 +++++++-----
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
index 8be857a4fa13..0906182011d6 100644
--- a/drivers/usb/usbip/usbip_common.h
+++ b/drivers/usb/usbip/usbip_common.h
@@ -277,6 +277,10 @@ struct usbip_device {
 		void (*reset)(struct usbip_device *);
 		void (*unusable)(struct usbip_device *);
 	} eh_ops;
+
+#ifdef CONFIG_KCOV
+	u64 kcov_handle;
+#endif
 };
 
 #define kthread_get_run(threadfn, data, namefmt, ...)			   \
diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
index 266024cbb64f..473f14587bd5 100644
--- a/drivers/usb/usbip/vhci_rx.c
+++ b/drivers/usb/usbip/vhci_rx.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2003-2008 Takahiro Hirofuchi
  */
 
+#include <linux/kcov.h>
 #include <linux/kthread.h>
 #include <linux/slab.h>
 
@@ -261,7 +262,9 @@ int vhci_rx_loop(void *data)
 		if (usbip_event_happened(ud))
 			break;
 
+		kcov_remote_start_common(ud->kcov_handle);
 		vhci_rx_pdu(ud);
+		kcov_remote_stop();
 	}
 
 	return 0;
diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index be37aec250c2..966f1f5cafb1 100644
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2015-2016 Nobuo Iwata
  */
 
+#include <linux/kcov.h>
 #include <linux/kthread.h>
 #include <linux/file.h>
 #include <linux/net.h>
@@ -378,11 +379,12 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 	dev_info(dev, "devid(%u) speed(%u) speed_str(%s)\n",
 		 devid, speed, usb_speed_string(speed));
 
-	vdev->devid         = devid;
-	vdev->speed         = speed;
-	vdev->ud.sockfd     = sockfd;
-	vdev->ud.tcp_socket = socket;
-	vdev->ud.status     = VDEV_ST_NOTASSIGNED;
+	vdev->devid          = devid;
+	vdev->speed          = speed;
+	vdev->ud.sockfd      = sockfd;
+	vdev->ud.tcp_socket  = socket;
+	vdev->ud.status      = VDEV_ST_NOTASSIGNED;
+	vdev->ud.kcov_handle = kcov_common_handle();
 
 	spin_unlock(&vdev->ud.lock);
 	spin_unlock_irqrestore(&vhci->lock, flags);
-- 
2.28.0.1011.ga647a8990f-goog

