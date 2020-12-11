Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349D62D8136
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 22:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406135AbgLKVju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 16:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406100AbgLKVix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:38:53 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC38C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:38:12 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id g1so10150117ilk.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=svarBrGApw/qWLNn00KtZB/9F43QBsME7evkZEf9bH0=;
        b=lijKy5APL+2z3DCf1DQMRh/nY6D0yvzEmRQceFyYFlJXEGulqTwhUHBnKVOLbX3/Ud
         +Xg2TItailnEAU6W/DUUy3qlxqXi9AkpdUTWQmCXgztBFY2UyEr57SOZM145JRlz8kFa
         3JjVHxCcUqihqlf6wBHD7SCglMZz22hhi+cUEo1Wc+rbpUU6HcfvC6QT2FZkCR83p3Up
         GEEdApUqp2639oaBPb96OL7+AZPvgjYwjVWPeKavHRbOndqX3a9gjP4UcbMAUxRTFc0H
         EMfUQLa8XOGIOfFfWOmpnZr4TBTztTGbL/tRLDHc8qPiyvrQyc+VJSKuN36TvQfdeo3H
         Ejmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=svarBrGApw/qWLNn00KtZB/9F43QBsME7evkZEf9bH0=;
        b=mu51TQ/W/gQuWIjdb+Prjsnd3xkK8FmVdpcImnh2IrqaC4nQdVkUwK9xCVKXnmrFI6
         3c6UVKFp1bIvDynGiraoFkgXN2J99BGcQkebWFFojmyzo+ZN3GBG6MYV4txdDp6TkDkr
         PrMuiq2GWrZJ3PIfp8N/Oueq/SnMpgss3sPIQZRKjyu8nmUfYCSdc5Y9c7zxkJcCiORw
         giEMstslPhZBWw/TY/CZYcSNQYjjOZNl6uriQkdlZhWtrZ2oYPjFsLePOEhW42+6vi++
         PU7zU2DuavtImxuXgQWVAdW2yF+XiG2Iq+oIBeT+Q//gDauK/YoFMYTCv2Z1qUYWh0Fa
         Afzg==
X-Gm-Message-State: AOAM5315bAuVcJAHkfOstMb2egA2rapOXS/3IBkYrsjdr1+Yf9br6tRe
        VWclBr6DI0B3hlbnfKzOHTCgb2lZEHpwcCG5eubgfQ==
X-Google-Smtp-Source: ABdhPJycWEeDJv8ZrtJhu1ouD0YnBXYNmMXHpafEco1lG49PDdUdz107EJ9/0kVpRncz9K96jvYZ1d35wBG3xMK4Dn8=
X-Received: by 2002:a92:c986:: with SMTP id y6mr19431085iln.57.1607722691963;
 Fri, 11 Dec 2020 13:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20201204074036.23870-1-peng.fan@oss.nxp.com> <20201204074036.23870-2-peng.fan@oss.nxp.com>
 <X8rRedNHet9gm5lJ@builder.lan> <DB6PR0402MB276056A300BD72EA59FC429488CE0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <DB6PR0402MB27602A953194DBE2CE96D54388CC0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB27602A953194DBE2CE96D54388CC0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 11 Dec 2020 14:38:01 -0700
Message-ID: <CANLsYkzh4GqqoQHFMUtQ_1+yja06nDratY_UOLPEpmufVgS2HA@mail.gmail.com>
Subject: Re: [PATCH V3 1/7] remoteproc: elf: support platform specific memory hook
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Dec 2020 at 08:00, Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: RE: [PATCH V3 1/7] remoteproc: elf: support platform specific
> > memory hook
> >
> > Hi Bjorn,
> >
> > > Subject: Re: [PATCH V3 1/7] remoteproc: elf: support platform specific
> > > memory hook
> > >
> > > On Fri 04 Dec 01:40 CST 2020, Peng Fan (OSS) wrote:
> > >
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > To arm64, "dc      zva, dst" is used in memset.
> > > > Per ARM DDI 0487A.j, chapter C5.3.8 DC ZVA, Data Cache Zero by VA,
> > > >
> > > > "If the memory region being zeroed is any type of Device memory,
> > > > this instruction can give an alignment fault which is prioritized in
> > > > the same way as other alignment faults that are determined by the
> > > > memory type."
> > > >
> > > > On i.MX platforms, when elf is loaded to onchip TCM area, the region
> > > > is ioremapped, so "dc zva, dst" will trigger abort. And ioremap_wc()
> > > > on i.MX not able to write correct data to TCM area.
> > > >
> > > > So we need to use io helpers, and extend the elf loader to support
> > > > platform specific memory functions.
> > > >
> > > > Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > ---
> > > >  drivers/remoteproc/remoteproc_elf_loader.c | 20
> > > ++++++++++++++++++--
> > > >  include/linux/remoteproc.h                 |  4 ++++
> > > >  2 files changed, 22 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/remoteproc/remoteproc_elf_loader.c
> > > > b/drivers/remoteproc/remoteproc_elf_loader.c
> > > > index df68d87752e4..6cb71fe47261 100644
> > > > --- a/drivers/remoteproc/remoteproc_elf_loader.c
> > > > +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> > > > @@ -129,6 +129,22 @@ u64 rproc_elf_get_boot_addr(struct rproc
> > > > *rproc, const struct firmware *fw)  }
> > > EXPORT_SYMBOL(rproc_elf_get_boot_addr);
> > > >
> > > > +static void rproc_elf_memcpy(struct rproc *rproc, void *dest, const
> > > > +void *src, size_t count) {
> > > > + if (!rproc->ops->elf_memcpy)
> > > > +         memcpy(dest, src, count);
> > > > +
> > > > + rproc->ops->elf_memcpy(rproc, dest, src, count);
> > >
> > > Looking at the current set of remoteproc drivers I get a feeling that
> > > we'll end up with a while bunch of functions that all just wraps
> > > memcpy_toio(). And the reason for this is that we are we're "abusing"
> > > the carveout to carry the __iomem pointer without keeping track of it.
> > >
> > > And this is not the only time we're supposed to use an io-accessor,
> > > another example is rproc_copy_segment() in rproc_coredump.c
> > >
> > > It also means that if a platform driver for some reason where to
> > > support both ioremap and normal carveouts the elf_memcpy op would be
> > quite quirky.
> > >
> > >
> > > So I would prefer if we track the knowledge about void *va being a
> > > __iomem or not in the struct rproc_mem_entry and make rproc_da_to_va()
> > > return this information as well.
> > >
> > > Then instead of extending the ops we can make this simply call memcpy
> > > or
> > > memcpy_toio() depending on this.
> >
> > A draft proposal as below, are you ok with the approach?
>
> Mathieu, do you have any comments?
>

I will look into this on Monday.
