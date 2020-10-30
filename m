Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6512A00AA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgJ3JEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:04:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:37914 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgJ3JET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:04:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17916AF27;
        Fri, 30 Oct 2020 09:04:13 +0000 (UTC)
Subject: Re: [PATCH v5 1/1] arm64: dts: Add Mediatek SoC MT8192 and evaluation
 board dts and Makefile
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     Seiya Wang <seiya.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
References: <20201027102652.12806-1-seiya.wang@mediatek.com>
 <20201027102652.12806-2-seiya.wang@mediatek.com>
 <5695b5cb-c57d-f6de-27b7-e9c2de6a088d@gmail.com>
Message-ID: <c51090c5-46ce-7779-fd6b-df38dc7ba7c1@gmail.com>
Date:   Fri, 30 Oct 2020 10:04:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5695b5cb-c57d-f6de-27b7-e9c2de6a088d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2020 16:50, Matthias Brugger wrote:
> 
> 
> On 27/10/2020 11:26, Seiya Wang wrote:
>> Add basic chip support for Mediatek MT8192
>>
>> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> 
> Pushed to v5.10-next/dts64
> 
> Thanks!
> 
>> ---
>>   arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>>   arch/arm64/boot/dts/mediatek/mt8192-evb.dts |  29 ++
>>   arch/arm64/boot/dts/mediatek/mt8192.dtsi    | 513 ++++++++++++++++++++++++++++
>>   3 files changed, 543 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-evb.dts
>>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile 
>> b/arch/arm64/boot/dts/mediatek/Makefile
>> index 3ee682c266cc..b431ee2d6cac 100644
>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>> @@ -12,4 +12,5 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana-rev7.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-evb.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-evb.dts 
>> b/arch/arm64/boot/dts/mediatek/mt8192-evb.dts
>> new file mode 100644
>> index 000000000000..0205837fa698
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/mediatek/mt8192-evb.dts
>> @@ -0,0 +1,29 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +/*
>> + * Copyright (C) 2020 MediaTek Inc.
>> + * Author: Seiya Wang <seiya.wang@mediatek.com>
>> + */
>> +/dts-v1/;
>> +#include "mt8192.dtsi"
>> +
>> +/ {
>> +    model = "MediaTek MT8192 evaluation board";
>> +    compatible = "mediatek,mt8192-evb", "mediatek,mt8192";
>> +
>> +    aliases {
>> +        serial0 = &uart0;
>> +    };
>> +
>> +    chosen {
>> +        stdout-path = "serial0:921600n8";
>> +    };
>> +
>> +    memory@40000000 {
>> +        device_type = "memory";
>> +        reg = <0 0x40000000 0 0x80000000>;
>> +    };
>> +};
>> +
>> +&uart0 {
>> +    status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi 
>> b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>> new file mode 100644
>> index 000000000000..648f0f269b8b
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>> @@ -0,0 +1,513 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +/*
>> + * Copyright (C) 2020 MediaTek Inc.
>> + * Author: Seiya Wang <seiya.wang@mediatek.com>
>> + */
>> +
>> +/dts-v1/;
>> +#include <dt-bindings/clock/mt8192-clk.h>

AFAIK the clock driver is not upstream.
Did you tried to compile this at least?

I dropped it for now. If you want to get that in without the clock driver bein 
accepted first, you will need to fix this patch. And please make sure it 
compiles against v5.10-rc1

Regards,
Matthias

>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/pinctrl/mt8192-pinfunc.h>
>> +
>> +/ {
>> +    compatible = "mediatek,mt8192";
>> +    interrupt-parent = <&gic>;
>> +    #address-cells = <2>;
>> +    #size-cells = <2>;
>> +
>> +    clk26m: oscillator0 {
>> +        compatible = "fixed-clock";
>> +        #clock-cells = <0>;
>> +        clock-frequency = <26000000>;
>> +        clock-output-names = "clk26m";
>> +    };
>> +
>> +    clk32k: oscillator1 {
>> +        compatible = "fixed-clock";
>> +        #clock-cells = <0>;
>> +        clock-frequency = <32768>;
>> +        clock-output-names = "clk32k";
>> +    };
>> +
>> +    cpus {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        cpu0: cpu@0 {
>> +            device_type = "cpu";
>> +            compatible = "arm,cortex-a55";
>> +            reg = <0x000>;
>> +            enable-method = "psci";
>> +            clock-frequency = <1701000000>;
>> +            next-level-cache = <&l2_0>;
>> +            capacity-dmips-mhz = <530>;
>> +        };
>> +
>> +        cpu1: cpu@100 {
>> +            device_type = "cpu";
>> +            compatible = "arm,cortex-a55";
>> +            reg = <0x100>;
>> +            enable-method = "psci";
>> +            clock-frequency = <1701000000>;
>> +            next-level-cache = <&l2_0>;
>> +            capacity-dmips-mhz = <530>;
>> +        };
>> +
>> +        cpu2: cpu@200 {
>> +            device_type = "cpu";
>> +            compatible = "arm,cortex-a55";
>> +            reg = <0x200>;
>> +            enable-method = "psci";
>> +            clock-frequency = <1701000000>;
>> +            next-level-cache = <&l2_0>;
>> +            capacity-dmips-mhz = <530>;
>> +        };
>> +
>> +        cpu3: cpu@300 {
>> +            device_type = "cpu";
>> +            compatible = "arm,cortex-a55";
>> +            reg = <0x300>;
>> +            enable-method = "psci";
>> +            clock-frequency = <1701000000>;
>> +            next-level-cache = <&l2_0>;
>> +            capacity-dmips-mhz = <530>;
>> +        };
>> +
>> +        cpu4: cpu@400 {
>> +            device_type = "cpu";
>> +            compatible = "arm,cortex-a76";
>> +            reg = <0x400>;
>> +            enable-method = "psci";
>> +            clock-frequency = <2171000000>;
>> +            next-level-cache = <&l2_1>;
>> +            capacity-dmips-mhz = <1024>;
>> +        };
>> +
>> +        cpu5: cpu@500 {
>> +            device_type = "cpu";
>> +            compatible = "arm,cortex-a76";
>> +            reg = <0x500>;
>> +            enable-method = "psci";
>> +            clock-frequency = <2171000000>;
>> +            next-level-cache = <&l2_1>;
>> +            capacity-dmips-mhz = <1024>;
>> +        };
>> +
>> +        cpu6: cpu@600 {
>> +            device_type = "cpu";
>> +            compatible = "arm,cortex-a76";
>> +            reg = <0x600>;
>> +            enable-method = "psci";
>> +            clock-frequency = <2171000000>;
>> +            next-level-cache = <&l2_1>;
>> +            capacity-dmips-mhz = <1024>;
>> +        };
>> +
>> +        cpu7: cpu@700 {
>> +            device_type = "cpu";
>> +            compatible = "arm,cortex-a76";
>> +            reg = <0x700>;
>> +            enable-method = "psci";
>> +            clock-frequency = <2171000000>;
>> +            next-level-cache = <&l2_1>;
>> +            capacity-dmips-mhz = <1024>;
>> +        };
>> +
>> +        cpu-map {
>> +            cluster0 {
>> +                core0 {
>> +                    cpu = <&cpu0>;
>> +                };
>> +                core1 {
>> +                    cpu = <&cpu1>;
>> +                };
>> +                core2 {
>> +                    cpu = <&cpu2>;
>> +                };
>> +                core3 {
>> +                    cpu = <&cpu3>;
>> +                };
>> +            };
>> +
>> +            cluster1 {
>> +                core0 {
>> +                    cpu = <&cpu4>;
>> +                };
>> +                core1 {
>> +                    cpu = <&cpu5>;
>> +                };
>> +                core2 {
>> +                    cpu = <&cpu6>;
>> +                };
>> +                core3 {
>> +                    cpu = <&cpu7>;
>> +                };
>> +            };
>> +        };
>> +
>> +        l2_0: l2-cache0 {
>> +            compatible = "cache";
>> +            next-level-cache = <&l3_0>;
>> +        };
>> +
>> +        l2_1: l2-cache1 {
>> +            compatible = "cache";
>> +            next-level-cache = <&l3_0>;
>> +        };
>> +
>> +        l3_0: l3-cache {
>> +            compatible = "cache";
>> +        };
>> +    };
>> +
>> +    pmu-a55 {
>> +        compatible = "arm,cortex-a55-pmu";
>> +        interrupt-parent = <&gic>;
>> +        interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_cluster0>;
>> +    };
>> +
>> +    pmu-a76 {
>> +        compatible = "arm,cortex-a76-pmu";
>> +        interrupt-parent = <&gic>;
>> +        interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_cluster1>;
>> +    };
>> +
>> +    psci {
>> +        compatible = "arm,psci-1.0";
>> +        method = "smc";
>> +    };
>> +
>> +    timer: timer {
>> +        compatible = "arm,armv8-timer";
>> +        interrupt-parent = <&gic>;
>> +        interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                 <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                 <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                 <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
>> +        clock-frequency = <13000000>;
>> +    };
>> +
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        compatible = "simple-bus";
>> +        ranges;
>> +
>> +        gic: interrupt-controller@c000000 {
>> +            compatible = "arm,gic-v3";
>> +            #interrupt-cells = <4>;
>> +            #redistributor-regions = <1>;
>> +            interrupt-parent = <&gic>;
>> +            interrupt-controller;
>> +            reg = <0 0x0c000000 0 0x40000>,
>> +                  <0 0x0c040000 0 0x200000>;
>> +            interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
>> +
>> +            ppi-partitions {
>> +                ppi_cluster0: interrupt-partition-0 {
>> +                    affinity = <&cpu0 &cpu1 &cpu2 &cpu3>;
>> +                };
>> +                ppi_cluster1: interrupt-partition-1 {
>> +                    affinity = <&cpu4 &cpu5 &cpu6 &cpu7>;
>> +                };
>> +            };
>> +        };
>> +
>> +        pio: pinctrl@10005000 {
>> +            compatible = "mediatek,mt8192-pinctrl";
>> +            reg = <0 0x10005000 0 0x1000>,
>> +                  <0 0x11c20000 0 0x1000>,
>> +                  <0 0x11d10000 0 0x1000>,
>> +                  <0 0x11d30000 0 0x1000>,
>> +                  <0 0x11d40000 0 0x1000>,
>> +                  <0 0x11e20000 0 0x1000>,
>> +                  <0 0x11e70000 0 0x1000>,
>> +                  <0 0x11ea0000 0 0x1000>,
>> +                  <0 0x11f20000 0 0x1000>,
>> +                  <0 0x11f30000 0 0x1000>,
>> +                  <0 0x1000b000 0 0x1000>;
>> +            reg-names = "iocfg0", "iocfg_rm", "iocfg_bm",
>> +                    "iocfg_bl", "iocfg_br", "iocfg_lm",
>> +                    "iocfg_lb", "iocfg_rt", "iocfg_lt",
>> +                    "iocfg_tl", "eint";
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +            gpio-ranges = <&pio 0 0 220>;
>> +            interrupt-controller;
>> +            interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            #interrupt-cells = <2>;
>> +        };
>> +
>> +        systimer: timer@10017000 {
>> +            compatible = "mediatek,mt8192-timer",
>> +                     "mediatek,mt6765-timer";
>> +            reg = <0 0x10017000 0 0x1000>;
>> +            interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&topckgen CLK_TOP_CSW_F26M_D2>;
>> +            clock-names = "clk13m";
>> +        };
>> +
>> +        uart0: serial@11002000 {
>> +            compatible = "mediatek,mt8192-uart",
>> +                     "mediatek,mt6577-uart";
>> +            reg = <0 0x11002000 0 0x1000>;
>> +            interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&clk26m>, <&clk26m>;
>> +            clock-names = "baud", "bus";
>> +            status = "disabled";
>> +        };
>> +
>> +        uart1: serial@11003000 {
>> +            compatible = "mediatek,mt8192-uart",
>> +                     "mediatek,mt6577-uart";
>> +            reg = <0 0x11003000 0 0x1000>;
>> +            interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&clk26m>, <&clk26m>;
>> +            clock-names = "baud", "bus";
>> +            status = "disabled";
>> +        };
>> +
>> +        spi0: spi@1100a000 {
>> +            compatible = "mediatek,mt8192-spi",
>> +                     "mediatek,mt6765-spi";
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            reg = <0 0x1100a000 0 0x1000>;
>> +            interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
>> +                 <&topckgen CLK_TOP_SPI_SEL>,
>> +                 <&infracfg CLK_INFRA_SPI0>;
>> +            clock-names = "parent-clk", "sel-clk", "spi-clk";
>> +            status = "disabled";
>> +        };
>> +
>> +        spi1: spi@11010000 {
>> +            compatible = "mediatek,mt8192-spi",
>> +                     "mediatek,mt6765-spi";
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            reg = <0 0x11010000 0 0x1000>;
>> +            interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
>> +                 <&topckgen CLK_TOP_SPI_SEL>,
>> +                 <&infracfg CLK_INFRA_SPI1>;
>> +            clock-names = "parent-clk", "sel-clk", "spi-clk";
>> +            status = "disabled";
>> +        };
>> +
>> +        spi2: spi@11012000 {
>> +            compatible = "mediatek,mt8192-spi",
>> +                     "mediatek,mt6765-spi";
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            reg = <0 0x11012000 0 0x1000>;
>> +            interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
>> +                 <&topckgen CLK_TOP_SPI_SEL>,
>> +                 <&infracfg CLK_INFRA_SPI2>;
>> +            clock-names = "parent-clk", "sel-clk", "spi-clk";
>> +            status = "disabled";
>> +        };
>> +
>> +        spi3: spi@11013000 {
>> +            compatible = "mediatek,mt8192-spi",
>> +                     "mediatek,mt6765-spi";
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            reg = <0 0x11013000 0 0x1000>;
>> +            interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
>> +                 <&topckgen CLK_TOP_SPI_SEL>,
>> +                 <&infracfg CLK_INFRA_SPI3>;
>> +            clock-names = "parent-clk", "sel-clk", "spi-clk";
>> +            status = "disabled";
>> +        };
>> +
>> +        spi4: spi@11018000 {
>> +            compatible = "mediatek,mt8192-spi",
>> +                     "mediatek,mt6765-spi";
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            reg = <0 0x11018000 0 0x1000>;
>> +            interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
>> +                 <&topckgen CLK_TOP_SPI_SEL>,
>> +                 <&infracfg CLK_INFRA_SPI4>;
>> +            clock-names = "parent-clk", "sel-clk", "spi-clk";
>> +            status = "disabled";
>> +        };
>> +
>> +        spi5: spi@11019000 {
>> +            compatible = "mediatek,mt8192-spi",
>> +                     "mediatek,mt6765-spi";
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            reg = <0 0x11019000 0 0x1000>;
>> +            interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
>> +                 <&topckgen CLK_TOP_SPI_SEL>,
>> +                 <&infracfg CLK_INFRA_SPI5>;
>> +            clock-names = "parent-clk", "sel-clk", "spi-clk";
>> +            status = "disabled";
>> +        };
>> +
>> +        spi6: spi@1101d000 {
>> +            compatible = "mediatek,mt8192-spi",
>> +                     "mediatek,mt6765-spi";
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            reg = <0 0x1101d000 0 0x1000>;
>> +            interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
>> +                 <&topckgen CLK_TOP_SPI_SEL>,
>> +                 <&infracfg CLK_INFRA_SPI6>;
>> +            clock-names = "parent-clk", "sel-clk", "spi-clk";
>> +            status = "disabled";
>> +        };
>> +
>> +        spi7: spi@1101e000 {
>> +            compatible = "mediatek,mt8192-spi",
>> +                     "mediatek,mt6765-spi";
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            reg = <0 0x1101e000 0 0x1000>;
>> +            interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
>> +                 <&topckgen CLK_TOP_SPI_SEL>,
>> +                 <&infracfg CLK_INFRA_SPI7>;
>> +            clock-names = "parent-clk", "sel-clk", "spi-clk";
>> +            status = "disabled";
>> +        };
>> +
>> +        i2c3: i2c3@11cb0000 {
>> +            compatible = "mediatek,mt8192-i2c";
>> +            reg = <0 0x11cb0000 0 0x1000>,
>> +                  <0 0x10217300 0 0x80>;
>> +            interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&clk26m>, <&clk26m>;
>> +            clock-names = "main", "dma";
>> +            clock-div = <1>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            status = "disabled";
>> +        };
>> +
>> +        i2c7: i2c7@11d00000 {
>> +            compatible = "mediatek,mt8192-i2c";
>> +            reg = <0 0x11d00000 0 0x1000>,
>> +                  <0 0x10217600 0 0x180>;
>> +            interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&clk26m>, <&clk26m>;
>> +            clock-names = "main", "dma";
>> +            clock-div = <1>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            status = "disabled";
>> +        };
>> +
>> +        i2c8: i2c8@11d01000 {
>> +            compatible = "mediatek,mt8192-i2c";
>> +            reg = <0 0x11d01000 0 0x1000>,
>> +                  <0 0x10217780 0 0x180>;
>> +            interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&clk26m>, <&clk26m>;
>> +            clock-names = "main", "dma";
>> +            clock-div = <1>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            status = "disabled";
>> +        };
>> +
>> +        i2c9: i2c9@11d02000 {
>> +            compatible = "mediatek,mt8192-i2c";
>> +            reg = <0 0x11d02000 0 0x1000>,
>> +                  <0 0x10217900 0 0x180>;
>> +            interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&clk26m>, <&clk26m>;
>> +            clock-names = "main", "dma";
>> +            clock-div = <1>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            status = "disabled";
>> +        };
>> +
>> +        i2c1: i2c1@11d20000 {
>> +            compatible = "mediatek,mt8192-i2c";
>> +            reg = <0 0x11d20000 0 0x1000>,
>> +                  <0 0x10217100 0 0x80>;
>> +            interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&clk26m>, <&clk26m>;
>> +            clock-names = "main", "dma";
>> +            clock-div = <1>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            status = "disabled";
>> +        };
>> +
>> +        i2c2: i2c2@11d21000 {
>> +            compatible = "mediatek,mt8192-i2c";
>> +            reg = <0 0x11d21000 0 0x1000>,
>> +                  <0 0x10217180 0 0x180>;
>> +            interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&clk26m>, <&clk26m>;
>> +            clock-names = "main", "dma";
>> +            clock-div = <1>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            status = "disabled";
>> +        };
>> +
>> +        i2c4: i2c4@11d22000 {
>> +            compatible = "mediatek,mt8192-i2c";
>> +            reg = <0 0x11d22000 0 0x1000>,
>> +                  <0 0x10217380 0 0x180>;
>> +            interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&clk26m>, <&clk26m>;
>> +            clock-names = "main", "dma";
>> +            clock-div = <1>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            status = "disabled";
>> +        };
>> +
>> +        i2c5: i2c5@11e00000 {
>> +            compatible = "mediatek,mt8192-i2c";
>> +            reg = <0 0x11e00000 0 0x1000>,
>> +                  <0 0x10217500 0 0x80>;
>> +            interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&clk26m>, <&clk26m>;
>> +            clock-names = "main", "dma";
>> +            clock-div = <1>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            status = "disabled";
>> +        };
>> +
>> +        i2c0: i2c0@11f00000 {
>> +            compatible = "mediatek,mt8192-i2c";
>> +            reg = <0 0x11f00000 0 0x1000>,
>> +                  <0 0x10217080 0 0x80>;
>> +            interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&clk26m>, <&clk26m>;
>> +            clock-names = "main", "dma";
>> +            clock-div = <1>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            status = "disabled";
>> +        };
>> +
>> +        i2c6: i2c6@11f01000 {
>> +            compatible = "mediatek,mt8192-i2c";
>> +            reg = <0 0x11f01000 0 0x1000>,
>> +                  <0 0x10217580 0 0x80>;
>> +            interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&clk26m>, <&clk26m>;
>> +            clock-names = "main", "dma";
>> +            clock-div = <1>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            status = "disabled";
>> +        };
>> +    };
>> +};
>>

