Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DE03025B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 14:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbhAYNtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 08:49:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:48558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729052AbhAYNsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:48:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0ECB922240;
        Mon, 25 Jan 2021 13:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611582419;
        bh=4jeTXsONQRvlpQNo8y1N+7h1UcVWalGRTtzIbqhd3rM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OEtXqwrUq1iirVFq9qgSaEL96SW0ubYogbrPYtb/DEu2Sy43hGKfesstIYJ4eoY3h
         +LaUR6hkVwIBcd1iOxEnS4O86wumpOAmN8sKcV/sePGDMpbJ4JSYM1S8u2GsfWC9jB
         IpETXmF2tZCdVB8dKbSpgzSbQBK1KQArUoD+/9PHPuQiJOVkFED5X1Nqv1pHeETYLW
         oaAGALgYujtdCPjBEUNfKuDnL5UpMZAtqYYhvN2zvVCt6szD3Zs7hlkFzIW1Bs0k0u
         AwUEwjIlUC5VunOD2GEdq9qkwjdIrKO5uw4jsJjHI4k3CfzhkRDpvu/7eIdKQZsRX9
         K41iOttCH+ibA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l42Cx-00033C-H3; Mon, 25 Jan 2021 14:47:07 +0100
Date:   Mon, 25 Jan 2021 14:47:07 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Pho Tran <Pho.Tran@silabs.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "johan@kernel.org" <johan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v4] USB: serial: cp210x: Fix error 32 when hardware flow
 control  is enabled.
Message-ID: <YA7L21jbIl9hPQf1@hovoldconsulting.com>
References: <E0AAFEFF-2250-4991-8ED8-9B6EE14111EC@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E0AAFEFF-2250-4991-8ED8-9B6EE14111EC@silabs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 09:52:23AM +0000, Pho Tran wrote:
> Fix error 32 returned by CP210X_SET_MHS when hardware flow control is enabled.
> 
> The root cause of error 32 is that user application (CoolTerm, linux-serial-test)
> opened cp210x device with hardware flow control then attempt to control RTS/DTR pins.
> In hardware flow control, RTS/DTR pins will be controlled by hardware only,
> any attempt to control those pins will cause error 32 from the device.
> This fix will block MHS command(command to control RTS/DTR pins) to the device
> if hardware flow control is being used.
> 
> Signed-off-by: Pho Tran <pho.tran@silabs.com>
> ---
> 01/21/2021: Patch v3 modified based on comment from Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 01/19/2021: Patch v2  Modified based on comment from Johan Hovold <johan@kernel.org>
> and Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Giving credit in the commit log is nice, but this still doesn't say
anything about *what* you changed.

> ---
>  drivers/usb/serial/cp210x.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index fbb10dfc56e3..814dff5fee98 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -1204,7 +1204,12 @@ static int cp210x_tiocmset(struct tty_struct *tty,
>  		unsigned int set, unsigned int clear)
>  {
>  	struct usb_serial_port *port = tty->driver_data;
> -	return cp210x_tiocmset_port(port, set, clear);
> +
> +	/* Don't send SET_MHS command if device in hardware flow control mode. */
> +	if (C_CRTSCTS(tty))
> +		return 0;

You didn't reply to my comments that what should be done here is to
disable auto-RTS when clearing TIOCM_RST and re-enable it when setting
the same bit. If you disagree with review feedback you need to say so
and not just resend a new version of your patch without an explanation.

Note that the above would also needlessly prevent DTR from being changed
whenever auto-RTS is enabled and return success instead of an error to
user space.

My suggestion for how to suppress the error message from dtr_rts()
suffers from the same problem so I've updated that patch and implemented
proper RTS handling in the driver now.

This takes care not only of the SET_MHS error messages, but also makes
sure that RTS can always be deasserted and some other related issues
with regards to modem control.

> +	else
> +		return cp210x_tiocmset_port(port, set, clear);
>  }
>  
>  static int cp210x_tiocmset_port(struct usb_serial_port *port,

Johan
