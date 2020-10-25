Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DE92982FC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 19:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417805AbgJYSCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 14:02:09 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41995 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437136AbgJYSCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 14:02:08 -0400
Received: by mail-lf1-f66.google.com with SMTP id a7so8929843lfk.9;
        Sun, 25 Oct 2020 11:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MYxrGPwPmNlWY3Qwx3a7M1zBcj46Y4g6IU5EjbG12vA=;
        b=Q9tDIlb0adTetHZP0xF4OihPn6LUvzZykcS1HysN+JA3x6uNYopuYPYxKLqpJFwKi/
         YRzLE9woyYH8ftiuOhlcbFOlF54rZCrxT0/WO6gjUhkWKY1xdewvr7OYTbFEPGyYn378
         HwaE1x6mgDZhSWxp/N4FKLxzG79DePIQok7NUBKtgq5uUX3kIBB5UYFKv3y7RkyPZp9B
         LqmzmaOxGkkf3oJnDELPPCNik7hLznpEsg7r0ouWqC2fl6a8oxLr7NknKTWaHJIzO6k7
         kDXKSTqXVa0eRQS7zhB933q3PkpPAKi7CgHd/pRPQXa9nFps0dRJcdXPj00yTmCi7jZe
         WB8A==
X-Gm-Message-State: AOAM533Spd8CIMTM114hiPjOjtcYTq6AGQ+cNXr5rgVLSOOGvt0xPp6V
        GVmCBZFBDM3sJGolV3b5YEn4C16CTho1jw==
X-Google-Smtp-Source: ABdhPJwjCHr0Va2ItWvQ3V06dkbEmIwTzfuW608yK9FwVSxCpUDDHK+X5gKeq3tcQOClLU2dnalBfQ==
X-Received: by 2002:a19:8488:: with SMTP id g130mr3872370lfd.424.1603648923737;
        Sun, 25 Oct 2020 11:02:03 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id y5sm797192lff.179.2020.10.25.11.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 11:02:02 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kWk6J-0007I3-ED; Sun, 25 Oct 2020 18:46:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 12/14] USB: serial: keyspan_pda: clean up comments and whitespace
Date:   Sun, 25 Oct 2020 18:45:58 +0100
Message-Id: <20201025174600.27896-13-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201025174600.27896-1-johan@kernel.org>
References: <20201025174600.27896-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up comment style, remove some stale or redundant comments and drop
superfluous white space.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/keyspan_pda.c | 116 +++++++++++++++----------------
 1 file changed, 56 insertions(+), 60 deletions(-)

diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index f102dbf83492..8df7c54d6986 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -11,7 +11,6 @@
  * driver
  */
 
-
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
@@ -121,8 +120,10 @@ static void keyspan_pda_request_unthrottle(struct work_struct *work)
 
 	dev_dbg(&port->dev, "%s\n", __func__);
 
-	/* ask the device to tell us when the tx buffer becomes
-	   sufficiently empty */
+	/*
+	 * Ask the device to tell us when the tx buffer becomes
+	 * sufficiently empty.
+	 */
 	result = usb_control_msg(serial->dev,
 				 usb_sndctrlpipe(serial->dev, 0),
 				 7, /* request_unthrottle */
@@ -208,7 +209,6 @@ static void keyspan_pda_rx_interrupt(struct urb *urb)
 
 			keyspan_pda_write_start(port);
 
-			/* queue up a wakeup at scheduler time */
 			usb_serial_port_softint(port);
 			break;
 		default:
@@ -227,31 +227,30 @@ static void keyspan_pda_rx_interrupt(struct urb *urb)
 			__func__, retval);
 }
 
-
 static void keyspan_pda_rx_throttle(struct tty_struct *tty)
 {
-	/* stop receiving characters. We just turn off the URB request, and
-	   let chars pile up in the device. If we're doing hardware
-	   flowcontrol, the device will signal the other end when its buffer
-	   fills up. If we're doing XON/XOFF, this would be a good time to
-	   send an XOFF, although it might make sense to foist that off
-	   upon the device too. */
 	struct usb_serial_port *port = tty->driver_data;
 
+	/*
+	 * Stop receiving characters. We just turn off the URB request, and
+	 * let chars pile up in the device. If we're doing hardware
+	 * flowcontrol, the device will signal the other end when its buffer
+	 * fills up. If we're doing XON/XOFF, this would be a good time to
+	 * send an XOFF, although it might make sense to foist that off upon
+	 * the device too.
+	 */
 	usb_kill_urb(port->interrupt_in_urb);
 }
 
