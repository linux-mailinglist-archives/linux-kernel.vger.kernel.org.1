Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AD12FEB18
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbhAUNG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:06:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729447AbhAUKaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:30:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F15A23899;
        Thu, 21 Jan 2021 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611224969;
        bh=l37/E/vH4XbFHwCeL/usOurAN4NyJR1QzSmrjcbEVUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IeCt3T7xJntsvWfSdnZj23s60eW/tzIClgPhPw4LPMSdGpbnCgPDVjjnwbKWgVhLP
         SQlMROeEU6Yv/cxQ8XMt+xB25mP/FrJsRhqEXjXXM4JJZJl97smwrCf7F58z51BfSZ
         YOtwRKG8YBW69YzYo9EwphVdDyGNO6bZPAqNnHg3h8SehCRR++KvBinqCpVHf3dz9Q
         VRlix76zis9/0rVn9wy/laoDBeZwlmhvZkhCy8U5Z7rKe9gDmFh+4t58BR4kmvEf9I
         UmZTwcsupU5n4ShABu0eKhqAt12aR94azlCU1NKJssbq0Ftu4G4CUpkEqQlUzmcKhD
         CxNUlwpkrDJWg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l2XDc-0004YK-Ks; Thu, 21 Jan 2021 11:29:36 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 02/10] USB: serial: xr: fix interface leak at disconnect
Date:   Thu, 21 Jan 2021 11:29:14 +0100
Message-Id: <20210121102922.17439-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121102922.17439-1-johan@kernel.org>
References: <20210121102922.17439-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to release the control interface at disconnect so that the
driver can be unbound without leaking resources (and later rebound).

Fixes: a8f54b7bd132 ("USB: serial: add MaxLinear/Exar USB to Serial driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 7be6da6a5cf3..5e110b0c8e71 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -564,6 +564,15 @@ static int xr_probe(struct usb_serial *serial, const struct usb_device_id *id)
 	return 0;
 }
 
+static void xr_disconnect(struct usb_serial *serial)
+{
+	struct usb_driver *driver = serial->type->usb_driver;
+	struct usb_interface *control_interface;
+
+	control_interface = usb_ifnum_to_if(serial->dev, 0);
+	usb_driver_release_interface(driver, control_interface);
+}
+
 static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x04e2, 0x1410) }, /* XR21V141X */
 	{ }
@@ -578,6 +587,7 @@ static struct usb_serial_driver xr_device = {
 	.id_table		= id_table,
 	.num_ports		= 1,
 	.probe			= xr_probe,
+	.disconnect		= xr_disconnect,
 	.open			= xr_open,
 	.close			= xr_close,
 	.break_ctl		= xr_break_ctl,
-- 
2.26.2

