Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEB62D4529
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgLIPNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:13:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgLIPNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:13:05 -0500
Date:   Wed, 9 Dec 2020 16:13:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607526744;
        bh=rXgoUOratmeo5sC/HBwZuLZjYniTRKmfBVg6PzO6Ovg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=s7/XsrxReGM6YIKq9N103xhBUxwSSKtTkLWTynuPUPZ/N9lR71imAbF8qHHXrBPOR
         4FckpwKFbrUh8/pzXFJ/iuBHxnpOLVzK72FWQPA89/V7lH4/A2Cd0MH4WLNt3wJ94q
         UkDoZjL7k0YP3XmqkiRAqvwiYLecQRd3htqQlFGQ=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shaojie.dong@isrc.iscas.ac.cn
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: check register_netdev() return value
Message-ID: <X9DppHini6848vTM@kroah.com>
References: <20201209150124.23446-1-shaojie.dong@isrc.iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209150124.23446-1-shaojie.dong@isrc.iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 11:01:24PM +0800, shaojie.dong@isrc.iscas.ac.cn wrote:
> From: "shaojie.dong" <shaojie.dong@isrc.iscas.ac.cn>
> 
> Function register_netdev() can fail, so we should check it's return value
> 
> Signed-off-by: shaojie.dong <shaojie.dong@isrc.iscas.ac.cn>

I doubt you sign your name with a '.' in it, right?

Please resend with the correct name, and using Capital letters where
needed.

> ---
>  drivers/staging/rtl8712/hal_init.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712/hal_init.c
> index 715f1fe8b..38a3e3d44 100644
> --- a/drivers/staging/rtl8712/hal_init.c
> +++ b/drivers/staging/rtl8712/hal_init.c
> @@ -45,7 +45,10 @@ static void rtl871x_load_fw_cb(const struct firmware *firmware, void *context)
>  	}
>  	adapter->fw = firmware;
>  	/* firmware available - start netdev */
> -	register_netdev(adapter->pnetdev);
> +	if (register_netdev(adapter->pnetdev) != 0) {
> +		netdev_err(adapter->pnetdev, "register_netdev() failed\n");
> +		free_netdev(adapter->pnetdev);
> +	}

Did you test this to see if this really properly cleans everything up?

And your if statement can be simplified, please do so.

thanks,

greg k-h
