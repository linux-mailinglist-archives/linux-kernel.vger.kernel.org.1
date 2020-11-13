Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB172B1BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgKMNRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:17:17 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44899 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMNRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:17:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id r9so13744401lfn.11;
        Fri, 13 Nov 2020 05:17:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Guc1BdARztfEwKj+vAVKyR5395awEZYrrg6JPhwIZUw=;
        b=SYFbiZEfDBqSOs/s2JVPiOQIsg+ZyXQcvzpsxPm+qzUI2AIuZE4w2N3miCAuUmY0Gz
         FLaqVCUc3o7BW4TBQvkslRdROaUjZmpIie8ZCniBz/XtgIM866QyYtTmzB/CiejR7M46
         RXfv/UKfOguJ9UQ5FFmiBVzRPK2qrHJZidfX7SFd2myOBN4UEtkqjmzdjeXuy95pW400
         sx4AYWGQZRWtuIXQCDZHX2GUl4wMV35xFkGu1t1kKpHQtA3QJ8J+7I+AdlWFd46O9XwA
         bOJwsP+vfKNKVQ7IsgjTBGOsxd1L49OAotj5MjUKZc+eW+ux4q4BqBk2tX3XpSeLkQjh
         H7jw==
X-Gm-Message-State: AOAM531D7NBbVVusD1vSU5HRt/U+pSxymbW5NO2PI8oGX0WjRScZ3gPI
        KRg9Z3Fo7CPKBsxHYhofn64=
X-Google-Smtp-Source: ABdhPJx+z5mZzQL5vUI6a+7Qx+KBR5QZIdsz0b+/Xs8cmzGkvN90DBZzqA6qMLjDCdTYP+9KV/NZwA==
X-Received: by 2002:a19:c815:: with SMTP id y21mr995666lff.589.1605273430010;
        Fri, 13 Nov 2020 05:17:10 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id x18sm1578099ljh.125.2020.11.13.05.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:17:08 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kdYx2-0001ql-Gb; Fri, 13 Nov 2020 14:17:17 +0100
Date:   Fri, 13 Nov 2020 14:17:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bertold Van den Bergh <vandenbergh@bertold.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb-serial: support NAL Research Corporation Iridium
 modems
Message-ID: <20201113131716.GK4085@localhost>
References: <20201020155426.9919-1-vandenbergh@bertold.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020155426.9919-1-vandenbergh@bertold.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 05:54:26PM +0200, Bertold Van den Bergh wrote:
> This driver is for NAL Reserach Corporation Iridium modems with USB.

"Research"

> There are different variants of the bus protocol, but the driver should
> detect this automatically.

Do you mean that this is something to be implemented?

> Signed-off-by: Bertold Van den Bergh <vandenbergh@bertold.org>
> ---
>  Documentation/usb/usb-serial.rst |  15 ++
>  drivers/usb/serial/Kconfig       |   9 +
>  drivers/usb/serial/Makefile      |   1 +
>  drivers/usb/serial/nal.c         | 357 +++++++++++++++++++++++++++++++
>  4 files changed, 382 insertions(+)
>  create mode 100644 drivers/usb/serial/nal.c
> 
> diff --git a/Documentation/usb/usb-serial.rst b/Documentation/usb/usb-serial.rst
> index 8fa7dbd3d..fdc8c0c76 100644
> --- a/Documentation/usb/usb-serial.rst
> +++ b/Documentation/usb/usb-serial.rst
> @@ -494,6 +494,21 @@ Moschip MCS7720, MCS7715 driver
>        with this driver with a simple addition to the usb_device_id table.  I
>        don't have one of these devices, so I can't say for sure.
>  
> +NAL Research Corporation driver
> +-------------------------------
> +
> +  This driver is for NAL Reserach Corporation Iridium modems with USB.

Same typo.

