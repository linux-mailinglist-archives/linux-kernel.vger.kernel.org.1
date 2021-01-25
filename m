Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE13303681
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbhAZG0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:26:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:48906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbhAYNtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:49:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1A552229C;
        Mon, 25 Jan 2021 13:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611582505;
        bh=aM4WEZ4ICrEfWHuqpLjWreQ0Ds/6EnJrDpgFJXbEqQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=izVYI39BOonN4h0GibLNCPs2UfWop+zTIvmjeSS1xUyQayPuO+uDSi3CqsYUvz/cX
         HvFVCjCcG4iyrFgr8+6NCCaIVy+nodqU2KiIAVANwXJaq9d0OLDIOvVY0ylfN3U6wK
         gI0uBYqqXyOoymZG2by1GJuKiAHL+YJ0Mg9E8ScUWOov7k3nxTNkUDXCkKjS8Djs/y
         Ijpqpe6qmn3523MiZiLjwuH8LAy5FM6TivRaufw3aMmgF7td8BK74DF1W+75do18Kp
         43bwNJEFV8D/f64WA6D8NFdlxlJc4NTEOWUg5/eYX8PK2nJ+5G86niR0xlm62nIxrT
         syWf9QRp1X6Tg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l42EL-00034Z-Uq; Mon, 25 Jan 2021 14:48:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Pho Tran <Pho.Tran@silabs.com>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5/7] USB: serial: cp210x: clean up printk zero padding
Date:   Mon, 25 Jan 2021 14:48:15 +0100
Message-Id: <20210125134817.11749-6-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210125134817.11749-1-johan@kernel.org>
References: <20210125134817.11749-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the 0-flag and a field width to specify zero-padding consistently in
printk messages.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 36ae44818c13..4ba3fb096bf1 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1319,7 +1319,7 @@ static int cp210x_tiocmset_port(struct usb_serial_port *port,
 	if (port_priv->crtscts)
 		control &= ~CONTROL_WRITE_RTS;
 
-	dev_dbg(&port->dev, "%s - control = 0x%.4x\n", __func__, control);
+	dev_dbg(&port->dev, "%s - control = 0x%04x\n", __func__, control);
 
 	ret = cp210x_write_u16_reg(port, CP210X_SET_MHS, control);
 
@@ -1353,7 +1353,7 @@ static int cp210x_tiocmget(struct tty_struct *tty)
 		|((control & CONTROL_RING)? TIOCM_RI  : 0)
 		|((control & CONTROL_DCD) ? TIOCM_CD  : 0);
 
-	dev_dbg(&port->dev, "%s - control = 0x%.2x\n", __func__, control);
+	dev_dbg(&port->dev, "%s - control = 0x%02x\n", __func__, control);
 
 	return result;
 }
-- 
2.26.2

