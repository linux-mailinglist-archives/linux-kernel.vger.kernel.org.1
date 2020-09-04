Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE1B25CF22
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 03:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgIDBs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 21:48:59 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:46848 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgIDBs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 21:48:58 -0400
Received: from localhost (unknown [192.168.167.209])
        by lucky1.263xmail.com (Postfix) with ESMTP id 22EE5A27C5;
        Fri,  4 Sep 2020 09:48:57 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (250.19.126.124.broad.bjtelecom.net [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P26187T140084735092480S1599184137120717_;
        Fri, 04 Sep 2020 09:48:57 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <11421c5600f03eaf668671430d14ed55>
X-RL-SENDER: penghao@uniontech.com
X-SENDER: penghao@uniontech.com
X-LOGIN-NAME: penghao@uniontech.com
X-FST-TO: gregkh@linuxfoundation.org
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 5
X-System-Flag: 0
From:   Penghao <penghao@uniontech.com>
To:     gregkh@linuxfoundation.org
Cc:     johan@kernel.org, hdegoede@redhat.com, dlaz@chromium.org,
        stern@rowland.harvard.edu, kerneldev@karsmulder.nl,
        penghao@uniontech.com, jonathan@jdcox.net, tomasz@meresinski.eu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: quirks: Add USB_QUIRK_IGNORE_REMOTE_WAKEUP quirk for BYD zhaoxin notebook
Date:   Fri,  4 Sep 2020 09:48:54 +0800
Message-Id: <20200904014854.12577-1-penghao@uniontech.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a USB_QUIRK_IGNORE_REMOTE_WAKEUP quirk for the BYD zhaoxin notebook.
This notebook come with usb touchpad. And we would like to disable touchpad
wakeup on this notebook by default.

Signed-off-by: Penghao <penghao@uniontech.com>
---
 drivers/usb/core/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 7c1198f80c23..5fa3f2416967 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -387,6 +387,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0b05, 0x17e0), .driver_info =
 			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
 
+	/* SONiX USB DEVICE Touchpad */
+	{ USB_DEVICE(0x0c45, 0x7056), .driver_info =
+			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
+
 	/* Realtek hub in Dell WD19 (Type-C) */
 	{ USB_DEVICE(0x0bda, 0x0487), .driver_info = USB_QUIRK_NO_LPM },
 
-- 
2.11.0