> +  There are different variants of the bus protocol, but the driver should
> +  detect this automatically.
> +
> +  The manufacturer provided Windows driver attaches to all PIDs in the given
> +  VID, so you may want to try this driver even if the PID doesn't match.
> +
> +  The manufacturer's website: https://www.nalresearch.com/
> +
> +  For any questions or problems with this driver, please contact:
> +  Bertold Van den Bergh <vandenbergh@bertold.org>
> +
>  Generic Serial driver
>  ---------------------
>  
> diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
> index 4007fa25a..f97c44068 100644
> --- a/drivers/usb/serial/Kconfig
> +++ b/drivers/usb/serial/Kconfig
> @@ -436,6 +436,15 @@ config USB_SERIAL_MXUPORT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called mxuport.
>  
> +config USB_SERIAL_NAL
> +	tristate "USB NAL Research Corporation Serial Bridge"
> +	help
> +	  Say Y here if you want to use NAL Research Corporation
> +	  USB devices.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called nal.
> +
>  config USB_SERIAL_NAVMAN
>  	tristate "USB Navman GPS device"
>  	help
> diff --git a/drivers/usb/serial/Makefile b/drivers/usb/serial/Makefile
> index 2d491e434..f3cbe972f 100644
> --- a/drivers/usb/serial/Makefile
> +++ b/drivers/usb/serial/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_USB_SERIAL_METRO)			+= metro-usb.o
>  obj-$(CONFIG_USB_SERIAL_MOS7720)		+= mos7720.o
>  obj-$(CONFIG_USB_SERIAL_MOS7840)		+= mos7840.o
>  obj-$(CONFIG_USB_SERIAL_MXUPORT)		+= mxuport.o
> +obj-$(CONFIG_USB_SERIAL_NAL)			+= nal.o
>  obj-$(CONFIG_USB_SERIAL_NAVMAN)			+= navman.o
>  obj-$(CONFIG_USB_SERIAL_OMNINET)		+= omninet.o
>  obj-$(CONFIG_USB_SERIAL_OPTICON)		+= opticon.o
> diff --git a/drivers/usb/serial/nal.c b/drivers/usb/serial/nal.c
> new file mode 100644
> index 000000000..e3272cd5e
> --- /dev/null
> +++ b/drivers/usb/serial/nal.c
> @@ -0,0 +1,357 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for NAL Research Corporation USB serial converter.
> + * Tested using A3LA-XG.
> + *
> + * Copyright (C) 2020 Bertold Van den Bergh (vandenbergh@bertold.org)
> + *

Please provide some details on the protocol here. What are the header
types, that you use a bulk pipe for modem control, etc.

> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/slab.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +#include <linux/module.h>
> +#include <linux/usb.h>
> +#include <linux/usb/serial.h>
> +#include <linux/mutex.h>
> +#include <linux/spinlock.h>
> +#include <linux/workqueue.h>
> +
> +static const struct usb_device_id id_table[] = {
> +	{ USB_DEVICE(0x2017, 0x0001) },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(usb, id_table);
> +
> +struct nal_serial_private {
> +	struct usb_device       *dev;
> +	struct mutex             cmd_mutex; //Mutex for sharing cmd_buf

Please don't use // comments and shorten to something like

	/* protects cmd_buf */

> +	unsigned char            cmd_buf[64];
> +
> +	spinlock_t               lock;      //Lock for sharing next three entries

Here too.

> +	unsigned char            control_get;
> +	unsigned char            control_put;
> +	unsigned char            header_type;
> +
> +	wait_queue_head_t        control_event;
> +
> +	struct workqueue_struct *work_queue;
> +	struct work_struct       control_work;
> +	struct work_struct       data_work;
> +};
> +
> +static int nal_prepare_write_buffer(struct usb_serial_port *port,
> +				    void *buf, size_t count);
> +static void nal_process_read_urb(struct urb *urb);
> +static int nal_request(struct nal_serial_private *priv, int type);
> +static void nal_data_work(struct work_struct *work);
> +static int nal_tiocmget(struct tty_struct *tty);
> +static int nal_send_control(struct nal_serial_private *priv,
> +			    unsigned int set, unsigned int clear);
> +static int nal_tiocmset(struct tty_struct *tty,
> +			unsigned int set, unsigned int clear);
> +static void nal_dtr_rts(struct usb_serial_port *port, int on);
> +static void nal_control_work(struct work_struct *work);
> +static int nal_port_probe(struct usb_serial_port *serial);
> +static int nal_port_remove(struct usb_serial_port *serial);
> +
> +static struct usb_serial_driver nal_device = {
> +	.driver = {
> +		.owner =	THIS_MODULE,
> +		.name =		"nal",
> +	},
> +	.id_table		= id_table,
> +	.num_ports		= 1,
> +	.tiocmget		= nal_tiocmget,
> +	.tiocmset		= nal_tiocmset,
> +	.port_probe		= nal_port_probe,
> +	.port_remove		= nal_port_remove,
> +	.dtr_rts		= nal_dtr_rts,
> +	.process_read_urb       = nal_process_read_urb,
> +	.prepare_write_buffer   = nal_prepare_write_buffer
> +};
> +
> +static struct usb_serial_driver * const serial_drivers[] = {
> +	&nal_device, NULL
> +};

Move the driver structures to the end of the file and drop the function
prototypes (may need to reorder some functions).

> +
> +#define CONTROL_DSR (1)
> +#define CONTROL_CD  (2)
> +#define CONTROL_RI  (4)
> +#define CONTROL_CTS (8)
> +#define CONTROL_DTR (16)
> +#define CONTROL_RTS (32)

No need for parentheses, use BIT(n).

> +
> +static int nal_prepare_write_buffer(struct usb_serial_port *port,
> +				    void *buf, size_t count)
> +{
> +	struct nal_serial_private *priv = usb_get_serial_port_data(port);
> +	unsigned char *header = (unsigned char *)buf;

Cast not needed.

> +	unsigned char header_type, cout;
> +
> +	spin_lock(&priv->lock);

You need to disable interrupts also in the completion handlers (which
may run in soft-interrupt context); use spin_lock_irqsave().

> +	header_type = priv->header_type;
> +	spin_unlock(&priv->lock);
> +
> +	count = min_t(size_t, count, 64 - header_type);

Please clarify how the max-packet size correlates with the header types
by using a helper function (and defines for the types).

> +
> +	cout = kfifo_out_locked(&port->write_fifo, buf + header_type,
> +				count, &port->lock) + header_type;

Is header type really a header length?

> +
> +	header[0] = 5;

What's 5 here? Use a defines for magic constants throughout.

> +
> +	if (!header_type) {
> +		return 0;

You're throwing away data here.

> +	} else if (header_type == 2) {
> +		header[1] = count;
> +		return 64;

What if there wasn't 64 bytes in the fifo? Should the stale buffer data
be cleared?

> +	}
> +
> +	return cout;
> +}
> +
> +static void nal_process_read_urb(struct urb *urb)
> +{
> +	struct usb_serial_port *port = urb->context;
> +	struct nal_serial_private *priv = usb_get_serial_port_data(port);
> +	const unsigned char *buf = (const unsigned char *)urb->transfer_buffer;

Cast not needed.

> +	unsigned char length;
> +
> +	if (urb->actual_length < 1)
> +		return;
> +
> +	if (!priv->header_type && urb->actual_length < 64) {
> +		spin_lock(&priv->lock);
> +		priv->header_type = 1;
> +		spin_unlock(&priv->lock);
> +	}

Can you do the header type (protocol?) detection at probe somehow
instead? Send a request and read it back synchronously?

> +
> +	if (priv->header_type != 1)
> +		schedule_work(&priv->data_work);

What's going on here? Looks like you're polling for data, but that
should be made clear here (use a helper function, or at least add a
comment).

How does it depend on the header type?

> +
> +	if (buf[0] == 5 && urb->actual_length >= 2) {
> +		if (!priv->header_type) {
> +			return;

Throwing away data if you haven't yet detected the protocol?

> +		} else if (priv->header_type == 1) {
> +			tty_insert_flip_string(&port->port, buf + 1,
> +					       urb->actual_length - 1);
> +		} else {
> +			length = buf[1];
> +			if (length > urb->actual_length - 2)
> +				length = urb->actual_length - 2;
> +
> +			tty_insert_flip_string(&port->port, buf + 2, length);
> +		}
> +
> +		tty_flip_buffer_push(&port->port);
> +	} else if (buf[0] == 0 && urb->actual_length >= 2) {
> +		spin_lock(&priv->lock);
> +		priv->control_get = 0x80 | buf[1];

What's going on here? What is command/reply "0"? Use a define.

What is 0x80? Use a define.

> +		if (!priv->header_type && urb->actual_length == 64)
> +			priv->header_type = 2;
> +		spin_unlock(&priv->lock);
> +
> +		wake_up(&priv->control_event);
> +	} else if (buf[0] == 1) {

What's "1"? You get the point...

> +		schedule_work(&priv->control_work);

And why do you need to set the control lines on a device request here?

> +	} else {
> +		dev_info(&priv->dev->dev, "Unsupported input (length=%u): %02x\n",
> +			 urb->actual_length, buf[0]);

Use &port->dev for messages, and this one should be demoted to
dev_dbg().

> +	}
> +}
> +
> +static int nal_request(struct nal_serial_private *priv, int type)
> +{
> +	int ret_val;

Please use the shorter "ret" throughout.

> +
> +	mutex_lock(&priv->cmd_mutex);
> +
> +	/* type==0: Request control lines
> +	 * type==1: Request application data
> +	 */

Use an enum or defines for the request types.

Comment style should be

	/*
	 * ...
	 */

> +	priv->cmd_buf[0] = type ? 0x04 : 0x01;
> +	priv->cmd_buf[1] = 0xFF;

Defines.

> +
> +	ret_val = usb_bulk_msg(priv->dev, usb_sndbulkpipe(priv->dev, 1),
> +			       priv->cmd_buf, 64, NULL, HZ);

Timeout is specified in milliseconds and should not depend on HZ.

Note that cmd_buf must be allocated separately from priv as it may be
mapped for DMA.

> +
> +	mutex_unlock(&priv->cmd_mutex);
> +
> +	return ret_val;
> +}
> +
> +static void nal_data_work(struct work_struct *work)
> +{
> +	struct nal_serial_private *priv =
> +		container_of(work, struct nal_serial_private, data_work);
> +
> +	nal_request(priv, 1);
> +}
> +
> +static int nal_tiocmget(struct tty_struct *tty)
> +{
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct nal_serial_private *priv = usb_get_serial_port_data(port);
> +	int ret_val, control = 0;
> +
> +	spin_lock(&priv->lock);

You must disable interrupt when taking this lock (throughout).

> +	priv->control_get = 0;
> +	spin_unlock(&priv->lock);
> +
> +	ret_val = nal_request(priv, 0);
> +	if (ret_val)
> +		return ret_val;
> +
> +	while (!control) {

do-while

> +		ret_val = wait_event_interruptible_timeout(priv->control_event,
> +							   priv->control_get > 0, HZ);

Looks like this could be simplified by using a struct completion and
calling wait_for_completion_interruptible_timeout() here instead. Just
store the latest modem control status in the completion handler and call
complete().

> +		if (ret_val == 0)
> +			ret_val = -ETIMEDOUT;
> +		if (ret_val < 0)
> +			return ret_val;
> +
> +		spin_lock(&priv->lock);
> +		control = priv->control_get;
> +		spin_unlock(&priv->lock);
> +	}
> +
> +	ret_val = ((control & CONTROL_DSR) ? TIOCM_DSR : 0) |
> +		 ((control & CONTROL_CD)  ? TIOCM_CD  : 0) |
> +		 ((control & CONTROL_RI)  ? TIOCM_RI  : 0) |
> +		 ((control & CONTROL_CTS) ? TIOCM_CTS : 0);
> +
> +	spin_lock(&priv->lock);
> +	control = priv->control_put;
> +	spin_unlock(&priv->lock);

Are DTR and RTS included in the bulk response you get? If so you may not
need to store control_put at all. Just return the latest values returned
by the device.

> +
> +	ret_val |= ((control & CONTROL_DTR) ? TIOCM_DTR : 0) |
> +		  ((control & CONTROL_RTS) ? TIOCM_RTS : 0);
> +
> +	return ret_val;
> +}
> +
> +static int nal_send_control(struct nal_serial_private *priv,
> +			    unsigned int set, unsigned int clear)
> +{
> +	int ret_val, control;
> +
> +	mutex_lock(&priv->cmd_mutex);
> +
> +	spin_lock(&priv->lock);
> +	if (set & TIOCM_RTS)
> +		priv->control_put |= CONTROL_RTS;
> +	if (set & TIOCM_DTR)
> +		priv->control_put |= CONTROL_DTR;
> +	if (clear & TIOCM_RTS)
> +		priv->control_put &= ~CONTROL_RTS;
> +	if (clear & TIOCM_DTR)
> +		priv->control_put &= ~CONTROL_DTR;
> +
> +	control = priv->control_put;
> +	spin_unlock(&priv->lock);
> +
> +	priv->cmd_buf[0] = 0x00;
> +	priv->cmd_buf[1] = 0x0d | control;
> +
> +	ret_val = usb_bulk_msg(priv->dev, usb_sndbulkpipe(priv->dev, 1),
> +			       priv->cmd_buf, 64, NULL, HZ);
> +
> +	mutex_unlock(&priv->cmd_mutex);
> +
> +	return ret_val;
> +}
> +
> +static int nal_tiocmset(struct tty_struct *tty,
> +			unsigned int set, unsigned int clear)
> +{
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct nal_serial_private *priv = usb_get_serial_port_data(port);
> +
> +	return nal_send_control(priv, set, clear);
> +}
> +
> +static void nal_dtr_rts(struct usb_serial_port *port, int enable)
> +{
> +	struct nal_serial_private *priv = usb_get_serial_port_data(port);
> +
> +	if (enable)
> +		nal_send_control(priv, TIOCM_RTS | TIOCM_DTR, 0);
> +	else
> +		nal_send_control(priv, 0, TIOCM_RTS | TIOCM_DTR);
> +}
> +
> +static void nal_control_work(struct work_struct *work)
> +{
> +	struct nal_serial_private *priv =
> +		container_of(work, struct nal_serial_private, control_work);
> +
> +	nal_send_control(priv, 0, 0);
> +}
> +
> +static int nal_port_probe(struct usb_serial_port *serial)
> +{
> +	struct nal_serial_private *priv;
> +	int ret_val;
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = serial->serial->dev;
> +	spin_lock_init(&priv->lock);
> +	init_waitqueue_head(&priv->control_event);
> +	mutex_init(&priv->cmd_mutex);
> +
> +	priv->work_queue = alloc_workqueue("nal_wq", 0, 0);
> +	if (!priv->work_queue) {
> +		ret_val = -ENOMEM;
> +		goto fail_queue;
> +	}

You never use the work queue so remove it.

> +
> +	usb_set_serial_port_data(serial, priv);
> +
> +	INIT_WORK(&priv->control_work, nal_control_work);
> +	INIT_WORK(&priv->data_work, nal_data_work);
> +
> +	/* Used for header autodetect */
> +	ret_val = nal_request(priv, 0);

Again, what is 0...

So this is used to trigger a reply that you read when the port is
opened?

> +	if (ret_val < 0)
> +		goto fail_probe;
> +
> +	ret_val = nal_send_control(priv, TIOCM_RTS | TIOCM_DTR, 0);
> +	if (ret_val < 0)
> +		goto fail_probe;

This is taken care of by the dtr_rts callback on open().

> +
> +	return 0;
> +
> +fail_probe:
> +	cancel_work_sync(&priv->data_work);
> +	cancel_work_sync(&priv->control_work);

These cannot possibly be scheduled yet, right? Can you cancel (or flush)
them on close instead?

> +	destroy_workqueue(priv->work_queue);
> +fail_queue:
> +	kfree(priv);
> +	return ret_val;

Name labels after what they do rather than where you jump from (e.g.
"err_cancel_work" and "err_free").

> +}
> +
> +static int nal_port_remove(struct usb_serial_port *serial)
> +{
> +	struct nal_serial_private *priv = usb_get_serial_port_data(serial);
> +
> +	cancel_work_sync(&priv->data_work);
> +	cancel_work_sync(&priv->control_work);
> +	destroy_workqueue(priv->work_queue);
> +	kfree(priv);
> +
> +	return 0;
> +}
> +
> +module_usb_serial_driver(serial_drivers, id_table);
> +
> +#define AUTHOR "Bertold Van den Bergh <vandenbergh@bertold.org>"
> +#define DESC   "Driver for NAL Research Corporation USB serial interface"

No need for these, just use the module macros directly.

> +MODULE_AUTHOR(AUTHOR);
> +MODULE_DESCRIPTION(DESC);
> +MODULE_LICENSE("GPL v2");

The shorter "GPL" means the same here.

Ok, I think I get the protocol now, but it really shouldn't take that
much effort. You need to go through the driver and add helper functions
and/or aptly named defines so that the protocol becomes more or less
obvious to someone looking at this code. And please add a short overview
of the protocol to the file header.

Johan
