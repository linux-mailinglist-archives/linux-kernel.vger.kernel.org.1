Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D56C2B1E97
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgKMP1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:27:32 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40706 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgKMP1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:27:31 -0500
Received: by mail-lj1-f196.google.com with SMTP id x9so11127681ljc.7;
        Fri, 13 Nov 2020 07:27:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kbDcH7OxuU5kmg2HT6wUfLKLTTzmoxUrOtw1c5hU1VI=;
        b=Mi0SogmhJTNuNVM6SmzxvPSWuMc9MftLYNOYzwuJAM6uuqWlp6NgE/1jjPYAUxTPdQ
         Wa/HvJA0Njtc+tA53Zcu8pTeWp5tbbIMMicR5syiQhszwoYQQShue5kPmHrerfJPhbQd
         8QhO7brfzwC91ZzdIrm01k3hYr9/jbOCgUllRi5NeTihtf3Ef4aglqFNq3CdSSgksCsV
         +2a+0Z7nwDmMrLenL8Ncb4FM2fNiYwlyVMeEt/4ZTZ4PF6B6d8JkVAy0j3wuuPJKAayA
         fdHggL7oUfHB2wqtCx/acsJrQkCprnPg5JHesZlnYg/mgBEN2DR4dZ3cfgJRBAchcqx7
         jS9g==
X-Gm-Message-State: AOAM531KR5rR0us5qeLf6I8ZXDFnhIjWsefVyhLnkuNVieFZxhi39LFu
        V5fTQ8KlRkJV4+tG835Zk+k=
X-Google-Smtp-Source: ABdhPJx8gKuylIekm+ROz9Z6mOTUY2XE2jvNGrLJSiwa/Au+THype5WIk7fEz+DDP+9uQ018ez7XnA==
X-Received: by 2002:a05:651c:107:: with SMTP id a7mr1305926ljb.463.1605281243415;
        Fri, 13 Nov 2020 07:27:23 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id r2sm1620068lfm.220.2020.11.13.07.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:27:22 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kdaz5-0002E3-Db; Fri, 13 Nov 2020 16:27:31 +0100
Date:   Fri, 13 Nov 2020 16:27:31 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Sheng Long Wang <china_shenglong@163.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkp@intel.com, Wang Sheng Long <shenglong.wang.ext@siemens.com>
Subject: Re: [PATCH v6] usb-serial:cp210x: add support to software flow
 control
Message-ID: <X66l44MqSlj774DL@localhost>
References: <20201016022428.9671-1-china_shenglong@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016022428.9671-1-china_shenglong@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 10:24:28AM +0800, Sheng Long Wang wrote:
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
> - It mainly adjusts the patch based on the last usb-next branch
>   of the usb-serial.

