Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B8E2CD8FB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389132AbgLCOYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:24:06 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:55111 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbgLCOYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:24:06 -0500
Received: from orion.localdomain ([95.118.71.13]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MQMmF-1kXoui1iF7-00MIsk; Thu, 03 Dec 2020 15:21:33 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH] drivers: usb: core: prefer pr_*() macros over bare printk()
Date:   Thu,  3 Dec 2020 15:21:32 +0100
Message-Id: <20201203142132.30334-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:s8lRoK9f6+7jquvtZUrT18jiSFd37BWHB1ug0mmSZC+a5t++lE0
 j0mMKA1/7/gxo6I7ZtulJRkf7JD5WBuZPokXzazJg4ZdvJXK038GGynk0EuVrsIKIj6Cdex
 GoTtazE6J+S6qX6MhW5vTKe2+7WZnhygfrnxMeB36k3d1L2pNTicydexW3SGi+iA4Zn8O2h
 JVoypRL7udA4jYNODvRiw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tbzYR0dE85U=:NDcLe2wVGM2S3PcxI+9+WU
 nsuCVYx+KR3Xey0uyd/T54SLip1Kw8eLybEjjZvWvHFdk9lOj/dhvhc/Bi3/3V1cmwtSPtFLS
 H47OhN2JBPJdxOQgDtLDXwpw010PigRuAKxM/EBgLya1pzhk4G/IzkO5KD4GN79YWhzjC7Hrd
 yY/6cbhyjdQ/SeMH8F6nnHqlpisurkf6ByDUue5/t83U285g0qLx6s5tEs7ep3pgNVifX05Vc
 LC69ktB53ju/cihNTJntVIwdWSYM9Yq7p0HsuQ2mtd9k6I+lLqt1EyDeYc0iWIP8nz0nczfNB
 /Ku9sU1Mkh64qdpZbKcd49YTGrRrNG3On0Y8LIafpz001GrkhZtW/aefTor2rbv7gyDs9weYf
 zGym94prTOBA+F3Igao7k0ZT8XkInLkPyNIQfV84zlQ3EigSTC0lM3v8rcyAa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pr_*() printing helpers are preferred over using bare printk().

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/usb/core/devio.c | 10 +++++-----
 drivers/usb/core/file.c  |  5 ++---
 drivers/usb/core/hcd.c   |  2 +-
 drivers/usb/core/hub.c   |  2 +-
 drivers/usb/core/sysfs.c |  2 +-
 drivers/usb/core/usb.c   |  5 ++---
 6 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 533236366a03..c65651b28ac4 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1169,7 +1169,7 @@ static int do_proc_control(struct usb_dev_state *ps,
 		snoop_urb(dev, NULL, pipe, max(i, 0), min(i, 0), COMPLETE, NULL, 0);
 	}
 	if (i < 0 && i != -EPIPE) {
-		dev_printk(KERN_DEBUG, &dev->dev, "usbfs: USBDEVFS_CONTROL "
+		dev_dbg(&dev->dev, "usbfs: USBDEVFS_CONTROL "
 			   "failed cmd %s rqt %u rq %u len %u ret %d\n",
 			   current->comm, ctrl->bRequestType, ctrl->bRequest,
 			   ctrl->wLength, i);
@@ -1861,8 +1861,8 @@ static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb
 	}
 
 	if (ret) {
-		dev_printk(KERN_DEBUG, &ps->dev->dev,
-			   "usbfs: usb_submit_urb returned %d\n", ret);
+		dev_dbg(&ps->dev->dev,
+			"usbfs: usb_submit_urb returned %d\n", ret);
 		snoop_urb(ps->dev, as->userurb, as->urb->pipe,
 				0, ret, COMPLETE, NULL, 0);
 		async_removepending(as);
@@ -2785,13 +2785,13 @@ int __init usb_devio_init(void)
 	retval = register_chrdev_region(USB_DEVICE_DEV, USB_DEVICE_MAX,
 					"usb_device");
 	if (retval) {
-		printk(KERN_ERR "Unable to register minors for usb_device\n");
+		pr_err("Unable to register minors for usb_device\n");
 		goto out;
 	}
 	cdev_init(&usb_device_cdev, &usbdev_file_operations);
 	retval = cdev_add(&usb_device_cdev, USB_DEVICE_DEV, USB_DEVICE_MAX);
 	if (retval) {
-		printk(KERN_ERR "Unable to get usb_device major %d\n",
+		pr_err("Unable to get usb_device major %d\n",
 		       USB_DEVICE_MAJOR);
 		goto error_cdev;
 	}
diff --git a/drivers/usb/core/file.c b/drivers/usb/core/file.c
index 558890ada0e5..760866d38f8a 100644
--- a/drivers/usb/core/file.c
+++ b/drivers/usb/core/file.c
@@ -91,7 +91,7 @@ static int init_usb_class(void)
 	usb_class->class = class_create(THIS_MODULE, "usbmisc");
 	if (IS_ERR(usb_class->class)) {
 		result = PTR_ERR(usb_class->class);
-		printk(KERN_ERR "class_create failed for usb devices\n");
+		pr_err("class_create failed for usb devices\n");
 		kfree(usb_class);
 		usb_class = NULL;
 		goto exit;
@@ -123,8 +123,7 @@ int usb_major_init(void)
 
 	error = register_chrdev(USB_MAJOR, "usb", &usb_fops);
 	if (error)
-		printk(KERN_ERR "Unable to get major %d for usb devices\n",
-		       USB_MAJOR);
+		pr_err("Unable to get major %d for usb devices\n", USB_MAJOR);
 
 	return error;
 }
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 2c6b9578a7d3..ef74cb8b58e6 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2979,7 +2979,7 @@ void usb_mon_deregister (void)
 {
 
 	if (mon_ops == NULL) {
-		printk(KERN_ERR "USB: monitor was not registered\n");
+		pr_err("USB: monitor was not registered\n");
 		return;
 	}
 	mon_ops = NULL;
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 17202b2ee063..b542db35ee3f 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5674,7 +5674,7 @@ static struct usb_driver hub_driver = {
 int usb_hub_init(void)
 {
 	if (usb_register(&hub_driver) < 0) {
-		printk(KERN_ERR "%s: can't register hub driver\n",
+		pr_err("%s: can't register hub driver\n",
 			usbcore_name);
 		return -1;
 	}
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index 8d134193fa0c..7b09c35c3928 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -448,7 +448,7 @@ static void warn_level(void)
 
 	if (!level_warned) {
 		level_warned = 1;
-		printk(KERN_WARNING "WARNING! power/level is deprecated; "
+		pr_warn("WARNING! power/level is deprecated; "
 				"use power/control instead\n");
 	}
 }
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 9b4ac4415f1a..5f67e5f511c1 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -241,7 +241,7 @@ struct usb_host_interface *usb_find_alt_setting(
 		if (intf_cache->altsetting[i].desc.bAlternateSetting == alt_num)
 			return &intf_cache->altsetting[i];
 
-	printk(KERN_DEBUG "Did not find alt setting %u for intf %u, "
+	pr_debug("Did not find alt setting %u for intf %u, "
 			"config %u\n", alt_num, iface_num,
 			config->desc.bConfigurationValue);
 	return NULL;
@@ -846,8 +846,7 @@ int __usb_get_extra_descriptor(char *buffer, unsigned size,
 		header = (struct usb_descriptor_header *)buffer;
 
 		if (header->bLength < 2 || header->bLength > size) {
-			printk(KERN_ERR
-				"%s: bogus descriptor, type %d length %d\n",
+			pr_err("%s: bogus descriptor, type %d length %d\n",
 				usbcore_name,
 				header->bDescriptorType,
 				header->bLength);
-- 
2.11.0

