Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F042A29EE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgKBLtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgKBLtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:49:07 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521EEC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:49:07 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id w14so14205522wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+nfxQCCmJXEo7KncMNyKTjvgt98qI81zIUKCv1ZGk7A=;
        b=gRVuPI8Mfv4ZFGLYGPQhACenu9vVDG903vkWLHVy+/1o+8b+naTJnraP4Dpoj5wEkl
         hNJ6VFcZKLu7kk/zbxDCOgcPkK0I7OiqTGkWOxZHvmCWYJO1jrjsSzoSwDq5xVm4Un3U
         LROLW/77WC0GhEobCwK6DjkRmLH4MUmYo0TW7+8YABnCp4zoLfq4DeyQ6Dm2lAfAn1vK
         9Vvj5PaXynwPrJOPCfI1N7l1hcuesyRz+5S6P3wld5tpLaQpCsnJiYruwrfu1d2jW/Ug
         S87MI1SRGXt0/JcB/2fEFOI+gFidAWIDfUYiUbfP/KIVuKOaTRR+nbB9oNyMFiZscKIG
         vCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+nfxQCCmJXEo7KncMNyKTjvgt98qI81zIUKCv1ZGk7A=;
        b=jT+DWDEgLGLjhxI1SQv9LU4nQfsGrGyzdTZ1LYJlqKT2I5JU5vcCmg0aWRsNi7o9pA
         o7G6UZT1kueYbVJDM+bYQ97YNP+Hn9Y6X36ctxyIFIoNAO/+fh+AHifFt+MjXB4l8LmX
         I/s8yFTxn8J2ZjEMBEc8QhfaxM4oozuOteC0c9OQQtke2mx+U2JuShhWV6S6mLFOGDtu
         Lnfn3rAk0UtTO7WF6w4JohwLG71S3XBUKC9ZgphrEPdxge7zDIipOYyVZJ4yK7GDl+XI
         2W2qsZXvgo5DhUuj72hPwzkYl2y0XlwV6qGapC7/75gJ163cDIS9nMrfh+ptpzE4xttl
         EWIw==
X-Gm-Message-State: AOAM532chEJ5BtNVI+yYtsIYxMs6U2+Sm5vUj+XECC1Zl5F7m1dZh25A
        Y16VFiFzY4Y2GPEoxCraq+ZVxxY0mzXFpQ==
X-Google-Smtp-Source: ABdhPJzlXOMnvvRSFKCIMDXT1E5IRJdfL+GZYEdvDsrxITEEnF5V1jDXACBqO2oZw8A8ePwmsXjtdQ==
X-Received: by 2002:adf:ab50:: with SMTP id r16mr19080712wrc.235.1604317746019;
        Mon, 02 Nov 2020 03:49:06 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id a3sm14865167wmb.46.2020.11.02.03.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:49:05 -0800 (PST)
Date:   Mon, 2 Nov 2020 11:49:03 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rodolfo Giometti <giometti@enneenne.com>,
        "Eurotech S.p.A" <info@eurotech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/2] misc: c2port: core: Make copying name from userspace
 more secure
Message-ID: <20201102114903.GN4127@dell>
References: <20201102111211.1047972-1-lee.jones@linaro.org>
 <d7b2a5d8d46e4f7885315ea4aa032b8c@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7b2a5d8d46e4f7885315ea4aa032b8c@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Nov 2020, David Laight wrote:

> From: Lee Jones
> > Sent: 02 November 2020 11:12
> > 
> > strncpy() may not provide a NUL terminator, which means that a 1-byte
> > leak would be possible *if* this was ever copied to userspace.  Ensure
> > the buffer will always be NUL terminated by using the kernel's
> > strscpy() which a) uses the destination (instead of the source) size
> > as the bytes to copy and b) is *always* NUL terminated.
> > 
> > Cc: Rodolfo Giometti <giometti@enneenne.com>
> > Cc: "Eurotech S.p.A" <info@eurotech.it>
> > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/misc/c2port/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
> > index 80d87e8a0bea9..b96444ec94c7e 100644
> > --- a/drivers/misc/c2port/core.c
> > +++ b/drivers/misc/c2port/core.c
> > @@ -923,7 +923,7 @@ struct c2port_device *c2port_device_register(char *name,
> >  	}
> >  	dev_set_drvdata(c2dev->dev, c2dev);
> > 
> > -	strncpy(c2dev->name, name, C2PORT_NAME_LEN - 1);
> > +	strscpy(c2dev->name, name, sizeof(c2dev->name));
> 
> strscpy() doesn't zero fill so if the memory isn't zeroed
> and a 'blind' copy to user of the structure is done
> then more data is leaked.
> 
> strscpy() may be better, but rational isn't right.

The original patch zeroed the data too, but I was asked to remove that
part [0].  In your opinion, should it be reinstated?

[0] https://lore.kernel.org/patchwork/patch/1272290/

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
