Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C44C2A77D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 08:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgKEHQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 02:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbgKEHQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 02:16:44 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADAEC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 23:16:44 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id m17so713956oie.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 23:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZA0tcaelfi4vPXfLKUzyksU37FXQtlbKqMRl+WgX6M8=;
        b=NfcCnhu/w42/uQG2j448HJl/LDzAjFJhLKwWc+j3wswPP76RNSg72jVLGKiqvsHbgG
         d8i/DTYQZzLHPa7efJxIc+OuZKIYAB4S3FWX4vDrC0gEkkNo3ARevcgH+OnUjBAt/lsp
         WMGpT8W1o3k77P6/TBFMJiaTILTeHmPMc7ivZH3LUgkD6+QV/nDKilRA4ZrnnNfQjuZ2
         f3sxEs8IBDlMeDWVdqTw5lPEOdhWxh+LHDoXmtzwQh2Wc/33rQ/fDRGMjUzfu3zxqIES
         bDbS6tZEi2uWqJYZA4WK+S5+MJMHYb6vMggLIuSLatcty0I1YKWhz/Qr6q6HnRknfMAP
         mrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZA0tcaelfi4vPXfLKUzyksU37FXQtlbKqMRl+WgX6M8=;
        b=W4DiIGpdd+MsrIwX3wmUFBVqaWO1/3jWLLbKx57dQZ44cfGI6X08p5UrqXkiB+VIGA
         C6vVqFDEh9OpIcU1c9ynlGy7evZGSsUjqFdh0+9ZrzuB0rPb4JtoBV2Ps+9TpC3o0aC9
         +t/98t4IaxHxQp6EHzeOBEfKSyxh+//yr2lrOeOxnmiS9pyNcVmlc7Lw2wsIEwB1Al5D
         mndYSxmiJEEuJ8MuFFkciiB6D8EiCT1nFkUkajA9Q4T01no59O0Vg6MbJBs8LCHO3/Sx
         iw/NEIrVODOuxFdg8kVwmIVX0BO3ZW/4jqc6GlgIcgiThO0wa9KO5LE13wWhDjz75+pX
         O/IQ==
X-Gm-Message-State: AOAM530i+7XAf4+rQmfh4W8quqYffXulc8BrEFXxqWsf+HLwjxhTUrdu
        z9GZwPVMUG2QGayE7C31iMjbh8fNrZLFIc7qIAXETA==
X-Google-Smtp-Source: ABdhPJwxMW6GaWS3wgiDY7NBrqT8hQb5Q5TNbpAum2FT4XyQd/urrJKmvqnomOy6I9RhcrdgZReLX+e7Xc2dKQZbaEM=
X-Received: by 2002:aca:4b82:: with SMTP id y124mr741948oia.35.1604560603675;
 Wed, 04 Nov 2020 23:16:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1602838910.git.zong.li@sifive.com> <8ad64f9814137c5255d43d4ba670b5fcd15837ab.1602838910.git.zong.li@sifive.com>
 <160454464591.3965362.9361884545184336266@swboyd.mtv.corp.google.com>
In-Reply-To: <160454464591.3965362.9361884545184336266@swboyd.mtv.corp.google.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 5 Nov 2020 15:16:30 +0800
Message-ID: <CANXhq0rbkRc3kKAPsbR=Tg5uqvazOqSZwzEEOp7std_Tf5LhHA@mail.gmail.com>
Subject: Re: [PATCH 4/4] clk: sifive: Refactor __prci_clock array by using macro
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, linux-clk@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Yash Shah <yash.shah@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 10:50 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Zong Li (2020-10-16 02:18:26)
> > Refactor code by using DEFINE_PRCI_CLOCK to define each clock
> > and reduce duplicate code.
>
> What is duplicate?

Sorry for unclear description, actually, I want to say that we can
remove the repeating code about initializing the data member of
structure.

