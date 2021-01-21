Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C094A2FEB16
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbhAUNG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:06:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:60230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbhAUKbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:31:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6B7C239E7;
        Thu, 21 Jan 2021 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611224970;
        bh=LB7JmBqWiGACFdERW0/yScBVALQ/zUAt6uErRz6Q0Pc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QbvEIKNKDcVf2nhJ8r5xynsebn/9kNQ84p1/eJlBNBd5yZCJzqHAlYFD9U6BMQ122
         EWyQx/nb1IxRdaGrOdEHJ9OK7zBpVNO1aua/YsaD8pfNs00qEv3tyU2oa3NXnaF0n3
         To9n6l6JKHAP1REIMo0mZ+/ALfDX0MciawSfbQaPjzhhh/VOMtXrWItU0jr9TXFWrJ
         MzqhTQP/fbHrRmd/bKG8+3+M9LcY/6nUE4NzeQ73QeQ2xe9yJW08BZ6DZJG/A+lDe4
         QU2csgJJEqGYO8jls2EEvQTWYvHAqJkb1m8UAlgcDtqH1NjvhFmt4+BORtrZ+r621D
         pBR051hjMS98Q==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l2XDd-0004Yd-8U; Thu, 21 Jan 2021 11:29:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 08/10] USB: serial: xr: fix gpio-mode handling
Date:   Thu, 21 Jan 2021 11:29:20 +0100
Message-Id: <20210121102922.17439-10-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121102922.17439-1-johan@kernel.org>
References: <20210121102922.17439-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the gpio-mode handling so that all the pins are under driver control
(i.e. in gpio mode) when hardware flow control is disabled.

This is specifically needed to be able to control RTS.

Fixes: a8f54b7bd132 ("USB: serial: add MaxLinear/Exar USB to Serial driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index fc727f4283f2..183731cd2ef7 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -408,14 +408,11 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 	if (ret)
 		return;
 
+	/* Set GPIO mode for controlling the pins manually by default. */
+	gpio_mode &= ~XR21V141X_UART_MODE_GPIO_MASK;
+
 	if (C_CRTSCTS(tty)) {
 		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
-
-		/*
-		 * RTS/CTS is the default flow control mode, so set GPIO mode
-		 * for controlling the pins manually by default.
-		 */
-		gpio_mode &= ~XR21V141X_UART_MODE_GPIO_MASK;
 		gpio_mode |= XR21V141X_UART_MODE_RTS_CTS;
 		flow = XR21V141X_UART_FLOW_MODE_HW;
 	} else if (I_IXON(tty)) {
-- 
2.26.2

