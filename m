Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429162B3E69
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgKPIQV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Nov 2020 03:16:21 -0500
Received: from david.siemens.com.cn ([194.138.202.53]:42122 "EHLO
        david.siemens.com.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKPIQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:16:20 -0500
X-Greylist: delayed 1162 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2020 03:16:17 EST
Received: from mail.siemens.com.cn (mail.siemens.com.cn [194.138.237.52])
        by david.siemens.com.cn (8.14.9/8.14.9) with ESMTP id 0AG7uGCB010069
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 15:56:17 +0800
Received: from CNPEK01M04MSX.ad011.siemens.net (cnpek01m04msx.ad011.siemens.net [139.24.237.221])
        by mail.siemens.com.cn (8.14.9/8.14.9) with ESMTP id 0AG7u901002837
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 15:56:15 +0800
Received: from CNPEK01M06MSX.ad011.siemens.net (139.24.237.223) by
 CNPEK01M04MSX.ad011.siemens.net (139.24.237.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 16 Nov 2020 15:56:11 +0800
Received: from CNPEK01M06MSX.ad011.siemens.net ([139.24.237.223]) by
 CNPEK01M06MSX.ad011.siemens.net ([139.24.237.223]) with mapi id
 15.01.2106.003; Mon, 16 Nov 2020 15:56:11 +0800
From:   "Wang, Sheng Long" <shenglong.wang.ext@siemens.com>
To:     Johan Hovold <johan@kernel.org>,
        Sheng Long Wang <china_shenglong@163.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>
Subject: RE: [PATCH v6] usb-serial:cp210x: add support to software flow
 control
Thread-Topic: [PATCH v6] usb-serial:cp210x: add support to software flow
 control
Thread-Index: AQHWo2OeB9qO2j8ZGUeYQhba2pC/J6nF1h2AgAS8JjA=
Content-Class: 
Date:   Mon, 16 Nov 2020 07:56:10 +0000
Message-ID: <520e730958174cb39561a94d03e4727e@siemens.com>
References: <20201016022428.9671-1-china_shenglong@163.com>
 <X66l44MqSlj774DL@localhost>
In-Reply-To: <X66l44MqSlj774DL@localhost>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcejAwNDNjYnhcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0yZjQ2NDA5NS0yN2UxLTExZWItYmU2ZS1iMDBjZDE2OTA4NjRcYW1lLXRlc3RcMmY0NjQwOTctMjdlMS0xMWViLWJlNmUtYjAwY2QxNjkwODY0Ym9keS50eHQiIHN6PSI5Mjg1IiB0PSIxMzI0OTk4Njk2ODkzMjAxODUiIGg9ImkzeGJvblk1T1FKRGRUMVZ6SzZSdHhKbjk3UT0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUhBQUFBRDVFcDd4N2J2V0FZNjFtR3JGdEdTempyV1lhc1cwWkxNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUJBQUFBbytaL1dnQUFBQUFBQUFBQUFBQUFBQT09Ii8+PC9tZXRhPg==
x-dg-rorf: true
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2020-11-16T07:56:08Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Standard;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=d642f92d-ec02-4dc3-9bf3-b31e1d69e5b8;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
x-originating-ip: [139.24.108.150]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Johan

Thank you very much for your reply!

You mean if we call cp210x_open()  When opening the device, because IXON  is set by default, the
cp210x_get_termios() does not process IXON, So it is invalid IXON at this time.
 
As you said, It is very strange in cp210x_get_termios()  In the "get" function to "set"  IXON.
In addition, the best way is to disable the IXON bit as you said.  If the user needs IXON, call set_ termios function,
So I'm now in cp210x_get_termios()  Is it a temporary solution for terminos to handle IXON ? 
I'm afraid it will need to be adjusted.

BR/ShengLong


-----Original Message-----
From: Johan Hovold <johan@kernel.org> 
Sent: Friday, November 13, 2020 11:28 PM
To: Sheng Long Wang <china_shenglong@163.com>
Cc: johan@kernel.org; gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; lkp@intel.com; Wang, Sheng Long (EXT) (RC-CN DI FA BL IPC&C PRC4) <shenglong.wang.ext@siemens.com>
Subject: Re: [PATCH v6] usb-serial:cp210x: add support to software flow control

On Fri, Oct 16, 2020 at 10:24:28AM +0800, Sheng Long Wang wrote:
> From: Wang Sheng Long <shenglong.wang.ext@siemens.com>
> 
> When data is transmitted between two serial ports, the phenomenon of 
> data loss often occurs. The two kinds of flow control commonly used in 
> serial communication are hardware flow control and software flow 
> control.
> 
> In serial communication, If you only use RX/TX/GND Pins, you can't do 
> hardware flow. So we often used software flow control and prevent data 
> loss. The user sets the software flow control through the application 
> program, and the application program sets the software flow control 
> mode for the serial port chip through the driver.
> 
> For the cp210 serial port chip, its driver lacks the software flow 
> control setting code, so the user cannot set the software flow control 
> function through the application program. This adds the missing 
> software flow control.
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

Again, you did a whole lot more than just rebase here based on the review feedback you got.

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
>  drivers/usb/serial/cp210x.c | 128 
> ++++++++++++++++++++++++++++++++++--
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

As I said earlier, these functions should take a pointer to a struct special_chars (not void *).

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
>  		struct usb_serial_port *port, struct ktermios *old_termios)  {
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
>  		cp210x_change_speed(tty, port, old_termios); @@ -1434,10 +1514,6 @@ 
> static void cp210x_set_termios(struct tty_struct *tty,
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

Ok, this works, but it's weird with a label named "out" in the middle of a function. Please handle software flow control in a helper function as I suggested.

>  	/*
>  	 * Enable event-insertion mode only if input parity checking is
>  	 * enabled for now.

Also, you didn't address my final comment:

	Finally, this driver is a bit weird in that it retrieves the
	termios settings from the device on open. You need to handle
	IXON/IXOFF there as well for now I'm afraid.

Without that bit, output flow control (IXON, which is set in termios by
default) will not be enabled in the device until it's disabled and re-enabled.

I'll try to find some time to rip that bit out of the driver, but for now you need to handle also IXON/IXOFF in cp210x_get_termios().

Johan
