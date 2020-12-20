Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A04B2DF38E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 05:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgLTEhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 23:37:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgLTEhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 23:37:19 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608438998;
        bh=h0twT4Kjfbep8q+R8oxVjgYmifH+7HiLcLieH9jgCkE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ja3eYY7oYPhqnfxP81HeNbX6oSCsZ1Y9aS72yWq4wR5z7gpSoFpLBUG0FuPejGgS8
         NLJ4FLXO1gq3ynb/UfYUrpNMlfquvoUk3O1A3HzAgKV0aaJH9zFPbxPQZFJx8aOww7
         m6utiS9MVJGmtdxicAdm8TzmadOYczpD9Si2P/1LTkkPzL/LW9jM1m9yHBhUdkdpUK
         AK1HMMrQ3Q4htEJD5MwpirxLf6SrPBlTFi5q8V5n4A2Bdj2nmyrFkIy5BSPQgM+CuV
         86bC0TqzTu1zThlfWji2MjS5ZcIVf/JNyWafac1KJqBfQvZ7vRhS5TgyvHIPC8f33H
         DzlgyAiP5g+HA==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201114135044.724385-4-daniel@0x0f.com>
References: <20201114135044.724385-1-daniel@0x0f.com> <20201114135044.724385-4-daniel@0x0f.com>
Subject: Re: [PATCH 3/6] clk: mstar: MStar/SigmaStar MPLL driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        w@1wt.eu, Daniel Palmer <daniel@0x0f.com>
To:     Daniel Palmer <daniel@0x0f.com>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Sat, 19 Dec 2020 20:36:36 -0800
Message-ID: <160843899675.1580929.13271525932327387602@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Palmer (2020-11-14 05:50:41)
>  F:     include/dt-bindings/gpio/msc313-gpio.h
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index c715d4681a0b..a002f2605fa3 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -370,6 +370,7 @@ source "drivers/clk/ingenic/Kconfig"
>  source "drivers/clk/keystone/Kconfig"
>  source "drivers/clk/mediatek/Kconfig"
>  source "drivers/clk/meson/Kconfig"
> +source "drivers/clk/mstar/Kconfig"
>  source "drivers/clk/mvebu/Kconfig"
>  source "drivers/clk/qcom/Kconfig"
>  source "drivers/clk/renesas/Kconfig"

This looks good.

> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index da8fcf147eb1..b758aae17ab8 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -124,3 +124,4 @@ endif
>  obj-$(CONFIG_ARCH_ZX)                  +=3D zte/
>  obj-$(CONFIG_ARCH_ZYNQ)                        +=3D zynq/
>  obj-$(CONFIG_COMMON_CLK_ZYNQMP)         +=3D zynqmp/
> +obj-$(CONFIG_ARCH_MSTARV7)             +=3D mstar/

This is in the wrong place. It looks to be sorted based on the path
name, so mstar/ comes much earlier in this file.

> diff --git a/drivers/clk/mstar/Kconfig b/drivers/clk/mstar/Kconfig
> new file mode 100644
> index 000000000000..23765edde3af
> --- /dev/null
> +++ b/drivers/clk/mstar/Kconfig
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config MSTAR_MSC313_MPLL
> +       bool
> +       select REGMAP
> +       select REGMAP_MMIO
> diff --git a/drivers/clk/mstar/Makefile b/drivers/clk/mstar/Makefile
> new file mode 100644
> index 000000000000..f8dcd25ede1d
> --- /dev/null
> +++ b/drivers/clk/mstar/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for mstar specific clk
> +#
> +
> +obj-$(CONFIG_MSTAR_MSC313_MPLL) +=3D clk-msc313-mpll.o
> diff --git a/drivers/clk/mstar/clk-msc313-mpll.c b/drivers/clk/mstar/clk-=
msc313-mpll.c
> new file mode 100644
> index 000000000000..c1e2fe0fc412
> --- /dev/null
> +++ b/drivers/clk/mstar/clk-msc313-mpll.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MStar MSC313 MPLL driver
> + *
> + * Copyright (C) 2020 Daniel Palmer <daniel@thingy.jp>
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>

