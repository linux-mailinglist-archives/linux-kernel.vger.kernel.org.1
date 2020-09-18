Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CD726F97C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgIRJmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:42:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41857 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIRJmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:42:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id y17so5431331lfa.8;
        Fri, 18 Sep 2020 02:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VxLGeGP6aRrazCyuDhAcIbNhntO52mGbum/KYkThetI=;
        b=fO8N7JpvQHQUoNnozWeQfkN6/P0jchgbS3auq5x+nAVfw3bUlLSmDpHzP7yrlMyVEe
         Iocz4IjZchiAlmFpT/KSsQAwRGRdjLNcrqhg0/jFlFohsu4UV5szGxj+mFgjQXhuSh/o
         eQY7kJrr6z4yGeEWhkbSyWC3qtvEEEcMvQxV+6i7LctbgDt2D4sMLRlCSWxFWtku9nby
         FbKbmjODylK7lEBD9bAulYUsFTKIaYff067XqKwb3Nzkhnj0Eia9FcHs3GvN2BETSZqo
         id7d1V6ei04LTXyK+OMXatTY//Mmt9Zw3HZFqMQfmaB6pfh83jUUkEwfz6EiGYd+mwuv
         nhdQ==
X-Gm-Message-State: AOAM532kJRTCAQ1yvOwPn2bAsbFoyc6lYprTZVaO4/qZuMIfrnOGMWdg
        4mzzwNm3ox9StE6954gKB68=
X-Google-Smtp-Source: ABdhPJztObW0JDeZKDwGCX+4j02Fmg91DAAIRVDIqevEOz5relnYhDVU7IffInxe3nqMcJ1PNkWBKg==
X-Received: by 2002:ac2:5458:: with SMTP id d24mr9779428lfn.446.1600422170510;
        Fri, 18 Sep 2020 02:42:50 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id v13sm496497lfo.30.2020.09.18.02.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 02:42:49 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kJCui-0007s6-RJ; Fri, 18 Sep 2020 11:42:45 +0200
Date:   Fri, 18 Sep 2020 11:42:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sheng Long Wang <china_shenglong@163.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jan.kiszka@siemens.com,
        Wang Sheng Long <shenglong.wang.ext@siemens.com>
Subject: Re: [PATCH v4] usb-serial:cp210x: add support to software flow
 control
Message-ID: <20200918094244.GR24441@localhost>
References: <20200909023931.19530-1-china_shenglong@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909023931.19530-1-china_shenglong@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 10:39:30AM +0800, Sheng Long Wang wrote:
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
>   of the usb-serial and optimized the relevant code.

"optimize code" is too hand-wavy, please be more specific on what you've
changed.

> ---
>  drivers/usb/serial/cp210x.c | 125 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 120 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index d0c05aa8a0d6..bcbf8da99ebb 100644
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
> @@ -675,6 +684,69 @@ static int cp210x_read_vendor_block(struct usb_serial *serial, u8 type, u16 val,
>  	return result;
>  }
>  
> +static int cp210x_get_chars(struct usb_serial_port *port, void *buf, int bufsize)

No need to pass in a length here. Just use a pointer to struct
cp210x_special_chars.

