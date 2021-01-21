Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC6B2FEB0D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbhAUNFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:05:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:60218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729287AbhAUKbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:31:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 951CD238D7;
        Thu, 21 Jan 2021 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611224969;
        bh=cAZ+bdotNq2+OepIgVZlBcVcWLCXIE8JG8JDOtK1y0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aNu4QWe29ncRnTTRRqNLAhTO3N5Pxq22g4ct+MhNDnCmZL0JMowzE1UQcYcThdyie
         GZBlcZY1XFDsUd5YDCDtmFM3eaH/grtyX/yRfa3F8x6WMwxJ5b4TG8NV0Zi3ydqIve
         HjnLi4Tc9yxwa7adRgPq9/CyJ0rhLGI99X8Baj8LdX7LsIaRW3g7Lpl3XcjCrLxLcx
         D8LupIjWZqqfTgCYCiYh4NQX12fchVCFyJg9lCyomjUA9lnJZ+WDs1sNpDDhyIERSZ
         cHM64ncsUdOcnNhjW+mzqLwOzVqI3SqadhcixmtGgDxcTnMh21HzV/s6uxxEF1Rl1r
         NT92oIqElj2QA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l2XDc-0004YR-R0; Thu, 21 Jan 2021 11:29:36 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 04/10] USB: serial: xr: use termios flag helpers
Date:   Thu, 21 Jan 2021 11:29:16 +0100
Message-Id: <20210121102922.17439-6-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121102922.17439-1-johan@kernel.org>
References: <20210121102922.17439-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the termios flag helpers consistently, including for CRTSCTS.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 8f81f866d681..52909dccb4dc 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -401,7 +401,6 @@ static int xr_set_baudrate(struct tty_struct *tty,
 static void xr_set_flow_mode(struct tty_struct *tty,
 			     struct usb_serial_port *port)
 {
-	unsigned int cflag = tty->termios.c_cflag;
 	u8 flow, gpio_mode;
 	int ret;
 
@@ -409,7 +408,7 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 	if (ret)
 		return;
 
-	if (cflag & CRTSCTS) {
+	if (C_CRTSCTS(tty)) {
 		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
 
 		/*
-- 
2.26.2

