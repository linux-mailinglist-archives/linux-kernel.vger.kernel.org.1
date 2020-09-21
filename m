Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E922734B2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 23:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgIUVRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 17:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgIUVRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 17:17:40 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A5823A5C;
        Mon, 21 Sep 2020 21:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600723059;
        bh=foxV8HjtRnG82K58AVzQJRz/cnwSm3nZy29v7i9WxGI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XIUY+AvI7vRLsmiDHW9jPKOQgtv2Os7K8A7cVZu48A5i3+Ifh0fSJjBLWZhOKoVO8
         oFyogjq8CbWlxJ2Io9/HhveXVAOLmY2ulIDreIZoKR+T12VhBnCe9h+vM1OQj7iIfO
         4GS+a5nmBYCn5SaqgL13s3JjjGHzS3BgYgysDNTs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1598621996-31040-6-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1598621996-31040-1-git-send-email-shubhrajyoti.datta@xilinx.com> <1598621996-31040-6-git-send-email-shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH v6 5/8] clk: clock-wizard: Add support for fractional support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-clk@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:17:38 -0700
Message-ID: <160072305811.310579.18192761455478284239@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shubhrajyoti Datta (2020-08-28 06:39:53)
> Currently the set rate granularity is to integral divisors.
> Add support for the fractional divisors.
> Only the first output0 is fractional in the hardware.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Getting closer.

> diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-c=
lock-wizard.c
> index 8dfcec8..1af59a4 100644
> --- a/drivers/clk/clk-xlnx-clock-wizard.c
> +++ b/drivers/clk/clk-xlnx-clock-wizard.c
> @@ -185,6 +191,134 @@ static const struct clk_ops clk_wzrd_clk_divider_op=
s =3D {
>         .recalc_rate =3D clk_wzrd_recalc_rate,
>  };
> =20
> +static unsigned long clk_wzrd_recalc_ratef(struct clk_hw *hw,
> +                                          unsigned long parent_rate)
> +{
> +       unsigned int val;
> +       u32 div, frac;
> +       struct clk_wzrd_divider *divider =3D to_clk_wzrd_divider(hw);
> +       void __iomem *div_addr =3D divider->base + divider->offset;
> +
> +       val =3D readl(div_addr);
> +       div =3D val & div_mask(divider->width);
> +       frac =3D (val >> WZRD_CLKOUT_FRAC_SHIFT) & WZRD_CLKOUT_FRAC_MASK;
> +
> +       return ((parent_rate * 1000) / ((div * 1000) + frac));

Please remove extra parenthesis. And is this mult_frac()?

> +}
> +
> +static int clk_wzrd_dynamic_reconfig_f(struct clk_hw *hw, unsigned long =
rate,
> +                                      unsigned long parent_rate)
> +{
> +       int err;
> +       u32 value, pre;
> +       unsigned long rate_div, f, clockout0_div;
> +       struct clk_wzrd_divider *divider =3D to_clk_wzrd_divider(hw);
> +       void __iomem *div_addr =3D divider->base + divider->offset;
> +
> +       rate_div =3D ((parent_rate * 1000) / rate);
> +       clockout0_div =3D rate_div / 1000;
> +
> +       pre =3D DIV_ROUND_CLOSEST((parent_rate * 1000), rate);
> +       f =3D (u32)(pre - (clockout0_div * 1000));
> +       f =3D f & WZRD_CLKOUT_FRAC_MASK;
> +
> +       value =3D ((f << WZRD_CLKOUT_DIVIDE_WIDTH) | (clockout0_div &
> +                       WZRD_CLKOUT_DIVIDE_MASK));

Please split this to multiple lines.

> +
> +       /* Set divisor and clear phase offset */
> +       writel(value, div_addr);
> +       writel(0x0, div_addr + WZRD_DR_DIV_TO_PHASE_OFFSET);
> +
> +       /* Check status register */
> +       err=3D readl_poll_timeout(divider->base + WZRD_DR_STATUS_REG_OFFS=
ET, value,
> +                               value & WZRD_DR_LOCK_BIT_MASK,
> +                               WZRD_USEC_POLL, WZRD_TIMEOUT_POLL);
> +       if (err)
> +               return err;
> +
> +       /* Initiate reconfiguration */
> +       writel(WZRD_DR_BEGIN_DYNA_RECONF,
> +              divider->base + WZRD_DR_INIT_REG_OFFSET);
> +
> +       /* Check status register */
> +       err=3D readl_poll_timeout(divider->base + WZRD_DR_STATUS_REG_OFFS=
ET, value,
> +                               value & WZRD_DR_LOCK_BIT_MASK,
> +                               WZRD_USEC_POLL, WZRD_TIMEOUT_POLL);
> +
> +       return err;

Just return readl_poll_timeout() please.

> +}
> +
> +static long clk_wzrd_round_rate_f(struct clk_hw *hw, unsigned long rate,
> +                                 unsigned long *prate)
> +{
> +       return rate;

Can every rate be supported? This function is supposed to tell the clk
framework what rate will be achieved if we call clk_set_rate() with
'rate' passed to this function. Almost always returning 'rate' is not
the case.

>=20
> +
> +static const struct clk_ops clk_wzrd_clk_divider_ops_f =3D {
> +       .round_rate =3D clk_wzrd_round_rate_f,
> +       .set_rate =3D clk_wzrd_dynamic_reconfig_f,
> +       .recalc_rate =3D clk_wzrd_recalc_ratef,
> +};
> +
> +static struct clk *clk_wzrd_register_divf(struct device *dev,
> +                                         const char *name,
> +                                         const char *parent_name,
> +                                         unsigned long flags,
> +                                         void __iomem *base, u16 offset,
> +                                         u8 shift, u8 width,
> +                                         u8 clk_divider_flags,
> +                                         const struct clk_div_table *tab=
le,
> +                                         spinlock_t *lock)
> +{
> +       struct clk_wzrd_divider *div;
> +       struct clk_hw *hw;
> +       struct clk_init_data init;
> +       int ret;
> +
> +       if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) {

Is this used? It's a rockchip specific flag mostly so probably not?

> +               if (width + shift > 16) {
> +                       pr_warn("divider value exceeds LOWORD field\n");
> +                       return ERR_PTR(-EINVAL);
> +               }
> +       }
> +
> +       /* allocate the divider */

Please remove useless comments like this.

> +       div =3D kzalloc(sizeof(*div), GFP_KERNEL);
> +       if (!div)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name =3D name;
> +
> +       if (clk_divider_flags & CLK_DIVIDER_READ_ONLY)

Is this flag used?

> +               init.ops =3D &clk_divider_ro_ops;
> +       else
> +               init.ops =3D &clk_wzrd_clk_divider_ops_f;
> +
> +       init.flags =3D flags;
> +       init.parent_names =3D (parent_name ? &parent_name : NULL);
> +       init.num_parents =3D (parent_name ? 1 : 0);

Do you have cases where there isn't a parent? Hopefully not, so this
can be simplified.

>
> +       /* struct clk_divider assignments */

Drop this comment?

> +       div->base =3D base;
> +       div->offset =3D offset;
> +       div->shift =3D shift;
> +       div->width =3D width;
> +       div->flags =3D clk_divider_flags;
> +       div->lock =3D lock;
> +       div->hw.init =3D &init;
> +       div->table =3D table;
> +
> +       /* register the clock */

Drop this comment?

> +       hw =3D &div->hw;
> +       ret =3D clk_hw_register(dev, hw);

Any reason we can't use devm_clk_hw_register() here?

> +       if (ret) {
> +               kfree(div);
> +               return ERR_PTR(ret);
> +       }
> +
> +       return hw->clk;
> +}
> +
>  static struct clk *clk_wzrd_register_divider(struct device *dev,
>                                              const char *name,
>                                              const char *parent_name,
> @@ -355,17 +489,13 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
>                 goto err_disable_clk;
>         }
> =20
> -       /* we don't support fractional div/mul yet */
> -       reg =3D readl(clk_wzrd->base + WZRD_CLK_CFG_REG(0)) &
> -                   WZRD_CLKFBOUT_FRAC_EN;
> -       reg |=3D readl(clk_wzrd->base + WZRD_CLK_CFG_REG(2)) &
> -                    WZRD_CLKOUT0_FRAC_EN;
> -       if (reg)
> -               dev_warn(&pdev->dev, "fractional div/mul not supported\n"=
);
> -
>         /* register multiplier */
>         reg =3D (readl(clk_wzrd->base + WZRD_CLK_CFG_REG(0)) &
>                      WZRD_CLKFBOUT_MULT_MASK) >> WZRD_CLKFBOUT_MULT_SHIFT;
> +       reg_f =3D (readl(clk_wzrd->base + WZRD_CLK_CFG_REG(0)) &
> +                    WZRD_CLKFBOUT_FRAC_MASK) >> WZRD_CLKFBOUT_FRAC_SHIFT;

