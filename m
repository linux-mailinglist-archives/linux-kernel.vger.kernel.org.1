Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5736C2FEB0E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbhAUNFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:05:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729272AbhAUKbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:31:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AA94238E2;
        Thu, 21 Jan 2021 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611224969;
        bh=xjg4bJ/WJ7UGY2kaqmpOdGZkHckPyPqK/EUxrrD9Eu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ATQ1FSqCg5HJuJsGlh9XsipX3j0BDNJ6MttLxQdqPRBx3D1M3V1sdVbfebK7fqtyh
         QjP0uYeW6zZfDjW14utme2iJNcumkwMsI2faC51MTwC1UP/3sJPOe0ptGidoK1YCFW
         z7n5qGgRcSHMiNUSnv5qx30JlZ1tXaTkU/U2q7XFq9q6nCTbuzDNK/JIDx+5RmQcYb
         9P8NcrpbPxx8g3oYQ/LN0DsYldmhrkmNMXBnXE6GMRFjTlZOunb6qsOtzfWGb708EK
         RTL0Xtbl/Yup6MLKRR9kyogjrmGxSal/8xJFRDXyzUFRD7n1jW33f/zNirX+lu0sFs
         gG9viQqb8RvNA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l2XDd-0004YW-1c; Thu, 21 Jan 2021 11:29:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 06/10] USB: serial: xr: clean up line-settings handling
Date:   Thu, 21 Jan 2021 11:29:18 +0100
Message-Id: <20210121102922.17439-8-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121102922.17439-1-johan@kernel.org>
References: <20210121102922.17439-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shift the line-setting values when defining them rather than in
set_termios() for consistency and improved readability.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 202263211ba9..2000277bacc1 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -71,17 +71,17 @@ struct xr_txrx_clk_mask {
 #define XR21V141X_UART_DATA_8		0x8
 
 #define XR21V141X_UART_PARITY_MASK	GENMASK(6, 4)
-#define XR21V141X_UART_PARITY_SHIFT	0x4
-#define XR21V141X_UART_PARITY_NONE	0x0
-#define XR21V141X_UART_PARITY_ODD	0x1
-#define XR21V141X_UART_PARITY_EVEN	0x2
-#define XR21V141X_UART_PARITY_MARK	0x3
-#define XR21V141X_UART_PARITY_SPACE	0x4
+#define XR21V141X_UART_PARITY_SHIFT	4
+#define XR21V141X_UART_PARITY_NONE	(0x0 << XR21V141X_UART_PARITY_SHIFT)
+#define XR21V141X_UART_PARITY_ODD	(0x1 << XR21V141X_UART_PARITY_SHIFT)
+#define XR21V141X_UART_PARITY_EVEN	(0x2 << XR21V141X_UART_PARITY_SHIFT)
+#define XR21V141X_UART_PARITY_MARK	(0x3 << XR21V141X_UART_PARITY_SHIFT)
+#define XR21V141X_UART_PARITY_SPACE	(0x4 << XR21V141X_UART_PARITY_SHIFT)
 
 #define XR21V141X_UART_STOP_MASK	BIT(7)
-#define XR21V141X_UART_STOP_SHIFT	0x7
-#define XR21V141X_UART_STOP_1		0x0
-#define XR21V141X_UART_STOP_2		0x1
+#define XR21V141X_UART_STOP_SHIFT	7
+#define XR21V141X_UART_STOP_1		(0x0 << XR21V141X_UART_STOP_SHIFT)
+#define XR21V141X_UART_STOP_2		(0x1 << XR21V141X_UART_STOP_SHIFT)
 
 #define XR21V141X_UART_FLOW_MODE_NONE	0x0
 #define XR21V141X_UART_FLOW_MODE_HW	0x1
@@ -477,25 +477,21 @@ static void xr_set_termios(struct tty_struct *tty,
 	if (C_PARENB(tty)) {
 		if (C_CMSPAR(tty)) {
 			if (C_PARODD(tty))
-				bits |= XR21V141X_UART_PARITY_MARK <<
-					XR21V141X_UART_PARITY_SHIFT;
+				bits |= XR21V141X_UART_PARITY_MARK;
 			else
-				bits |= XR21V141X_UART_PARITY_SPACE <<
-					XR21V141X_UART_PARITY_SHIFT;
+				bits |= XR21V141X_UART_PARITY_SPACE;
 		} else {
 			if (C_PARODD(tty))
-				bits |= XR21V141X_UART_PARITY_ODD <<
-					XR21V141X_UART_PARITY_SHIFT;
+				bits |= XR21V141X_UART_PARITY_ODD;
 			else
-				bits |= XR21V141X_UART_PARITY_EVEN <<
-					XR21V141X_UART_PARITY_SHIFT;
+				bits |= XR21V141X_UART_PARITY_EVEN;
 		}
 	}
 
 	if (C_CSTOPB(tty))
-		bits |= XR21V141X_UART_STOP_2 << XR21V141X_UART_STOP_SHIFT;
+		bits |= XR21V141X_UART_STOP_2;
 	else
-		bits |= XR21V141X_UART_STOP_1 << XR21V141X_UART_STOP_SHIFT;
+		bits |= XR21V141X_UART_STOP_1;
 
 	ret = xr_set_reg_uart(port, XR21V141X_REG_FORMAT, bits);
 	if (ret)
-- 
2.26.2