>
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/clk/sifive/fu540-prci.c  | 38 ++++++----------
> >  drivers/clk/sifive/fu540-prci.h  |  2 +-
> >  drivers/clk/sifive/fu740-prci.c  | 74 ++++++++++++--------------------
> >  drivers/clk/sifive/fu740-prci.h  |  2 +-
> >  drivers/clk/sifive/sifive-prci.c |  2 +-
> >  drivers/clk/sifive/sifive-prci.h | 10 ++++-
> >  6 files changed, 53 insertions(+), 75 deletions(-)
> >
> > diff --git a/drivers/clk/sifive/fu540-prci.c b/drivers/clk/sifive/fu540-prci.c
> > index 840b97bfff85..d43b9a9984f6 100644
> > --- a/drivers/clk/sifive/fu540-prci.c
> > +++ b/drivers/clk/sifive/fu540-prci.c
> > @@ -54,29 +54,19 @@ static const struct clk_ops sifive_fu540_prci_tlclksel_clk_ops = {
> >         .recalc_rate = sifive_prci_tlclksel_recalc_rate,
> >  };
> >
> > +DEFINE_PRCI_CLOCK(fu540, corepll, hfclk,
> > +                 &sifive_fu540_prci_wrpll_clk_ops, &__prci_corepll_data);
> > +DEFINE_PRCI_CLOCK(fu540, ddrpll, hfclk,
> > +                 &sifive_fu540_prci_wrpll_ro_clk_ops, &__prci_ddrpll_data);
> > +DEFINE_PRCI_CLOCK(fu540, gemgxlpll, hfclk,
> > +                 &sifive_fu540_prci_wrpll_clk_ops, &__prci_gemgxlpll_data);
> > +DEFINE_PRCI_CLOCK(fu540, tlclk, corepll,
> > +                 &sifive_fu540_prci_tlclksel_clk_ops, NULL);
>
> Readability looks to decrease with this change. Why should all us code
> reviewers suffer because the code author wants to type a few less
> characters? Named initializers are useful so we don't have to hold each
> macro argument in our head and map it to the struct member that is being
> initialized.

Ok, as you mentioned, macro reduce the readability, let me remove this
change in the next version.