Use two lines please. Read into variable on one line, shift on another.

> +
> +       mult =3D ((reg * 1000) + reg_f);

Please remove extra parenthesis.

>         clk_name =3D kasprintf(GFP_KERNEL, "%s_mul", dev_name(&pdev->dev)=
);
>         if (!clk_name) {
>                 ret =3D -ENOMEM;
> @@ -413,8 +543,18 @@ static int clk_wzrd_probe(struct platform_device *pd=
ev)
>                         ret =3D -EINVAL;
>                         goto err_rm_int_clks;
>                 }
> -               clk_wzrd->clkout[i] =3D clk_wzrd_register_divider(&pdev->=
dev,
> -                                                               clkout_na=
me,
> +               if (!i)
> +                       clk_wzrd->clkout[i] =3D clk_wzrd_register_divf
> +                               (&pdev->dev, clkout_name,
> +                               clk_name, 0,
> +                               clk_wzrd->base, (WZRD_CLK_CFG_REG(2) + i =
* 12),
> +                               WZRD_CLKOUT_DIVIDE_SHIFT,
> +                               WZRD_CLKOUT_DIVIDE_WIDTH,
> +                               CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW=
_ZERO,
> +                               NULL, &clkwzrd_lock);
> +               else
> +                       clk_wzrd->clkout[i] =3D clk_wzrd_register_divider
> +                               (&pdev->dev, clkout_name,
>                                 clk_name, 0,
>                                 clk_wzrd->base, (WZRD_CLK_CFG_REG(2) + i =
* 12),
>                                 WZRD_CLKOUT_DIVIDE_SHIFT,
>=20

I wonder if a do-while loop with flags set to ONE_BASED and ALLOW_ZERO
could work and then flags gets overwritten to be just DIVIDE_SHIFT? Then
we don't have to duplicate the registration line.
