Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5422B79C8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbgKRI4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:56:38 -0500
Received: from lucky1.263xmail.com ([211.157.147.135]:48304 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgKRI4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:56:37 -0500
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 3D2F7A5EB2;
        Wed, 18 Nov 2020 16:56:26 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (250.19.126.124.broad.bjtelecom.net [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P26978T140148616816384S1605689787381400_;
        Wed, 18 Nov 2020 16:56:27 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <fbcb1dee2af695eef72cd5ac8d86c5a9>
X-RL-SENDER: penghao@uniontech.com
X-SENDER: penghao@uniontech.com
X-LOGIN-NAME: penghao@uniontech.com
X-FST-TO: gregkh@linuxfoundation.org
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 5
X-System-Flag: 0
From:   penghao <penghao@uniontech.com>
To:     gregkh@linuxfoundation.org
Cc:     johan@kernel.org, jonathan@jdcox.net, tomasz@meresinski.eu,
        penghao@uniontech.com, hdegoede@redhat.com, dlaz@chromium.org,
        kai.heng.feng@canonical.com, richard.o.dodd@gmail.com,
        kerneldev@karsmulder.nl, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] USB: quirks: Add USB_QUIRK_DISCONNECT_SUSPEND quirk for Lenovo A630Z TIO built-in usb-audio card
Date:   Wed, 18 Nov 2020 16:56:23 +0800
Message-Id: <20201118085623.31221-1-penghao@uniontech.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a USB_QUIRK_DISCONNECT_SUSPEND quirk for the Lenovo TIO built-in
usb-audio. when A630Z going into S3,the system immediately wakeup 7-8
seconds later by usb-audio disconnect interrupt to avoids the issue.

Seeking a better fix, we've tried a lot of things, including:
 - Check that the device's power/wakeup is disabled
 - Check that remote wakeup is off at the USB level
 - All the quirks in drivers/usb/core/quirks.c
   e.g. USB_QUIRK_RESET_RESUME,
        USB_QUIRK_RESET,
        USB_QUIRK_IGNORE_REMOTE_WAKEUP,
        USB_QUIRK_NO_LPM.

but none of that makes any difference.

There are no errors in the logs showing any suspend/resume-related issues.
When the system wakes up due to the modem, log-wise it appears to be a
normal resume.

Introduce a quirk to disable the port during suspend when the modem is
detected.

Changes since v2
 - Add Changes commit format

Changes since v1
 - Change subject form "ALSA" to "USB:"
 - Adjust to approoriate line

Signed-off-by: penghao <penghao@uniontech.com>
---
 drivers/usb/core/quirks.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 7c1198f80c23..25f655c2cd28 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -410,6 +410,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x1532, 0x0116), .driver_info =
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
 
+	/* Lenovo ThinkCenter A630Z TI024Gen3 usb-audio */
+	{ USB_DEVICE(0x17ef, 0xa012), .driver_info =
+			USB_QUIRK_DISCONNECT_SUSPEND },
+
 	/* BUILDWIN Photo Frame */
 	{ USB_DEVICE(0x1908, 0x1315), .driver_info =
 			USB_QUIRK_HONOR_BNUMINTERFACES },
@@ -430,6 +434,7 @@ static const struct usb_device_id usb_quirk_list[] = {
 	  USB_QUIRK_DELAY_CTRL_MSG },
 
 	/* Corsair Strafe RGB */
+
 	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT |
 	  USB_QUIRK_DELAY_CTRL_MSG },
 
-- 
2.11.0



