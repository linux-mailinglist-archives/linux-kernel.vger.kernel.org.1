Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0A92F0D22
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 08:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbhAKHOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 02:14:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbhAKHOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 02:14:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A7D3225A9;
        Mon, 11 Jan 2021 07:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610349217;
        bh=ZwNYpISPlVywIvh+htoo5VWC0pR+1TPmOJ4Ti8bujmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TWB+q7EVVt43XK2L4hFXQTgQio6V9SsGk7CF5+6zsgbX1i6KhMJRcl/Pw2fqWfKXp
         tE86Mxxl8VkbNG3OJzKhOCtTv29cO8j3Rv5j89Ex2pYfSP8HxmyKWoNwQtB/MXu4Zc
         OmXs7MAedSa/HyRZbVzvRLzLIXl9LkKTHK8cdNyA=
Date:   Mon, 11 Jan 2021 08:14:49 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Pho Tran <Pho.Tran@silabs.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Tung Pham <Tung.Pham@silabs.com>
Subject: Re: [PATCH] USB: otg: Fix error 32 when enable hardware flow control.
Message-ID: <X/v66Rm8nECrmNYY@kroah.com>
References: <C429CBAD-FE44-42AE-909C-4C33052A7413@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C429CBAD-FE44-42AE-909C-4C33052A7413@silabs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 04:55:22AM +0000, Pho Tran wrote:
> When hardware flow control is enabled,
> don't allow host send MHS command to cp210x.
> 
> Signed-off-by: Pho Tran<pho.tran@silabs.com>

Nit, you need a ' ' before the '<' character.

And why didn't you send this to the maintainer of this file as described
by scripts/get_maintainer.pl?

Please do so when you fix things up and send the next version.

> ---
>  drivers/usb/serial/cp210x.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index fbb10dfc56e3..f231cecdaf7d 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -1204,6 +1204,7 @@ static int cp210x_tiocmset(struct tty_struct *tty,
>  		unsigned int set, unsigned int clear)
>  {
>  	struct usb_serial_port *port = tty->driver_data;
> +
>  	return cp210x_tiocmset_port(port, set, clear);
>  }
>  

Unneeded change :(


> @@ -1211,6 +1212,11 @@ static int cp210x_tiocmset_port(struct usb_serial_port *port,
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
> @@ -1230,6 +1236,30 @@ static int cp210x_tiocmset_port(struct usb_serial_port *port,
>  	}
>  
>  	dev_dbg(&port->dev, "%s - control = 0x%.4x\n", __func__, control);
> +	/*
> +	 *	Don't send MHS command if device in hardware flowcontrol mode
> +	 */

Why the giant comment?

> +	cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl,
> +				sizeof(flow_ctl));
> +	ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
> +	flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);
> +
> +	if (CP210X_SERIAL_DTR_SHIFT(CP210X_SERIAL_DTR_FLOW_CTL)
> +		== (ctl_hs & CP210X_SERIAL_DTR_MASK))

Very odd indentation :(

> +		auto_dtr = true;
> +	else
> +		auto_dtr = false;
> +
> +	if (CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_FLOW_CTL)
> +		== (flow_repl & CP210X_SERIAL_RTS_MASK))
> +		auto_rts = true;
> +	else
> +		auto_rts = false;
> +
> +	if (auto_dtr || auto_rts) {
> +		dev_dbg(&port->dev, "Don't set MHS when while device in flow control mode\n");
> +		return 0;
> +	}
>  
>  	return cp210x_write_u16_reg(port, CP210X_SET_MHS, control);
>  }
> @@ -1256,7 +1286,7 @@ static int cp210x_tiocmget(struct tty_struct *tty)
>  		|((control & CONTROL_RTS) ? TIOCM_RTS : 0)
>  		|((control & CONTROL_CTS) ? TIOCM_CTS : 0)
>  		|((control & CONTROL_DSR) ? TIOCM_DSR : 0)
> -		|((control & CONTROL_RING)? TIOCM_RI  : 0)
> +		|((control & CONTROL_RING) ? TIOCM_RI  : 0)

Do not mix whitespace changes with logic changes in the same patch, that
is a sure way to get your patch rejected.

thanks,

greg k-h
