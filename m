Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7891C5014
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 10:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgEEIRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 04:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725833AbgEEIRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 04:17:54 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AF4C061A41
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 01:17:53 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id v192so276194vkd.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 01:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TbQ/NUsTl64Wiv4a1ipzIuD3CBdf0yc6n6AHT0AzX6s=;
        b=lizeE8913OsCMHce51oPvAyEnSr00jzla8Wj9ZJX8Yj4J1Psb7aJ12HDbUuxzEASuV
         CJOcUf/1RPpJ18db073V2gTXAgZrhjOiqKsFQTtxkRjpOYi7p+8iPI6IgM2MLiGzaKLy
         cLIvq0bhk4yEFz1lkPgzduKThkyI9/FNNBUECjt00MMWx/SmSy1QyuQ90mKXKVovzmJ9
         4fKGh0hJnh1TGnDmYd/ZhNdLxC+6X+tPCtAfmgDvTlLfG9iZKYS2tw377gR8NwBlvma+
         N8uaPL/HAJq4slF/CQIAr93/bDUWK4Xy5o9CeYh1dInheigK6z+mx2xsFNL4I2ItVIiH
         Sw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TbQ/NUsTl64Wiv4a1ipzIuD3CBdf0yc6n6AHT0AzX6s=;
        b=UBU+MXW4cyeGOR3Kvg3TakdfF+VrYRoC7vuWeINlA7D7rF2XDiDW0A0Ag9H2dGJTdE
         7bRkdOTcgB+JO6XDvRu8FTpoqH9StYtnrlNnYXLdHe4DM4xPjpTxZNh7z21hljgBQnLB
         xX6mIB9xXykP3x6O/EFhpa1QKI6WHFSCVO9eGMCgAlwLF91MXIHyftVYlrJGSoUTjCCH
         PdbbHp0cf2T+q0djMLgXV/EFKLfCiF/mwR8OMmsfXfp4jzFM8c+0IrIoT+hqh+IxkoY+
         vBI5zscO1YspDyAr2lW6ZyaRstc7hPi+0mKfNE9psBuWRbo8p3ES89J58MPjaY/43m7M
         Gosw==
X-Gm-Message-State: AGi0PuaSUoYNvNg2W//9y7AtJbaXNocHAukQhoHhY4BFDzVDUnogOaMS
        fSliS+lFRVxvqAWopO0NXLFS9sT4Jdu8NG0VFjhANg==
X-Google-Smtp-Source: APiQypJn4YPdoD6blL7gFwU0ijM52tdeLzBf7tlSaUAOwu8rfRRQ9Nd8hu+SfYhQA6qyrUO32C4i1Xcp+YT+RFkLY84=
X-Received: by 2002:a1f:a60b:: with SMTP id p11mr1325157vke.43.1588666671822;
 Tue, 05 May 2020 01:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200428210229.703309-1-martin.blumenstingl@googlemail.com>
 <20200428210229.703309-3-martin.blumenstingl@googlemail.com>
 <1jlfmdi9uw.fsf@starbuckisacylon.baylibre.com> <CAPDyKFoEh8qKYFONo1SHnvwhDwjUa5bMnnT1Kbu8=4rd=T-8Kg@mail.gmail.com>
 <1jh7x1i3hj.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jh7x1i3hj.fsf@starbuckisacylon.baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 5 May 2020 10:17:15 +0200
Message-ID: <CAPDyKFq_USCNNps3s4+C_1hriycrxtRMKJvnPFcP59CZmLXbGw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] mmc: host: meson-mx-sdhc: new driver for the
 Amlogic Meson SDHC host
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yinxin_1989@aliyun.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lnykww@gmail.com, Anand Moon <linux.amoon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> >> > +
> >> > +     return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> >> > +                                        onecell_data);
> >>
> >> I think registering a provider for a module that does not provide clocks
> >> to any other device is a bit overkill.
> >>
> >> I understand the matter is getting the per-user clk* pointer.
> >> Since this is the module registering the clock, you can use clk_hw->clk
> >> to get it.
> >>
> >> Once you have the clk* of the leaf clocks, you don't even need to keep
> >> track of the clk_hw* since you are using devm_
> >>
> >> Afterward, we should propably discuss with Stephen if something should
> >> be added in CCF to get a struct clk* from struct clk_hw*.
> >>
> >
> > [...]
> >
> > Hmm.
> >
> > I am not sure the above is a good idea, at all. Unless, I am
> > misunderstanding your point, which may be the case.
> >
> > I think above "shortcuts" could lead to abuse of the clock framework
> > and its internal data structures. When going forward, this could make
> > it unnecessary harder to maintain the clock framework.
> >
> > I know, it's not my responsibility, but from my experience with MMC
> > and SDIO interfaces, is that those have been too easy abuse - since
> > most of the data structures and interfaces have been exported. Now,
> > it's hard to roll back that, if you see what I mean.
>
> Indeed, it worth clarifying this first.
>
> With clk_register deprecated in favor of clk_hw_register, we are likely
> to see that case rise elsewhere.
>

So, according to the separate discussion [1], I think we can let
Martin decide what option to implement at this point.

1. Implement the "clk_hw_get_clk()" approach. The preferred option,
but requires wider changes of the clock subsystem as well.

2. Keep the existing approach, with devm_clk_get(). I am fine with
this as well, we can always switch to 1) later on.

[...]

Kind regards
Uffe

[1]
https://www.spinics.net/lists/linux-clk/msg48373.html
