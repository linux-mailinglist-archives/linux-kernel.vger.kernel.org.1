Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87D62B76A6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 08:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgKRHAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 02:00:30 -0500
Received: from lucky1.263xmail.com ([211.157.147.131]:57932 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgKRHAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 02:00:30 -0500
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2020 02:00:25 EST
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 8396DB6B1F;
        Wed, 18 Nov 2020 14:51:38 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (250.19.126.124.broad.bjtelecom.net [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P26978T140148431894272S1605682298944163_;
        Wed, 18 Nov 2020 14:51:39 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <ead1bf6159ec8691252672aba89c1fea>
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
Subject: [PATCH] Changes since v1  - Change subject form "ALSA" to "USB:"  - Adjust to approoriate line
Date:   Wed, 18 Nov 2020 14:51:32 +0800
Message-Id: <20201118065132.24772-1-penghao@uniontech.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB: quirks: Add USB_QUIRK_DISCONNECT_SUSPEND quirk for
Lenovo A630Z TIO built-in usb-audio card

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

Signed-off-by: penghao <penghao@uniontech.com>
---
 drivers/usb/core/quirks.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 7c1198f80c23..8d18e89f9eb0 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -410,7 +410,11 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x1532, 0x0116), .driver_info =
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
 
-	/* BUILDWIN Photo Frame */
+/* Lenovo - ThinkCenter A630Z TI024Gen3 usb-audio card */
+{ USB_DEVICE(0x17ef, 0x0xa012), .driver_info =
+USB_QUIRK_DISCONNECT_SUSPEND },
+
+    /* BUILDWIN Photo Frame */
 	{ USB_DEVICE(0x1908, 0x1315), .driver_info =
 			USB_QUIRK_HONOR_BNUMINTERFACES },
 
-- 
2.11.0



