Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F682F9DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388338AbhARLMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:12:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388577AbhARLLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:11:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EFF2221F8;
        Mon, 18 Jan 2021 11:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610968268;
        bh=b9fZRETPTiDyHkdFZSEBtnyaZKiRqwHv+i6X2PdtEMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BKXc2g/vrmKo6wawRik0E/x9zOoUknebS1QrFMpf9YYVVuDzj6It5crcbQMsYvIaZ
         wsyOj0+vhU2NB2f5IJCzzeDLZZvJMVNgkKnu38sQpC2m8aIeLkvH/5WLl9vA5e/dnv
         KCwraPoBTKQjQATGsZHEVuW856Phjutzss2g052+mv/lz0DCMBciky9rDxEUrI7TCm
         OIZstNhK8RwwIHIhhd7kdJVtEguEQyVob7aI8UPnbZYdUkVWrEt+cVgc/kdKhFy7m9
         6rSrkG04hunzTNAoyHxr8GWv+n27ZMqMR1b7+ioEBHP59XC8MJm6gJjj/H8FmdboMa
         H/L3z4Zf7Qv7w==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l1SRF-0001Iz-UI; Mon, 18 Jan 2021 12:11:14 +0100
Date:   Mon, 18 Jan 2021 12:11:13 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Sheng Long Wang <china_shenglong@163.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkp@intel.com, Wang Sheng Long <shenglong.wang.ext@siemens.com>
Subject: Re: [PATCH v7] usb-serial:cp210x: add support to software flow
 control
Message-ID: <YAVs0Zvx9UNJ72P3@hovoldconsulting.com>
References: <20210104094502.3942-1-china_shenglong@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104094502.3942-1-china_shenglong@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 05:45:02PM +0800, Sheng Long Wang wrote:
> From: Wang Sheng Long <shenglong.wang.ext@siemens.com>
> 
> When data is transmitted between two serial ports,
> the phenomenon of data loss often occurs. The two kinds
> of flow control commonly used in serial communication
> are hardware flow control and software flow control.
> 
> In serial communication, If you only use RX/TX/GND Pins, you
> can't do hardware flow. So we often used software flow control
> and prevent data loss. The user sets the software flow control
> through the application program, and the application program
> sets the software flow control mode for the serial port
> chip through the driver.
> 
> For the cp210 serial port chip, its driver lacks the
> software flow control setting code, so the user cannot set
> the software flow control function through the application
> program. This adds the missing software flow control.
> 
> Signed-off-by: Wang Sheng Long <shenglong.wang.ext@siemens.com>
> 
> Changes in v3:
> - fixed code style, It mainly adjusts the code style acccording
>   to kernel specification.
> 
> Changes in v4:
> - It adjusts the patch based on the last usb-next branch
>   of the usb-serial.
> 
> Changes in v5:
> - Fixes:
>   * According to the cp210x specification, use usb_control_msg()
>     requesttype 'REQTYPE_DEVICE_TO_HOST' is modified to
>     'REQTYPE_INTERFACE_TO_HOST' in cp210x_get_chars().
> 
>   * If modify IXOFF/IXON has been changed, we can call set software
>     flow control code.
> 
>   * If the setting software flow control wrong, do not continue
>     processing proceed with updating software flow control.
> 
> Changes in v6:
> - Fix 'result' variable not uninitialized warning in cp210x_set_termios().
> 
> Changes in v7:
> - Fix:
>   * Rebase work code branch on cp210x-termios branch.

You obviously did not test this patch *at all* since the kernel now
oopses immediately when opening the port due to a NULL-pointer
dereference. And that's not the only bug in this patch (see below).

I rewrote the termios handling in an attempt to help you implement this
properly (e.g. instead of having you add the pieces to
cp210x_get_termios() that were missing from your initial submission),
but clearly this didn't work out as intended.

Normally I would have just asked you to fix your patch, but this is has
taken way too much of my time already. And while it's never ok to send
completely untested patches without even mentioning it, I still feel
partly responsible for they way things turned out (if you no longer have
access to the hardware, or whatever, you should have said so).

So to get this over with, I've reworked your patch properly for you and
added some further missing pieces (e.g. at least on CP2102 the XON/XOFF
threshold needs to be set for input flow control to work).

I'll post it all as a series after replying here.
 