Again, you did a whole lot more than just rebase here based on the
review feedback you got.

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
> ---
>  drivers/usb/serial/cp210x.c | 128 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 123 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index d0c05aa8a0d6..2d5e31282599 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -412,6 +412,15 @@ struct cp210x_comm_status {
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
> @@ -675,6 +684,70 @@ static int cp210x_read_vendor_block(struct usb_serial *serial, u8 type, u16 val,
>  	return result;
>  }
>  
> +static int cp210x_get_chars(struct usb_serial_port *port, void *buf)

As I said earlier, these functions should take a pointer to a struct
special_chars (not void *).

> +{
> +	struct usb_serial *serial = port->serial;
> +	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
> +	struct cp210x_special_chars *special_chars;
> +	void *dmabuf;
> +	int result;
> +
> +	dmabuf = kmemdup(buf, sizeof(*special_chars), GFP_KERNEL);
> +	if (!dmabuf)
> +		return -ENOMEM;
> +
> +	result = usb_control_msg(serial->dev,
> +				usb_rcvctrlpipe(serial->dev, 0),
> +				CP210X_GET_CHARS, REQTYPE_INTERFACE_TO_HOST, 0,
> +				port_priv->bInterfaceNumber,
> +				dmabuf, sizeof(*special_chars),
> +				USB_CTRL_GET_TIMEOUT);
> +
> +	if (result == sizeof(*special_chars)) {
> +		memcpy(buf, dmabuf, sizeof(*special_chars));
> +		result = 0;
> +	} else {
> +		dev_err(&port->dev, "failed to get special chars: %d\n", result);
> +		if (result >= 0)
> +			result = -EIO;
> +	}
> +
> +	kfree(dmabuf);
> +
> +	return result;
> +}
> +
> +static int cp210x_set_chars(struct usb_serial_port *port, void *buf)
> +{
> +	struct usb_serial *serial = port->serial;
> +	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
> +	struct cp210x_special_chars *special_chars;
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
> @@ -1356,11 +1429,18 @@ static void cp210x_set_termios(struct tty_struct *tty,
>  		struct usb_serial_port *port, struct ktermios *old_termios)
>  {
>  	struct device *dev = &port->dev;
> -	unsigned int cflag, old_cflag;
> +	unsigned int cflag, old_cflag, iflag, old_iflag;
> +	struct cp210x_special_chars special_chars;
> +	struct cp210x_flow_ctl flow_ctl;
>  	u16 bits;
> +	int result = 0;
> +	u32 ctl_hs;
> +	u32 flow_repl;
>  
>  	cflag = tty->termios.c_cflag;
> +	iflag = tty->termios.c_iflag;
>  	old_cflag = old_termios->c_cflag;
> +	old_iflag = old_termios->c_iflag;
>  
>  	if (tty->termios.c_ospeed != old_termios->c_ospeed)
>  		cp210x_change_speed(tty, port, old_termios);
> @@ -1434,10 +1514,6 @@ static void cp210x_set_termios(struct tty_struct *tty,
>  	}
>  
>  	if ((cflag & CRTSCTS) != (old_cflag & CRTSCTS)) {
> -		struct cp210x_flow_ctl flow_ctl;
> -		u32 ctl_hs;
> -		u32 flow_repl;
> -
>  		cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl,
>  				sizeof(flow_ctl));
>  		ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
> @@ -1474,6 +1550,48 @@ static void cp210x_set_termios(struct tty_struct *tty,
>  				sizeof(flow_ctl));
>  	}
>  
> +	if (((iflag & IXOFF) != (old_iflag & IXOFF)) ||
> +		((iflag & IXON) != (old_iflag & IXON))) {

You need to check if START_CHAR or STOP_CHAR has changed too.

> +		result = cp210x_get_chars(port, &special_chars);
> +		if (result < 0)
> +			goto out;
> +
> +		special_chars.bXonChar  = START_CHAR(tty);
> +		special_chars.bXoffChar = STOP_CHAR(tty);
> +
> +		result = cp210x_set_chars(port, &special_chars);
> +		if (result < 0)
> +			goto out;
> +
> +		result = cp210x_read_reg_block(port,
> +					CP210X_GET_FLOW,
> +					&flow_ctl,
> +					sizeof(flow_ctl));
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
> +	}
> +out:
> +	if (result < 0)
> +		dev_err(dev, "failed to set software flow control: %d\n", result);
> +

Ok, this works, but it's weird with a label named "out" in the middle of
a function. Please handle software flow control in a helper function as
I suggested.

>  	/*
>  	 * Enable event-insertion mode only if input parity checking is
>  	 * enabled for now.

Also, you didn't address my final comment:

	Finally, this driver is a bit weird in that it retrieves the
	termios settings from the device on open. You need to handle
	IXON/IXOFF there as well for now I'm afraid.

Without that bit, output flow control (IXON, which is set in termios by
default) will not be enabled in the device until it's disabled and
re-enabled.

I'll try to find some time to rip that bit out of the driver, but for
now you need to handle also IXON/IXOFF in cp210x_get_termios().

Johan
