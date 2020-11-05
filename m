Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C892A75C4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 03:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388446AbgKECut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 21:50:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgKECut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 21:50:49 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75A2920825;
        Thu,  5 Nov 2020 02:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604544647;
        bh=s9TmciBG4hvcsBn5EOIsicR/HDbAaQeCGdnoHYH8AQo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Ye/hPkoXGGk/wr9ge36IzFFs9zzVxX8hffZxSf8AZsRvQVdU4v6lPJ3nH6KLfYyJC
         nslmXovseDS1qfsLmcf+OevTS90dt4jr4IFzb/OC0shoji1IbKqnPyykvw/feiNhGn
         u21r4r9PKzObyQZtImbiYvSKaU3WfVjIia2tih6M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8ad64f9814137c5255d43d4ba670b5fcd15837ab.1602838910.git.zong.li@sifive.com>
References: <cover.1602838910.git.zong.li@sifive.com> <8ad64f9814137c5255d43d4ba670b5fcd15837ab.1602838910.git.zong.li@sifive.com>
Subject: Re: [PATCH 4/4] clk: sifive: Refactor __prci_clock array by using macro
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Zong Li <zong.li@sifive.com>
To:     Zong Li <zong.li@sifive.com>, aou@eecs.berkeley.edu,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, yash.shah@sifive.com
Date:   Wed, 04 Nov 2020 18:50:45 -0800
Message-ID: <160454464591.3965362.9361884545184336266@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zong Li (2020-10-16 02:18:26)
> Refactor code by using DEFINE_PRCI_CLOCK to define each clock
> and reduce duplicate code.

What is duplicate?

>=20
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/clk/sifive/fu540-prci.c  | 38 ++++++----------
>  drivers/clk/sifive/fu540-prci.h  |  2 +-
>  drivers/clk/sifive/fu740-prci.c  | 74 ++++++++++++--------------------
>  drivers/clk/sifive/fu740-prci.h  |  2 +-
>  drivers/clk/sifive/sifive-prci.c |  2 +-
>  drivers/clk/sifive/sifive-prci.h | 10 ++++-
>  6 files changed, 53 insertions(+), 75 deletions(-)
>=20
> diff --git a/drivers/clk/sifive/fu540-prci.c b/drivers/clk/sifive/fu540-p=
rci.c
> index 840b97bfff85..d43b9a9984f6 100644
> --- a/drivers/clk/sifive/fu540-prci.c
> +++ b/drivers/clk/sifive/fu540-prci.c
> @@ -54,29 +54,19 @@ static const struct clk_ops sifive_fu540_prci_tlclkse=
l_clk_ops =3D {
>         .recalc_rate =3D sifive_prci_tlclksel_recalc_rate,
>  };
> =20
> +DEFINE_PRCI_CLOCK(fu540, corepll, hfclk,
> +                 &sifive_fu540_prci_wrpll_clk_ops, &__prci_corepll_data);
> +DEFINE_PRCI_CLOCK(fu540, ddrpll, hfclk,
> +                 &sifive_fu540_prci_wrpll_ro_clk_ops, &__prci_ddrpll_dat=
a);
> +DEFINE_PRCI_CLOCK(fu540, gemgxlpll, hfclk,
> +                 &sifive_fu540_prci_wrpll_clk_ops, &__prci_gemgxlpll_dat=
a);
> +DEFINE_PRCI_CLOCK(fu540, tlclk, corepll,
> +                 &sifive_fu540_prci_tlclksel_clk_ops, NULL);

Readability looks to decrease with this change. Why should all us code
reviewers suffer because the code author wants to type a few less
characters? Named initializers are useful so we don't have to hold each
macro argument in our head and map it to the struct member that is being
initialized.