>   * Support for software flow control to the new cp210x_set_flow_control()
>     function.
> 
>   * Modify cp210x_set_chars() parameter 'void *buf' take a pointer to
>     a struct special_chars (not void *).
> 
>   * Drop cp210x_get_chars() function.
> ---
>  drivers/usb/serial/cp210x.c | 86 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index fbb10dfc56e3..bc84834cc416 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -408,6 +408,15 @@ struct cp210x_comm_status {
>  	u8       bReserved;
>  } __packed;
>  
> +struct cp210x_special_chars {
> +	u8	bEofChar;
> +	u8	bErrorChar;
> +	u8	bBreakChar;
> +	u8	bEventChar;
> +	u8	bXonChar;
> +	u8	bXoffChar;
> +};
> +
>  /*
>   * CP210X_PURGE - 16 bits passed in wValue of USB request.
>   * SiLabs app note AN571 gives a strange description of the 4 bits:
> @@ -619,6 +628,38 @@ static int cp210x_read_vendor_block(struct usb_serial *serial, u8 type, u16 val,
>  	return result;
>  }
>  
> +
> +static int cp210x_set_chars(struct usb_serial_port *port, struct cp210x_special_chars *buf)
> +{
> +	struct usb_serial *serial = port->serial;
> +	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
> +	struct cp210x_special_chars *special_chars;

This pointer isn't needed, for some reason you use it instead of the buf
pointer to determine the transfer size.

> +	void *dmabuf;
> +	int result;
> +
> +	dmabuf = kmemdup(buf, sizeof(*special_chars), GFP_KERNEL);
> +	if (!dmabuf)
> +		return -ENOMEM;
> +
> +	result = usb_control_msg(serial->dev,
> +				usb_sndctrlpipe(serial->dev, 0),
> +				CP210X_SET_CHARS, REQTYPE_HOST_TO_INTERFACE, 0,
> +				port_priv->bInterfaceNumber,
> +				dmabuf, sizeof(*special_chars), USB_CTRL_SET_TIMEOUT);
> +
> +	if (result == sizeof(*special_chars)) {
> +		result = 0;
> +	} else {
> +		dev_err(&port->dev, "failed to set special chars: %d\n", result);
> +		if (result >= 0)
> +			result = -EIO;
> +	}
> +
> +	kfree(dmabuf);
> +
> +	return result;
> +}
> +
>  /*
>   * Writes any 16-bit CP210X_ register (req) whose value is passed
>   * entirely in the wValue field of the USB request.
> @@ -1087,9 +1128,12 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
>  		struct usb_serial_port *port, struct ktermios *old_termios)
>  {
>  	struct cp210x_flow_ctl flow_ctl;
> +	struct cp210x_special_chars special_chars;
> +	unsigned int iflag, old_iflag;
>  	u32 flow_repl;
>  	u32 ctl_hs;
>  	int ret;
> +	int result = 0;
>  
>  	if (old_termios && C_CRTSCTS(tty) == (old_termios->c_cflag & CRTSCTS))
>  		return;

You didn't update this conditional, which means that the software
flow-control settings could only be changed by reopening a port or
changing the *hardware* flow-control setting (!).

You also didn't update the cp210x_termios_change() helper, which I
explicitly told you to do, which means that this function isn't even
called when only the IXON and IXOFF flags change.

> @@ -1126,6 +1170,48 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
>  
>  	cp210x_write_reg_block(port, CP210X_SET_FLOW, &flow_ctl,
>  			sizeof(flow_ctl));
> +
> +	iflag = tty->termios.c_iflag;
> +	old_iflag = old_termios->c_iflag;

And here's an even bigger problem, which clearly shows that you didn't
test this at all:

This dereference will cause an oops as old_termios is NULL here when
set_termios() is called from open().

> +	if (((iflag & IXOFF) != (old_iflag & IXOFF)) ||
> +		((iflag & IXON) != (old_iflag & IXON))) {
> +
> +		special_chars.bXonChar  = START_CHAR(tty);
> +		special_chars.bXoffChar = STOP_CHAR(tty);

You never clear special_chars, which means that you're setting the other
control characters to random data from the stack.

> +
> +		result = cp210x_set_chars(port, &special_chars);
> +		if (result < 0)
> +			goto out;
> +
> +		result = cp210x_read_reg_block(port,
> +					CP210X_GET_FLOW,
> +					&flow_ctl,
> +					sizeof(flow_ctl));

And why are you fetching the flow-control settings again when this has
just been done a few lines above when handling CRTSCTS?

> +		if (result < 0)
> +			goto out;
> +
> +		flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);
> +
> +		if (iflag & IXOFF)
> +			flow_repl |= CP210X_SERIAL_AUTO_RECEIVE;
> +		else
> +			flow_repl &= ~CP210X_SERIAL_AUTO_RECEIVE;
> +
> +		if (iflag & IXON)
> +			flow_repl |= CP210X_SERIAL_AUTO_TRANSMIT;
> +		else
> +			flow_repl &= ~CP210X_SERIAL_AUTO_TRANSMIT;
> +
> +		flow_ctl.ulFlowReplace = cpu_to_le32(flow_repl);
> +		result = cp210x_write_reg_block(port,
> +					CP210X_SET_FLOW,
> +					&flow_ctl,
> +					sizeof(flow_ctl));

Same here, you only need to store the updates settings once for both
hardware and software flow control.

> +	}
> +out:
> +	if (result < 0)
> +		dev_err(&port->dev, "failed to set software flow control: %d\n", result);
> +
>  }
>  
>  static void cp210x_set_termios(struct tty_struct *tty,

I've fixed all of this up as can be seen below.

In the future, always test your patches and don't ignore review
feedback.

Johan


From 892bdabbfc24992d49e9b0c04d746dd4d7633791 Mon Sep 17 00:00:00 2001
From: Wang Sheng Long <shenglong.wang.ext@siemens.com>
Date: Mon, 4 Jan 2021 17:45:02 +0800
Subject: [PATCH 1/6] USB: serial: cp210x: add support for software flow
 control

When data is transmitted between two serial ports, the phenomenon of
data loss often occurs. The two kinds of flow control commonly used in
serial communication are hardware flow control and software flow
control.

In serial communication, If you only use RX/TX/GND Pins, you can't do
hardware flow. So we often used software flow control and prevent data
loss. The user sets the software flow control through the application
program, and the application program sets the software flow control mode
for the serial port chip through the driver.

For the cp210 serial port chip, its driver lacks the software flow
control setting code, so the user cannot set the software flow control
function through the application program. This adds the missing software
flow control.

Signed-off-by: Wang Sheng Long <shenglong.wang.ext@siemens.com>
Link: https://lore.kernel.org/r/20210104094502.3942-1-china_shenglong@163.com
[ johan: rework properly on top of recent termios changes ]
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 67 +++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index fbb10dfc56e3..5bd14770065b 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -377,6 +377,16 @@ static struct usb_serial_driver * const serial_drivers[] = {
 #define CONTROL_WRITE_DTR	0x0100
 #define CONTROL_WRITE_RTS	0x0200
 
+/* CP210X_(GET|SET)_CHARS */
+struct cp210x_special_chars {
+	u8	bEofChar;
+	u8	bErrorChar;
+	u8	bBreakChar;
+	u8	bEventChar;
+	u8	bXonChar;
+	u8	bXoffChar;
+};
+
 /* CP210X_VENDOR_SPECIFIC values */
 #define CP210X_READ_2NCONFIG	0x000E
 #define CP210X_READ_LATCH	0x00C2
