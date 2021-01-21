Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6870E2FE7BF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbhAUKhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:37:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbhAUKbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:31:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2389C23444;
        Thu, 21 Jan 2021 10:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611224971;
        bh=2a6eKV6ka6kZEf6Ox3YKBGQDv8NFUC/2/V+O9Rj3yJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=buEQiFy0gZ+L5hd7cfuwohcx24LtrMGVQQfepETEvvJlcepVS7a/MfkMWGWMJ+rkV
         GmS0q4GQzqyO9zeevbshnQ1sN2LUvER/3FvaSOmBSH3+lqe7LmcZ5zFlUPGRQe1KZ7
         K5zLdFHjfD8N8NaWH9gwnd3e95O53MLEGuFMdnbVsatOGNJgV5kjvK8vlC6UAx0nyT
         V3OdmY9NF7g8yy05VrJrIg1V4QQm9+VZZ0YP0KyB0neSOWpt2dDah8qFpcHadAQcsX
         +IpAI7ezdqY29SfL8MDZtHXThPNaOkbKUqpWmMJp/MXvNB81r++rcDo0K9gZ3kHmV9
         Z1aFj5o+NAoaw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l2XDc-0004YH-I2; Thu, 21 Jan 2021 11:29:36 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 01/10] USB: serial: xr: fix NULL-deref at probe
Date:   Thu, 21 Jan 2021 11:29:13 +0100
Message-Id: <20210121102922.17439-3-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121102922.17439-1-johan@kernel.org>
References: <20210121102922.17439-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that the probed device has an interface 0 to avoid
dereferencing a NULL pointer in case of a malicious device or during
USB-descriptor fuzzing.

Fixes: a8f54b7bd132 ("USB: serial: add MaxLinear/Exar USB to Serial driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index bdb2df27b50b..7be6da6a5cf3 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -552,6 +552,9 @@ static int xr_probe(struct usb_serial *serial, const struct usb_device_id *id)
 
 	/* But claim the control interface during data interface probe */
 	control_interface = usb_ifnum_to_if(usb_dev, 0);
+	if (!control_interface)
+		return -ENODEV;
+
 	ret = usb_driver_claim_interface(driver, control_interface, NULL);
 	if (ret) {
 		dev_err(&serial->interface->dev, "Failed to claim control interface\n");
-- 
2.26.2

