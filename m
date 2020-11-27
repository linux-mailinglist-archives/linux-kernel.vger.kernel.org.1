Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202762C6A60
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbgK0REA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:04:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731528AbgK0REA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:04:00 -0500
Received: from localhost (82-217-20-185.cable.dynamic.v4.ziggo.nl [82.217.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 697AA21D46;
        Fri, 27 Nov 2020 17:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606496639;
        bh=b4hIcTuq0eZR5lLBto3s9A5gYyAe0x2uIcW3/lCuZ28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LAWWYqZ9G1ABeqgXFgMvrlycvfOJcB39dN4w9mVlHoszGpQZeZVAD/SxVl/FOsR8Y
         nCQ9EmFc2IMEoj1KWMMAOrrbEY3UBqzy8wMjOgt/j2ieVeJ+4rvQD7QSSGqTrxdnhH
         2Bxu65oq7b4qpncvPZYYKDlISrAyAdr8L5bkvqcA=
Date:   Fri, 27 Nov 2020 18:03:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     trix@redhat.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: altera-stapl: remove trailing semicolon in macro
 definition
Message-ID: <X8ExfFYVcwsbBa81@kroah.com>
References: <20201127165421.2692469-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127165421.2692469-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 08:54:21AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> The macro use will already have a semicolon.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/misc/altera-stapl/altera-jtag.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/altera-stapl/altera-jtag.c b/drivers/misc/altera-stapl/altera-jtag.c
> index 27e8e0c9e8cf..0238600107b0 100644
> --- a/drivers/misc/altera-stapl/altera-jtag.c
> +++ b/drivers/misc/altera-stapl/altera-jtag.c
> @@ -17,9 +17,9 @@
>  #include "altera-jtag.h"
>  
>  #define	alt_jtag_io(a, b, c)\
> -		astate->config->jtag_io(astate->config->dev, a, b, c);
> +		astate->config->jtag_io(astate->config->dev, a, b, c)
>  
> -#define	alt_malloc(a)	kzalloc(a, GFP_KERNEL);
> +#define	alt_malloc(a)	kzalloc(a, GFP_KERNEL)

Ick, really?  That macro should be removed entirely.  Can you redo this
as a 2 patch series, the first for the alt_jtag_io() change, and the
other to remove all users of alt_malloc()?

thanks,

greg k-h
