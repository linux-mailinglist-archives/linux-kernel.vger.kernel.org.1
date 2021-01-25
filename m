Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DAF30367E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbhAZG0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:26:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:48912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729058AbhAYNtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:49:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3CA4229C6;
        Mon, 25 Jan 2021 13:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611582505;
        bh=gNPpisxTbUwwqpcarWd4vsslU7KVrvVl4+pWDDJcseg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IndhCtYi8f3X5eK6kcHYvEUAGjqsZUgmCs34ycFHu6jgYnr6JPbFS6bsXq3+OdQls
         cgxp2dc0nU5AJWrWb8+mZ6I8z8HwEAyQB7Qw9q6O1vdQLSs+KD/Qd8gJz4PSyiJpwW
         GxSlsbf6YyNMLCgWmFRNf9Ch48hsNdCapeT3QqSeyXIycoJjvv34QfXQ5YSTDnLdrR
         3AK/PYsOp529th7m/JpwCBO0Oq7gTfxWpqWOk2UulEz36ZAs9Yi3kMS55NzGKA/r8N
         wMSxw2rpyaD3jkivzL2a4P1GE5gkBypg74SWFragOP7dY3/m8E0YeifP3BE8YbR5Ke
         R2aYKH0QTIhfg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l42EM-00034g-4P; Mon, 25 Jan 2021 14:48:34 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Pho Tran <Pho.Tran@silabs.com>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 7/7] USB: serial: cp210x: clean up auto-RTS handling
Date:   Mon, 25 Jan 2021 14:48:17 +0100
Message-Id: <20210125134817.11749-8-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210125134817.11749-1-johan@kernel.org>
References: <20210125134817.11749-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear the RTS bits of the flow-control request before determining the
new value when updating the settings.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index f00b736f3cd3..cc4f63a06f9e 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1163,9 +1163,9 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
 	else
 		ctl_hs |= CP210X_SERIAL_DTR_INACTIVE;
 
+	flow_repl &= ~CP210X_SERIAL_RTS_MASK;
 	if (C_CRTSCTS(tty)) {
 		ctl_hs |= CP210X_SERIAL_CTS_HANDSHAKE;
-		flow_repl &= ~CP210X_SERIAL_RTS_MASK;
 		if (port_priv->rts)
 			flow_repl |= CP210X_SERIAL_RTS_FLOW_CTL;
 		else
@@ -1173,7 +1173,6 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
 		port_priv->crtscts = true;
 	} else {
 		ctl_hs &= ~CP210X_SERIAL_CTS_HANDSHAKE;
-		flow_repl &= ~CP210X_SERIAL_RTS_MASK;
 		if (port_priv->rts)
 			flow_repl |= CP210X_SERIAL_RTS_ACTIVE;
 		else
-- 
2.26.2

