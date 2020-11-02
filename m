Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F90B2A2B1A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgKBM6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 07:58:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbgKBM6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:58:16 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95DC222273;
        Mon,  2 Nov 2020 12:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604321895;
        bh=fQ8P5yc8YQIpIUWE0C/hVRoq6teUjZGUWQYNFBcbt1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lPZZIwoUuMhJhCo92GeozYcqPk7Lb8nc4ylpcD9fRDASDy5+193i2ip+L4cPGdvUU
         TaY2tEWraTAUspuZDT1R3HbA76aZP8LJF7dAwMGUFoZ0XbHTRBy/9cS3dJo9wXDZaW
         +C5XbMkKBVtqxTlk/Vxd6i2K66rL+ALl9gFuIAf4=
Date:   Mon, 2 Nov 2020 13:59:10 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rodolfo Giometti <giometti@enneenne.com>,
        "Eurotech S.p.A" <info@eurotech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/2] misc: c2port: core: Make copying name from userspace
 more secure
Message-ID: <20201102125910.GA1008111@kroah.com>
References: <20201102111211.1047972-1-lee.jones@linaro.org>
 <d7b2a5d8d46e4f7885315ea4aa032b8c@AcuMS.aculab.com>
 <20201102114903.GN4127@dell>
 <20201102121150.GA663356@kroah.com>
 <20201102124301.GC4488@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102124301.GC4488@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 12:43:01PM +0000, Lee Jones wrote:
> On Mon, 02 Nov 2020, gregkh@linuxfoundation.org wrote:
> 
> > On Mon, Nov 02, 2020 at 11:49:03AM +0000, Lee Jones wrote:
> > > On Mon, 02 Nov 2020, David Laight wrote:
> > > 
> > > > From: Lee Jones
> > > > > Sent: 02 November 2020 11:12
> > > > > 
> > > > > strncpy() may not provide a NUL terminator, which means that a 1-byte
> > > > > leak would be possible *if* this was ever copied to userspace.  Ensure
> > > > > the buffer will always be NUL terminated by using the kernel's
> > > > > strscpy() which a) uses the destination (instead of the source) size
> > > > > as the bytes to copy and b) is *always* NUL terminated.
> > > > > 
> > > > > Cc: Rodolfo Giometti <giometti@enneenne.com>
> > > > > Cc: "Eurotech S.p.A" <info@eurotech.it>
> > > > > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > ---
> > > > >  drivers/misc/c2port/core.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
> > > > > index 80d87e8a0bea9..b96444ec94c7e 100644
> > > > > --- a/drivers/misc/c2port/core.c
> > > > > +++ b/drivers/misc/c2port/core.c
> > > > > @@ -923,7 +923,7 @@ struct c2port_device *c2port_device_register(char *name,
> > > > >  	}
> > > > >  	dev_set_drvdata(c2dev->dev, c2dev);
> > > > > 
> > > > > -	strncpy(c2dev->name, name, C2PORT_NAME_LEN - 1);
> > > > > +	strscpy(c2dev->name, name, sizeof(c2dev->name));
> > > > 
> > > > strscpy() doesn't zero fill so if the memory isn't zeroed
> > > > and a 'blind' copy to user of the structure is done
> > > > then more data is leaked.
> > > > 
> > > > strscpy() may be better, but rational isn't right.
> > > 
> > > The original patch zeroed the data too, but I was asked to remove that
> > > part [0].  In your opinion, should it be reinstated?
> > > 
> > > [0] https://lore.kernel.org/patchwork/patch/1272290/
> > 
> > Just keep the kzalloc() part of the patch, this portion makes no sense
> > to me.
> 
> Can do.
> 
> > But if you REALLY want to get it correct, call dev_set_name()
> > instead please, as that is what it is there for.
> 
> The line above isn't setting the 'struct device' name.  It looks as
> though 'struct c2port' has it's own member, also called 'name'.  As to
> how they differ, I'm not currently aware.  Nor do I wish to mess
> around with the semantics all that much.
> 
> Going with suggestion #1.

As the "device" already has a name, I suggest just getting rid of this
name field anyway, no need for duplicates.

thanks,

greg k-h
