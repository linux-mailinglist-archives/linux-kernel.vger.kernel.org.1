Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708EE2FEB0C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbhAUNFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbhAUKbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:31:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C80CA2399A;
        Thu, 21 Jan 2021 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611224969;
        bh=DEeqkkmfzEshOH9YcHBTh0nZBMY1kefvozqEmVaGwrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HoZVQnIfaIcftewG35mfdBs0Y22w215QvhpVz0YmxMvmWz7iSdBHXcsWmdvDvmygT
         E02t+4D74xIYR8BAMctLk1QRdYnS85gkaD6dpYcVlm6pdu9aCj3KU58Go9tOBw7jVs
         jJahfNOiZ7/+xahSl8lvGI27B71E5UEe9WAg7wWPFHhwi9jIq/b3qYdO8tEUr2nwAv
         vBhMjZtsbma0Y3zTv/I8fjId3oyF5PwE+2xWsq8IU35cjzdDHAmBesu8I6ruaB62B0
         taFq1SNw3dcWLPzXhU2NqLAKK3zD+RlnRJJF1gDlGov0/F498uwZGbd4qSK666an7v
         xzS0NTBcKNbnw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l2XDd-0004Yg-C6; Thu, 21 Jan 2021 11:29:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 09/10] USB: serial: xr: fix pin configuration
Date:   Thu, 21 Jan 2021 11:29:21 +0100
Message-Id: <20210121102922.17439-11-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121102922.17439-1-johan@kernel.org>
References: <20210121102922.17439-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that the modem pins are set up correctly when opening the
port to avoid leaving, for example, DTR and RTS configured as inputs,
which is the device default.

This is specifically needed to be able to control DTR and RTS when
hardware flow control is disabled.

Fixes: a8f54b7bd132 ("USB: serial: add MaxLinear/Exar USB to Serial driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 183731cd2ef7..f67e7dba9509 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -502,6 +502,7 @@ static void xr_set_termios(struct tty_struct *tty,
 
 static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
 {
+	u8 gpio_dir;
 	int ret;
 
 	ret = xr_uart_enable(port);
@@ -510,6 +511,13 @@ static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
 		return ret;
 	}
 
+	/*
+	 * Configure DTR and RTS as outputs and RI, CD, DSR and CTS as
+	 * inputs.
+	 */
+	gpio_dir = XR21V141X_UART_MODE_DTR | XR21V141X_UART_MODE_RTS;
+	xr_set_reg_uart(port, XR21V141X_REG_GPIO_DIR, gpio_dir);
+
 	/* Setup termios */
 	if (tty)
 		xr_set_termios(tty, port, NULL);
-- 
2.26.2