> +{
> +	struct usb_serial *serial = port->serial;
> +	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
> +	void *dmabuf;
> +	int result;
> +
> +	dmabuf = kmemdup(buf, bufsize, GFP_KERNEL);
> +	if (!dmabuf)
> +		return -ENOMEM;
> +
> +	result = usb_control_msg(serial->dev,
> +				usb_sndctrlpipe(serial->dev, 0),

usb_rcvctrlpipe()

> +				CP210X_GET_CHARS, REQTYPE_DEVICE_TO_HOST, 0,
> +				port_priv->bInterfaceNumber,
> +				dmabuf, bufsize, USB_CTRL_SET_TIMEOUT);

USB_CTRL_GET_TIMEOUT

> +
> +	if (result == bufsize) {
> +		memcpy(buf, dmabuf, bufsize);
> +		result = 0;
> +	} else {
> +		dev_err(&port->dev, "failed get req 0x%x size %d status: %d\n",
> +			CP210X_GET_CHARS, bufsize, result);

Just spell out "failed to get special chars: %d\n"

> +		if (result >= 0)
> +			result = -EIO;
> +	}
> +
> +	kfree(dmabuf);
> +
> +	return result;
> +}
> +
> +static int cp210x_set_chars(struct usb_serial_port *port, void *buf, int bufsize)
> +{

Same as above.

> +	struct usb_serial *serial = port->serial;
> +	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
> +	void *dmabuf;
> +	int result;
> +
> +	dmabuf = kmemdup(buf, bufsize, GFP_KERNEL);
> +	if (!dmabuf)
> +		return -ENOMEM;
> +
> +	result = usb_control_msg(serial->dev,
> +				usb_sndctrlpipe(serial->dev, 0),
> +				CP210X_SET_CHARS, REQTYPE_HOST_TO_INTERFACE, 0,
> +				port_priv->bInterfaceNumber,
> +				dmabuf, bufsize, USB_CTRL_SET_TIMEOUT);
> +
> +	if (result == bufsize) {
> +		result = 0;
> +	} else {
> +		dev_err(&port->dev, "failed get req 0x%x size %d status: %d\n",
> +			CP210X_SET_CHARS, bufsize, result);

"failed to set special chars: %d\n" (and not "get").

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
> @@ -1356,11 +1428,17 @@ static void cp210x_set_termios(struct tty_struct *tty,
>  		struct usb_serial_port *port, struct ktermios *old_termios)
>  {
>  	struct device *dev = &port->dev;
> -	unsigned int cflag, old_cflag;
> +	unsigned int cflag, old_cflag, iflag;
> +	struct cp210x_special_chars charsres;

s/charsres/special_chars/

> +	struct cp210x_flow_ctl flow_ctl;
>  	u16 bits;
> +	int result;
> +	u32 ctl_hs;
> +	u32 flow_repl;
>  
>  	cflag = tty->termios.c_cflag;
>  	old_cflag = old_termios->c_cflag;
> +	iflag = tty->termios.c_iflag;
>  
>  	if (tty->termios.c_ospeed != old_termios->c_ospeed)
>  		cp210x_change_speed(tty, port, old_termios);
> @@ -1434,10 +1512,6 @@ static void cp210x_set_termios(struct tty_struct *tty,
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
> @@ -1474,6 +1548,47 @@ static void cp210x_set_termios(struct tty_struct *tty,
>  				sizeof(flow_ctl));
>  	}
>  
> +	if ((iflag & IXOFF) || (iflag & IXON)) {

Try to only do this on changes (of IXON/IXOFF/START_CHAR/STOP_CHAR).

> +

Stray newline.

> +		result = cp210x_get_chars(port, &charsres, sizeof(charsres));
> +		if (result < 0)
> +			dev_err(dev, "failed to get character: %d\n", result);

Error already logged, you shouldn't proceed with set_chars if this
fails. Perhaps use a helper function for settings software flow
control?

> +
> +		charsres.bXonChar  = START_CHAR(tty);
> +		charsres.bXoffChar = STOP_CHAR(tty);
> +
> +		result = cp210x_set_chars(port, &charsres, sizeof(charsres));
> +		if (result < 0)
> +			dev_err(dev, "failed to set character: %d\n", result);

Same here.

> +
> +		result = cp210x_read_reg_block(port,
> +					CP210X_GET_FLOW,
> +					&flow_ctl,
> +					sizeof(flow_ctl));
> +		if (result)
> +			dev_err(dev, "failed to read flow_ctl reg: %d\n", result);

Don't continue updating flow control on errors.

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
> +		if (result)
> +			dev_err(dev, "failed to write flow_ctl reg: %d\n", result);
> +	}
> +
>  	/*
>  	 * Enable event-insertion mode only if input parity checking is
>  	 * enabled for now.

Finally, this driver is a bit weird in that it retrieves the termios
settings from the device on open. You need to handle IXON/IXOFF there as
well for now I'm afraid.

Johan
