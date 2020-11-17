Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6D52B5F40
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgKQMhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgKQMhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:37:45 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45546C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 04:37:45 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id d12so22977286wrr.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 04:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dYTUP6m9B9Q6q/xbnQnotcTT/32r5BltFzpa6gbz/yY=;
        b=cu9zhW6LQ5+ppuXapDbrykN/TT065Y8UUoHsxUCzCOiTNtsMtEBTa6sYFVgWqen3pT
         yyOF4V9mHY1xV/KgfEnJ76cPDnKwjF6JJ/Ymj+2IIefY2oZmL4L6aIsFR8beY+fuRQSW
         9REkHdkZdHa6srk5mGwfH3B7sh4ung6vYD1KtwEeJ8WIhq/amuMpGXv1ovnaBYjhddJV
         Kv6VBiEdAk4HQiDpVed9Kus7R31rfVBrudp/hpywEoN/9D6v4TQV5kDAVE9s4hSZnyk6
         UWy8nq1BJjfy2wMttVdTyWql73GbJVdfadVERHamlF5hwTitPDFqbzMwhzAypJhi/77C
         vRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dYTUP6m9B9Q6q/xbnQnotcTT/32r5BltFzpa6gbz/yY=;
        b=rNljk31rt/NCfhjbrhY6Yr4R+sQ8jCSduMKxaoaLGuFr3bPvcf58fYlmjYYPa9svFO
         6fbj+jToRBQu+iq6BZ1ihR7ZRgCiHn6GNi6UqW7hevmM4nqZwiqxMCECOQIrawhaVEs3
         dmS6KWPDST7S3QKQOKmSzk13LPx0XqlF9p03vCHR37t5miwaHjWi8Rk+g3ydJaz1KO2a
         FLYayCmTI9ToPmNSEGSD7bWlXWFkoJdmtc9wDPEHXBBjRvTnph8eGVfdPTyg9BYgS4Fj
         0/kYQ3TxvemEvk2cE5TaWsZG5vZYt4NJfQqdp/3YFBxRuH56uNWS+SpSZAg934rwdcKK
         MGbw==
X-Gm-Message-State: AOAM533JISIht0PFsJgSkFkqXW/1R28IznsaMuo5hnZAeYE27PY5CQGs
        AJL280gSoKjjJy4B4KTsB0FzTg==
X-Google-Smtp-Source: ABdhPJw+j/xh3axf4rExtox8uvxiA9tBLkhu8ubtNnralAsexsEZGR3HaHdE/o3OoVI2jKn6NG8Ugw==
X-Received: by 2002:a5d:5711:: with SMTP id a17mr23881869wrv.136.1605616664001;
        Tue, 17 Nov 2020 04:37:44 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id f13sm21902518wrq.78.2020.11.17.04.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 04:37:43 -0800 (PST)
Date:   Tue, 17 Nov 2020 12:37:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] mfd: syscon: Add
 syscon_regmap_lookup_by_phandle_optional() function.
Message-ID: <20201117123741.GH1869941@dell>
References: <20201110161338.18198-1-enric.balletbo@collabora.com>
 <20201113101940.GH3718728@dell>
 <c4ed34d5-83a1-98d1-580f-8f8504c5ca0a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4ed34d5-83a1-98d1-580f-8f8504c5ca0a@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020, Matthias Brugger wrote:

> Hi Lee,
> 
> On 13/11/2020 11:19, Lee Jones wrote:
> > On Tue, 10 Nov 2020, Enric Balletbo i Serra wrote:
> > 
> > > This adds syscon_regmap_lookup_by_phandle_optional() function to get an
> > > optional regmap.
> > > 
> > > It behaves the same as syscon_regmap_lookup_by_phandle() except where
> > > there is no regmap phandle. In this case, instead of returning -ENODEV,
> > > the function returns NULL. This makes error checking simpler when the
> > > regmap phandle is optional.
> > > 
> > > Suggested-by: Nicolas Boichat <drinkcat@chromium.org>
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > > ---
> > > 
> > > Changes in v2:
> > > - Add Matthias r-b tag.
> > > - Add the explanation from the patch description to the code.
> > > - Return NULL instead of -ENOTSUPP when regmap helpers are not enabled.
> > > 
> > >   drivers/mfd/syscon.c       | 18 ++++++++++++++++++
> > >   include/linux/mfd/syscon.h | 11 +++++++++++
> > >   2 files changed, 29 insertions(+)
> > 
> > Applied, thanks.
> > 
> 
> I've a series [1] that's based on this patch, could you provide a stable
> branch for it, so that I can take the series.

Why can't you base it off of for-mfd-next?

https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=for-mfd-next

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
