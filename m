Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496CD2DA8E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgLOIGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgLOIFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:05:37 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF36C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 00:04:48 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id m5so18850375wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 00:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MbW/aNPnMI3Tt8o0eStb7kmZYcIkeHTT/zhJDBmp9Po=;
        b=ERAzFdv3OQLUww5ou7XtAG/8q6kqp/p8+AfwT2MaTB2yzEEM0sYuWSkXTVOI6wIxla
         Z1Yjv2l6iA3MYW0nu0cUyrHGFWKb99pxy9srXvvZ1M3iX2xkYT7r3sNnHhxiC1weYjA9
         wvYgYaIqA7mu88/BRCrDTSyeJKNL466afdLNdIx6FR4CN6bQfTer0bIJXg9T8+y52EbB
         DSRqiVD0IzrCDqB7hzHC/THJaYeVIDSdjXuwXskAdvI3eXrBjrOaZ6Yl+Lur19glBDkl
         GACBOOLJ/OX4ZJ3NUBwYU90XTveFA8aiPEvlfURB3O83mTnSqhsRlUK7C+8LJOwyrlPc
         G0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MbW/aNPnMI3Tt8o0eStb7kmZYcIkeHTT/zhJDBmp9Po=;
        b=WNDKCcPJNEjnGsfTIGmClam97cNFNavfG21krlu6fnmRu1vhFjBYHtnuEFz7YvPQkF
         q6J1b/pkzSnd3opGc+JclOA3a3wV2XGQ1MZqyqs7rDVSyrzkDP7Jbg/m/Wa4abWR+vfo
         g0UuMTCc19V2bAtxWQCVt9CPB5FGK2fYMXHQJ0SaHmtBAJa7eAJ9NhkGCshCtT2D2sCC
         dnejCzsyl4iqESq1rR/C1gMzlb69XpEh52H83oKT2EG9lgVc+3tLdkoZnv1MBXG3/Jk4
         NUvz46VprYzk6qvkZa2wG1VjfXmzY3qJlBEYxoVM8IQayShpZc2omon4AHsCTfjf26U2
         ksvQ==
X-Gm-Message-State: AOAM5305KWZN8G58l3ilREmfPDKk19xdtRmyQTqbPB7KczDQdaCGmwUO
        BtyUy2dVOeovcffk69l3QwT9Uw==
X-Google-Smtp-Source: ABdhPJyBaJVZxusL4+NkX5M1cL9XgJuSWZPi9uRydM6u2Zpl6/+bh4iwRS1pELsgP/ST1fktxMTHnw==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr32200972wrs.284.1608019487058;
        Tue, 15 Dec 2020 00:04:47 -0800 (PST)
Received: from dell ([91.110.221.168])
        by smtp.gmail.com with ESMTPSA id n12sm38986631wrg.76.2020.12.15.00.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 00:04:46 -0800 (PST)
Date:   Tue, 15 Dec 2020 08:04:44 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Zheng Yongjun <zhengyongjun3@huawei.com>, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] backlight: sky81452-backlight: convert comma to
 semicolon
Message-ID: <20201215080444.GK5029@dell>
References: <20201214133458.3729-1-zhengyongjun3@huawei.com>
 <20201214143632.oiqmvpkai7kurc2d@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201214143632.oiqmvpkai7kurc2d@holly.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Dec 2020, Daniel Thompson wrote:

> On Mon, Dec 14, 2020 at 09:34:58PM +0800, Zheng Yongjun wrote:
> > Replace a comma between expression statements by a semicolon.
> > 
> > Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> 
> Weird! I guess it was harmless but still seriously weird ;-)

One of these was found in MFD a couple of weeks ago.

Yours was exactly my train of thought!

One suggestion was to convert all semi-colons to commas and do away
with all the curly braces encapsulating if()s, for()s and while()s.

Who knew that was even possible?

> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Thanks!
> 
> 
> > ---
> >  drivers/video/backlight/sky81452-backlight.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
> > index 8268ac43d54f..c95e0de7f4e7 100644
> > --- a/drivers/video/backlight/sky81452-backlight.c
> > +++ b/drivers/video/backlight/sky81452-backlight.c
> > @@ -291,7 +291,7 @@ static int sky81452_bl_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	memset(&props, 0, sizeof(props));
> > -	props.max_brightness = SKY81452_MAX_BRIGHTNESS,
> > +	props.max_brightness = SKY81452_MAX_BRIGHTNESS;
> >  	name = pdata->name ? pdata->name : SKY81452_DEFAULT_NAME;
> >  	bd = devm_backlight_device_register(dev, name, dev, regmap,
> >  						&sky81452_bl_ops, &props);

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
