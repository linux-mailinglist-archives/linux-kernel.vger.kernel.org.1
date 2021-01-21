Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C29D2FE7B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbhAUKfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:35:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:59704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729449AbhAUKaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:30:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9692F238E1;
        Thu, 21 Jan 2021 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611224969;
        bh=muBD3IQ1TCM0qBQYVRvhSbDGJU6BeU5w0afjk7NjGbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6ZIJg+uHqEEvjh9KRazuGtO3ToQJ09p5V6IUKO1F8IZowohPY+aI4TSaf+ARseJK
         MUk/ih3UCWa2KhANYsQIBGq0IXpW2xwpAJjdwCII7xRgaqXKjijkwwzwNtzewgCxlv
         cC6wD0tHv16UUGsw9XcbGvKd5aH/X33ID60BZaBVCaNHtYC6I8MThC7mE9ElRVqZGV
         FWmvImwZNvOxBGTwP25ZvwRp3Y5aHO61oAKYZTQr8xMmBGmnxtQCTFdrxTNI/+J8zO
         aG+1ctAW5bEJqEhzFYMnBpEUbrFY4zbMzQUkDPHL6XHQoBvEEft2QqLeMs39b9oXww
         /LmOtr9uBER0w==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l2XDc-0004YN-Np; Thu, 21 Jan 2021 11:29:36 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 03/10] USB: serial: xr: use subsystem usb_device at probe
Date:   Thu, 21 Jan 2021 11:29:15 +0100
Message-Id: <20210121102922.17439-5-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121102922.17439-1-johan@kernel.org>
References: <20210121102922.17439-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the subsystem struct usb_device pointer at probe instead of
deriving it from the interface pointer.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 5e110b0c8e71..8f81f866d681 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -541,7 +541,6 @@ static void xr_close(struct usb_serial_port *port)
 
 static int xr_probe(struct usb_serial *serial, const struct usb_device_id *id)
 {
-	struct usb_device *usb_dev = interface_to_usbdev(serial->interface);
 	struct usb_driver *driver = serial->type->usb_driver;
 	struct usb_interface *control_interface;
 	int ret;
@@ -551,7 +550,7 @@ static int xr_probe(struct usb_serial *serial, const struct usb_device_id *id)
 		return -ENODEV;
 
 	/* But claim the control interface during data interface probe */
-	control_interface = usb_ifnum_to_if(usb_dev, 0);
+	control_interface = usb_ifnum_to_if(serial->dev, 0);
 	if (!control_interface)
 		return -ENODEV;
 
-- 
2.26.2