>
> > +
> >  /* List of clock controls provided by the PRCI */
> > -struct __prci_clock __prci_init_clocks_fu540[] = {
> > -       [PRCI_CLK_COREPLL] = {
> > -               .name = "corepll",
> > -               .parent_name = "hfclk",
> > -               .ops = &sifive_fu540_prci_wrpll_clk_ops,
> > -               .pwd = &__prci_corepll_data,
> > -       },
> > -       [PRCI_CLK_DDRPLL] = {
> > -               .name = "ddrpll",
> > -               .parent_name = "hfclk",
> > -               .ops = &sifive_fu540_prci_wrpll_ro_clk_ops,
> > -               .pwd = &__prci_ddrpll_data,
> > -       },
> > -       [PRCI_CLK_GEMGXLPLL] = {
> > -               .name = "gemgxlpll",
> > -               .parent_name = "hfclk",
> > -               .ops = &sifive_fu540_prci_wrpll_clk_ops,
> > -               .pwd = &__prci_gemgxlpll_data,
> > -       },
> > -       [PRCI_CLK_TLCLK] = {
> > -               .name = "tlclk",
> > -               .parent_name = "corepll",
> > -               .ops = &sifive_fu540_prci_tlclksel_clk_ops,
> > -       },
> > +struct __prci_clock *__prci_init_clocks_fu540[] = {
> > +       [PRCI_CLK_COREPLL]      = &fu540_corepll,
> > +       [PRCI_CLK_DDRPLL]       = &fu540_ddrpll,
> > +       [PRCI_CLK_GEMGXLPLL]    = &fu540_gemgxlpll,
> > +       [PRCI_CLK_TLCLK]        = &fu540_tlclk,
> >  };
> > diff --git a/drivers/clk/sifive/fu540-prci.h b/drivers/clk/sifive/fu540-prci.h
> > index c8271efa7bdc..281200cd8848 100644
> > --- a/drivers/clk/sifive/fu540-prci.h
> > +++ b/drivers/clk/sifive/fu540-prci.h
> > @@ -11,7 +11,7 @@
> >
> >  #define NUM_CLOCK_FU540        4
> >
> > -extern struct __prci_clock __prci_init_clocks_fu540[NUM_CLOCK_FU540];
> > +extern struct __prci_clock *__prci_init_clocks_fu540[NUM_CLOCK_FU540];
> >
> >  static const struct prci_clk_desc prci_clk_fu540 = {
> >         .clks = __prci_init_clocks_fu540,
> > diff --git a/drivers/clk/sifive/fu740-prci.c b/drivers/clk/sifive/fu740-prci.c
> > index 3b87e273c3eb..676cad2c3886 100644
> > --- a/drivers/clk/sifive/fu740-prci.c
> > +++ b/drivers/clk/sifive/fu740-prci.c
> > @@ -71,52 +71,32 @@ static const struct clk_ops sifive_fu740_prci_hfpclkplldiv_clk_ops = {
> >         .recalc_rate = sifive_prci_hfpclkplldiv_recalc_rate,
> >  };
> >
> > +
> > +DEFINE_PRCI_CLOCK(fu740, corepll, hfclk,
> > +                 &sifive_fu740_prci_wrpll_clk_ops, &__prci_corepll_data);
> > +DEFINE_PRCI_CLOCK(fu740, ddrpll, hfclk,
> > +                 &sifive_fu740_prci_wrpll_ro_clk_ops, &__prci_ddrpll_data);
> > +DEFINE_PRCI_CLOCK(fu740, gemgxlpll, hfclk,
> > +                 &sifive_fu740_prci_wrpll_clk_ops, &__prci_gemgxlpll_data);
> > +DEFINE_PRCI_CLOCK(fu740, dvfscorepll, hfclk,
> > +                 &sifive_fu740_prci_wrpll_clk_ops, &__prci_dvfscorepll_data);
> > +DEFINE_PRCI_CLOCK(fu740, hfpclkpll, hfclk,
> > +                 &sifive_fu740_prci_wrpll_clk_ops, &__prci_hfpclkpll_data);
> > +DEFINE_PRCI_CLOCK(fu740, cltxpll, hfclk,
> > +                 &sifive_fu740_prci_wrpll_clk_ops, &__prci_cltxpll_data);
> > +DEFINE_PRCI_CLOCK(fu740, tlclk, corepll,
> > +                 &sifive_fu740_prci_tlclksel_clk_ops, NULL);
> > +DEFINE_PRCI_CLOCK(fu740, pclk, hfpclkpll,
> > +                 &sifive_fu740_prci_hfpclkplldiv_clk_ops, NULL);
> > +
> >  /* List of clock controls provided by the PRCI */
> > -struct __prci_clock __prci_init_clocks_fu740[] = {
> > -       [PRCI_CLK_COREPLL] = {
> > -               .name = "corepll",
> > -               .parent_name = "hfclk",
> > -               .ops = &sifive_fu740_prci_wrpll_clk_ops,
> > -               .pwd = &__prci_corepll_data,
> > -       },
> > -       [PRCI_CLK_DDRPLL] = {
> > -               .name = "ddrpll",
> > -               .parent_name = "hfclk",
> > -               .ops = &sifive_fu740_prci_wrpll_ro_clk_ops,
> > -               .pwd = &__prci_ddrpll_data,
> > -       },
> > -       [PRCI_CLK_GEMGXLPLL] = {
> > -               .name = "gemgxlpll",
> > -               .parent_name = "hfclk",
> > -               .ops = &sifive_fu740_prci_wrpll_clk_ops,
> > -               .pwd = &__prci_gemgxlpll_data,
> > -       },
> > -       [PRCI_CLK_DVFSCOREPLL] = {
> > -               .name = "dvfscorepll",
> > -               .parent_name = "hfclk",
> > -               .ops = &sifive_fu740_prci_wrpll_clk_ops,
> > -               .pwd = &__prci_dvfscorepll_data,
> > -       },
> > -       [PRCI_CLK_HFPCLKPLL] = {
> > -               .name = "hfpclkpll",
> > -               .parent_name = "hfclk",
> > -               .ops = &sifive_fu740_prci_wrpll_clk_ops,
> > -               .pwd = &__prci_hfpclkpll_data,
> > -       },
> > -       [PRCI_CLK_CLTXPLL] = {
> > -               .name = "cltxpll",
> > -               .parent_name = "hfclk",
> > -               .ops = &sifive_fu740_prci_wrpll_clk_ops,
> > -               .pwd = &__prci_cltxpll_data,
> > -       },
> > -       [PRCI_CLK_TLCLK] = {
> > -               .name = "tlclk",
> > -               .parent_name = "corepll",
> > -               .ops = &sifive_fu740_prci_tlclksel_clk_ops,
> > -       },
> > -       [PRCI_CLK_PCLK] = {
> > -               .name = "pclk",
> > -               .parent_name = "hfpclkpll",
> > -               .ops = &sifive_fu740_prci_hfpclkplldiv_clk_ops,
> > -       },
> > +struct __prci_clock *__prci_init_clocks_fu740[] = {
> > +       [PRCI_CLK_COREPLL]      = &fu740_corepll,
> > +       [PRCI_CLK_DDRPLL]       = &fu740_ddrpll,
> > +       [PRCI_CLK_GEMGXLPLL]    = &fu740_gemgxlpll,
> > +       [PRCI_CLK_DVFSCOREPLL]  = &fu740_dvfscorepll,
> > +       [PRCI_CLK_HFPCLKPLL]    = &fu740_hfpclkpll,
> > +       [PRCI_CLK_CLTXPLL]      = &fu740_cltxpll,
> > +       [PRCI_CLK_TLCLK]        = &fu740_tlclk,
> > +       [PRCI_CLK_PCLK]         = &fu740_pclk,
> >  };
>
> I suppose this is fine and then non-macro structs above this array of
> pointers.
>
> > diff --git a/drivers/clk/sifive/fu740-prci.h b/drivers/clk/sifive/fu740-prci.h
> > index 13ef971f7764..3f03295f719a 100644
> > --- a/drivers/clk/sifive/fu740-prci.h
> > +++ b/drivers/clk/sifive/fu740-prci.h
> > @@ -11,7 +11,7 @@
> >
> >  #define NUM_CLOCK_FU740        8
> >
> > -extern struct __prci_clock __prci_init_clocks_fu740[NUM_CLOCK_FU740];
> > +extern struct __prci_clock *__prci_init_clocks_fu740[NUM_CLOCK_FU740];
> >
> >  static const struct prci_clk_desc prci_clk_fu740 = {
> >         .clks = __prci_init_clocks_fu740,
> > diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
> > index 4098dbc5881a..2ef3f9f91b33 100644
> > --- a/drivers/clk/sifive/sifive-prci.c
> > +++ b/drivers/clk/sifive/sifive-prci.c
> > @@ -431,7 +431,7 @@ static int __prci_register_clocks(struct device *dev, struct __prci_data *pd,
> >
> >         /* Register PLLs */
> >         for (i = 0; i < desc->num_clks; ++i) {
> > -               pic = &(desc->clks[i]);
> > +               pic = desc->clks[i];
>
> This is related how?
>
> >
> >                 init.name = pic->name;
> >                 init.parent_names = &pic->parent_name;
> > diff --git a/drivers/clk/sifive/sifive-prci.h b/drivers/clk/sifive/sifive-prci.h
> > index bc0646bc9c3e..e6c9f72e20de 100644
> > --- a/drivers/clk/sifive/sifive-prci.h
> > +++ b/drivers/clk/sifive/sifive-prci.h
> > @@ -253,6 +253,14 @@ struct __prci_clock {
> >         struct __prci_data *pd;
> >  };
> >
> > +#define DEFINE_PRCI_CLOCK(_platform, _name, _parent, _ops, _pwd)       \
> > +       static struct __prci_clock _platform##_##_name = {              \
> > +               .name = #_name,                                         \
> > +               .parent_name = #_parent,                                \
> > +               .ops = _ops,                                            \
> > +               .pwd = _pwd,                                            \
> > +       }                                                               \
> > +
> >  #define clk_hw_to_prci_clock(pwd) container_of(pwd, struct __prci_clock, hw)
> >
> >  /*
> > @@ -261,7 +269,7 @@ struct __prci_clock {
> >   * @num_clks: the number of element of clks
> >   */
> >  struct prci_clk_desc {
> > -       struct __prci_clock *clks;
> > +       struct __prci_clock **clks;
>
> Huh? Nothing in the commit text mentions this.
>

Because I introduce the macro in this patch, so the type of array
__prci_init_clocks_fuXXX are changed to pointer which point to
__prci_clock, the related use need to be changed as well. It would be
recover due to discarding this patch.

> >         size_t num_clks;
> >  };