-
 static void keyspan_pda_rx_unthrottle(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
-	/* just restart the receive interrupt URB */
 
+	/* just restart the receive interrupt URB */
 	if (usb_submit_urb(port->interrupt_in_urb, GFP_KERNEL))
 		dev_dbg(&port->dev, "usb_submit_urb(read urb) failed\n");
 }
 
-
 static speed_t keyspan_pda_setbaud(struct usb_serial *serial, speed_t baud)
 {
 	int rc;
@@ -293,8 +292,6 @@ static speed_t keyspan_pda_setbaud(struct usb_serial *serial, speed_t baud)
 		baud = 9600;
 	}
 
-	/* rather than figure out how to sleep while waiting for this
-	   to complete, I just use the "legacy" API. */
 	rc = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
 			     0, /* set baud */
 			     USB_TYPE_VENDOR
@@ -307,10 +304,10 @@ static speed_t keyspan_pda_setbaud(struct usb_serial *serial, speed_t baud)
 			     2000); /* timeout */
 	if (rc < 0)
 		return 0;
+
 	return baud;
 }
 
-
 static void keyspan_pda_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
@@ -322,6 +319,7 @@ static void keyspan_pda_break_ctl(struct tty_struct *tty, int break_state)
 		value = 1; /* start break */
 	else
 		value = 0; /* clear break */
+
 	result = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
 			4, /* set break */
 			USB_TYPE_VENDOR | USB_RECIP_INTERFACE | USB_DIR_OUT,
@@ -329,39 +327,35 @@ static void keyspan_pda_break_ctl(struct tty_struct *tty, int break_state)
 	if (result < 0)
 		dev_dbg(&port->dev, "%s - error %d from usb_control_msg\n",
 			__func__, result);
-	/* there is something funky about this.. the TCSBRK that 'cu' performs
-	   ought to translate into a break_ctl(-1),break_ctl(0) pair HZ/4
-	   seconds apart, but it feels like the break sent isn't as long as it
-	   is on /dev/ttyS0 */
 }
 
-
 static void keyspan_pda_set_termios(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
 	struct usb_serial *serial = port->serial;
 	speed_t speed;
 
-	/* cflag specifies lots of stuff: number of stop bits, parity, number
-	   of data bits, baud. What can the device actually handle?:
-	   CSTOPB (1 stop bit or 2)
-	   PARENB (parity)
-	   CSIZE (5bit .. 8bit)
-	   There is minimal hw support for parity (a PSW bit seems to hold the
-	   parity of whatever is in the accumulator). The UART either deals
-	   with 10 bits (start, 8 data, stop) or 11 bits (start, 8 data,
-	   1 special, stop). So, with firmware changes, we could do:
-	   8N1: 10 bit
-	   8N2: 11 bit, extra bit always (mark?)
-	   8[EOMS]1: 11 bit, extra bit is parity
-	   7[EOMS]1: 10 bit, b0/b7 is parity
-	   7[EOMS]2: 11 bit, b0/b7 is parity, extra bit always (mark?)
-
-	   HW flow control is dictated by the tty->termios.c_cflags & CRTSCTS
-	   bit.
-
-	   For now, just do baud. */
-
+	/*
+	 * cflag specifies lots of stuff: number of stop bits, parity, number
+	 * of data bits, baud. What can the device actually handle?:
+	 * CSTOPB (1 stop bit or 2)
+	 * PARENB (parity)
+	 * CSIZE (5bit .. 8bit)
+	 * There is minimal hw support for parity (a PSW bit seems to hold the
+	 * parity of whatever is in the accumulator). The UART either deals
+	 * with 10 bits (start, 8 data, stop) or 11 bits (start, 8 data,
+	 * 1 special, stop). So, with firmware changes, we could do:
+	 * 8N1: 10 bit
+	 * 8N2: 11 bit, extra bit always (mark?)
+	 * 8[EOMS]1: 11 bit, extra bit is parity
+	 * 7[EOMS]1: 10 bit, b0/b7 is parity
+	 * 7[EOMS]2: 11 bit, b0/b7 is parity, extra bit always (mark?)
+	 *
+	 * HW flow control is dictated by the tty->termios.c_cflags & CRTSCTS
+	 * bit.
+	 *
+	 * For now, just do baud.
+	 */
 	speed = tty_get_baud_rate(tty);
 	speed = keyspan_pda_setbaud(serial, speed);
 
@@ -370,17 +364,19 @@ static void keyspan_pda_set_termios(struct tty_struct *tty,
 		/* It hasn't changed so.. */
 		speed = tty_termios_baud_rate(old_termios);
 	}
-	/* Only speed can change so copy the old h/w parameters
-	   then encode the new speed */
+	/*
+	 * Only speed can change so copy the old h/w parameters then encode
+	 * the new speed.
+	 */
 	tty_termios_copy_hw(&tty->termios, old_termios);
 	tty_encode_baud_rate(tty, speed, speed);
 }
 
