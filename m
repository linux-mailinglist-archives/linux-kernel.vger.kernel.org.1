Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C057B2CF301
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbgLDRTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731339AbgLDRTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:19:42 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1132C061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:19:26 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id q22so6103047qkq.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 09:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IZENXwp/mbOpuUA3VU+AmP56OfM+59cOFAKz/i16yr8=;
        b=s7DUSXf2UKfa6WF51SGm1zhLe8D7zIAH5N41VtmJRjT6eEvHVrAX5z1XVx377vgJo8
         I3zvwLqKiLYmKPyhI0miSfBYqJwRVRmNgHX9gBeae2hE5z2KOFJXZVSTcn51bBq8Sd2h
         6rhRkO443QYxsJgVfx+SpU+YYcux3PWflF06UB9xGbiupDJe/1LwutMDepTD7q/0H+5g
         sKQmfYJQxKwTIwIN37LT+IBpglx3KloSydK0ZjVckQpDUVgYzBENeN8gB5huZQSAeXMM
         K7GaHP3h1L9l7KsVra/IfpfuIkbcV4GC+5AjJ2o0Dc80OLr5AmC2YCcqq4PQe46K3D0O
         tjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IZENXwp/mbOpuUA3VU+AmP56OfM+59cOFAKz/i16yr8=;
        b=cLF5suVTT5DSJLI9RGtLQERY4uxAhmHYxfJBgmXc9bQQBwJwDxL2xCGRN6oSKPzGeT
         TMk3I4wuhVCmwR/8kIk+0SIbfdlbo+4fzUGJh0uDJwb8V5tKG2zt6F7czDHD2Oe5l1r6
         9Zhv06BoeT60MXbbYlaDZ7oItaE8zU/bv5anbnu1NbvzBtS915VQ/AwAFmTQ0HIQrdaD
         SOsFAgqhkfrxxUYflgeqvnCP/Pr+gNFTG6F14bSCoM09WuKrqjshxBvlOQApY2/ItDd0
         fWQYdo45ReEXOzn7vP/OTT51E895nU+we2VJ6CLPTy6Y+el/AE8eAMZGtldCTvOe4dUZ
         xFoQ==
X-Gm-Message-State: AOAM530Ozfhj1bujeUMkRdJyMEWOCDYix+6TZTWAp0klgaL5p3KCWGpJ
        NfGNXA+ZObajMI2T2y37XSwWIMtL1I+KHVpU75kCsw==
X-Google-Smtp-Source: ABdhPJwNRwo4xiaTnJlMuUspZ487ZdEjv0BDXLIQfzZG/FxEqfW/NsqpeaT8x/40CXaOGdzcnZQ1IMX9/YdZXL1w1bk=
X-Received: by 2002:a37:f509:: with SMTP id l9mr1849305qkk.155.1607102366002;
 Fri, 04 Dec 2020 09:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20201202185118.29076-1-mw@semihalf.com> <20201202185118.29076-4-mw@semihalf.com>
 <CAPDyKFp_+5G2Bg0rWcW+ZKeee--3znZJhRuXUi1U70ksy+qcjw@mail.gmail.com>
In-Reply-To: <CAPDyKFp_+5G2Bg0rWcW+ZKeee--3znZJhRuXUi1U70ksy+qcjw@mail.gmail.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 4 Dec 2020 18:19:14 +0100
Message-ID: <CAPv3WKfX8coEcTAR9gdt=Pg=V_UHZ0tMzRfOdGz6jemYsV3UqQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mmc: sdhci-xenon: use clk only with DT
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ziji Hu <huziji@marvell.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Kostya Porotchkin <kostap@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 4 gru 2020 o 14:51 Ulf Hansson <ulf.hansson@linaro.org> napisa=C5=82(a=
):
>
> On Wed, 2 Dec 2020 at 19:51, Marcin Wojtas <mw@semihalf.com> wrote:
> >
> > As a preparation for supporting ACPI, modify the driver
> > to use the clk framework only when booting with DT -
> > otherwise rely on the configuration done by firmware.
> > For that purpose introduce also a custom SDHCI get_max_clock
> > callback.
> >
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  drivers/mmc/host/sdhci-xenon.c | 61 ++++++++++++--------
> >  1 file changed, 38 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xe=
non.c
>
> [...]
>
> > @@ -637,10 +650,12 @@ static int xenon_runtime_resume(struct device *de=
v)
> >         struct xenon_priv *priv =3D sdhci_pltfm_priv(pltfm_host);
> >         int ret;
> >
> > -       ret =3D clk_prepare_enable(pltfm_host->clk);
> > -       if (ret) {
> > -               dev_err(dev, "can't enable mainck\n");
> > -               return ret;
> > +       if (dev->of_node) {
>
> I didn't notice this in the earlier version, my apologies, but there
> is no need for this check.
>
> clk_prepare_enable() should cope fine with a NULL argument - and you
> only reach this path, if the clock was successfully fetched during the
> probe or that it was left to stay NULL for non-DT case.

You are right, thanks! I applied the change and resent v4.

Best regards,
Marcin

>
> > +               ret =3D clk_prepare_enable(pltfm_host->clk);
> > +               if (ret) {
> > +                       dev_err(dev, "can't enable mainck\n");
> > +                       return ret;
> > +               }
> >         }
> >
> >         if (priv->restore_needed) {
> > --
> > 2.29.0
> >
>
> Kind regards
> Uffe
