Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA6D2FB72F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390493AbhASK31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:29:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389679AbhASKOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:14:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2623C23110;
        Tue, 19 Jan 2021 10:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611051237;
        bh=oJP2CZT0iShT2cm0o7ur8h+l0HQzMOMI5R/YrhgrDhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G1PgBRxb8UZ1SDYsPZImNkOJenjNQ/5Ax42IdXTRX0z6dDTBi2HGOdtU1+WhJV5I6
         JyME2lFCBmN+iZVfGU9BoSd5b2b1eClyFtC8uKLfHpQn3DosSo0ASQdHKa4OxaxqAp
         +EN+LLxWn4uxvftWLAEHHUWFgnDtaut6d/xWk5gg=
Date:   Tue, 19 Jan 2021 11:13:54 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Pho Tran <Pho.Tran@silabs.com>
Cc:     "johan@kernel.org" <johan@kernel.org>,
        "inux-usb@vger.kernel.org" <inux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: cp210x: Fix error 32 when hardware flow
 control is enabled.
Message-ID: <YAaw4lZHsfBRY3cd@kroah.com>
References: <658ABD80-572C-44BD-8DBD-79396109A175@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658ABD80-572C-44BD-8DBD-79396109A175@silabs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 09:43:13AM +0000, Pho Tran wrote:
> Fix error 32 returned by CP210X_SET_MHS when hardware flow control is enabled.
> 
> The root cause of error 32 is that user application (CoolTerm, linux-serial-test)
> opened cp210x device with hardware flow control then attempt to control RTS/DTR pins.
> In hardware flow control, RTS/DTR pins will be controlled by hardware only,
> any attempt to control those pin will cause error 32 from the device.
> This fix will block MHS command(command to control RTS/DTR pins) to the device
> if hardware flow control is being used.
> 
> Signed-off-by: Pho Tran <pho.tran@silabs.com>
> ---
>  drivers/usb/serial/cp210x.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index fbb10dfc56e3..1835ccf2aa2f 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -1211,6 +1211,11 @@ static int cp210x_tiocmset_port(struct usb_serial_port *port,
>  		unsigned int set, unsigned int clear)
>  {
>  	u16 control = 0;
> +	struct cp210x_flow_ctl flow_ctl;
> +	u32 ctl_hs = 0;
> +	u32 flow_repl = 0;
> +	bool auto_dtr = false;
> +	bool auto_rts = false;
>  
>  	if (set & TIOCM_RTS) {
>  		control |= CONTROL_RTS;
> @@ -1230,6 +1235,25 @@ static int cp210x_tiocmset_port(struct usb_serial_port *port,
>  	}
>  
>  	dev_dbg(&port->dev, "%s - control = 0x%.4x\n", __func__, control);
> +	//Don't send MHS command if device in hardware flowcontrol mode

Please put a blank line before this comment.

And a ' ' after "//".

> +	cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl, sizeof(flow_ctl));

No error checking?

> +	ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
> +	flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);
> +
> +	if (CP210X_SERIAL_DTR_SHIFT(CP210X_SERIAL_DTR_FLOW_CTL) == (ctl_hs & CP210X_SERIAL_DTR_MASK))
> +		auto_dtr = true;
> +	else
> +		auto_dtr = false;
> +
> +	if (CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_FLOW_CTL) == (flow_repl & CP210X_SERIAL_RTS_MASK))
> +		auto_rts = true;
> +	else
> +		auto_rts = false;
> +
> +	if (auto_dtr || auto_rts) {
> +		dev_dbg(&port->dev, "Don't set MHS when while device in flow control mode\n");
> +		return 0;

Shouldn't this be a real error to send back to userspace, so that they
know the change they asked for failed?

thanks,

greg k-h
