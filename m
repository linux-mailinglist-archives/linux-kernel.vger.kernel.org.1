Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEAA2A8FAE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgKFGvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:51:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbgKFGvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:51:35 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 552D120691;
        Fri,  6 Nov 2020 06:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604645495;
        bh=kNDfYVfpH4nkrNprUwBaFUvUlK46PuxrydsnPgGdmbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cMFXKevGRjx96vuNSXQwFgqw4CI2BmIitFB/s6Q0HfNzAfIXcRiXJRj9e8se7AxyV
         UNrknvic0H9fstvEudr1qBW5xExDNEPhYsp/0duJv44/9q5Tfx4MF9OzLRM6NZ35gU
         Vt4PvUNMLO/BYG7rLm3v0KfGTssSRlaLja7P2jSc=
Date:   Fri, 6 Nov 2020 07:51:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: Assign =?utf-8?Q?NULL_?= =?utf-8?B?4oCL4oCLdG8=?=
 phy that may be returned
Message-ID: <20201106065131.GD697514@kroah.com>
References: <1604632555-18497-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1604632555-18497-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 11:15:55AM +0800, Wang Qing wrote:
> Assign initial values ​​to local variables that may be returned
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Your subject, and body of text, seem to have 2 "odd" characters in it,
please fix up.

Also, your subject and changelog body here are identical, please be much
more verbose in the body explaining why you are doing something, not
just what you are doing.

And your subject line should also match other patches for this file, and
have "usb: phy: ..." in the beginning.

> ---
>  drivers/usb/phy/phy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
> index b47285f..de21967
> --- a/drivers/usb/phy/phy.c
> +++ b/drivers/usb/phy/phy.c
> @@ -59,7 +59,7 @@ static struct usb_phy *__usb_find_phy(struct list_head *list,
>  
>  static struct usb_phy *__of_usb_find_phy(struct device_node *node)
>  {
> -	struct usb_phy  *phy;
> +	struct usb_phy  *phy = NULL;

Why isn't the compiler complaining about this today?  Are you sure this
is needed?

thanks,

greg k-h
