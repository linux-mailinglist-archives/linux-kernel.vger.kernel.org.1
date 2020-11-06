Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C81D2A9415
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgKFKXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:23:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgKFKXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:23:25 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ED8621D81
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 10:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604658204;
        bh=YO03IaFoz1g+4x3+n58bkH7/Cex+2ht8GRyZ0XAnoO0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cqeCLAYKapJVJRNG4S3OMnilHz3K4r8Frko0+JmQMT7J2clbC13dSgsPNazKUjPTg
         U2REJUwwMQ9FtssJg+oinCLpzWsO7Zgx4L1+6EpfkyJuFRR+Y80S8vhsL+UmmD+TrX
         ZPDSjBSDooSmHM6XB2CYELhYTJvM1odd42tDKWa4=
Received: by mail-wr1-f53.google.com with SMTP id y12so742530wrp.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 02:23:23 -0800 (PST)
X-Gm-Message-State: AOAM532J5pf2ExYI/A8755doJOiiPWgatry5HLwg4w94gLaeuM6AChlQ
        5m8kLIhyj/KTq57yMXHTsjDGAwaiP5tVCj5NohQ=
X-Google-Smtp-Source: ABdhPJzGlxyVpRmzXkF/PvtmenqfFAyGYQMN57w29mtbnh0QH7Wks6mGYWLtTqUVFt1TKtAlk9pnjZt1Nf7U/oQcAXk=
X-Received: by 2002:adf:fe09:: with SMTP id n9mr1839224wrr.361.1604658201741;
 Fri, 06 Nov 2020 02:23:21 -0800 (PST)
MIME-Version: 1.0
References: <20201027211154.3371691-1-enric.balletbo@collabora.com> <CAK8P3a0r8vaL8Mc=EVZCrqW4s8uvhfBjLRfGCEc4jp7W6Z_dUQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0r8vaL8Mc=EVZCrqW4s8uvhfBjLRfGCEc4jp7W6Z_dUQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 6 Nov 2020 11:23:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1uZndNOq0SfBt8C78COAy70gMws47FPNS8CdoLHNdvyw@mail.gmail.com>
Message-ID: <CAK8P3a1uZndNOq0SfBt8C78COAy70gMws47FPNS8CdoLHNdvyw@mail.gmail.com>
Subject: Re: [PATCH] mfd: syscon: Add syscon_regmap_lookup_by_phandle_optional()
 function.
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that my earlier reply was rejected by some mail servers,
resending from @kernel.org to make sure everyone has it.

On Tue, Oct 27, 2020 at 10:57 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Oct 27, 2020 at 10:11 PM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > This adds syscon_regmap_lookup_by_phandle_optional() function to get an
> > optional regmap.
> >
> > It behaves the same as syscon_regmap_lookup_by_phandle() except where
> > there is no regmap phandle. In this case, instead of returning -ENODEV,
> > the function returns NULL. This makes error checking simpler when the
> > regmap phandle is optional.
> >
> > Suggested-by: Nicolas Boichat <drinkcat@chromium.org>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> Looks good in principle.
>
> > @@ -255,6 +255,19 @@ struct regmap *syscon_regmap_lookup_by_phandle_args(struct device_node *np,
> >  }
> >  EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle_args);
> >
> > +struct regmap *syscon_regmap_lookup_by_phandle_optional(struct device_node *np,
> > +                                       const char *property)
> > +{
> > +       struct regmap *regmap;
> > +
> > +       regmap = syscon_regmap_lookup_by_phandle(np, property);
> > +       if (IS_ERR(regmap) && PTR_ERR(regmap) == -ENODEV)
> > +               return NULL;
> > +
> > +       return regmap;
> > +}
>
> I think the explanation from the patch description is needed here as well,
> as an interface that might either return an error code or NULL is generally
> a really bad idea. I understand what this is for, but it's easy to misread.
>
> >  static inline struct regmap *device_node_to_regmap(struct device_node *np)
> >  {
> > @@ -59,6 +62,14 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle_args(
> >  {
> >         return ERR_PTR(-ENOTSUPP);
> >  }
> > +
> > +static inline struct regmap *syscon_regmap_lookup_by_phandle_optional(
> > +                                       struct device_node *np,
> > +                                       const char *property)
> > +{
> > +       return ERR_PTR(-ENOTSUPP);
> > +}
>
> Shouldn't this also return NULL then?
>
>           Arnd
