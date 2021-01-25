Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0633303678
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbhAZGZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:25:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbhAYNtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:49:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5D4A22AEC;
        Mon, 25 Jan 2021 13:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611582505;
        bh=utwTy/K6bSH+WnerAU457mlKdmG4o5ZVpKSF7KoC4IY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bpbJDxGqzUo/ohAAD+GWuSej89NicEMjWWrU8NFcIB4/E2gjvU0RN0yfciXFqlRCp
         X7YpXmlCvLm/MDjgmps+oFK0qX/lqJshF0JVQuKwbkeA0hpbzpCF4oOYZHSNHCkfhB
         FKVoZVwI/ehHC/Of5I6aQCwdCHqb85OT5UROYmDBZMQg/k5S2I7lUR+Wkg4Zte+yXe
         2GGcRQCvntwrF9PuJpufZGpJbrXiDuNojlasX12tJNMRdj46sWjDjdqS0f7jrq0pur
         co6lqjfsoNQJcQtCnEy3w6Z2Atn39wkM+HdWcloV9OZIMvAFLUbZnkD0y9znE26KEA
         rhr3/AbY5VRnQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l42EL-00034T-OT; Mon, 25 Jan 2021 14:48:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Pho Tran <Pho.Tran@silabs.com>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/7] USB: serial: cp210x: drop shift macros
Date:   Mon, 25 Jan 2021 14:48:13 +0100
Message-Id: <20210125134817.11749-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210125134817.11749-1-johan@kernel.org>
References: <20210125134817.11749-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the macros used to shift the flow-control settings to make the code
more readable for consistency with the other requests.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 9378b4bba34b..aa874641374a 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -449,17 +449,14 @@ struct cp210x_flow_ctl {
 
 /* cp210x_flow_ctl::ulControlHandshake */
 #define CP210X_SERIAL_DTR_MASK		GENMASK(1, 0)
-#define CP210X_SERIAL_DTR_SHIFT(_mode)	(_mode)
+#define CP210X_SERIAL_DTR_INACTIVE	(0 << 0)
+#define CP210X_SERIAL_DTR_ACTIVE	(1 << 0)
+#define CP210X_SERIAL_DTR_FLOW_CTL	(2 << 0)
 #define CP210X_SERIAL_CTS_HANDSHAKE	BIT(3)
 #define CP210X_SERIAL_DSR_HANDSHAKE	BIT(4)
 #define CP210X_SERIAL_DCD_HANDSHAKE	BIT(5)
 #define CP210X_SERIAL_DSR_SENSITIVITY	BIT(6)
 
-/* values for cp210x_flow_ctl::ulControlHandshake::CP210X_SERIAL_DTR_MASK */
-#define CP210X_SERIAL_DTR_INACTIVE	0
-#define CP210X_SERIAL_DTR_ACTIVE	1
-#define CP210X_SERIAL_DTR_FLOW_CTL	2
-
 /* cp210x_flow_ctl::ulFlowReplace */
 #define CP210X_SERIAL_AUTO_TRANSMIT	BIT(0)
 #define CP210X_SERIAL_AUTO_RECEIVE	BIT(1)
@@ -467,14 +464,11 @@ struct cp210x_flow_ctl {
 #define CP210X_SERIAL_NULL_STRIPPING	BIT(3)
 #define CP210X_SERIAL_BREAK_CHAR	BIT(4)
 #define CP210X_SERIAL_RTS_MASK		GENMASK(7, 6)
-#define CP210X_SERIAL_RTS_SHIFT(_mode)	(_mode << 6)
+#define CP210X_SERIAL_RTS_INACTIVE	(0 << 6)
+#define CP210X_SERIAL_RTS_ACTIVE	(1 << 6)
+#define CP210X_SERIAL_RTS_FLOW_CTL	(2 << 6)
 #define CP210X_SERIAL_XOFF_CONTINUE	BIT(31)
 
-/* values for cp210x_flow_ctl::ulFlowReplace::CP210X_SERIAL_RTS_MASK */
-#define CP210X_SERIAL_RTS_INACTIVE	0
-#define CP210X_SERIAL_RTS_ACTIVE	1
-#define CP210X_SERIAL_RTS_FLOW_CTL	2
-
 /* CP210X_VENDOR_SPECIFIC, CP210X_GET_DEVICEMODE call reads these 0x2 bytes. */
 struct cp210x_pin_mode {
 	u8	eci;
@@ -1165,22 +1159,22 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
 	ctl_hs &= ~CP210X_SERIAL_DSR_SENSITIVITY;
 	ctl_hs &= ~CP210X_SERIAL_DTR_MASK;
 	if (port_priv->dtr)
-		ctl_hs |= CP210X_SERIAL_DTR_SHIFT(CP210X_SERIAL_DTR_ACTIVE);
+		ctl_hs |= CP210X_SERIAL_DTR_ACTIVE;
 	else
-		ctl_hs |= CP210X_SERIAL_DTR_SHIFT(CP210X_SERIAL_DTR_INACTIVE);
+		ctl_hs |= CP210X_SERIAL_DTR_INACTIVE;
 
 	if (C_CRTSCTS(tty)) {
 		ctl_hs |= CP210X_SERIAL_CTS_HANDSHAKE;
 		flow_repl &= ~CP210X_SERIAL_RTS_MASK;
-		flow_repl |= CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_FLOW_CTL);
+		flow_repl |= CP210X_SERIAL_RTS_FLOW_CTL;
 		port_priv->crtscts = true;
 	} else {
 		ctl_hs &= ~CP210X_SERIAL_CTS_HANDSHAKE;
 		flow_repl &= ~CP210X_SERIAL_RTS_MASK;
 		if (port_priv->rts)
-			flow_repl |= CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_ACTIVE);
+			flow_repl |= CP210X_SERIAL_RTS_ACTIVE;
 		else
-			flow_repl |= CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_INACTIVE);
+			flow_repl |= CP210X_SERIAL_RTS_INACTIVE;
 		port_priv->crtscts = false;
 	}
 
-- 
2.26.2

