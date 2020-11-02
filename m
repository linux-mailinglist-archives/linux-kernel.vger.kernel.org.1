Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3C32A2BEC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgKBNrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKBNrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:47:33 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF32DC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 05:47:32 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id k18so9560421wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 05:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DVnJguRhgSuHhwcYKzQRaLJKdcuRSoN8zs/m3lzrT8A=;
        b=Wj+M71N1RdTes6u5Dk/LSSCt4EGD0c0ahuPykaBmLtqj5wgCCwDKpQorczrBwUZuxW
         jxmSqJxuntk6eSsX63IzrPdaSzAGwEA6hNvc4fkb12l+Oqvle+NIL9fTwBZAt1uhP6Wi
         TaDnKUVszH5mVBfI6frj/C4seQwVvbFzL213QQRQ7e65Ct8ONqO3adpQ7wRZwT/AT7l1
         zNHx7Cn2WP7eY3Te4BoVsfclhGCL8OqkucRFhVDVXNiOld4XY55FKA41KkrpCSFGTunm
         U50Fsf5VY3ndb11+hIedidMU8LPxc6rH9DiRhPl+dPfocciUMjYV8rCKb2axq0GKBq4/
         s39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DVnJguRhgSuHhwcYKzQRaLJKdcuRSoN8zs/m3lzrT8A=;
        b=C238yCXzTKC1RTC3Dg7HE9W/7emYO6XmJ08sDfhyl4EowHxN815BNsag9YLswdRpDn
         xo1AczAJNeZYNrpiaQBZ7OfNk4Um8PuD6pyxJmoihAOGN1NealCXBaOMlvB4ETMYzJmY
         OfuGoQcq082m1AsUVI89U+5AZUjzrOONZTmrcr6nFQ7dduMomaWPj4l7K2pTJyyq7ySr
         Pa1+/LRj4hdFGvKtPicC064cHixbYsxGT5uBmBkNTqwTY5RT90X8z3hCXPczIYYz3huC
         ED4VDfBcL2kOm3RBh3AoCKo3Bjq3xHx4GKD+LtomWLU2sfjxDljNhuNzcoBeYSU/TzFV
         tTpw==
X-Gm-Message-State: AOAM5308p4O57LDx3NAEgBXnm90D+lRgwpMQ9jlElUAXPjl2X1XyNpSs
        ++DewzJNRsxyKHVXl1Fif/M34LQjg1NmNA==
X-Google-Smtp-Source: ABdhPJwhOF6/VnPaqD7AyqODaugILylu0MjNzP+5+j47JBh/6sO368NjKWTtz0Ovwglk43vym94Dxw==
X-Received: by 2002:a1c:bac1:: with SMTP id k184mr11862826wmf.76.1604324851469;
        Mon, 02 Nov 2020 05:47:31 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id s11sm22102143wrm.56.2020.11.02.05.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 05:47:30 -0800 (PST)
Date:   Mon, 2 Nov 2020 13:47:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rodolfo Giometti <giometti@enneenne.com>,
        "Eurotech S.p.A" <info@eurotech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/2] misc: c2port: core: Make copying name from userspace
 more secure
Message-ID: <20201102134729.GD4488@dell>
References: <20201102111211.1047972-1-lee.jones@linaro.org>
 <d7b2a5d8d46e4f7885315ea4aa032b8c@AcuMS.aculab.com>
 <20201102114903.GN4127@dell>
 <20201102121150.GA663356@kroah.com>
 <20201102124301.GC4488@dell>
 <20201102125910.GA1008111@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201102125910.GA1008111@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Nov 2020, gregkh@linuxfoundation.org wrote:

> On Mon, Nov 02, 2020 at 12:43:01PM +0000, Lee Jones wrote:
> > On Mon, 02 Nov 2020, gregkh@linuxfoundation.org wrote:
> > 
> > > On Mon, Nov 02, 2020 at 11:49:03AM +0000, Lee Jones wrote:
> > > > On Mon, 02 Nov 2020, David Laight wrote:
> > > > 
> > > > > From: Lee Jones
> > > > > > Sent: 02 November 2020 11:12
> > > > > > 
> > > > > > strncpy() may not provide a NUL terminator, which means that a 1-byte
> > > > > > leak would be possible *if* this was ever copied to userspace.  Ensure
> > > > > > the buffer will always be NUL terminated by using the kernel's
> > > > > > strscpy() which a) uses the destination (instead of the source) size
> > > > > > as the bytes to copy and b) is *always* NUL terminated.
> > > > > > 
> > > > > > Cc: Rodolfo Giometti <giometti@enneenne.com>
> > > > > > Cc: "Eurotech S.p.A" <info@eurotech.it>
> > > > > > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > > ---
> > > > > >  drivers/misc/c2port/core.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
> > > > > > index 80d87e8a0bea9..b96444ec94c7e 100644
> > > > > > --- a/drivers/misc/c2port/core.c
> > > > > > +++ b/drivers/misc/c2port/core.c
> > > > > > @@ -923,7 +923,7 @@ struct c2port_device *c2port_device_register(char *name,
> > > > > >  	}
> > > > > >  	dev_set_drvdata(c2dev->dev, c2dev);
> > > > > > 
> > > > > > -	strncpy(c2dev->name, name, C2PORT_NAME_LEN - 1);
> > > > > > +	strscpy(c2dev->name, name, sizeof(c2dev->name));
> > > > > 
> > > > > strscpy() doesn't zero fill so if the memory isn't zeroed
> > > > > and a 'blind' copy to user of the structure is done
> > > > > then more data is leaked.
> > > > > 
> > > > > strscpy() may be better, but rational isn't right.
> > > > 
> > > > The original patch zeroed the data too, but I was asked to remove that
> > > > part [0].  In your opinion, should it be reinstated?
> > > > 
> > > > [0] https://lore.kernel.org/patchwork/patch/1272290/
> > > 
> > > Just keep the kzalloc() part of the patch, this portion makes no sense
> > > to me.
> > 
> > Can do.
> > 
> > > But if you REALLY want to get it correct, call dev_set_name()
> > > instead please, as that is what it is there for.
> > 
> > The line above isn't setting the 'struct device' name.  It looks as
> > though 'struct c2port' has it's own member, also called 'name'.  As to
> > how they differ, I'm not currently aware.  Nor do I wish to mess
> > around with the semantics all that much.
> > 
> > Going with suggestion #1.
> 
> As the "device" already has a name, I suggest just getting rid of this
> name field anyway, no need for duplicates.

That definitely goes against the point I made above:

 "Nor do I wish to mess around with the semantics all that much."

It looks as though the device name 'c2port%d' varies greatly to the
requested name 'uc'.  I don't have enough knowledge of how user-
space expects to use the provided sysfs entries to be able to
competently merge/decide which of these should be kept and which to
discard.

Hopefully one of the authors/maintainers are reading this and can come
up with an acceptable solution.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