Please remove unused includes

> +#include <linux/of_address.h>
> +#include <linux/module.h>

Isn't it builtin? This include should be removed.

> +#include <linux/regmap.h>
> +
> +#define REG_CONFIG1    0x8
> +#define REG_CONFIG2    0xc
> +
> +static const struct regmap_config msc313_mpll_regmap_config =3D {
> +       .reg_bits =3D 16,
> +       .val_bits =3D 16,
> +       .reg_stride =3D 4,
> +};
> +
> +static const struct reg_field config1_loop_div_first =3D REG_FIELD(REG_C=
ONFIG1, 8, 9);
> +static const struct reg_field config1_input_div_first =3D REG_FIELD(REG_=
CONFIG1, 4, 5);
> +static const struct reg_field config2_output_div_first =3D REG_FIELD(REG=
_CONFIG2, 12, 13);
> +static const struct reg_field config2_loop_div_second =3D REG_FIELD(REG_=
CONFIG2, 0, 7);
> +
> +static const unsigned int output_dividers[] =3D {
> +       2, 3, 4, 5, 6, 7, 10
> +};
> +
> +#define NUMOUTPUTS (ARRAY_SIZE(output_dividers) + 1)
> +
> +struct msc313_mpll {
> +       struct clk_hw clk_hw;
> +       struct regmap_field *input_div;
> +       struct regmap_field *loop_div_first;
> +       struct regmap_field *loop_div_second;
> +       struct regmap_field *output_div;
> +       struct clk_hw_onecell_data *clk_data;
> +};
> +
> +#define to_mpll(_hw) container_of(_hw, struct msc313_mpll, clk_hw)
> +#define to_divider_hw(_mpll, _which) _mpll->clk_data->hws[_which + 1]

I'd rather not have this macro. It's confusing given that to_foo()
macros are usually a container_of() invocation. Given that it's only
used in the registration/unregistration loops please inline it and use a
local variable.