@@ -1074,11 +1084,38 @@ static void cp210x_disable_event_mode(struct usb_serial_port *port)
 	port_priv->event_mode = false;
 }
 
+static int cp210x_set_chars(struct usb_serial_port *port,
+		struct cp210x_special_chars *chars)
+{
+	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
+	struct usb_serial *serial = port->serial;
+	void *dmabuf;
+	int result;
+
+	dmabuf = kmemdup(chars, sizeof(*chars), GFP_KERNEL);
+	if (!dmabuf)
+		return -ENOMEM;
+
+	result = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
+				CP210X_SET_CHARS, REQTYPE_HOST_TO_INTERFACE, 0,
+				port_priv->bInterfaceNumber,
+				dmabuf, sizeof(*chars), USB_CTRL_SET_TIMEOUT);
+
+	kfree(dmabuf);
+
+	if (result < 0) {
+		dev_err(&port->dev, "failed to set special chars: %d\n", result);
+		return result;
+	}
+
+	return 0;
+}
+
 static bool cp210x_termios_change(const struct ktermios *a, const struct ktermios *b)
 {
 	bool iflag_change;
 
-	iflag_change = ((a->c_iflag ^ b->c_iflag) & INPCK);
+	iflag_change = ((a->c_iflag ^ b->c_iflag) & (INPCK | IXON | IXOFF));
 
 	return tty_termios_hw_change(a, b) || iflag_change;
 }
@@ -1086,13 +1123,29 @@ static bool cp210x_termios_change(const struct ktermios *a, const struct ktermio
 static void cp210x_set_flow_control(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
+	struct cp210x_special_chars chars;
 	struct cp210x_flow_ctl flow_ctl;
 	u32 flow_repl;
 	u32 ctl_hs;
 	int ret;
 
-	if (old_termios && C_CRTSCTS(tty) == (old_termios->c_cflag & CRTSCTS))
+	if (old_termios &&
+			C_CRTSCTS(tty) == (old_termios->c_cflag & CRTSCTS) &&
+			I_IXON(tty) == (old_termios->c_iflag & IXON) &&
+			I_IXOFF(tty) == (old_termios->c_iflag & IXOFF)) {
 		return;
+	}
+
+	if (I_IXON(tty) || I_IXOFF(tty)) {
+		memset(&chars, 0, sizeof(chars));
+
+		chars.bXonChar = START_CHAR(tty);
+		chars.bXoffChar = STOP_CHAR(tty);
+
+		ret = cp210x_set_chars(port, &chars);
+		if (ret)
+			return;
+	}
 
 	ret = cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl,
 			sizeof(flow_ctl));
@@ -1118,6 +1171,16 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
 		flow_repl |= CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_ACTIVE);
 	}
 
+	if (I_IXOFF(tty))
+		flow_repl |= CP210X_SERIAL_AUTO_RECEIVE;
+	else
+		flow_repl &= ~CP210X_SERIAL_AUTO_RECEIVE;
+
+	if (I_IXON(tty))
+		flow_repl |= CP210X_SERIAL_AUTO_TRANSMIT;
+	else
+		flow_repl &= ~CP210X_SERIAL_AUTO_TRANSMIT;
+
 	dev_dbg(&port->dev, "%s - ulControlHandshake=0x%08x, ulFlowReplace=0x%08x\n",
 			__func__, ctl_hs, flow_repl);
 
-- 
2.26.2



