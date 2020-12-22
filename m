Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EE22E0775
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 09:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgLVIw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 03:52:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:47938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgLVIw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 03:52:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 096D12076B;
        Tue, 22 Dec 2020 08:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1608627137;
        bh=Eo+/3GxxfJoxqtCpQmtzecCT5vtIMi9pqnp1mADEaFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fWVgcy1q4NXpS011cArBaBgZn83QLKdduVZWlB0Lm19qdQ/tbjWWb3zmc+1/KnpP4
         eqlVFypcPIBj7NJdVHeQdIBFjcqrr8Obn7NUDeRDL9GObT76Ij51JiDztS8HL4O7YJ
         kjSkMcM+zrmftcYM6c8234G8YFnysDxMegtMO2D4=
Date:   Tue, 22 Dec 2020 09:52:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     trix@redhat.com
Cc:     b-liu@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: musb: add printf attribute to log function
Message-ID: <X+Gzvo3vPBFGKAy+@kroah.com>
References: <20201221162547.3756889-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221162547.3756889-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 08:25:47AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Attributing the function allows the compiler to more thoroughly
> check the use of the function with -Wformat and similar flags.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/usb/musb/musb_debug.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/musb/musb_debug.h b/drivers/usb/musb/musb_debug.h
> index e5b3506c7b3f..dfc0d02695fa 100644
> --- a/drivers/usb/musb/musb_debug.h
> +++ b/drivers/usb/musb/musb_debug.h
> @@ -17,6 +17,7 @@
>  #define INFO(fmt, args...) yprintk(KERN_INFO, fmt, ## args)
>  #define ERR(fmt, args...) yprintk(KERN_ERR, fmt, ## args)
>  
> +__printf(2, 3)
>  void musb_dbg(struct musb *musb, const char *fmt, ...);

While I understand the need for this, did this find any problems?  If
not, then it's not worth adding, the driver-specific debugging macros
should be removed entirely and just use dev_dbg() and friends instead.

thanks,

greg k-h
