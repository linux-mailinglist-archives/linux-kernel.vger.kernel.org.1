Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257C72734E0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 23:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgIUV0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 17:26:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbgIUV0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 17:26:53 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F270A23A5D;
        Mon, 21 Sep 2020 21:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600723613;
        bh=IV7PGDUgLEoCRfexj4agX3MDocOIODP3V/aEU9GbhMw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ybOrtx2xpLaqhS5nTFaAqTrS1S6QjwWw5WMKBdLLbvFzg0I3lx+0GwSbWf0MeXa1L
         qxbsmQyDIf2yfvQTkLqDju6BRC42pt+k8QF8IIcEpsvMpldJhf7LMtKwCe1m99AH8B
         f2fb3IBbwQ7l79feNMyekvyYCmLRkJr2QSQF7Daw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1598621996-31040-5-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1598621996-31040-1-git-send-email-shubhrajyoti.datta@xilinx.com> <1598621996-31040-5-git-send-email-shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH v6 4/8] clk: clock-wizard: Add support for dynamic reconfiguration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Chirag Parekh <chirag.parekh@xilinx.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-clk@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:26:51 -0700
Message-ID: <160072361167.310579.5552787788001872119@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shubhrajyoti Datta (2020-08-28 06:39:52)
> The patch adds support for dynamic reconfiguration of clock output rate.
> Output clocks are registered as dividers and set rate callback function
> is used for dynamic reconfiguration.
>=20
> Based on the initial work from Chirag.
>=20
> Signed-off-by: Chirag Parekh <chirag.parekh@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---

A lot of the same comments apply here.

