Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E012428830C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 08:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgJIGzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 02:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgJIGzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 02:55:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5A0C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 23:55:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e17so9039405wru.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 23:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0DIIkikDzDpqw7QIcfNPLZr1NLPJnYzyVy6xbInQ09c=;
        b=khw75Y3YtoatbpZVz+cYlQNIYPP8MqfVV7IpxED67l9Qfc8LAS2oHH0Jd2SNMQgiZ3
         EJoTkuwiYjvE3HPmjOcoklrOfVHPec5S3UElMoIIHZqso/7vHn1peubwJd9OHIHRPA54
         FKjsiVisTn5lcQLzrxi2NYsyCDZ5HYItNXEKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=0DIIkikDzDpqw7QIcfNPLZr1NLPJnYzyVy6xbInQ09c=;
        b=Lm8qL5l2EFqaHso0i3bYdTmweG2QZGXHo4hwAOuWRBAvtCY+2MPGFZXAKgAD4lIBOD
         QZN05y89lzO/+T24vH5OGCLptZUUUgvRWhT3XfvTZusRGzH5TSv70hMEO4DtgrRK9oxl
         gCBQPGQUfMwFXxNBF9O2hjSA6rz8z+6ApqLwkzHiPkEU3m7RV/FOXbh0fhhF+FVWGpB7
         W5hM8gw20OdNMQ+CDXriPFzXBaLVAWi+KxfP3bpbUjfGkbT5JK0f6rVltOfPpqPPxhBb
         ggmUuJGrNXT13UtUPMkVA0SiRbDNZPariwnYfERtdh91VgGZw5zQIBkzsaTD59G5jPsb
         4Kgw==
X-Gm-Message-State: AOAM533pC1DGSnAqXGsTkhXKeJv2+tcN+JtAfz9CsdLf+sXIi5Y1kEW8
        KT1FHnlaUYBDexLi2+2ZdBjo5Q==
X-Google-Smtp-Source: ABdhPJwINWBtAcBqqUULl8SGGW4lyULdu1/AzvHe7YnRNfs22ucQoPSdKC0g+OrLnW4upZaZaYCbMw==
X-Received: by 2002:adf:ed09:: with SMTP id a9mr12994550wro.407.1602226543511;
        Thu, 08 Oct 2020 23:55:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k190sm10332534wme.33.2020.10.08.23.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 23:55:42 -0700 (PDT)
Date:   Fri, 9 Oct 2020 08:55:40 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Ondrej Jirman <megous@megous.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] MAINTAINERS: Update entry for st7703 driver after the
 rename
Message-ID: <20201009065540.GJ438822@phenom.ffwll.local>
Mail-Followup-To: Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ondrej Jirman <megous@megous.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>
References: <20200701184640.1674969-1-megous@megous.com>
 <alpine.DEB.2.21.2010090623060.15995@felia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2010090623060.15995@felia>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 06:27:46AM +0200, Lukas Bulwahn wrote:
> 
> 
> On Wed, 1 Jul 2020, Ondrej Jirman wrote:
> 
> > The driver was renamed, change the path in the MAINTAINERS file.
> > 
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> 
> This minor non-urgent cleanup patch has not been picked up yet by anyone.
> 
> Hence, ./scripts/get_maintainers.pl --self-test=patterns continues to 
> complain:
> 
>   warning: no file matches  F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
>   warning: no file matches  F:	drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> 
> This patch cleanly applies on next-20201008 and resolves the issue above.

Generally after 2-3 weeks a patch is lost and unfortunately needs to be
resend. Please do that next time around instead of waiting.

Patch queued up now for 5.10, thanks.
-Daniel

> Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> 
> Lukas
> 
> > ---
> >  MAINTAINERS | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5f186a661a9b..f5183eae08df 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5487,12 +5487,13 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
> >  F:	drivers/gpu/drm/panel/panel-raydium-rm67191.c
> >  
> > -DRM DRIVER FOR ROCKTECH JH057N00900 PANELS
> > +DRM DRIVER FOR SITRONIX ST7703 PANELS
> >  M:	Guido Günther <agx@sigxcpu.org>
> >  R:	Purism Kernel Team <kernel@puri.sm>
> > +R:	Ondrej Jirman <megous@megous.com>
> >  S:	Maintained
> > -F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
> > -F:	drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> > +F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> > +F:	drivers/gpu/drm/panel/panel-sitronix-st7703.c
> >  
> >  DRM DRIVER FOR SAVAGE VIDEO CARDS
> >  S:	Orphan / Obsolete
> > -- 
> > 2.27.0
> > 
> > 


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
