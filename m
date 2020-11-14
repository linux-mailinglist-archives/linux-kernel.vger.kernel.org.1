Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74EA2B30F1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 22:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgKNVPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 16:15:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgKNVPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 16:15:02 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A0D522384;
        Sat, 14 Nov 2020 21:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605388501;
        bh=xTsPS9BqVJmIWaQyIUFXi/nmgrZUNaJ8UyhWdA5aqi4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TGWMybjvu3PweAL0+Y5dR2CD0xWvoGyubYT8spJx4bsxf/QtZzoFgOcL+xP2F9jqN
         F+LQIviGmnWOwNkoDAgBHY6VQaYV0i8bbSxMa8A5UKvUNp/gKCtMLctOXRhogVMz+S
         YKCvaWd9gXd7JI3ZFpE4fDcvw/k9IKc47J1OuGCs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1604655988-353-7-git-send-email-claudiu.beznea@microchip.com>
References: <1604655988-353-1-git-send-email-claudiu.beznea@microchip.com> <1604655988-353-7-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v4 06/11] clk: at91: clk-sam9x60-pll: allow runtime changes for pll
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     eugen.hristev@microchip.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com,
        robh+dt@kernel.org
Date:   Sat, 14 Nov 2020 13:14:59 -0800
Message-ID: <160538849947.60232.12002724470272520124@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-11-06 01:46:23)
> diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sa=
m9x60-pll.c
> index 78f458a7b2ef..6fe5d8530a0c 100644
> --- a/drivers/clk/at91/clk-sam9x60-pll.c
> +++ b/drivers/clk/at91/clk-sam9x60-pll.c
> @@ -225,8 +225,51 @@ static int sam9x60_frac_pll_set_rate(struct clk_hw *=
hw, unsigned long rate,
>                                      unsigned long parent_rate)
>  {
>         struct sam9x60_pll_core *core =3D to_sam9x60_pll_core(hw);
> +       struct sam9x60_frac *frac =3D to_sam9x60_frac(core);
> +       struct regmap *regmap =3D core->regmap;
> +       unsigned long irqflags, clkflags =3D clk_hw_get_flags(hw);
> +       unsigned int val, cfrac, cmul;
> +       long ret;
> +
> +       ret =3D sam9x60_frac_pll_compute_mul_frac(core, rate, parent_rate=
, true);
> +       if (ret <=3D 0 || (clkflags & CLK_SET_RATE_GATE))

Is this function being called when the clk is enabled and it has the
CLK_SET_RATE_GATE flag set? I'm confused why this driver needs to check
this flag.
=20
> +               return ret;
> +
> +       spin_lock_irqsave(core->lock, irqflags);
> +
> +       regmap_update_bits(regmap, AT91_PMC_PLL_UPDT, AT91_PMC_PLL_UPDT_I=
D_MSK,
> +                          core->id);
> +       regmap_read(regmap, AT91_PMC_PLL_CTRL1, &val);
> +       cmul =3D (val & core->layout->mul_mask) >> core->layout->mul_shif=
t;
> +       cfrac =3D (val & core->layout->frac_mask) >> core->layout->frac_s=
hift;
> +
> +       if (cmul =3D=3D frac->mul && cfrac =3D=3D frac->frac)
> +               goto unlock;
> +
> +       regmap_write(regmap, AT91_PMC_PLL_CTRL1,
> +                    (frac->mul << core->layout->mul_shift) |
> +                    (frac->frac << core->layout->frac_shift));
> +
> +       regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
> +                          AT91_PMC_PLL_UPDT_UPDATE | AT91_PMC_PLL_UPDT_I=
D_MSK,
> +                          AT91_PMC_PLL_UPDT_UPDATE | core->id);
> +
> +       regmap_update_bits(regmap, AT91_PMC_PLL_CTRL0,
> +                          AT91_PMC_PLL_CTRL0_ENLOCK | AT91_PMC_PLL_CTRL0=
_ENPLL,
> +                          AT91_PMC_PLL_CTRL0_ENLOCK |
> +                          AT91_PMC_PLL_CTRL0_ENPLL);
> +
> +       regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
> +                          AT91_PMC_PLL_UPDT_UPDATE | AT91_PMC_PLL_UPDT_I=
D_MSK,
> +                          AT91_PMC_PLL_UPDT_UPDATE | core->id);
> =20
> -       return sam9x60_frac_pll_compute_mul_frac(core, rate, parent_rate,=
 true);
