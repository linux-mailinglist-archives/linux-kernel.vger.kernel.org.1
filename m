Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE712982DB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 18:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417774AbgJYRqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 13:46:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36120 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1417747AbgJYRqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 13:46:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id h6so8907672lfj.3;
        Sun, 25 Oct 2020 10:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CqbRKimYe1NyugKflXSgKWReJkFImiLBzd8ZfDSwYpg=;
        b=c6P38fDtk0csY9SZwIe0jYTSexBOJElTDPMA1xOvikZ1asO/cnQgSH2ZgTUZHj216f
         7MQIhiVvPE+xfZocSQKpyS9iBZkXh2kvxczofCdM01dGeG02JPlq3cClnBu0YWQ6MLS/
         G4NZD9FZAe5JyHbrShFPXs1mQfKfJx76JCghEckm/++CaLeorq2kDrw7Z3h4CR2XSpxT
         mo6ZnXqieHk/kT0BzT3CccecgoKxJFwbKAKtJEK7ZCUFiQ8gCYZA8y+b+c2uti3oFLhc
         1m5fSTMHQBh3ev7+uZ7WMCMzxkKSYiAjUq1cDEx5qpq8zHtl2ujMNy2kvDjqNynvh48s
         IUiQ==
X-Gm-Message-State: AOAM532x+4OWtBMt/6qZ+fDrpzGMcMYttUhQTfIqtFP29axdnarf98QF
        jwbwPvLEPqpbIJABmiYjlAi3hGYfjbndig==
X-Google-Smtp-Source: ABdhPJx37cyoczEwaZ6YPMHYucOh9v9JYWqeuv+goTQG0oldDd7xZO8VWg1+xhCY34vfAJlw2rFnig==
X-Received: by 2002:ac2:51ab:: with SMTP id f11mr4224755lfk.417.1603648002107;
        Sun, 25 Oct 2020 10:46:42 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id 18sm900581ljq.0.2020.10.25.10.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 10:46:37 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kWk6J-0007Ht-8m; Sun, 25 Oct 2020 18:46:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 10/14] USB: serial: keyspan_pda: add write-fifo support
Date:   Sun, 25 Oct 2020 18:45:56 +0100
Message-Id: <20201025174600.27896-11-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201025174600.27896-1-johan@kernel.org>
References: <20201025174600.27896-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the port write fifo and generic chars_and_buffer and write_room
implementations when writing. This not only allows for more efficient
transfers, but more importantly fixes the remaining issues related to
the conservative write_room() implementation which could prevent the
line discipline from making forward progress (e.g. waiting for n > 1
bytes of space to become available).

Note that this also allows using the driver for the system console
without dropping data when the write URB is busy (including when adding
carriage return on line feed).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/keyspan_pda.c | 115 +++++++++++++++----------------
 1 file changed, 55 insertions(+), 60 deletions(-)

diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index 3816bbc928b2..aa19dd181e42 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -5,6 +5,7 @@
  * Copyright (C) 1999 - 2001 Greg Kroah-Hartman	<greg@kroah.com>
  * Copyright (C) 1999, 2000 Brian Warner	<warner@lothar.com>
  * Copyright (C) 2000 Al Borchers		<borchers@steinerpoint.com>
+ * Copyright (C) 2020 Johan Hovold <johan@kernel.org>
  *
  * See Documentation/usb/usb-serial.rst for more information on using this
  * driver
@@ -37,7 +38,7 @@
 	#undef XIRCOM
 #endif
 
-#define DRIVER_AUTHOR "Brian Warner <warner@lothar.com>"
+#define DRIVER_AUTHOR "Brian Warner <warner@lothar.com>, Johan Hovold <johan@kernel.org>"
 #define DRIVER_DESC "USB Keyspan PDA Converter driver"
 
 #define KEYSPAN_TX_THRESHOLD	128
@@ -49,6 +50,7 @@ struct keyspan_pda_private {
 	struct usb_serial_port	*port;
 };
 
+static int keyspan_pda_write_start(struct usb_serial_port *port);
 
 #define KEYSPAN_VENDOR_ID		0x06cd
 #define KEYSPAN_PDA_FAKE_ID		0x0103
