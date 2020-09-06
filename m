Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D8C25F0F5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 00:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgIFWmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 18:42:18 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38346 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgIFWmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 18:42:17 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kF3MT-0002bg-4F; Mon, 07 Sep 2020 00:42:13 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: Re: [PATCH v3 5/6] clk: rockchip: fix the clk config to support module build
Date:   Mon, 07 Sep 2020 00:42:12 +0200
Message-ID: <3695649.H3NGuQi1vT@diego>
In-Reply-To: <20200904074448.24753-1-zhangqing@rock-chips.com>
References: <20200904074405.24439-1-zhangqing@rock-chips.com> <20200904074448.24753-1-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elaine,

Am Freitag, 4. September 2020, 09:44:48 CEST schrieb Elaine Zhang:
> use CONFIG_COMMON_CLK_ROCKCHIP for Rk common clk drivers.
> use CONFIG_CLK_RKXX for Rk soc clk driver.
> Mark configuration to "tristate",
> to support building Rk SoCs clock driver as module.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>  drivers/clk/Kconfig           |  1 +
>  drivers/clk/rockchip/Kconfig  | 78 +++++++++++++++++++++++++++++++++++
>  drivers/clk/rockchip/Makefile | 42 ++++++++++---------
>  3 files changed, 101 insertions(+), 20 deletions(-)
>  create mode 100644 drivers/clk/rockchip/Kconfig
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 4026fac9fac3..b41aaed9bd51 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -373,6 +373,7 @@ source "drivers/clk/meson/Kconfig"
>  source "drivers/clk/mvebu/Kconfig"
>  source "drivers/clk/qcom/Kconfig"
>  source "drivers/clk/renesas/Kconfig"
> +source "drivers/clk/rockchip/Kconfig"
>  source "drivers/clk/samsung/Kconfig"
>  source "drivers/clk/sifive/Kconfig"
>  source "drivers/clk/sprd/Kconfig"
> diff --git a/drivers/clk/rockchip/Kconfig b/drivers/clk/rockchip/Kconfig
> new file mode 100644
> index 000000000000..53a44396bc35
> --- /dev/null
> +++ b/drivers/clk/rockchip/Kconfig
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# common clock support for ROCKCHIP SoC family.
> +
> +config COMMON_CLK_ROCKCHIP
> +	tristate "Rockchip clock controller common support"
> +	depends on ARCH_ROCKCHIP
> +	default ARCH_ROCKCHIP
> +	help
> +	  Say y here to enable common clock controller.

Maybe  "Say y here to enable common clock controller for Rockchip platforms."


> +
> +if COMMON_CLK_ROCKCHIP
> +config CLK_PX30
> +	tristate "Rockchip Px30 clock controller support"

2 Problems:
- order: you add the symbols allowing module builds before adding module
  infrastructure, so in a bisection build with patch6 not applied you
  probably end up with build errors?
- in patch6 you only add module infrastructure for rk3399, but here you
  declare all as tristate ... so what happens if someone selects to build
  the PX30 as module now?

Thanks
Heiko