> +       while (!sam9x60_pll_ready(regmap, core->id))
> +               cpu_relax();
> +
> +unlock:
> +       spin_unlock_irqrestore(core->lock, irqflags);
> +
> +       return ret;
>  }
> =20
>  static const struct clk_ops sam9x60_frac_pll_ops =3D {
> @@ -378,9 +421,39 @@ static int sam9x60_div_pll_set_rate(struct clk_hw *h=
w, unsigned long rate,
>  {
>         struct sam9x60_pll_core *core =3D to_sam9x60_pll_core(hw);
>         struct sam9x60_div *div =3D to_sam9x60_div(core);
> +       struct regmap *regmap =3D core->regmap;
> +       unsigned long irqflags, clkflags =3D clk_hw_get_flags(hw);
> +       unsigned int val, cdiv;
> =20
>         div->div =3D DIV_ROUND_CLOSEST(parent_rate, rate) - 1;
> =20
> +       if (clkflags & CLK_SET_RATE_GATE)

Same comment.

> diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
> index d685e22b2014..33faf7c6d9fb 100644
> --- a/drivers/clk/at91/sama7g5.c
> +++ b/drivers/clk/at91/sama7g5.c
> @@ -95,15 +95,15 @@ static const struct clk_pll_layout pll_layout_divio =
=3D {
>   * @p:         clock parent
>   * @l:         clock layout
>   * @t:         clock type
> - * @f:         true if clock is critical and cannot be disabled
> + * @f:         clock flags
>   * @eid:       export index in sama7g5->chws[] array
>   */
>  static const struct {
>         const char *n;
>         const char *p;
>         const struct clk_pll_layout *l;
> +       u32 f;

Why not unsigned long?

>         u8 t;
> -       u8 c;
>         u8 eid;
>  } sama7g5_plls[][PLL_ID_MAX] =3D {
>         [PLL_ID_CPU] =3D {
> @@ -111,13 +111,13 @@ static const struct {
>                   .p =3D "mainck",
>                   .l =3D &pll_layout_frac,
>                   .t =3D PLL_TYPE_FRAC,
> -                 .c =3D 1, },
> +                 .f =3D CLK_IS_CRITICAL, },
> =20
>                 { .n =3D "cpupll_divpmcck",
>                   .p =3D "cpupll_fracck",
>                   .l =3D &pll_layout_divpmc,
>                   .t =3D PLL_TYPE_DIV,
> -                 .c =3D 1,
> +                 .f =3D CLK_IS_CRITICAL | CLK_SET_RATE_PARENT,
>                   .eid =3D PMC_CPUPLL, },
>         },
> =20
> @@ -126,13 +126,13 @@ static const struct {
>                   .p =3D "mainck",
>                   .l =3D &pll_layout_frac,
>                   .t =3D PLL_TYPE_FRAC,
> -                 .c =3D 1, },
> +                 .f =3D CLK_IS_CRITICAL | CLK_SET_RATE_GATE, },
> =20
>                 { .n =3D "syspll_divpmcck",
>                   .p =3D "syspll_fracck",
>                   .l =3D &pll_layout_divpmc,
>                   .t =3D PLL_TYPE_DIV,
> -                 .c =3D 1,
> +                 .f =3D CLK_IS_CRITICAL | CLK_SET_RATE_GATE,

Please indicate why clks are critical. Whenever the CLK_IS_CRITICAL flag
is used we should have a comment indicating why.

>                   .eid =3D PMC_SYSPLL, },
>         },
>