> +
>  /* List of clock controls provided by the PRCI */
> -struct __prci_clock __prci_init_clocks_fu540[] =3D {
> -       [PRCI_CLK_COREPLL] =3D {
> -               .name =3D "corepll",
> -               .parent_name =3D "hfclk",
> -               .ops =3D &sifive_fu540_prci_wrpll_clk_ops,
> -               .pwd =3D &__prci_corepll_data,
> -       },
> -       [PRCI_CLK_DDRPLL] =3D {
> -               .name =3D "ddrpll",
> -               .parent_name =3D "hfclk",
> -               .ops =3D &sifive_fu540_prci_wrpll_ro_clk_ops,
> -               .pwd =3D &__prci_ddrpll_data,
> -       },
> -       [PRCI_CLK_GEMGXLPLL] =3D {
> -               .name =3D "gemgxlpll",
> -               .parent_name =3D "hfclk",
> -               .ops =3D &sifive_fu540_prci_wrpll_clk_ops,
> -               .pwd =3D &__prci_gemgxlpll_data,
> -       },
> -       [PRCI_CLK_TLCLK] =3D {
> -               .name =3D "tlclk",
> -               .parent_name =3D "corepll",
> -               .ops =3D &sifive_fu540_prci_tlclksel_clk_ops,
> -       },
> +struct __prci_clock *__prci_init_clocks_fu540[] =3D {
> +       [PRCI_CLK_COREPLL]      =3D &fu540_corepll,
> +       [PRCI_CLK_DDRPLL]       =3D &fu540_ddrpll,
> +       [PRCI_CLK_GEMGXLPLL]    =3D &fu540_gemgxlpll,
> +       [PRCI_CLK_TLCLK]        =3D &fu540_tlclk,
>  };
> diff --git a/drivers/clk/sifive/fu540-prci.h b/drivers/clk/sifive/fu540-p=
rci.h
> index c8271efa7bdc..281200cd8848 100644
> --- a/drivers/clk/sifive/fu540-prci.h
> +++ b/drivers/clk/sifive/fu540-prci.h
> @@ -11,7 +11,7 @@
> =20
>  #define NUM_CLOCK_FU540        4
> =20
> -extern struct __prci_clock __prci_init_clocks_fu540[NUM_CLOCK_FU540];
> +extern struct __prci_clock *__prci_init_clocks_fu540[NUM_CLOCK_FU540];
> =20
>  static const struct prci_clk_desc prci_clk_fu540 =3D {
>         .clks =3D __prci_init_clocks_fu540,
> diff --git a/drivers/clk/sifive/fu740-prci.c b/drivers/clk/sifive/fu740-p=
rci.c
> index 3b87e273c3eb..676cad2c3886 100644
> --- a/drivers/clk/sifive/fu740-prci.c
> +++ b/drivers/clk/sifive/fu740-prci.c
> @@ -71,52 +71,32 @@ static const struct clk_ops sifive_fu740_prci_hfpclkp=
lldiv_clk_ops =3D {
>         .recalc_rate =3D sifive_prci_hfpclkplldiv_recalc_rate,
>  };
> =20
> +
> +DEFINE_PRCI_CLOCK(fu740, corepll, hfclk,
> +                 &sifive_fu740_prci_wrpll_clk_ops, &__prci_corepll_data);
> +DEFINE_PRCI_CLOCK(fu740, ddrpll, hfclk,
> +                 &sifive_fu740_prci_wrpll_ro_clk_ops, &__prci_ddrpll_dat=
a);
> +DEFINE_PRCI_CLOCK(fu740, gemgxlpll, hfclk,
> +                 &sifive_fu740_prci_wrpll_clk_ops, &__prci_gemgxlpll_dat=
a);
> +DEFINE_PRCI_CLOCK(fu740, dvfscorepll, hfclk,
> +                 &sifive_fu740_prci_wrpll_clk_ops, &__prci_dvfscorepll_d=
ata);
> +DEFINE_PRCI_CLOCK(fu740, hfpclkpll, hfclk,
> +                 &sifive_fu740_prci_wrpll_clk_ops, &__prci_hfpclkpll_dat=
a);
> +DEFINE_PRCI_CLOCK(fu740, cltxpll, hfclk,
> +                 &sifive_fu740_prci_wrpll_clk_ops, &__prci_cltxpll_data);
> +DEFINE_PRCI_CLOCK(fu740, tlclk, corepll,
> +                 &sifive_fu740_prci_tlclksel_clk_ops, NULL);
> +DEFINE_PRCI_CLOCK(fu740, pclk, hfpclkpll,
> +                 &sifive_fu740_prci_hfpclkplldiv_clk_ops, NULL);
> +
>  /* List of clock controls provided by the PRCI */
> -struct __prci_clock __prci_init_clocks_fu740[] =3D {
> -       [PRCI_CLK_COREPLL] =3D {
> -               .name =3D "corepll",
> -               .parent_name =3D "hfclk",
> -               .ops =3D &sifive_fu740_prci_wrpll_clk_ops,
> -               .pwd =3D &__prci_corepll_data,
> -       },
> -       [PRCI_CLK_DDRPLL] =3D {
> -               .name =3D "ddrpll",
> -               .parent_name =3D "hfclk",
> -               .ops =3D &sifive_fu740_prci_wrpll_ro_clk_ops,
> -               .pwd =3D &__prci_ddrpll_data,
> -       },
> -       [PRCI_CLK_GEMGXLPLL] =3D {
> -               .name =3D "gemgxlpll",
> -               .parent_name =3D "hfclk",
> -               .ops =3D &sifive_fu740_prci_wrpll_clk_ops,
> -               .pwd =3D &__prci_gemgxlpll_data,
> -       },
> -       [PRCI_CLK_DVFSCOREPLL] =3D {
> -               .name =3D "dvfscorepll",
> -               .parent_name =3D "hfclk",
> -               .ops =3D &sifive_fu740_prci_wrpll_clk_ops,
> -               .pwd =3D &__prci_dvfscorepll_data,
> -       },
> -       [PRCI_CLK_HFPCLKPLL] =3D {
> -               .name =3D "hfpclkpll",
> -               .parent_name =3D "hfclk",
> -               .ops =3D &sifive_fu740_prci_wrpll_clk_ops,
> -               .pwd =3D &__prci_hfpclkpll_data,
> -       },
> -       [PRCI_CLK_CLTXPLL] =3D {
> -               .name =3D "cltxpll",
> -               .parent_name =3D "hfclk",
> -               .ops =3D &sifive_fu740_prci_wrpll_clk_ops,
> -               .pwd =3D &__prci_cltxpll_data,
> -       },
> -       [PRCI_CLK_TLCLK] =3D {
> -               .name =3D "tlclk",
> -               .parent_name =3D "corepll",
> -               .ops =3D &sifive_fu740_prci_tlclksel_clk_ops,
> -       },
> -       [PRCI_CLK_PCLK] =3D {
> -               .name =3D "pclk",
> -               .parent_name =3D "hfpclkpll",
> -               .ops =3D &sifive_fu740_prci_hfpclkplldiv_clk_ops,
> -       },
> +struct __prci_clock *__prci_init_clocks_fu740[] =3D {
> +       [PRCI_CLK_COREPLL]      =3D &fu740_corepll,
> +       [PRCI_CLK_DDRPLL]       =3D &fu740_ddrpll,
> +       [PRCI_CLK_GEMGXLPLL]    =3D &fu740_gemgxlpll,
> +       [PRCI_CLK_DVFSCOREPLL]  =3D &fu740_dvfscorepll,
> +       [PRCI_CLK_HFPCLKPLL]    =3D &fu740_hfpclkpll,
> +       [PRCI_CLK_CLTXPLL]      =3D &fu740_cltxpll,
> +       [PRCI_CLK_TLCLK]        =3D &fu740_tlclk,
> +       [PRCI_CLK_PCLK]         =3D &fu740_pclk,
>  };

I suppose this is fine and then non-macro structs above this array of
pointers.

> diff --git a/drivers/clk/sifive/fu740-prci.h b/drivers/clk/sifive/fu740-p=
rci.h
> index 13ef971f7764..3f03295f719a 100644
> --- a/drivers/clk/sifive/fu740-prci.h
> +++ b/drivers/clk/sifive/fu740-prci.h
> @@ -11,7 +11,7 @@
> =20
>  #define NUM_CLOCK_FU740        8
> =20
> -extern struct __prci_clock __prci_init_clocks_fu740[NUM_CLOCK_FU740];
> +extern struct __prci_clock *__prci_init_clocks_fu740[NUM_CLOCK_FU740];
> =20
>  static const struct prci_clk_desc prci_clk_fu740 =3D {
>         .clks =3D __prci_init_clocks_fu740,
> diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive=
-prci.c
> index 4098dbc5881a..2ef3f9f91b33 100644
> --- a/drivers/clk/sifive/sifive-prci.c
> +++ b/drivers/clk/sifive/sifive-prci.c
> @@ -431,7 +431,7 @@ static int __prci_register_clocks(struct device *dev,=
 struct __prci_data *pd,
> =20
>         /* Register PLLs */
>         for (i =3D 0; i < desc->num_clks; ++i) {
> -               pic =3D &(desc->clks[i]);
> +               pic =3D desc->clks[i];

This is related how?

> =20
>                 init.name =3D pic->name;
>                 init.parent_names =3D &pic->parent_name;
> diff --git a/drivers/clk/sifive/sifive-prci.h b/drivers/clk/sifive/sifive=
-prci.h
> index bc0646bc9c3e..e6c9f72e20de 100644
> --- a/drivers/clk/sifive/sifive-prci.h
> +++ b/drivers/clk/sifive/sifive-prci.h
> @@ -253,6 +253,14 @@ struct __prci_clock {
>         struct __prci_data *pd;
>  };
> =20
> +#define DEFINE_PRCI_CLOCK(_platform, _name, _parent, _ops, _pwd)       \
> +       static struct __prci_clock _platform##_##_name =3D {             =
 \
> +               .name =3D #_name,                                        =
 \
> +               .parent_name =3D #_parent,                               =
 \
> +               .ops =3D _ops,                                           =
 \
> +               .pwd =3D _pwd,                                           =
 \
> +       }                                                               \
> +
>  #define clk_hw_to_prci_clock(pwd) container_of(pwd, struct __prci_clock,=
 hw)
> =20
>  /*
> @@ -261,7 +269,7 @@ struct __prci_clock {
>   * @num_clks: the number of element of clks
>   */
>  struct prci_clk_desc {
> -       struct __prci_clock *clks;
> +       struct __prci_clock **clks;

Huh? Nothing in the commit text mentions this.

>         size_t num_clks;
>  };
