Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7848C2D4E4E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 23:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbgLIWqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 17:46:24 -0500
Received: from foss.arm.com ([217.140.110.172]:41400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388667AbgLIWqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 17:46:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BF3D31B;
        Wed,  9 Dec 2020 14:45:23 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 203843F66B;
        Wed,  9 Dec 2020 14:45:21 -0800 (PST)
Subject: Re: [linux-sunxi] [PATCH 5/8] clk: sunxi-ng: Add support for the
 Allwinner H616 CCU
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
References: <20201202135409.13683-1-andre.przywara@arm.com>
 <CAJiuCcewhVeHCDcMHY75mSqu33YEVoav2bAdVuc87Ek+LrujRA@mail.gmail.com>
 <3b6150a3-09a2-affc-9092-8c325765994a@arm.com>
 <9923889.3IKZAPC0Rj@jernej-laptop>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <68a7ef0c-eaea-5f3f-87f3-8d36e6bbd6da@arm.com>
Date:   Wed, 9 Dec 2020 22:45:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <9923889.3IKZAPC0Rj@jernej-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2020 22:20, Jernej Škrabec wrote:
> Dne sreda, 09. december 2020 ob 22:35:51 CET je André Przywara napisal(a):
>> On 09/12/2020 14:33, Clément Péron wrote:
>>
>> Hi,
>>
>>> I try to review this, and compare against the vendor Kernel>
>>>
>>> On Wed, 2 Dec 2020 at 14:54, Andre Przywara <andre.przywara@arm.com> 
> wrote:
>>>> While the clocks are fairly similar to the H6, many differ in tiny
>>>> details, so a separate clock driver seems indicated.
>>>>
>>>> Derived from the H6 clock driver, and adjusted according to the manual.
>>>>
>>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>>> ---
>>>>
>>>>  drivers/clk/sunxi-ng/Kconfig                |    7 +-
>>>>  drivers/clk/sunxi-ng/Makefile               |    1 +
>>>>  drivers/clk/sunxi-ng/ccu-sun50i-h616.c      | 1134 +++++++++++++++++++
>>>>  drivers/clk/sunxi-ng/ccu-sun50i-h616.h      |   58 +
>>>>  include/dt-bindings/clock/sun50i-h616-ccu.h |  110 ++
>>>>  include/dt-bindings/reset/sun50i-h616-ccu.h |   67 ++
>>>>  6 files changed, 1376 insertions(+), 1 deletion(-)
>>>>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h616.c
>>>>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h616.h
>>>>  create mode 100644 include/dt-bindings/clock/sun50i-h616-ccu.h
>>>>  create mode 100644 include/dt-bindings/reset/sun50i-h616-ccu.h
>>>>
>>>> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
>>>> index ce5f5847d5d3..cd46d8853876 100644
>>>> --- a/drivers/clk/sunxi-ng/Kconfig
>>>> +++ b/drivers/clk/sunxi-ng/Kconfig
>>>> @@ -32,8 +32,13 @@ config SUN50I_H6_CCU
>>>>
>>>>         default ARM64 && ARCH_SUNXI
>>>>         depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
>>>>
>>>> +config SUN50I_H616_CCU
>>>> +       bool "Support for the Allwinner H616 CCU"
>>>> +       default ARM64 && ARCH_SUNXI
>>>> +       depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
>>>> +
>>>>
>>>>  config SUN50I_H6_R_CCU
>>>>
>>>> -       bool "Support for the Allwinner H6 PRCM CCU"
>>>> +       bool "Support for the Allwinner H6 and H616 PRCM CCU"
>>>>
>>>>         default ARM64 && ARCH_SUNXI
>>>>         depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
>>>>
>>>> diff --git a/drivers/clk/sunxi-ng/Makefile
>>>> b/drivers/clk/sunxi-ng/Makefile
>>>> index 3eb5cff40eac..96c324306d97 100644
>>>> --- a/drivers/clk/sunxi-ng/Makefile
>>>> +++ b/drivers/clk/sunxi-ng/Makefile
>>>> @@ -26,6 +26,7 @@ obj-$(CONFIG_SUN50I_A64_CCU)  += ccu-sun50i-a64.o
>>>>
>>>>  obj-$(CONFIG_SUN50I_A100_CCU)  += ccu-sun50i-a100.o
>>>>  obj-$(CONFIG_SUN50I_A100_R_CCU)        += ccu-sun50i-a100-r.o
>>>>  obj-$(CONFIG_SUN50I_H6_CCU)    += ccu-sun50i-h6.o
>>>>
>>>> +obj-$(CONFIG_SUN50I_H616_CCU)  += ccu-sun50i-h616.o
>>>>
>>>>  obj-$(CONFIG_SUN50I_H6_R_CCU)  += ccu-sun50i-h6-r.o
>>>>  obj-$(CONFIG_SUN4I_A10_CCU)    += ccu-sun4i-a10.o
>>>>  obj-$(CONFIG_SUN5I_CCU)                += ccu-sun5i.o
>>>>
>>>> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
>>>> b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c new file mode 100644
>>>> index 000000000000..3fbb258f0354
>>>> --- /dev/null
>>>> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
>>>> @@ -0,0 +1,1134 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Copyright (c) 2020 Arm Ltd.
>>>> + * Based on the H6 CCU driver, which is:
>>>> + *   Copyright (c) 2017 Icenowy Zheng <icenowy@aosc.io>
>>>> + */
>>>> +
>>>> +#include <linux/clk-provider.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/of_address.h>
>>>> +#include <linux/platform_device.h>
>>>> +
>>>> +#include "ccu_common.h"
>>>> +#include "ccu_reset.h"
>>>> +
>>>> +#include "ccu_div.h"
>>>> +#include "ccu_gate.h"
>>>> +#include "ccu_mp.h"
>>>> +#include "ccu_mult.h"
>>>> +#include "ccu_nk.h"
>>>> +#include "ccu_nkm.h"
>>>> +#include "ccu_nkmp.h"
>>>> +#include "ccu_nm.h"
>>>> +
>>>> +#include "ccu-sun50i-h616.h"
>>>> +
>>>> +/*
>>>> + * The CPU PLL is actually NP clock, with P being /1, /2 or /4. However
>>>> + * P should only be used for output frequencies lower than 288 MHz.
>>>> + *
>>>> + * For now we can just model it as a multiplier clock, and force P to
>>>> /1.
>>>> + *
>>>> + * The M factor is present in the register's description, but not in the
>>>> + * frequency formula, and it's documented as "M is only used for
>>>> backdoor
>>>> + * testing", so it's not modelled and then force to 0.
>>>> + */
>>>> +#define SUN50I_H616_PLL_CPUX_REG       0x000
>>>> +static struct ccu_mult pll_cpux_clk = {
>>>> +       .enable         = BIT(31),
>>>> +       .lock           = BIT(28),
>>>> +       .mult           = _SUNXI_CCU_MULT_MIN(8, 8, 12),
>>>> +       .common         = {
>>>> +               .reg            = 0x000,
>>>> +               .hw.init        = CLK_HW_INIT("pll-cpux", "osc24M",
>>>> +                                             &ccu_mult_ops,
>>>> +                                             CLK_SET_RATE_UNGATE),
>>>> +       },
>>>> +};
>>>> +
>>>> +/* Some PLLs are input * N / div1 / P. Model them as NKMP with no K */
>>>> +#define SUN50I_H616_PLL_DDR0_REG       0x010
>>>> +static struct ccu_nkmp pll_ddr0_clk = {
>>>> +       .enable         = BIT(31),
>>>> +       .lock           = BIT(28),
>>>> +       .n              = _SUNXI_CCU_MULT_MIN(8, 8, 12),
>>>> +       .m              = _SUNXI_CCU_DIV(1, 1), /* input divider */
>>>> +       .p              = _SUNXI_CCU_DIV(0, 1), /* output divider */
>>>> +       .common         = {
>>>> +               .reg            = 0x010,
>>>> +               .hw.init        = CLK_HW_INIT("pll-ddr0", "osc24M",
>>>> +                                             &ccu_nkmp_ops,
>>>> +                                             CLK_SET_RATE_UNGATE),
>>>> +       },
>>>> +};
>>>> +
>>>> +#define SUN50I_H616_PLL_DDR1_REG       0x018
>>>> +static struct ccu_nkmp pll_ddr1_clk = {
>>>> +       .enable         = BIT(31),
>>>> +       .lock           = BIT(28),
>>>> +       .n              = _SUNXI_CCU_MULT_MIN(8, 8, 12),
>>>> +       .m              = _SUNXI_CCU_DIV(1, 1), /* input divider */
>>>> +       .p              = _SUNXI_CCU_DIV(0, 1), /* output divider */
>>>> +       .common         = {
>>>> +               .reg            = 0x018,
>>>> +               .hw.init        = CLK_HW_INIT("pll-ddr1", "osc24M",
>>>> +                                             &ccu_nkmp_ops,
>>>> +                                             CLK_SET_RATE_UNGATE),
>>>> +       },
>>>> +};
>>>> +
>>>> +#define SUN50I_H616_PLL_PERIPH0_REG    0x020
>>>> +static struct ccu_nkmp pll_periph0_clk = {
>>>> +       .enable         = BIT(31),
>>>> +       .lock           = BIT(28),
>>>> +       .n              = _SUNXI_CCU_MULT_MIN(8, 8, 12),
>>>> +       .m              = _SUNXI_CCU_DIV(1, 1), /* input divider */
>>>> +       .p              = _SUNXI_CCU_DIV(0, 1), /* output divider */
>>>> +       .fixed_post_div = 4,
>>>> +       .common         = {
>>>> +               .reg            = 0x020,
>>>> +               .features       = CCU_FEATURE_FIXED_POSTDIV,
>>>> +               .hw.init        = CLK_HW_INIT("pll-periph0", "osc24M",
>>>> +                                             &ccu_nkmp_ops,
>>>> +                                             CLK_SET_RATE_UNGATE),
>>>> +       },
>>>> +};
>>>> +
>>>> +#define SUN50I_H616_PLL_PERIPH1_REG    0x028
>>>> +static struct ccu_nkmp pll_periph1_clk = {
>>>> +       .enable         = BIT(31),
>>>> +       .lock           = BIT(28),
>>>> +       .n              = _SUNXI_CCU_MULT_MIN(8, 8, 12),
>>>> +       .m              = _SUNXI_CCU_DIV(1, 1), /* input divider */
>>>> +       .p              = _SUNXI_CCU_DIV(0, 1), /* output divider */
>>>> +       .fixed_post_div = 4,
>>>> +       .common         = {
>>>> +               .reg            = 0x028,
>>>> +               .features       = CCU_FEATURE_FIXED_POSTDIV,
>>>> +               .hw.init        = CLK_HW_INIT("pll-periph1", "osc24M",
>>>> +                                             &ccu_nkmp_ops,
>>>> +                                             CLK_SET_RATE_UNGATE),
>>>> +       },
>>>> +};
>>>> +
>>>> +#define SUN50I_H616_PLL_GPU_REG                0x030
>>>> +static struct ccu_nkmp pll_gpu_clk = {
>>>> +       .enable         = BIT(31),
>>>> +       .lock           = BIT(28),
>>>> +       .n              = _SUNXI_CCU_MULT_MIN(8, 8, 12),
>>>> +       .m              = _SUNXI_CCU_DIV(1, 1), /* input divider */
>>>> +       .p              = _SUNXI_CCU_DIV(0, 1), /* output divider */
>>>> +       .common         = {
>>>> +               .reg            = 0x030,
>>>> +               .hw.init        = CLK_HW_INIT("pll-gpu", "osc24M",
>>>> +                                             &ccu_nkmp_ops,
>>>> +                                             CLK_SET_RATE_UNGATE),
>>>> +       },
>>>> +};
>>>> +
>>>> +/*
>>>> + * For Video PLLs, the output divider is described as "used for testing"
>>>> + * in the user manual. So it's not modelled and forced to 0.
>>>> + */
>>>> +#define SUN50I_H616_PLL_VIDEO0_REG     0x040
>>>> +static struct ccu_nm pll_video0_clk = {
>>>> +       .enable         = BIT(31),
>>>> +       .lock           = BIT(28),
>>>> +       .n              = _SUNXI_CCU_MULT_MIN(8, 8, 12),
>>>> +       .m              = _SUNXI_CCU_DIV(1, 1), /* input divider */
>>>> +       .fixed_post_div = 4,
>>>> +       .min_rate       = 288000000,
>>>> +       .max_rate       = 2400000000UL,
>>>> +       .common         = {
>>>> +               .reg            = 0x040,
>>>> +               .features       = CCU_FEATURE_FIXED_POSTDIV,
>>>> +               .hw.init        = CLK_HW_INIT("pll-video0", "osc24M",
>>>> +                                             &ccu_nm_ops,
>>>> +                                             CLK_SET_RATE_UNGATE),
>>>> +       },
>>>> +};
>>>
>>> FYI the PLL video0 in your code is similar between H6/H616 but it's not
>>> the
>>> same in the vendor kernel.
>>> Vendor says for H6:
>>> pll_video0/pll_video1: 24*N/D1/4
>>> for H616:
>>> pll_video0x4 24*N/D1
>>> pll_video1/pll_video2: 24*N/D1/4
>>
>> I don't see any particular problem with this? I mean we pretty surely
>> have the x4 clock on the H6, and for the H616 the manual agrees to your
>> findings?
>>
>>> I'm not sure if this comment is correct or not.
>>>
>>>> +
>>>> +#define SUN50I_H616_PLL_VIDEO1_REG     0x048
>>>> +static struct ccu_nm pll_video1_clk = {
>>>> +       .enable         = BIT(31),
>>>> +       .lock           = BIT(28),
>>>> +       .n              = _SUNXI_CCU_MULT_MIN(8, 8, 12),
>>>> +       .m              = _SUNXI_CCU_DIV(1, 1), /* input divider */
>>>> +       .fixed_post_div = 4,
>>>> +       .min_rate       = 288000000,
>>>> +       .max_rate       = 2400000000UL,
>>>> +       .common         = {
>>>> +               .reg            = 0x048,
>>>> +               .features       = CCU_FEATURE_FIXED_POSTDIV,
>>>> +               .hw.init        = CLK_HW_INIT("pll-video1", "osc24M",
>>>> +                                             &ccu_nm_ops,
>>>> +                                             CLK_SET_RATE_UNGATE),
>>>> +       },
>>>> +};
>>>> +
>>>> +#define SUN50I_H616_PLL_VIDEO2_REG     0x050
>>>> +static struct ccu_nm pll_video2_clk = {
>>>> +       .enable         = BIT(31),
>>>> +       .lock           = BIT(28),
>>>> +       .n              = _SUNXI_CCU_MULT_MIN(8, 8, 12),
>>>> +       .m              = _SUNXI_CCU_DIV(1, 1), /* input divider */
>>>> +       .fixed_post_div = 4,
>>>> +       .min_rate       = 288000000,
>>>> +       .max_rate       = 2400000000UL,
>>>> +       .common         = {
>>>> +               .reg            = 0x050,
>>>> +               .features       = CCU_FEATURE_FIXED_POSTDIV,
>>>> +               .hw.init        = CLK_HW_INIT("pll-video2", "osc24M",
>>>> +                                             &ccu_nm_ops,
>>>> +                                             CLK_SET_RATE_UNGATE),
>>>> +       },
>>>> +};
>>>
>>> There is also a PLL_CSI. And all the CSI / LCD clocks but they are no
>>> output pins available in the H616.
>>> Maybe we can introduced these clocks later.
>>
>> I don't see good reasons to introduce undocumented and useless clocks at
>> this point.
>> So I will leave this out unless someone protests.
> 
> I'm pretty sure that H616 datasheet describes only subset of functionality 
> supported by die and BSP drivers cover full die functionality.

Yeah, Clément found a comment in the BSP U-Boot that suggests that the
same die is used with different packages. The H700 is mentioned as a
sun50iw9p1 there as well, and this one supports LCD, reportedly.

> Not only here, 
> but everywhere. We can leave them out for now.

Right, we can add them later, maybe using a new clock compatible, like
we do for the H3/H5.

Cheers,
Andre

>>>> +
>>>> +#define SUN50I_H616_PLL_VE_REG         0x058
>>>> +static struct ccu_nkmp pll_ve_clk = {
>>>> +       .enable         = BIT(31),
>>>> +       .lock           = BIT(28),
>>>> +       .n              = _SUNXI_CCU_MULT_MIN(8, 8, 12),
>>>> +       .m              = _SUNXI_CCU_DIV(1, 1), /* input divider */
>>>> +       .p              = _SUNXI_CCU_DIV(0, 1), /* output divider */
>>>> +       .common         = {
>>>> +               .reg            = 0x058,
>>>> +               .hw.init        = CLK_HW_INIT("pll-ve", "osc24M",
>>>> +                                             &ccu_nkmp_ops,
>>>> +                                             CLK_SET_RATE_UNGATE),
>>>> +       },
>>>> +};
>>>> +
>>>> +#define SUN50I_H616_PLL_DE_REG         0x060
>>>> +static struct ccu_nkmp pll_de_clk = {
>>>> +       .enable         = BIT(31),
>>>> +       .lock           = BIT(28),
>>>> +       .n              = _SUNXI_CCU_MULT_MIN(8, 8, 12),
>>>> +       .m              = _SUNXI_CCU_DIV(1, 1), /* input divider */
>>>> +       .p              = _SUNXI_CCU_DIV(0, 1), /* output divider */
>>>> +       .common         = {
>>>> +               .reg            = 0x060,
>>>> +               .hw.init        = CLK_HW_INIT("pll-de", "osc24M",
>>>> +                                             &ccu_nkmp_ops,
>>>> +                                             CLK_SET_RATE_UNGATE),
>>>> +       },
>>>> +};
>>>> +
>>>> +/*
>>>> + * TODO: Determine SDM settings for the audio PLL. The manual suggests
>>>> + * PLL_FACTOR_N=16, PLL_POST_DIV_P=2, OUTPUT_DIV=2, pattern=0xe000c49b
>>>> + * for 24.576 MHz, and PLL_FACTOR_N=22, PLL_POST_DIV_P=3, OUTPUT_DIV=2,
>>>> + * pattern=0xe001288c for 22.5792 MHz.
>>>> + * This clashes with our fixed PLL_POST_DIV_P.
>>>> + */
>>>> +#define SUN50I_H616_PLL_AUDIO_REG      0x078
>>>> +static struct ccu_nm pll_audio_hs_clk = {
>>>> +       .enable         = BIT(31),
>>>> +       .lock           = BIT(28),
>>>> +       .n              = _SUNXI_CCU_MULT_MIN(8, 8, 12),
>>>> +       .m              = _SUNXI_CCU_DIV(1, 1), /* input divider */
>>>> +       .common         = {
>>>> +               .reg            = 0x078,
>>>> +               .hw.init        = CLK_HW_INIT("pll-audio-hs", "osc24M",
>>>> +                                             &ccu_nm_ops,
>>>> +                                             CLK_SET_RATE_UNGATE),
>>>> +       },
>>>> +};
>>>> +
>>>> +static const char * const cpux_parents[] = { "osc24M", "osc32k",
>>>> +                                       "iosc", "pll-cpux", "pll-periph0"
>>>> }; +static SUNXI_CCU_MUX(cpux_clk, "cpux", cpux_parents,
>>>> +                    0x500, 24, 3, CLK_SET_RATE_PARENT |
>>>> CLK_IS_CRITICAL);
>>>> +static SUNXI_CCU_M(axi_clk, "axi", "cpux", 0x500, 0, 2, 0);
>>>> +static SUNXI_CCU_M(cpux_apb_clk, "cpux-apb", "cpux", 0x500, 8, 2, 0);
>>>> +
>>>> +static const char * const psi_ahb1_ahb2_parents[] = { "osc24M",
>>>> "osc32k",
>>>> +                                                     "iosc",
>>>> "pll-periph0" }; +static SUNXI_CCU_MP_WITH_MUX(psi_ahb1_ahb2_clk,
>>>> "psi-ahb1-ahb2",
>>>> +                            psi_ahb1_ahb2_parents,
>>>> +                            0x510,
>>>> +                            0, 2,      /* M */
>>>> +                            8, 2,      /* P */
>>>> +                            24, 2,     /* mux */
>>>> +                            0);
>>>> +
>>>> +static const char * const ahb3_apb1_apb2_parents[] = { "osc24M",
>>>> "osc32k",
>>>> +                                                      "psi-ahb1-ahb2",
>>>> +                                                      "pll-periph0" };
>>>> +static SUNXI_CCU_MP_WITH_MUX(ahb3_clk, "ahb3", ahb3_apb1_apb2_parents,
>>>> 0x51c, +                            0, 2,      /* M */
>>>> +                            8, 2,      /* P */
>>>> +                            24, 2,     /* mux */
>>>> +                            0);
>>>> +
>>>> +static SUNXI_CCU_MP_WITH_MUX(apb1_clk, "apb1", ahb3_apb1_apb2_parents,
>>>> 0x520, +                            0, 2,      /* M */
>>>> +                            8, 2,      /* P */
>>>> +                            24, 2,     /* mux */
>>>> +                            0);
>>>> +
>>>> +static SUNXI_CCU_MP_WITH_MUX(apb2_clk, "apb2", ahb3_apb1_apb2_parents,
>>>> 0x524, +                            0, 2,      /* M */
>>>> +                            8, 2,      /* P */
>>>> +                            24, 2,     /* mux */
>>>> +                            0);
>>>> +
>>>> +static const char * const mbus_parents[] = { "osc24M", "pll-periph0-2x",
>>>> +                                            "pll-ddr0", "pll-ddr1" };
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(mbus_clk, "mbus", mbus_parents, 0x540,
>>>> +                                       0, 3,   /* M */
>>>> +                                       24, 2,  /* mux */
>>>> +                                       BIT(31),        /* gate */
>>>> +                                       CLK_IS_CRITICAL);
>>>> +
>>>> +static const char * const de_parents[] = { "pll-de", "pll-periph0-2x" };
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_parents, 0x600,
>>>> +                                      0, 4,    /* M */
>>>> +                                      24, 1,   /* mux */
>>>> +                                      BIT(31), /* gate */
>>>> +                                      CLK_SET_RATE_PARENT);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_de_clk, "bus-de", "psi-ahb1-ahb2",
>>>> +                     0x60c, BIT(0), 0);
>>>> +
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_clk, "deinterlace",
>>>> +                                      de_parents,
>>>> +                                      0x620,
>>>> +                                      0, 4,    /* M */
>>>> +                                      24, 1,   /* mux */
>>>> +                                      BIT(31), /* gate */
>>>> +                                      0);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_deinterlace_clk, "bus-deinterlace",
>>>> "psi-ahb1-ahb2", +                     0x62c, BIT(0), 0);
>>>> +
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(g2d_clk, "g2d", de_parents, 0x630,
>>>> +                                      0, 4,    /* M */
>>>> +                                      24, 1,   /* mux */
>>>> +                                      BIT(31), /* gate */
>>>> +                                      0);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_g2d_clk, "bus-g2d", "psi-ahb1-ahb2",
>>>> +                     0x63c, BIT(0), 0);
>>>> +
>>>> +static const char * const gpu0_parents[] = { "pll-gpu", "gpu1" };
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(gpu0_clk, "gpu0", gpu0_parents, 0x670,
>>>> +                                      0, 2,    /* M */
>>>> +                                      24, 1,   /* mux */
>>>> +                                      BIT(31), /* gate */
>>>> +                                      CLK_SET_RATE_PARENT);
>>>> +static SUNXI_CCU_M_WITH_GATE(gpu1_clk, "gpu1", "pll-periph0-2x", 0x674,
>>>> +                                       0, 3,   /* M */
>>>
>>> M here should be 0,2
>>
>> Right, good catch.
>>
>>>> +                                       BIT(31),/* gate */
>>>> +                                       0);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_gpu_clk, "bus-gpu", "psi-ahb1-ahb2",
>>>> +                     0x67c, BIT(0), 0);
>>>> +
>>>> +static const char * const ce_parents[] = { "osc24M", "pll-periph0-2x" };
>>>> +static SUNXI_CCU_MP_WITH_MUX_GATE(ce_clk, "ce", ce_parents, 0x680,
>>>> +                                       0, 4,   /* M */
>>>> +                                       8, 2,   /* N */
>>>> +                                       24, 1,  /* mux */
>>>> +                                       BIT(31),/* gate */
>>>> +                                       0);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_ce_clk, "bus-ce", "psi-ahb1-ahb2",
>>>> +                     0x68c, BIT(0), 0);
>>>> +
>>>> +static const char * const ve_parents[] = { "pll-ve" };
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(ve_clk, "ve", ve_parents, 0x690,
>>>> +                                      0, 3,    /* M */
>>>> +                                      24, 1,   /* mux */
>>>> +                                      BIT(31), /* gate */
>>>> +                                      CLK_SET_RATE_PARENT);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_ve_clk, "bus-ve", "psi-ahb1-ahb2",
>>>> +                     0x69c, BIT(0), 0);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_dma_clk, "bus-dma", "psi-ahb1-ahb2",
>>>> +                     0x70c, BIT(0), 0);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_hstimer_clk, "bus-hstimer", "psi-ahb1-ahb2",
>>>> +                     0x73c, BIT(0), 0);
>>>> +
>>>> +static SUNXI_CCU_GATE(avs_clk, "avs", "osc24M", 0x740, BIT(31), 0);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_dbg_clk, "bus-dbg", "psi-ahb1-ahb2",
>>>> +                     0x78c, BIT(0), 0);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_psi_clk, "bus-psi", "psi-ahb1-ahb2",
>>>> +                     0x79c, BIT(0), 0);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_pwm_clk, "bus-pwm", "apb1", 0x7ac, BIT(0), 0);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_iommu_clk, "bus-iommu", "apb1", 0x7bc, BIT(0),
>>>> 0); +
>>>> +static const char * const dram_parents[] = { "pll-ddr0", "pll-ddr1" };
>>>> +static struct ccu_div dram_clk = {
>>>> +       .div            = _SUNXI_CCU_DIV(0, 2),
>>>> +       .mux            = _SUNXI_CCU_MUX(24, 2),
>>>> +       .common = {
>>>> +               .reg            = 0x800,
>>>> +               .hw.init        = CLK_HW_INIT_PARENTS("dram",
>>>> +                                                     dram_parents,
>>>> +                                                     &ccu_div_ops,
>>>> +                                                     CLK_IS_CRITICAL),
>>>> +       },
>>>> +};
>>>> +
>>>> +static SUNXI_CCU_GATE(mbus_dma_clk, "mbus-dma", "mbus",
>>>> +                     0x804, BIT(0), 0);
>>>> +static SUNXI_CCU_GATE(mbus_ve_clk, "mbus-ve", "mbus",
>>>> +                     0x804, BIT(1), 0);
>>>> +static SUNXI_CCU_GATE(mbus_ce_clk, "mbus-ce", "mbus",
>>>> +                     0x804, BIT(2), 0);
>>>> +static SUNXI_CCU_GATE(mbus_ts_clk, "mbus-ts", "mbus",
>>>> +                     0x804, BIT(3), 0);
>>>> +static SUNXI_CCU_GATE(mbus_nand_clk, "mbus-nand", "mbus",
>>>> +                     0x804, BIT(5), 0);
>>>
>>> Compare to H6, you drop mbus-deinterlace but it is present in the vendor
>>> kernel.
>> It's not in the manual (which is what I look at). Not sure I can trust
>> the vendor kernel more here.
> 
> This would need some experimenting.
> 
> Best regards,
> Jernej
> 
>>
>>>> +static SUNXI_CCU_GATE(mbus_g2d_clk, "mbus-g2d", "mbus",
>>>> +                     0x804, BIT(10), 0);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_dram_clk, "bus-dram", "psi-ahb1-ahb2",
>>>> +                     0x80c, BIT(0), CLK_IS_CRITICAL);
>>>> +
>>>> +static const char * const nand_spi_parents[] = { "osc24M",
>>>> "pll-periph0",
>>>> +                                            "pll-periph1",
>>>> "pll-periph0-2x", +                                           
>>>> "pll-periph1-2x" };
>>>> +static SUNXI_CCU_MP_WITH_MUX_GATE(nand0_clk, "nand0", nand_spi_parents,
>>>> 0x810, +                                       0, 4,   /* M */
>>>> +                                       8, 2,   /* N */
>>>> +                                       24, 3,  /* mux */
>>>> +                                       BIT(31),/* gate */
>>>> +                                       0);
>>>> +
>>>> +static SUNXI_CCU_MP_WITH_MUX_GATE(nand1_clk, "nand1", nand_spi_parents,
>>>> 0x814, +                                       0, 4,   /* M */
>>>> +                                       8, 2,   /* N */
>>>> +                                       24, 3,  /* mux */
>>>> +                                       BIT(31),/* gate */
>>>> +                                       0);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_nand_clk, "bus-nand", "ahb3", 0x82c, BIT(0),
>>>> 0);
>>>> +
>>>> +static const char * const mmc_parents[] = { "osc24M", "pll-periph0-2x",
>>>> +                                           "pll-periph1-2x" };
>>>> +static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc0_clk, "mmc0", mmc_parents,
>>>> 0x830, +                                         0, 4,         /* M */
>>>> +                                         8, 2,         /* N */
>>>> +                                         24, 2,        /* mux */
>>>> +                                         BIT(31),      /* gate */
>>>> +                                         2,            /* post-div */
>>>> +                                         0);
>>>> +
>>>> +static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1", mmc_parents,
>>>> 0x834, +                                         0, 4,         /* M */
>>>> +                                         8, 2,         /* N */
>>>> +                                         24, 2,        /* mux */
>>>> +                                         BIT(31),      /* gate */
>>>> +                                         2,            /* post-div */
>>>> +                                         0);
>>>> +
>>>> +static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc2_clk, "mmc2", mmc_parents,
>>>> 0x838, +                                         0, 4,         /* M */
>>>> +                                         8, 2,         /* N */
>>>> +                                         24, 2,        /* mux */
>>>> +                                         BIT(31),      /* gate */
>>>> +                                         2,            /* post-div */
>>>> +                                         0);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_mmc0_clk, "bus-mmc0", "ahb3", 0x84c, BIT(0),
>>>> 0);
>>>> +static SUNXI_CCU_GATE(bus_mmc1_clk, "bus-mmc1", "ahb3", 0x84c, BIT(1),
>>>> 0);
>>>> +static SUNXI_CCU_GATE(bus_mmc2_clk, "bus-mmc2", "ahb3", 0x84c, BIT(2),
>>>> 0);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_uart0_clk, "bus-uart0", "apb2", 0x90c, BIT(0),
>>>> 0); +static SUNXI_CCU_GATE(bus_uart1_clk, "bus-uart1", "apb2", 0x90c,
>>>> BIT(1), 0); +static SUNXI_CCU_GATE(bus_uart2_clk, "bus-uart2", "apb2",
>>>> 0x90c, BIT(2), 0); +static SUNXI_CCU_GATE(bus_uart3_clk, "bus-uart3",
>>>> "apb2", 0x90c, BIT(3), 0); +static SUNXI_CCU_GATE(bus_uart4_clk,
>>>> "bus-uart4", "apb2", 0x90c, BIT(4), 0); +static
>>>> SUNXI_CCU_GATE(bus_uart5_clk, "bus-uart5", "apb2", 0x90c, BIT(5), 0); +
>>>> +static SUNXI_CCU_GATE(bus_i2c0_clk, "bus-i2c0", "apb2", 0x91c, BIT(0),
>>>> 0);
>>>> +static SUNXI_CCU_GATE(bus_i2c1_clk, "bus-i2c1", "apb2", 0x91c, BIT(1),
>>>> 0);
>>>> +static SUNXI_CCU_GATE(bus_i2c2_clk, "bus-i2c2", "apb2", 0x91c, BIT(2),
>>>> 0);
>>>> +static SUNXI_CCU_GATE(bus_i2c3_clk, "bus-i2c3", "apb2", 0x91c, BIT(3),
>>>> 0);
>>>> +static SUNXI_CCU_GATE(bus_i2c4_clk, "bus-i2c4", "apb2", 0x91c, BIT(4),
>>>> 0);
>>>> +
>>>> +static SUNXI_CCU_MP_WITH_MUX_GATE(spi0_clk, "spi0", nand_spi_parents,
>>>> 0x940, +                                       0, 4,   /* M */
>>>> +                                       8, 2,   /* N */
>>>> +                                       24, 3,  /* mux */
>>>> +                                       BIT(31),/* gate */
>>>> +                                       0);
>>>> +
>>>> +static SUNXI_CCU_MP_WITH_MUX_GATE(spi1_clk, "spi1", nand_spi_parents,
>>>> 0x944, +                                       0, 4,   /* M */
>>>> +                                       8, 2,   /* N */
>>>> +                                       24, 3,  /* mux */
>>>> +                                       BIT(31),/* gate */
>>>> +                                       0);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_spi0_clk, "bus-spi0", "ahb3", 0x96c, BIT(0),
>>>> 0);
>>>> +static SUNXI_CCU_GATE(bus_spi1_clk, "bus-spi1", "ahb3", 0x96c, BIT(1),
>>>> 0);
>>>> +
>>>> +static SUNXI_CCU_GATE(emac_25m_clk, "emac-25m", "ahb3", 0x970,
>>>> +                     BIT(31) | BIT(30), 0);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_emac0_clk, "bus-emac0", "ahb3", 0x97c, BIT(0),
>>>> 0); +static SUNXI_CCU_GATE(bus_emac1_clk, "bus-emac1", "ahb3", 0x97c,
>>>> BIT(1), 0); +
>>>> +static const char * const ts_parents[] = { "osc24M", "pll-periph0" };
>>>> +static SUNXI_CCU_MP_WITH_MUX_GATE(ts_clk, "ts", ts_parents, 0x9b0,
>>>> +                                       0, 4,   /* M */
>>>> +                                       8, 2,   /* N */
>>>> +                                       24, 1,  /* mux */
>>>> +                                       BIT(31),/* gate */
>>>> +                                       0);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_ts_clk, "bus-ts", "ahb3", 0x9bc, BIT(0), 0);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_ths_clk, "bus-ths", "apb1", 0x9fc, BIT(0), 0);
>>>> +
>>>> +static const char * const audio_parents[] = { "pll-audio-1x",
>>>> "pll-audio-2x", +                                            
>>>> "pll-audio-4x", "pll-audio-hs" }; +static struct ccu_div spdif_clk = {
>>>> +       .enable         = BIT(31),
>>>> +       .div            = _SUNXI_CCU_DIV_FLAGS(8, 2,
>>>> CLK_DIVIDER_POWER_OF_TWO), +       .mux            = _SUNXI_CCU_MUX(24,
>>>> 2),
>>>> +       .common         = {
>>>> +               .reg            = 0xa20,
>>>> +               .hw.init        = CLK_HW_INIT_PARENTS("spdif",
>>>> +                                                     audio_parents,
>>>> +                                                     &ccu_div_ops,
>>>> +                                                     0),
>>>> +       },
>>>> +};
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_spdif_clk, "bus-spdif", "apb1", 0xa2c, BIT(0),
>>>> 0); +
>>>> +static struct ccu_div dmic_clk = {
>>>> +       .enable         = BIT(31),
>>>> +       .div            = _SUNXI_CCU_DIV_FLAGS(8, 2,
>>>> CLK_DIVIDER_POWER_OF_TWO), +       .mux            = _SUNXI_CCU_MUX(24,
>>>> 2),
>>>> +       .common         = {
>>>> +               .reg            = 0xa40,
>>>> +               .hw.init        = CLK_HW_INIT_PARENTS("dmic",
>>>> +                                                     audio_parents,
>>>> +                                                     &ccu_div_ops,
>>>> +                                                     0),
>>>> +       },
>>>> +};
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_dmic_clk, "bus-dmic", "apb1", 0xa4c, BIT(0),
>>>> 0);
>>>> +
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(audio_codec_1x_clk, "audio-codec-1x",
>>>> +                                audio_parents, 0xa50,
>>>> +                                0, 4,  /* M */
>>>> +                                24, 2, /* mux */
>>>> +                                BIT(31),       /* gate */
>>>> +                                CLK_SET_RATE_PARENT);
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(audio_codec_4x_clk, "audio-codec-4x",
>>>> +                                audio_parents, 0xa54,
>>>> +                                0, 4,  /* M */
>>>> +                                24, 2, /* mux */
>>>> +                                BIT(31),       /* gate */
>>>> +                                CLK_SET_RATE_PARENT);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_audio_codec_clk, "bus-audio-codec", "apb1",
>>>> 0xa5c, +               BIT(0), 0);
>>>> +
>>>> +static struct ccu_div audio_hub_clk = {
>>>> +       .enable         = BIT(31),
>>>> +       .div            = _SUNXI_CCU_DIV_FLAGS(8, 2,
>>>> CLK_DIVIDER_POWER_OF_TWO), +       .mux            = _SUNXI_CCU_MUX(24,
>>>> 2),
>>>> +       .common         = {
>>>> +               .reg            = 0xa60,
>>>> +               .hw.init        = CLK_HW_INIT_PARENTS("audio-hub",
>>>> +                                                     audio_parents,
>>>> +                                                     &ccu_div_ops,
>>>> +                                                     0),
>>>> +       },
>>>> +};
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_audio_hub_clk, "bus-audio-hub", "apb1", 0xa6c,
>>>> BIT(0), 0); +
>>>> +/*
>>>> + * There are OHCI 12M clock source selection bits for 2 USB 2.0 ports.
>>>> + * We will force them to 0 (12M divided from 48M).
>>>> + */
>>>> +#define SUN50I_H616_USB0_CLK_REG               0xa70
>>>> +#define SUN50I_H616_USB1_CLK_REG               0xa74
>>>> +#define SUN50I_H616_USB2_CLK_REG               0xa78
>>>> +#define SUN50I_H616_USB3_CLK_REG               0xa7c
>>>> +
>>>> +static SUNXI_CCU_GATE(usb_ohci0_clk, "usb-ohci0", "osc12M", 0xa70,
>>>> BIT(31), 0); +static SUNXI_CCU_GATE(usb_phy0_clk, "usb-phy0", "osc24M",
>>>> 0xa70, BIT(29), 0); +
>>>> +static SUNXI_CCU_GATE(usb_ohci1_clk, "usb-ohci1", "osc12M", 0xa74,
>>>> BIT(31), 0); +static SUNXI_CCU_GATE(usb_phy1_clk, "usb-phy1", "osc24M",
>>>> 0xa74, BIT(29), 0); +
>>>> +static SUNXI_CCU_GATE(usb_ohci2_clk, "usb-ohci2", "osc12M", 0xa78,
>>>> BIT(31), 0); +static SUNXI_CCU_GATE(usb_phy2_clk, "usb-phy2", "osc24M",
>>>> 0xa78, BIT(29), 0); +
>>>> +static SUNXI_CCU_GATE(usb_ohci3_clk, "usb-ohci3", "osc12M", 0xa7c,
>>>> BIT(31), 0); +static SUNXI_CCU_GATE(usb_phy3_clk, "usb-phy3", "osc12M",
>>>> 0xa7c, BIT(29), 0); +
>>>> +static SUNXI_CCU_GATE(bus_ohci0_clk, "bus-ohci0", "ahb3", 0xa8c, BIT(0),
>>>> 0); +static SUNXI_CCU_GATE(bus_ohci1_clk, "bus-ohci1", "ahb3", 0xa8c,
>>>> BIT(1), 0); +static SUNXI_CCU_GATE(bus_ohci2_clk, "bus-ohci2", "ahb3",
>>>> 0xa8c, BIT(2), 0); +static SUNXI_CCU_GATE(bus_ohci3_clk, "bus-ohci3",
>>>> "ahb3", 0xa8c, BIT(3), 0); +static SUNXI_CCU_GATE(bus_ehci0_clk,
>>>> "bus-ehci0", "ahb3", 0xa8c, BIT(4), 0); +static
>>>> SUNXI_CCU_GATE(bus_ehci1_clk, "bus-ehci1", "ahb3", 0xa8c, BIT(5), 0);
>>>> +static SUNXI_CCU_GATE(bus_ehci2_clk, "bus-ehci2", "ahb3", 0xa8c,
>>>> BIT(6), 0); +static SUNXI_CCU_GATE(bus_ehci3_clk, "bus-ehci3", "ahb3",
>>>> 0xa8c, BIT(7), 0); +static SUNXI_CCU_GATE(bus_otg_clk, "bus-otg",
>>>> "ahb3", 0xa8c, BIT(8), 0); +
>>>> +static SUNXI_CCU_GATE(bus_keyadc_clk, "bus-keyadc", "apb1", 0xa9c,
>>>> BIT(0), 0); +
>>>> +static struct clk_fixed_factor pll_periph0_4x_clk;
>>>> +
>>>> +static const char * const hdmi_parents[] = { "pll-video0",
>>>> "pll-video0-4x", +                                           
>>>> "pll-video2", "pll-video2-4x" }; +static
>>>> SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", hdmi_parents, 0xb00, +      
>>>>                          0, 4,          /* M */
>>>> +                                24, 2,         /* mux */
>>>> +                                BIT(31),       /* gate */
>>>> +                                0);
>>>> +
>>>> +static SUNXI_CCU_GATE(hdmi_slow_clk, "hdmi-slow", "osc24M", 0xb04,
>>>> BIT(31), 0); +
>>>> +static const char * const hdmi_cec_parents[] = { "osc32k",
>>>> "pll-periph0-2x" }; +static const struct ccu_mux_fixed_prediv
>>>> hdmi_cec_predivs[] = {
>>>> +       { .index = 1, .div = 36621 },
>>>> +};
>>>> +
>>>> +#define SUN50I_H616_HDMI_CEC_CLK_REG           0xb10
>>>> +static struct ccu_mux hdmi_cec_clk = {
>>>> +       .enable         = BIT(31),
>>>> +
>>>> +       .mux            = {
>>>> +               .shift  = 24,
>>>> +               .width  = 2,
>>>> +
>>>> +               .fixed_predivs  = hdmi_cec_predivs,
>>>> +               .n_predivs      = ARRAY_SIZE(hdmi_cec_predivs),
>>>> +       },
>>>> +
>>>> +       .common         = {
>>>> +               .reg            = 0xb10,
>>>> +               .features       = CCU_FEATURE_VARIABLE_PREDIV,
>>>> +               .hw.init        = CLK_HW_INIT_PARENTS("hdmi-cec",
>>>> +                                                     hdmi_cec_parents,
>>>> +                                                     &ccu_mux_ops,
>>>> +                                                     0),
>>>> +       },
>>>> +};
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_hdmi_clk, "bus-hdmi", "ahb3", 0xb1c, BIT(0),
>>>> 0);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_tcon_top_clk, "bus-tcon-top", "ahb3",
>>>> +                     0xb5c, BIT(0), 0);
>>>> +
>>>> +static const char * const tcon_tv0_parents[] = { "pll-video0",
>>>> +                                                "pll-video0-4x",
>>>> +                                                "pll-video1",
>>>> +                                                "pll-video1-4x" };
>>>> +static SUNXI_CCU_MP_WITH_MUX_GATE(tcon_tv0_clk, "tcon-tv0",
>>>> +                                 tcon_tv0_parents, 0xb80,
>>>> +                                 0, 4,         /* M */
>>>> +                                 8, 2,         /* P */
>>>> +                                 24, 3,        /* mux */
>>>> +                                 BIT(31),      /* gate */
>>>> +                                 CLK_SET_RATE_PARENT);
>>>> +
>>>> +static SUNXI_CCU_GATE(bus_tcon_tv0_clk, "bus-tcon-tv0", "ahb3",
>>>> +                     0xb9c, BIT(0), 0);
>>>
>>> The TV1 clk is missing here
>>
>> Right, and some more TV encoder related.
>>
>> Cheers,
>> Andre
> 
> 
> 
> 
> 

