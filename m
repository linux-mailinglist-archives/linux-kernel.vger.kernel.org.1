Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0056E213505
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 09:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgGCHc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 03:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgGCHc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:32:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EF2320890;
        Fri,  3 Jul 2020 07:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593761575;
        bh=YLzvaa1bLydJ+dj5X1a+vb6tk/OO1AZ6fTqSIeEFiRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1e8LJIpiz+8KVyLRfSjDXioQMMpKWYIuR5wNf/uzr0CYSI1UKVVV3G5by0usGGe7S
         HwY+dBk5yCP8VJ5DJFZtj3b53OfjXKCmimssiC58i6fXHkK0VlIIXpfxIlRawYJJ02
         BXzU7Xm0ye8DvrUyPvPA6dpx6cqHVZuKM1UlUeNM=
Date:   Fri, 3 Jul 2020 09:32:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 27/30] usb: class: cdc-wdm: Provide description for
 usb_cdc_wdm_register()'s manage_power arg
Message-ID: <20200703073259.GA2335445@kroah.com>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
 <20200702144625.2533530-28-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702144625.2533530-28-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 03:46:22PM +0100, Lee Jones wrote:
> A good attempt was made to document everything else.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/usb/class/cdc-wdm.c:961: warning: Function parameter or member 'manage_power' not described in 'usb_cdc_wdm_register'
> 
> Cc: Oliver Neukum <oneukum@suse.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/usb/class/cdc-wdm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
> index e3db6fbeadef8..4dceaeca46e73 100644
> --- a/drivers/usb/class/cdc-wdm.c
> +++ b/drivers/usb/class/cdc-wdm.c
> @@ -940,7 +940,8 @@ static int wdm_probe(struct usb_interface *intf, const struct usb_device_id *id)
>   * @intf: usb interface the subdriver will associate with
>   * @ep: interrupt endpoint to monitor for notifications
>   * @bufsize: maximum message size to support for read/write
> - *
> + * @manage_power: call-back invoked during open and release to
> + *                manage the device's power 
>   * Create WDM usb class character device and associate it with intf
>   * without binding, allowing another driver to manage the interface.
>   *

You just added a coding style warning :(

Hint, set your editor to flag trailing whitespace with a BIG RED COLOR
so that you don't do that.  If you use vim, that can be done with:
	highlight WhitespaceEOL ctermbg=red guibg=red
	match WhitespaceEOL /\s\+$/
in your .vimrc

For other sane editors, I'm sure there are ways to do it as well.

Please fix this patch up and send it in a new series, I've dropped it
from this one.

thanks,

greg k-h
