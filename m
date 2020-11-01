Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BE02A1F2D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 16:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgKAPkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 10:40:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbgKAPkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 10:40:18 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1CFE20870;
        Sun,  1 Nov 2020 15:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604245216;
        bh=cfBWIZ6CSRsNUZTv6d9OMPWdYjslQzWKE4+ZI+yCBMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lkww5ZLVtaw4/LQXlV8GY7HSiy4WHoOmiaDerVB0QCScFd5yX7m0HJ+h74Wonvjeb
         gxw7KdZ2sSTaH7QhpPwlY8RWMDN7WHkY0iP/jPme8lWkpE+Ep7M8+JiEH86ntHL8eb
         iIJ0AyJMZIFxghCxMw4dVMlaK7h7y1g5D8ySQz1o=
Date:   Sun, 1 Nov 2020 16:41:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbcon: Replace printk() with pr_*()
Message-ID: <20201101154113.GA41883@kroah.com>
References: <20201101094718.GD1166694@ravnborg.org>
 <20201101144904.1522611-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101144904.1522611-1-yepeilin.cs@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 01, 2020 at 09:49:04AM -0500, Peilin Ye wrote:
> Replace printk() with pr_err(), pr_warn() and pr_info(). Do not split long
> strings, for easier grepping. Use `__func__` whenever applicable.
> 
> fbcon_prepare_logo() has more than one callers, use "fbcon_prepare_logo:"
> instead of "fbcon_init:", for less confusion.
> 
> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> ---
>  drivers/video/fbdev/core/fbcon.c | 42 +++++++++++++-------------------
>  1 file changed, 17 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index cef437817b0d..a3e87ab0e523 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -659,8 +659,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
>  
>  	if (logo_lines > vc->vc_bottom) {
>  		logo_shown = FBCON_LOGO_CANSHOW;
> -		printk(KERN_INFO
> -		       "fbcon_init: disable boot-logo (boot-logo bigger than screen).\n");
> +		pr_info("%s: disable boot-logo (boot-logo bigger than screen).\n", __func__);

Shouldn't this be:
		dev_info(info->dev, "...");
instead?

It's a driver, and you have access to the struct device that is being
worked on, so always try to use the dev_* versions of these calls
instead when ever possible.

thanks,

greg k-h