-
-/* modem control pins: DTR and RTS are outputs and can be controlled.
-   DCD, RI, DSR, CTS are inputs and can be read. All outputs can also be
-   read. The byte passed is: DTR(b7) DCD RI DSR CTS RTS(b2) unused unused */
-
+/*
+ * Modem control pins: DTR and RTS are outputs and can be controlled.
+ * DCD, RI, DSR, CTS are inputs and can be read. All outputs can also be
+ * read. The byte passed is: DTR(b7) DCD RI DSR CTS RTS(b2) unused unused.
+ */
 static int keyspan_pda_get_modem_info(struct usb_serial *serial,
 				      unsigned char *value)
 {
@@ -404,7 +400,6 @@ static int keyspan_pda_get_modem_info(struct usb_serial *serial,
 	return rc;
 }
 
-
 static int keyspan_pda_set_modem_info(struct usb_serial *serial,
 				      unsigned char value)
 {
@@ -480,10 +475,11 @@ static int keyspan_pda_write_start(struct usb_serial_port *port)
 	 * unthrottle work is scheduled).
 	 */
 
-	/* we might block because of:
-	   the TX urb is in-flight (wait until it completes)
-	   the device is full (wait until it says there is room)
-	*/
+	/*
+	 * We might block because of:
+	 * the TX urb is in-flight (wait until it completes)
+	 * the device is full (wait until it says there is room)
+	 */
 	spin_lock_irqsave(&port->lock, flags);
 
 	room = priv->tx_room;
@@ -542,7 +538,6 @@ static void keyspan_pda_write_bulk_callback(struct urb *urb)
 
 	keyspan_pda_write_start(port);
 
-	/* queue up a wakeup at scheduler time */
 	usb_serial_port_softint(port);
 }
 
@@ -591,7 +586,6 @@ static int keyspan_pda_open(struct tty_struct *tty,
 	priv->tx_room = rc;
 	spin_unlock_irq(&port->lock);
 
-	/*Start reading from the device*/
 	rc = usb_submit_urb(port->interrupt_in_urb, GFP_KERNEL);
 	if (rc) {
 		dev_dbg(&port->dev, "%s - usb_submit_urb(read int) failed\n", __func__);
@@ -648,10 +642,12 @@ static int keyspan_pda_fake_startup(struct usb_serial *serial)
 		return -ENOENT;
 	}
 
-	/* after downloading firmware Renumeration will occur in a
-	  moment and the new device will bind to the real driver */
+	/*
+	 * After downloading firmware renumeration will occur in a moment and
+	 * the new device will bind to the real driver.
+	 */
 
-	/* we want this device to fail to have a driver assigned to it. */
+	/* We want this device to fail to have a driver assigned to it. */
 	return 1;
 }
 
@@ -711,7 +707,7 @@ static struct usb_serial_driver keyspan_pda_device = {
 	.open =			keyspan_pda_open,
 	.close =		keyspan_pda_close,
 	.write =		keyspan_pda_write,
-	.write_bulk_callback = 	keyspan_pda_write_bulk_callback,
+	.write_bulk_callback =	keyspan_pda_write_bulk_callback,
 	.read_int_callback =	keyspan_pda_rx_interrupt,
 	.throttle =		keyspan_pda_rx_throttle,
 	.unthrottle =		keyspan_pda_rx_unthrottle,
-- 
2.26.2

