Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA7A233E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 07:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbgGaFQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 01:16:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50145 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbgGaFQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 01:16:46 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1k1NPG-0005X6-0F; Fri, 31 Jul 2020 05:16:34 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Johan Hovold <johan@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Jonathan Cox <jonathan@jdcox.net>,
        Richard Dodd <richard.o.dodd@gmail.com>,
        =?UTF-8?q?Tomasz=20Meresi=C5=84ski?= <tomasz@meresinski.eu>,
        Dan Lazewatsky <dlaz@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] USB: quirks: Add no-lpm quirk for another Raydium touchscreen
Date:   Fri, 31 Jul 2020 13:16:20 +0800
Message-Id: <20200731051622.28643-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's another Raydium touchscreen needs the no-lpm quirk:
[    1.339149] usb 1-9: New USB device found, idVendor=2386, idProduct=350e, bcdDevice= 0.00
[    1.339150] usb 1-9: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.339151] usb 1-9: Product: Raydium Touch System
[    1.339152] usb 1-9: Manufacturer: Raydium Corporation
...
[    6.450497] usb 1-9: can't set config #1, error -110

BugLink: https://bugs.launchpad.net/bugs/1889446
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/core/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index e0b77674869c..6afb67c187b1 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -457,6 +457,8 @@ static const struct usb_device_id usb_quirk_list[] = {
 
 	{ USB_DEVICE(0x2386, 0x3119), .driver_info = USB_QUIRK_NO_LPM },
 
+	{ USB_DEVICE(0x2386, 0x350e), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* DJI CineSSD */
 	{ USB_DEVICE(0x2ca3, 0x0031), .driver_info = USB_QUIRK_NO_LPM },
 
-- 
2.17.1