@@ -228,6 +230,9 @@ static void keyspan_pda_rx_interrupt(struct urb *urb)
 			spin_lock_irqsave(&port->lock, flags);
 			priv->tx_room = max(priv->tx_room, KEYSPAN_TX_THRESHOLD);
 			spin_unlock_irqrestore(&port->lock, flags);
+
+			keyspan_pda_write_start(port);
+
 			/* queue up a wakeup at scheduler time */
 			usb_serial_port_softint(port);
 			break;
@@ -482,15 +487,15 @@ static int keyspan_pda_tiocmset(struct tty_struct *tty,
 	return rc;
 }
 
-static int keyspan_pda_write(struct tty_struct *tty,
-	struct usb_serial_port *port, const unsigned char *buf, int count)
+static int keyspan_pda_write_start(struct usb_serial_port *port)
 {
-	struct keyspan_pda_private *priv;
+	struct keyspan_pda_private *priv = usb_get_serial_port_data(port);
 	unsigned long flags;
+	struct urb *urb;
+	int count;
 	int room;
 	int rc;
 
-	priv = usb_get_serial_port_data(port);
 	/*
 	 * Guess how much room is left in the device's ring buffer. If our
 	 * write will result in no room left, ask the device to give us an
@@ -499,50 +504,48 @@ static int keyspan_pda_write(struct tty_struct *tty,
 	 * too conservative and the buffer is already empty when the
 	 * unthrottle work is scheduled).
 	 */
-	if (count == 0) {
-		dev_dbg(&port->dev, "write request of 0 bytes\n");
-		return 0;
-	}
-
-	if (count > port->bulk_out_size)
-		count = port->bulk_out_size;
 
 	/* we might block because of:
 	   the TX urb is in-flight (wait until it completes)
 	   the device is full (wait until it says there is room)
 	*/
 	spin_lock_irqsave(&port->lock, flags);
+
 	room = priv->tx_room;
-	if (!test_bit(0, &port->write_urbs_free) || room == 0) {
+	count = kfifo_len(&port->write_fifo);
+
+	if (!test_bit(0, &port->write_urbs_free) || count == 0 || room == 0) {
 		spin_unlock_irqrestore(&port->lock, flags);
 		return 0;
 	}
-	clear_bit(0, &port->write_urbs_free);
+	__clear_bit(0, &port->write_urbs_free);
+
 	if (count > room)
 		count = room;
+	if (count > port->bulk_out_size)
+		count = port->bulk_out_size;
+
+	urb = port->write_urb;
+	count = kfifo_out(&port->write_fifo, urb->transfer_buffer, count);
+	urb->transfer_buffer_length = count;
+
+	port->tx_bytes += count;
 	priv->tx_room -= count;
-	spin_unlock_irqrestore(&port->lock, flags);
 
-	/* At this point the URB is in our control, nobody else can submit it
-	   again (the only sudden transition was the one from EINPROGRESS to
-	   finished).  Also, the tx process is not throttled. So we are
-	   ready to write. */
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	dev_dbg(&port->dev, "%s - count = %d, txroom = %d\n", __func__, count, room);
 
-	memcpy(port->write_urb->transfer_buffer, buf, count);
-	port->write_urb->transfer_buffer_length = count;
-
-	rc = usb_submit_urb(port->write_urb, GFP_ATOMIC);
+	rc = usb_submit_urb(urb, GFP_ATOMIC);
 	if (rc) {
 		dev_dbg(&port->dev, "usb_submit_urb(write bulk) failed\n");
 
 		spin_lock_irqsave(&port->lock, flags);
+		port->tx_bytes -= count;
 		priv->tx_room = max(priv->tx_room, room + count);
+		__set_bit(0, &port->write_urbs_free);
 		spin_unlock_irqrestore(&port->lock, flags);
 
-		set_bit(0, &port->write_urbs_free);
-
 		return rc;
 	}
 
@@ -555,51 +558,38 @@ static int keyspan_pda_write(struct tty_struct *tty,
 static void keyspan_pda_write_bulk_callback(struct urb *urb)
 {
 	struct usb_serial_port *port = urb->context;
-	struct keyspan_pda_private *priv;
+	unsigned long flags;
 
-	set_bit(0, &port->write_urbs_free);
-	priv = usb_get_serial_port_data(port);
+	spin_lock_irqsave(&port->lock, flags);
+	port->tx_bytes -= urb->transfer_buffer_length;
+	__set_bit(0, &port->write_urbs_free);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	keyspan_pda_write_start(port);
 
 	/* queue up a wakeup at scheduler time */
 	usb_serial_port_softint(port);
 }
 
-
-static int keyspan_pda_write_room(struct tty_struct *tty)
+static int keyspan_pda_write(struct tty_struct *tty, struct usb_serial_port *port,
+		const unsigned char *buf, int count)
 {
-	struct usb_serial_port *port = tty->driver_data;
-	struct keyspan_pda_private *priv = usb_get_serial_port_data(port);
-	unsigned long flags;
-	int room = 0;
-
-	spin_lock_irqsave(&port->lock, flags);
-	if (test_bit(0, &port->write_urbs_free))
-		room = priv->tx_room;
-	spin_unlock_irqrestore(&port->lock, flags);
+	int rc;
 
-	return room;
-}
+	dev_dbg(&port->dev, "%s - count = %d\n", __func__, count);
 
-static int keyspan_pda_chars_in_buffer(struct tty_struct *tty)
-{
-	struct usb_serial_port *port = tty->driver_data;
-	struct keyspan_pda_private *priv;
-	unsigned long flags;
-	int ret = 0;
+	if (!count)
+		return 0;
 
-	priv = usb_get_serial_port_data(port);
+	count = kfifo_in_locked(&port->write_fifo, buf, count, &port->lock);
 
-	/* when throttled, return at least WAKEUP_CHARS to tell select() (via
-	   n_tty.c:normal_poll() ) that we're not writeable. */
+	rc = keyspan_pda_write_start(port);
+	if (rc)
+		return rc;
 
-	spin_lock_irqsave(&port->lock, flags);
-	if (!test_bit(0, &port->write_urbs_free) || priv->tx_room == 0)
-		ret = 256;
-	spin_unlock_irqrestore(&port->lock, flags);
-	return ret;
+	return count;
 }
 
-
 static void keyspan_pda_dtr_rts(struct usb_serial_port *port, int on)
 {
 	struct usb_serial *serial = port->serial;
@@ -640,12 +630,19 @@ static void keyspan_pda_close(struct usb_serial_port *port)
 {
 	struct keyspan_pda_private *priv = usb_get_serial_port_data(port);
 
-	usb_kill_urb(port->write_urb);
+	/*
+	 * Stop the interrupt URB first as its completion handler may submit
+	 * the write URB.
+	 */
 	usb_kill_urb(port->interrupt_in_urb);
+	usb_kill_urb(port->write_urb);
 
 	cancel_work_sync(&priv->unthrottle_work);
-}
 
+	spin_lock_irq(&port->lock);
+	kfifo_reset(&port->write_fifo);
+	spin_unlock_irq(&port->lock);
+}
 
 /* download the firmware to a "fake" device (pre-renumeration) */
 static int keyspan_pda_fake_startup(struct usb_serial *serial)
@@ -759,10 +756,8 @@ static struct usb_serial_driver keyspan_pda_device = {
 	.open =			keyspan_pda_open,
 	.close =		keyspan_pda_close,
 	.write =		keyspan_pda_write,
-	.write_room =		keyspan_pda_write_room,
 	.write_bulk_callback = 	keyspan_pda_write_bulk_callback,
 	.read_int_callback =	keyspan_pda_rx_interrupt,
-	.chars_in_buffer =	keyspan_pda_chars_in_buffer,
 	.throttle =		keyspan_pda_rx_throttle,
 	.unthrottle =		keyspan_pda_rx_unthrottle,
 	.set_termios =		keyspan_pda_set_termios,
-- 
2.26.2

