Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AAF2A2AE1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgKBMnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 07:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgKBMnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:43:06 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9939EC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 04:43:05 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id a9so14399015wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 04:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rgJj9AlHJO4Oanhoj3DS+Ov+LQevmNCMaj3cCH85YMI=;
        b=TMPifpHuYtodX1XSB2q94xDo0bscL6j7GrSU5Mt2ywlh+qzxowNfWP1JbBX2vSDSrP
         zV1a4gzBnBb+EntrHQwlom2Sk18ZF19FRiKYWm4daEw9vgEaSVAhqM6jqsF6CdpylFCr
         pwqJvclyghxu0EPaI3yMUc8eCbSg7HZr0+1JsXF7KFqDeD/YrGrZMRAjlVQLnkmJXc+W
         FJ8cil1UGCRjXeGzr0vMtbah4Ca6E9qBoPcAC2zvvk3gc/Rr51vIBu0GgLkVSVMjV1XA
         dS7/Ub3v+rGyPoAcjDz5U58SdNEN71udYCdwKcrSS8me7VTTKxyuMXUPTf94iJVGwibM
         g84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rgJj9AlHJO4Oanhoj3DS+Ov+LQevmNCMaj3cCH85YMI=;
        b=a+yMiuu9EOSMTYBV9eVF6/YJSe4XI2scugkKv/Hoaa4usbg7r/uOwCauRY5bSHd6IC
         YEKl8e6Jvn3Nzehii0hUrTlJwgnuGu97c6T91JrvIEPsUnhdQi9qTAbCmRDveDzimikP
         VLeBotU6eKB0CwkB7XTkDteLPC4xVMia7CoUFdt89qtcLucoXLFbG4at9DX88sONm3hh
         cwEps7HoHaJwYA3dmjmpgLcGItM1242rkKYGVAF+7vejy8i8IsYyWjCXNrDadDNycAXn
         al1iGjekv5SpPlvMk7CB53ZSuzXWSV5j37ellfmjrZEqHzJRx3eIMpEIfRWzqur+4u8s
         clLw==
X-Gm-Message-State: AOAM5319YktWMW9hoXuNVqbrfOWrssEOMZL1sKbsivo2Bd4OWUSQtVJx
        hOtmS7r4EU5D1gVzybWgF6vevA==
X-Google-Smtp-Source: ABdhPJwCA2cn8gTG5ycfI1cG4QbaxB42eGDjdkceAiYBMx+M49kqCKnOobr20b0ICHB0tDrkv2PFgQ==
X-Received: by 2002:a5d:4ad0:: with SMTP id y16mr19284523wrs.22.1604320984364;
        Mon, 02 Nov 2020 04:43:04 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id 3sm15873554wmd.19.2020.11.02.04.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 04:43:03 -0800 (PST)
Date:   Mon, 2 Nov 2020 12:43:01 +0000
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
Message-ID: <20201102124301.GC4488@dell>
References: <20201102111211.1047972-1-lee.jones@linaro.org>
 <d7b2a5d8d46e4f7885315ea4aa032b8c@AcuMS.aculab.com>
 <20201102114903.GN4127@dell>
 <20201102121150.GA663356@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201102121150.GA663356@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Nov 2020, gregkh@linuxfoundation.org wrote:

> On Mon, Nov 02, 2020 at 11:49:03AM +0000, Lee Jones wrote:
> > On Mon, 02 Nov 2020, David Laight wrote:
> > 
> > > From: Lee Jones
> > > > Sent: 02 November 2020 11:12
> > > > 
> > > > strncpy() may not provide a NUL terminator, which means that a 1-byte
> > > > leak would be possible *if* this was ever copied to userspace.  Ensure
> > > > the buffer will always be NUL terminated by using the kernel's
> > > > strscpy() which a) uses the destination (instead of the source) size
> > > > as the bytes to copy and b) is *always* NUL terminated.
> > > > 
> > > > Cc: Rodolfo Giometti <giometti@enneenne.com>
> > > > Cc: "Eurotech S.p.A" <info@eurotech.it>
> > > > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  drivers/misc/c2port/core.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
> > > > index 80d87e8a0bea9..b96444ec94c7e 100644
> > > > --- a/drivers/misc/c2port/core.c
> > > > +++ b/drivers/misc/c2port/core.c
> > > > @@ -923,7 +923,7 @@ struct c2port_device *c2port_device_register(char *name,
> > > >  	}
> > > >  	dev_set_drvdata(c2dev->dev, c2dev);
> > > > 
> > > > -	strncpy(c2dev->name, name, C2PORT_NAME_LEN - 1);
> > > > +	strscpy(c2dev->name, name, sizeof(c2dev->name));
> > > 
> > > strscpy() doesn't zero fill so if the memory isn't zeroed
> > > and a 'blind' copy to user of the structure is done
> > > then more data is leaked.
> > > 
> > > strscpy() may be better, but rational isn't right.
> > 
> > The original patch zeroed the data too, but I was asked to remove that
> > part [0].  In your opinion, should it be reinstated?
> > 
> > [0] https://lore.kernel.org/patchwork/patch/1272290/
> 
> Just keep the kzalloc() part of the patch, this portion makes no sense
> to me.

Can do.

> But if you REALLY want to get it correct, call dev_set_name()
> instead please, as that is what it is there for.

The line above isn't setting the 'struct device' name.  It looks as
though 'struct c2port' has it's own member, also called 'name'.  As to
how they differ, I'm not currently aware.  Nor do I wish to mess
around with the semantics all that much.

Going with suggestion #1.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