> +
> +static unsigned long msc313_mpll_recalc_rate(struct clk_hw *hw,
> +               unsigned long parent_rate)
> +{
> +       struct msc313_mpll *mpll =3D to_mpll(hw);
> +       unsigned int input_div, output_div, loop_first, loop_second;
> +       unsigned long output_rate;
> +
> +       regmap_field_read(mpll->input_div, &input_div);
> +       regmap_field_read(mpll->output_div, &output_div);
> +       regmap_field_read(mpll->loop_div_first, &loop_first);
> +       regmap_field_read(mpll->loop_div_second, &loop_second);
> +
> +       output_rate =3D parent_rate / (1 << input_div);
> +       output_rate *=3D (1 << loop_first) * max(loop_second, 1U);
> +       output_rate /=3D max(output_div, 1U);
> +
> +       return output_rate;
> +}
> +
> +static const struct clk_ops msc313_mpll_ops =3D {
> +               .recalc_rate =3D msc313_mpll_recalc_rate,

Weird double indent here.

> +};
> +
> +static int msc313_mpll_probe(struct platform_device *pdev)
> +{
> +       void __iomem *base;
> +       struct msc313_mpll *mpll;
> +       struct clk_init_data clk_init;
> +       struct device *dev =3D &pdev->dev;
> +       struct regmap *regmap;
> +       const char *parents[1], *outputnames[NUMOUTPUTS];
> +       const int numparents =3D ARRAY_SIZE(parents);
> +       int ret, i;
> +
> +       if (of_clk_parent_fill(dev->of_node, parents, numparents) !=3D nu=
mparents)
> +               return -EINVAL;
> +
> +       if (of_property_read_string_array(pdev->dev.of_node, "clock-outpu=
t-names",

Hopefully this isn't required.

> +                       outputnames, NUMOUTPUTS) !=3D NUMOUTPUTS)
> +               return -EINVAL;
> +
> +       mpll =3D devm_kzalloc(dev, sizeof(*mpll), GFP_KERNEL);
> +       if (!mpll)
> +               return -ENOMEM;
> +
> +       base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       regmap =3D devm_regmap_init_mmio(dev, base, &msc313_mpll_regmap_c=
onfig);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       mpll->input_div =3D devm_regmap_field_alloc(dev, regmap, config1_=
input_div_first);
> +       if (IS_ERR(mpll->input_div))
> +               return PTR_ERR(mpll->input_div);
> +       mpll->output_div =3D devm_regmap_field_alloc(dev, regmap, config2=
_output_div_first);
> +       if (IS_ERR(mpll->output_div))
> +               return PTR_ERR(mpll->output_div);
> +       mpll->loop_div_first =3D devm_regmap_field_alloc(dev, regmap, con=
fig1_loop_div_first);
> +       if (IS_ERR(mpll->loop_div_first))
> +               return PTR_ERR(mpll->loop_div_first);
> +       mpll->loop_div_second =3D devm_regmap_field_alloc(dev, regmap, co=
nfig2_loop_div_second);
> +       if (IS_ERR(mpll->loop_div_second))
> +               return PTR_ERR(mpll->loop_div_second);
> +
> +       mpll->clk_data =3D devm_kzalloc(dev, struct_size(mpll->clk_data, =
hws,
> +                       ARRAY_SIZE(output_dividers)), GFP_KERNEL);
> +       if (!mpll->clk_data)
> +               return -ENOMEM;
> +
> +       clk_init.name =3D outputnames[0];
> +       clk_init.ops =3D &msc313_mpll_ops;
> +       clk_init.num_parents =3D 1;
> +       clk_init.parent_names =3D parents;
> +       mpll->clk_hw.init =3D &clk_init;
> +
> +       ret =3D devm_clk_hw_register(dev, &mpll->clk_hw);
> +       if (ret)
> +               return ret;
> +
> +       mpll->clk_data->num =3D NUMOUTPUTS;
> +       mpll->clk_data->hws[0] =3D &mpll->clk_hw;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(output_dividers); i++) {
> +               to_divider_hw(mpll, i) =3D clk_hw_register_fixed_factor(d=
ev,
> +                               outputnames[i + 1], outputnames[0], 0, 1,=
 output_dividers[i]);
> +               if (IS_ERR(to_divider_hw(mpll, i))) {
> +                       ret =3D PTR_ERR(to_divider_hw(mpll, i));
> +                       goto unregister_dividers;
> +               }
> +       }
> +
> +       platform_set_drvdata(pdev, mpll);
> +
> +       return devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_=
get,
> +                       mpll->clk_data);
> +
> +unregister_dividers:
> +       for (i--; i >=3D 0; i--)
> +               clk_hw_unregister_fixed_factor(to_divider_hw(mpll, i));
> +       return ret;
> +}
> +
> +static int msc313_mpll_remove(struct platform_device *pdev)
> +{
> +       struct msc313_mpll *mpll =3D platform_get_drvdata(pdev);
> +       int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(output_dividers); i++)
> +               clk_hw_unregister_fixed_factor(to_divider_hw(mpll, i));

Maybe add a devm_ for this if it doesn't exist.

> +
> +       return 0;
> +}
> +
> +static const struct of_device_id msc313_mpll_of_match[] =3D {
> +       { .compatible =3D "mstar,msc313-mpll", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, msc313_mpll_of_match);

Drop this. It isn't a module.

> +
> +static struct platform_driver msc313_mpll_driver =3D {
> +       .driver =3D {
> +               .name =3D "mstar-msc313-mpll",
> +               .of_match_table =3D msc313_mpll_of_match,
> +       },
> +       .probe =3D msc313_mpll_probe,
> +       .remove =3D msc313_mpll_remove,
> +};
> +builtin_platform_driver(msc313_mpll_driver);
