Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5632F485D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 11:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbhAMKJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 05:09:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:57796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbhAMKJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:09:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78E7623370;
        Wed, 13 Jan 2021 10:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610532557;
        bh=RG5P0L+hCZa+zQYGZl7WdN+Z4YDh+Ch46/n83QaYUKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j7rFkLM4DaO8lBjpiEOxtMCWk90Nwf8yO1TvQaeXHzEFS4rS+xEKIzHtusg/QEYpN
         J3MM2zX1hxakT4Myk7qcUeFQIk6K17oe9mT36qGOq9KSZJLGY1A8viFjF2RRJLA2K6
         gmJX9YuhmhRyStG9mu3JQB6hfntNhxPgdQ1/yErH18++4VYiJ5nAQ8K3/r6tpL5vxE
         vZ3RPWg859W/IT+2Q2J728S2g7iBP2LiFDr5N857KQIo5p18tRj81YUl9e8RcqNQK3
         7GiSMnZcZOsPxteOx6GHOK9SHlvOn4tWQb6TSXYmlW5PYhYgEC1qTM3QJat7SDm68q
         jGeRJaTcnqv2w==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kzd5g-00040R-CA; Wed, 13 Jan 2021 11:09:25 +0100
Date:   Wed, 13 Jan 2021 11:09:24 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Jin ChenXin <bg4akv@hotmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: add new VID/PID for supporting Teraoka AD2000
Message-ID: <X/7G1LAzmTpfbPQF@hovoldconsulting.com>
References: <ME2PR01MB4483D68A6A925810E9A0B23082A90@ME2PR01MB4483.ausprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ME2PR01MB4483D68A6A925810E9A0B23082A90@ME2PR01MB4483.ausprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 09:03:36AM +0000, Jin ChenXin wrote:

Thanks for the patch. I've applied it now after fixing up some minor
nits (so you don't need to resend), but for next time please consider
the following comments.

> From 905036e81e0d32705379c40acddb634428aff0a6 Mon Sep 17 00:00:00 2001

Don't include this line since it prevents git-am from considering the
following lines.

It also seems hotmail base64-encoded your message, which you should try
to avoid (see Documentation/process/email-clients.rst).

> From: Chenxin Jin <bg4akv@hotmail.com>
> Date: Wed, 13 Jan 2021 16:59:05 +0800
> Subject: [PATCH] drivers: add new VID/PID for supporting Teraoka AD2000

Please use the same commit-summary prefix as other commits for the
subsystem and driver you're patching (e.g. "USB: serial: cp210x: ")

> Teraoka AD2000 uses the CP210x driver, but the chip VID/PID is
> customized with 0988/0578. We need the driver to support the new VID/PID.
> 
> Signed-off-by: Chenxin Jin <bg4akv@hotmail.com>
> ---
>  drivers/usb/serial/cp210x.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index fbb10df..c274cc3 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -234,6 +234,7 @@ static int cp210x_tiocmset_port(struct usb_serial_port *port,
>  	{ USB_DEVICE(0x3195, 0xF281) }, /* Link Instruments MSO-28 */
>  	{ USB_DEVICE(0x3923, 0x7A0B) }, /* National Instruments USB Serial Console */
>  	{ USB_DEVICE(0x413C, 0x9500) }, /* DW700 GPS USB interface */
> +	{ USB_DEVICE(0x0988, 0x0578) }, /* Teraoka AD2000 */

When possible, try to keep the entries ordered by VID and PID.

>  	{ } /* Terminating Entry */
>  };

The end-result is here:

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-linus&id=43377df70480f82919032eb09832e9646a8a5efb

Johan
