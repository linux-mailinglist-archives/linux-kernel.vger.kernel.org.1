Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0C62982DA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 18:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417764AbgJYRqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 13:46:47 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41875 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1417728AbgJYRqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 13:46:42 -0400
Received: by mail-lf1-f66.google.com with SMTP id d24so8913928lfa.8;
        Sun, 25 Oct 2020 10:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VSisBRKlms2bW6ryDsoA/vERvwhqA6Jy0C8Ke1HdF9Q=;
        b=lUqF2X1iGqTqZ5Gexk9R4SFL7/6ObN1CLnHxN4uyTVCtndyo4GAKveD2cQNhYbLsFy
         InFzqLR17JRWrooKo4XZXG9SwpCNkI1x8fAQ7y0rJ5Z4wkOU+DwiHZ439sgP0+mJqW6x
         991mNXR1TJtmz5Q4Z7N3etms39na9YhTDwM9IJBa9R2TU5h4HUE/6y3e4SM6iRqeICb9
         HBIlC+0LYXIKQSP/2FiffvIc46fZIDK9/VJqZYb/IU2y9gwCku8J1cjGOEvMXKmCy35/
         cuxnT+9GNRKjLlRqq8r+pZ6wi1ivrGqVjMefkDKcCb21c1IybxqbuDlkDvzY7rmmrE+m
         RbFw==
X-Gm-Message-State: AOAM531T8UbgykCEC8we4SgGxlVAOe+WFrYdBN0PBQYC+bD4knI9bWFQ
        mhjMqR9ajA86UQrd7qerUk+8ogLeCIGKiw==
X-Google-Smtp-Source: ABdhPJxT6605LlYpDxX6K75QUSS9yytb6OuuIoE+RPRfEvAdaIOEllNL1HJM2QpAZRKdnjOIq8LAdw==
X-Received: by 2002:a19:c142:: with SMTP id r63mr3415140lff.234.1603647999286;
        Sun, 25 Oct 2020 10:46:39 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id j12sm793172lfb.28.2020.10.25.10.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 10:46:37 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kWk6J-0007Hj-3i; Sun, 25 Oct 2020 18:46:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 08/14] USB: serial: keyspan_pda: fix write implementation
Date:   Sun, 25 Oct 2020 18:45:54 +0100
Message-Id: <20201025174600.27896-9-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201025174600.27896-1-johan@kernel.org>
References: <20201025174600.27896-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix stalled writes by checking the available buffer space after
requesting an unthrottle notification in case the device buffer is
already empty so that no notification is ever sent (e.g. when doing
single character writes).

This also means we can drop the room query from write() which was
conditioned on in_interrupt() and prevented writing using this driver
from atomic contexts (e.g. PPP).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/keyspan_pda.c | 109 +++++++++++++++----------------
 1 file changed, 51 insertions(+), 58 deletions(-)

diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index 54a21a99c001..b3fb2ecefb31 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -44,7 +44,6 @@
 
 struct keyspan_pda_private {
 	int			tx_room;
-	int			tx_throttled;
 	struct work_struct	unthrottle_work;
 	struct usb_serial	*serial;
 	struct usb_serial_port	*port;
@@ -138,9 +137,13 @@ static void keyspan_pda_request_unthrottle(struct work_struct *work)
 {
 	struct keyspan_pda_private *priv =
 		container_of(work, struct keyspan_pda_private, unthrottle_work);
+	struct usb_serial_port *port = priv->port;
 	struct usb_serial *serial = priv->serial;
+	unsigned long flags;
 	int result;
 
+	dev_dbg(&port->dev, "%s\n", __func__);
+
 	/* ask the device to tell us when the tx buffer becomes
 	   sufficiently empty */
 	result = usb_control_msg(serial->dev,
@@ -156,8 +159,19 @@ static void keyspan_pda_request_unthrottle(struct work_struct *work)
 	if (result < 0)
 		dev_dbg(&serial->dev->dev, "%s - error %d from usb_control_msg\n",
 			__func__, result);
-}
+	/*
+	 * Need to check available space after requesting notification in case
+	 * buffer is already empty so that no notification is sent.
+	 */
+	result = keyspan_pda_get_write_room(priv);
+	if (result > KEYSPAN_TX_THRESHOLD) {
+		spin_lock_irqsave(&port->lock, flags);
+		priv->tx_room = max(priv->tx_room, result);
+		spin_unlock_irqrestore(&port->lock, flags);
 
+		usb_serial_port_softint(port);
+	}
+}
 
 static void keyspan_pda_rx_interrupt(struct urb *urb)
 {
@@ -212,7 +226,6 @@ static void keyspan_pda_rx_interrupt(struct urb *urb)
 			break;
 		case 2: /* tx unthrottle interrupt */
 			spin_lock_irqsave(&port->lock, flags);
-			priv->tx_throttled = 0;
 			priv->tx_room = max(priv->tx_room, KEYSPAN_TX_THRESHOLD);
 			spin_unlock_irqrestore(&port->lock, flags);
 			/* queue up a wakeup at scheduler time */
@@ -472,35 +485,42 @@ static int keyspan_pda_tiocmset(struct tty_struct *tty,
 static int keyspan_pda_write(struct tty_struct *tty,
 	struct usb_serial_port *port, const unsigned char *buf, int count)
 {
-	int request_unthrottle = 0;
-	int rc = 0;
 	struct keyspan_pda_private *priv;
 	unsigned long flags;
+	int room;
+	int rc;
 
 	priv = usb_get_serial_port_data(port);
-	/* guess how much room is left in the device's ring buffer, and if we
-	   want to send more than that, check first, updating our notion of
-	   what is left. If our write will result in no room left, ask the
-	   device to give us an interrupt when the room available rises above
-	   a threshold, and hold off all writers (eventually, those using
-	   select() or poll() too) until we receive that unthrottle interrupt.
-	   Block if we can't write anything at all, otherwise write as much as
-	   we can. */
+	/*
+	 * Guess how much room is left in the device's ring buffer. If our
+	 * write will result in no room left, ask the device to give us an
+	 * interrupt when the room available rises above a threshold but also
+	 * query how much room is currently available (in case our guess was
+	 * too conservative and the buffer is already empty when the
+	 * unthrottle work is scheduled).
+	 */
 	if (count == 0) {
 		dev_dbg(&port->dev, "write request of 0 bytes\n");
 		return 0;
 	}
 
+	if (count > port->bulk_out_size)
+		count = port->bulk_out_size;
+
 	/* we might block because of:
 	   the TX urb is in-flight (wait until it completes)
 	   the device is full (wait until it says there is room)
 	*/
 	spin_lock_irqsave(&port->lock, flags);
-	if (!test_bit(0, &port->write_urbs_free) || priv->tx_throttled) {
+	room = priv->tx_room;
+	if (!test_bit(0, &port->write_urbs_free) || room == 0) {
 		spin_unlock_irqrestore(&port->lock, flags);
 		return 0;
 	}
 	clear_bit(0, &port->write_urbs_free);
+	if (count > room)
+		count = room;
+	priv->tx_room -= count;
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	/* At this point the URB is in our control, nobody else can submit it
@@ -508,58 +528,30 @@ static int keyspan_pda_write(struct tty_struct *tty,
 	   finished).  Also, the tx process is not throttled. So we are
 	   ready to write. */
 
-	count = (count > port->bulk_out_size) ? port->bulk_out_size : count;
+	dev_dbg(&port->dev, "%s - count = %d, txroom = %d\n", __func__, count, room);
 
-	/* Check if we might overrun the Tx buffer.   If so, ask the
-	   device how much room it really has.  This is done only on
-	   scheduler time, since usb_control_msg() sleeps. */
-	if (count > priv->tx_room && !in_interrupt()) {
-		rc = keyspan_pda_get_write_room(priv);
-		if (rc < 0)
-			goto exit;
-
-		priv->tx_room = rc;
-	}
+	memcpy(port->write_urb->transfer_buffer, buf, count);
+	port->write_urb->transfer_buffer_length = count;
 
-	if (count >= priv->tx_room) {
-		/* we're about to completely fill the Tx buffer, so
-		   we'll be throttled afterwards. */
-		count = priv->tx_room;
-		request_unthrottle = 1;
-	}
+	rc = usb_submit_urb(port->write_urb, GFP_ATOMIC);
+	if (rc) {
+		dev_dbg(&port->dev, "usb_submit_urb(write bulk) failed\n");
 
-	if (count) {
-		/* now transfer data */
-		memcpy(port->write_urb->transfer_buffer, buf, count);
-		/* send the data out the bulk port */
-		port->write_urb->transfer_buffer_length = count;
+		spin_lock_irqsave(&port->lock, flags);
+		priv->tx_room = max(priv->tx_room, room + count);
+		spin_unlock_irqrestore(&port->lock, flags);
 
-		priv->tx_room -= count;
+		set_bit(0, &port->write_urbs_free);
 
-		rc = usb_submit_urb(port->write_urb, GFP_ATOMIC);
-		if (rc) {
-			dev_dbg(&port->dev, "usb_submit_urb(write bulk) failed\n");
-			goto exit;
-		}
-	} else {
-		/* There wasn't any room left, so we are throttled until
-		   the buffer empties a bit */
-		request_unthrottle = 1;
+		return rc;
 	}
 
-	if (request_unthrottle) {
-		priv->tx_throttled = 1; /* block writers */
+	if (count == room)
 		schedule_work(&priv->unthrottle_work);
-	}
 
-	rc = count;
-exit:
-	if (rc <= 0)
-		set_bit(0, &port->write_urbs_free);
-	return rc;
+	return count;
 }
 
-
 static void keyspan_pda_write_bulk_callback(struct urb *urb)
 {
 	struct usb_serial_port *port = urb->context;
@@ -581,7 +573,7 @@ static int keyspan_pda_write_room(struct tty_struct *tty)
 	int room = 0;
 
 	spin_lock_irqsave(&port->lock, flags);
-	if (test_bit(0, &port->write_urbs_free) && !priv->tx_throttled)
+	if (test_bit(0, &port->write_urbs_free))
 		room = priv->tx_room;
 	spin_unlock_irqrestore(&port->lock, flags);
 
@@ -601,7 +593,7 @@ static int keyspan_pda_chars_in_buffer(struct tty_struct *tty)
 	   n_tty.c:normal_poll() ) that we're not writeable. */
 
 	spin_lock_irqsave(&port->lock, flags);
-	if (!test_bit(0, &port->write_urbs_free) || priv->tx_throttled)
+	if (!test_bit(0, &port->write_urbs_free) || priv->tx_room == 0)
 		ret = 256;
 	spin_unlock_irqrestore(&port->lock, flags);
 	return ret;
@@ -630,8 +622,9 @@ static int keyspan_pda_open(struct tty_struct *tty,
 	if (rc < 0)
 		return rc;
 
+	spin_lock_irq(&port->lock);
 	priv->tx_room = rc;
-	priv->tx_throttled = rc ? 0 : 1;
+	spin_unlock_irq(&port->lock);
 
 	/*Start reading from the device*/
 	rc = usb_submit_urb(port->interrupt_in_urb, GFP_KERNEL);
-- 
2.26.2