> v6:
> Remove the typecast.
> use min for capping frequency.
> use polled timeout
>=20
>  drivers/clk/clk-xlnx-clock-wizard.c | 185 ++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 179 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-c=
lock-wizard.c
> index d6577c8..8dfcec8 100644
> --- a/drivers/clk/clk-xlnx-clock-wizard.c
> +++ b/drivers/clk/clk-xlnx-clock-wizard.c
> @@ -31,8 +32,23 @@
>  #define WZRD_DIVCLK_DIVIDE_SHIFT       0
>  #define WZRD_DIVCLK_DIVIDE_MASK                (0xff << WZRD_DIVCLK_DIVI=
DE_SHIFT)
>  #define WZRD_CLKOUT_DIVIDE_SHIFT       0
> +#define WZRD_CLKOUT_DIVIDE_WIDTH       8
>  #define WZRD_CLKOUT_DIVIDE_MASK                (0xff << WZRD_DIVCLK_DIVI=
DE_SHIFT)
> =20
> +#define WZRD_DR_MAX_INT_DIV_VALUE      255
> +#define WZRD_DR_NUM_RETRIES            10000
> +#define WZRD_DR_STATUS_REG_OFFSET      0x04
> +#define WZRD_DR_LOCK_BIT_MASK          0x00000001
> +#define WZRD_DR_INIT_REG_OFFSET                0x25C
> +#define WZRD_DR_DIV_TO_PHASE_OFFSET    4
> +#define WZRD_DR_BEGIN_DYNA_RECONF      0x03
> +
> +/* Get the mask from width */
> +#define div_mask(width)                        ((1 << (width)) - 1)
> +
> +/* Extract divider instance from clock hardware instance */
> +#define to_clk_wzrd_divider(_hw) container_of(_hw, struct clk_wzrd_divid=
er, hw)
> +
>  enum clk_wzrd_int_clks {
>         wzrd_clk_mul,
>         wzrd_clk_mul_div,
> @@ -73,6 +112,136 @@ static const unsigned long clk_wzrd_max_freq[] =3D {
>         1066000000UL
>  };
> =20
> +/* spin lock variable for clk_wzrd */
> +static DEFINE_SPINLOCK(clkwzrd_lock);

What is it protecting?

> +
> +static unsigned long clk_wzrd_recalc_rate(struct clk_hw *hw,
> +                                         unsigned long parent_rate)
> +{
> +       struct clk_wzrd_divider *divider =3D to_clk_wzrd_divider(hw);
> +       void __iomem *div_addr =3D divider->base + divider->offset;
> +       unsigned int val;
> +
> +       val =3D readl(div_addr) >> divider->shift;
> +       val &=3D div_mask(divider->width);
> +
> +       return divider_recalc_rate(hw, parent_rate, val, divider->table,
> +                       divider->flags, divider->width);
> +}
> +
> +static int clk_wzrd_dynamic_reconfig(struct clk_hw *hw, unsigned long ra=
te,
> +                                    unsigned long parent_rate)
> +{
> +       int err =3D 0;
> +       u32 value;
> +       struct clk_wzrd_divider *divider =3D to_clk_wzrd_divider(hw);
> +       void __iomem *div_addr =3D divider->base + divider->offset;

Shouldn't the lock be held here?

> +
> +       value =3D DIV_ROUND_CLOSEST(parent_rate, rate);
> +
> +       /* Cap the value to max */
> +       min(value, (u32)WZRD_DR_MAX_INT_DIV_VALUE);
> +
> +       /* Set divisor and clear phase offset */
> +       writel(value, div_addr);
> +       writel(0x00, div_addr + WZRD_DR_DIV_TO_PHASE_OFFSET);
> +
> +       /* Check status register */
> +       err =3D readl_poll_timeout(divider->base + WZRD_DR_STATUS_REG_OFF=
SET, value,
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
> +       err =3D readl_poll_timeout(divider->base + WZRD_DR_STATUS_REG_OFF=
SET, value,
> +                               value & WZRD_DR_LOCK_BIT_MASK,
> +                               WZRD_USEC_POLL, WZRD_TIMEOUT_POLL);
> +
> +       return err;

return readl_poll_timeout().

> +}
> +
> +static long clk_wzrd_round_rate(struct clk_hw *hw, unsigned long rate,
> +                               unsigned long *prate)
> +{
> +       u8 div;
> +
> +       /*
> +        * since we don't change parent rate we just round rate to closest
> +        * achievable
> +        */
> +       div =3D DIV_ROUND_CLOSEST(*prate, rate);
> +
> +       return (*prate / div);

Drop useless parens please.

> +}
> +
> +static const struct clk_ops clk_wzrd_clk_divider_ops =3D {
> +       .round_rate =3D clk_wzrd_round_rate,
> +       .set_rate =3D clk_wzrd_dynamic_reconfig,
> +       .recalc_rate =3D clk_wzrd_recalc_rate,
> +};
> +
> +static struct clk *clk_wzrd_register_divider(struct device *dev,
> +                                            const char *name,
> +                                            const char *parent_name,
> +                                            unsigned long flags,
> +                                            void __iomem *base, u16 offs=
et,
> +                                            u8 shift, u8 width,
> +                                            u8 clk_divider_flags,
> +                                            const struct clk_div_table *=
table,
> +                                            spinlock_t *lock)
> +{
> +       struct clk_wzrd_divider *div;
> +       struct clk_hw *hw;
> +       struct clk_init_data init;
> +       int ret;
> +
> +       if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) {

Is it used?

> +               if (width + shift > 16) {
> +                       pr_warn("divider value exceeds LOWORD field\n");
> +                       return ERR_PTR(-EINVAL);
> +               }
> +       }
> +
> +       /* allocate the divider */
> +       div =3D kzalloc(sizeof(*div), GFP_KERNEL);
> +       if (!div)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name =3D name;
> +       if (clk_divider_flags & CLK_DIVIDER_READ_ONLY)

Is this used?

> +               init.ops =3D &clk_divider_ro_ops;
> +       else
> +               init.ops =3D &clk_wzrd_clk_divider_ops;
> +       init.flags =3D flags;
> +       init.parent_names =3D (parent_name ? &parent_name : NULL);
> +       init.num_parents =3D (parent_name ? 1 : 0);

Doesn't it always have a parent?

> +
> +       /* struct clk_divider assignments */

Drop useless comments please.

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
> +       hw =3D &div->hw;
> +       ret =3D clk_hw_register(dev, hw);

devm_clk_hw_register()?

> +       if (ret) {
> +               kfree(div);

Why not a devm_kzalloc() and then drop this?

> +               hw =3D ERR_PTR(ret);
> +       }
> +
> +       return hw->clk;
> +}
> +
>  static int clk_wzrd_clk_notifier(struct notifier_block *nb, unsigned lon=
g event,
>                                  void *data)
>  {
> @@ -243,11 +413,14 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
>                         ret =3D -EINVAL;
>                         goto err_rm_int_clks;
>                 }
> -               reg =3D readl(clk_wzrd->base + WZRD_CLK_CFG_REG(2) + i * =
12);
> -               reg &=3D WZRD_CLKOUT_DIVIDE_MASK;
> -               reg >>=3D WZRD_CLKOUT_DIVIDE_SHIFT;
> -               clk_wzrd->clkout[i] =3D clk_register_fixed_factor
> -                       (&pdev->dev, clkout_name, clk_name, 0, 1, reg);
> +               clk_wzrd->clkout[i] =3D clk_wzrd_register_divider(&pdev->=
dev,
> +                                                               clkout_na=
me,
> +                               clk_name, 0,
> +                               clk_wzrd->base, (WZRD_CLK_CFG_REG(2) + i =
* 12),
> +                               WZRD_CLKOUT_DIVIDE_SHIFT,
> +                               WZRD_CLKOUT_DIVIDE_WIDTH,
> +                               CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW=
_ZERO,
> +                               NULL, &clkwzrd_lock);

Also wonder if we could have a clk_wzrd_register_divider() API that
knows most of these things and just takes a number indicating which clk
it is? Then the caller isn't a bunch of lines of code that has to be
mentally carried to the callee.

>                 if (IS_ERR(clk_wzrd->clkout[i])) {
>                         int j;
>
