Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA27B2C199A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgKWXvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 18:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbgKWXvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:51:06 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EC0C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:51:04 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id j35so865980qtb.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=53LKNClv9WjrnexN7IY+lrSioJLLdaMg3EsJwltsJf8=;
        b=hy5xhvJu5L5VyPRBqml9A5kdcttMKgO7iuIOoRVScRVfZmPyHgoAqyMgHN/NUvsBzu
         ZCYGkJzvgbDYyVfmzDPrv+D+P+YcqzvrmRRaVHs8lbGmP2Z7CRvG/eMLP+09kQuCCKG7
         0EjhnQnPbm6UW/04mLvLMVmUsChAgZVcoRR0mSoUCI8/JXVFDhDWDZR0NnzzJE9MESoz
         J/TwrFSNBgpVgLjdktEUpq6ROQhjyX8IBKNCGYxBrtmAFROfVMdSnbpEHz1XHnwCWUg5
         YA8+CZEB+FrgNVOQQuEPjMV0rP3SosIKsJDGRJfvgRmHodTNd5uht+joL34xulomXDzY
         9vfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=53LKNClv9WjrnexN7IY+lrSioJLLdaMg3EsJwltsJf8=;
        b=OZdxLFWTIQWrQA14+rX0nFEaa2BlGAn6qHcacl4VzeJFn6BBgXZK2hiArVTLZf1bWp
         Th/geD668cvVwxK10YscM9TEH+N2ZrNfOCz1PzyFmip1yGBHzu6c1Udfzth8kqk6cT+G
         hY47lGYH1ed25knjEsZ8hxKcGAG8SLn0YE8u8GQ8+8+Y1qal+FH2OViKhZuCW/cqe8ZC
         Q1Nxc0t9NNcX2fpQsMAD6G7S8ALIZpsB8RXyax6knL5MhASKNy1qHYZzTqFszXh35nh/
         o71SZZzdXKD0bKVwFTRtrjdo6CQ070S+nFJyRuFTJRD1HX7jQH5jZFXzGHU5tqPoE8Pz
         h5Bg==
X-Gm-Message-State: AOAM531cHaec+DSX7ecP18I75rFE8U9+x/nNCGEjIPprRNBNlQ8T8ept
        MORgFOO8wTo6BgCoWj2Qa/AW2dwu4coqMK//
X-Google-Smtp-Source: ABdhPJwAzb5p6/dyrldQv2YE5KAOiyY3OZm0ny4lqJSKRMz0MO2v8vqB79+o3WSlE6TXrIjJC4qLiDkVZJhCW3dL
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:924:: with SMTP id
 dk4mr2031501qvb.19.1606175463697; Mon, 23 Nov 2020 15:51:03 -0800 (PST)
Date:   Tue, 24 Nov 2020 00:50:52 +0100
Message-Id: <f8114050f8d65aa0bc801318b1db532d9f432447.1606175386.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v4] kcov, usbip: collect coverage from vhci_rx_loop
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Nazime Hande Harputluoglu <handeharput@gmail.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
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
Co-developed-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---

Changes in v4:
- Add USB/IP specific wrappers around kcov functions to avoid having a lot
  of ifdef CONFIG_KCOV in the USB/IP code.

---
 drivers/usb/usbip/usbip_common.h | 29 +++++++++++++++++++++++++++++
 drivers/usb/usbip/vhci_rx.c      |  2 ++
 drivers/usb/usbip/vhci_sysfs.c   |  1 +
 3 files changed, 32 insertions(+)

diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
index 8be857a4fa13..d60ce17d3dd2 100644
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
@@ -337,4 +341,29 @@ static inline int interface_to_devnum(struct usb_interface *interface)
 	return udev->devnum;
 }
 
+#ifdef CONFIG_KCOV
+
+static inline void usbip_kcov_handle_init(struct usbip_device *ud)
+{
+	ud->kcov_handle = kcov_common_handle();
+}
+
+static inline void usbip_kcov_remote_start(struct usbip_device *ud)
+{
+	kcov_remote_start_common(ud->kcov_handle);
+}
+
+static inline void usbip_kcov_remote_stop(void)
+{
+	kcov_remote_stop();
+}
+
+#else /* CONFIG_KCOV */
+
+static inline void usbip_kcov_handle_init(struct usbip_device *ud) { }
+static inline void usbip_kcov_remote_start(struct usbip_device *ud) { }
+static inline void usbip_kcov_remote_stop(void) { }
+
+#endif /* CONFIG_KCOV */
+
 #endif /* __USBIP_COMMON_H */
diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
index 266024cbb64f..7f2d1c241559 100644
--- a/drivers/usb/usbip/vhci_rx.c
+++ b/drivers/usb/usbip/vhci_rx.c
@@ -261,7 +261,9 @@ int vhci_rx_loop(void *data)
 		if (usbip_event_happened(ud))
 			break;
 
+		usbip_kcov_remote_start(ud);
 		vhci_rx_pdu(ud);
+		usbip_kcov_remote_stop();
 	}
 
 	return 0;
diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index be37aec250c2..96e5371dc335 100644
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -383,6 +383,7 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 	vdev->ud.sockfd     = sockfd;
 	vdev->ud.tcp_socket = socket;
 	vdev->ud.status     = VDEV_ST_NOTASSIGNED;
+	usbip_kcov_handle_init(&vdev->ud);
 
 	spin_unlock(&vdev->ud.lock);
 	spin_unlock_irqrestore(&vhci->lock, flags);
-- 
2.29.2.454.gaff20da3a2-goog