> +	default y
> +	help
> +	  Build the driver for Px30 Clock Driver.
> +
> +config CLK_RV110X
> +	tristate "Rockchip Rv110x clock controller support"
> +	default y
> +	help
> +	  Build the driver for Rv110x Clock Driver.
> +
> +config CLK_RK3036
> +	tristate "Rockchip Rk3036 clock controller support"
> +	default y
> +	help
> +	  Build the driver for Rk3036 Clock Driver.
> +
> +config CLK_RK312X
> +	tristate "Rockchip Rk312x clock controller support"
> +	default y
> +	help
> +	  Build the driver for Rk312x Clock Driver.
> +
> +config CLK_RK3188
> +	tristate "Rockchip Rk3188 clock controller support"
> +	default y
> +	help
> +	  Build the driver for Rk3188 Clock Driver.
> +
> +config CLK_RK322X
> +	tristate "Rockchip Rk322x clock controller support"
> +	default y
> +	help
> +	  Build the driver for Rk322x Clock Driver.
> +
> +config CLK_RK3288
> +	tristate "Rockchip Rk3288 clock controller support"
> +	depends on ARM
> +	default y
> +	help
> +	  Build the driver for Rk3288 Clock Driver.
> +
> +config CLK_RK3308
> +	tristate "Rockchip Rk3308 clock controller support"
> +	default y
> +	help
> +	  Build the driver for Rk3308 Clock Driver.
> +
> +config CLK_RK3328
> +	tristate "Rockchip Rk3328 clock controller support"
> +	default y
> +	help
> +	  Build the driver for Rk3328 Clock Driver.
> +
> +config CLK_RK3368
> +	tristate "Rockchip Rk3368 clock controller support"
> +	default y
> +	help
> +	  Build the driver for Rk3368 Clock Driver.
> +
> +config CLK_RK3399
> +	tristate "Rockchip Rk3399 clock controller support"
> +	default y
> +	help
> +	  Build the driver for Rk3399 Clock Driver.
> +endif
> diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
> index 7c5b5813a87c..a99e4d9bbae1 100644
> --- a/drivers/clk/rockchip/Makefile
> +++ b/drivers/clk/rockchip/Makefile
> @@ -3,24 +3,26 @@
>  # Rockchip Clock specific Makefile
>  #
>  
> -obj-y	+= clk.o
> -obj-y	+= clk-pll.o
> -obj-y	+= clk-cpu.o
> -obj-y	+= clk-half-divider.o
> -obj-y	+= clk-inverter.o
> -obj-y	+= clk-mmc-phase.o
> -obj-y	+= clk-muxgrf.o
> -obj-y	+= clk-ddr.o
> -obj-$(CONFIG_RESET_CONTROLLER)	+= softrst.o
> +obj-$(CONFIG_COMMON_CLK_ROCKCHIP) += clk-rockchip.o
>  
> -obj-y	+= clk-px30.o
> -obj-y	+= clk-rv1108.o
> -obj-y	+= clk-rk3036.o
> -obj-y	+= clk-rk3128.o
> -obj-y	+= clk-rk3188.o
> -obj-y	+= clk-rk3228.o
> -obj-y	+= clk-rk3288.o
> -obj-y	+= clk-rk3308.o
> -obj-y	+= clk-rk3328.o
> -obj-y	+= clk-rk3368.o
> -obj-y	+= clk-rk3399.o
> +clk-rockchip-y += clk.o
> +clk-rockchip-y += clk-pll.o
> +clk-rockchip-y += clk-cpu.o
> +clk-rockchip-y += clk-half-divider.o
> +clk-rockchip-y += clk-inverter.o
> +clk-rockchip-y += clk-mmc-phase.o
> +clk-rockchip-y += clk-muxgrf.o
> +clk-rockchip-y += clk-ddr.o
> +clk-rockchip-$(CONFIG_RESET_CONTROLLER) += softrst.o
> +
> +obj-$(CONFIG_CLK_PX30)          += clk-px30.o
> +obj-$(CONFIG_CLK_RV110X)        += clk-rv1108.o
> +obj-$(CONFIG_CLK_RK3036)        += clk-rk3036.o
> +obj-$(CONFIG_CLK_RK312X)        += clk-rk3128.o
> +obj-$(CONFIG_CLK_RK3188)        += clk-rk3188.o
> +obj-$(CONFIG_CLK_RK322X)        += clk-rk3228.o
> +obj-$(CONFIG_CLK_RK3288)        += clk-rk3288.o
> +obj-$(CONFIG_CLK_RK3308)        += clk-rk3308.o
> +obj-$(CONFIG_CLK_RK3328)        += clk-rk3328.o
> +obj-$(CONFIG_CLK_RK3368)        += clk-rk3368.o
> +obj-$(CONFIG_CLK_RK3399)        += clk-rk3399.o
> 




