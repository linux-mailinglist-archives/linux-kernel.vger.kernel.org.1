Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C1F2FEB20
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbhAUNHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:07:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729441AbhAUKaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:30:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B4E62343E;
        Thu, 21 Jan 2021 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611224969;
        bh=yZsEYFxHhExQyS17apsnmD2VNyi2e+mhEdvR9PE0M50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PEKOd7okSE0hOqSVsTuk9LeSDjr7FBeAV5S+INLLYQ7R8bdpwPuUhUyGjSou9t12X
         Crr4MGyXGaq7AMx9fg/v0PuKmdsQEAXAvB34jucYb5iYu/hSKSyZ24L2bd8XDpccEr
         B4GtBq5lxRvAIkl4/Nx3gDQRD5aID930mP7BVzk/1CoIDWMHTH3F5ZeZ5ncYfTxi7H
         tHyomuaTXzrg77aJAgEVgYlbbO3DZs68QaNfs8Hu7jbHDoMYu/jWJHAOjAwk44mwMY
         /vZOLyIcaE3UKyswCUXifiayurVjO7kLb6ibpfR53ehQwRFrelSNDGZWOxDSZjf5p4
         JJxltK3lmV9tw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l2XDc-0004YU-UL; Thu, 21 Jan 2021 11:29:36 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 05/10] USB: serial: xr: document vendor-request recipient
Date:   Thu, 21 Jan 2021 11:29:17 +0100
Message-Id: <20210121102922.17439-7-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121102922.17439-1-johan@kernel.org>
References: <20210121102922.17439-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing device-recipient define to the vendor control requests
for completeness.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 52909dccb4dc..202263211ba9 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -116,8 +116,8 @@ static int xr_set_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 val)
 	ret = usb_control_msg(serial->dev,
 			      usb_sndctrlpipe(serial->dev, 0),
 			      XR21V141X_SET_REQ,
-			      USB_DIR_OUT | USB_TYPE_VENDOR, val,
-			      reg | (block << 8), NULL, 0,
+			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			      val, reg | (block << 8), NULL, 0,
 			      USB_CTRL_SET_TIMEOUT);
 	if (ret < 0) {
 		dev_err(&port->dev, "Failed to set reg 0x%02x: %d\n", reg, ret);
@@ -140,8 +140,8 @@ static int xr_get_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 *val)
 	ret = usb_control_msg(serial->dev,
 			      usb_rcvctrlpipe(serial->dev, 0),
 			      XR21V141X_GET_REQ,
-			      USB_DIR_IN | USB_TYPE_VENDOR, 0,
-			      reg | (block << 8), dmabuf, 1,
+			      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			      0, reg | (block << 8), dmabuf, 1,
 			      USB_CTRL_GET_TIMEOUT);
 	if (ret == 1) {
 		*val = *dmabuf;
-- 
2.26.2

