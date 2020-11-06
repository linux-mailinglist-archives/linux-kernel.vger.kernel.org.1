Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3FB2A9017
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgKFHOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgKFHOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:14:36 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A57EC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 23:14:36 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id h6so255694pgk.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 23:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Rg0EN28djJajksONUjeXPHXvqnhXBN9T5cRyaaTmlF0=;
        b=DqraHvS5Y/6Bp0vVkcXw/2NlomaBQXZei/MBfPL4OHVVGSxitb8GKP1gcSc9HWebfN
         sOHyUP8SF/ADqGITrPtUDqJxca+ZmZgw1WZdtTO5xr0R/LA7ekm+qrirmFZM7+AETmd+
         /YMK8agD4zylnBhXA7ki+XcXhpZ25BGslhJ/DZeq1v9QvGRD2eXg5a+n8QKQfycL42T9
         aJwDz266mHqwGqAIdYdx+usQUH8J4qOGHXNUAx6ZttPjZx53mhpX7TwwVCjPt0AO6CLD
         fJH5PVkuQfCJj3L+dETivvqAdMZHsKU3RDo4tLdLh7u5zgJ6pPU+oT7LIu0t+4GUAwzS
         gRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Rg0EN28djJajksONUjeXPHXvqnhXBN9T5cRyaaTmlF0=;
        b=Ng3/ASetVAd064PYl/MoSwuJh8+8tkBfoMkEeOzLpcwBq2mLcbFGa8G3/VCg8SI4na
         /797+bLxZEU4hcqUSq6ZQvSBa1DtL653Nh66ougDFcYk5ER4j5jlyteJ6lv4VZJTw+zC
         60/F7Ua0gVsg3SP6wuPsLjPm9uI3W/vz/L9xefNfJeXzbfJ0k2xAbP9+K2Fsu6eSHEvJ
         URdKz4yBWMhfdGhl6Bi/FoGPAbFv7LnPpoQG6dyWJBXQS8mLc5QgoIoUdt6QWzOQWqbQ
         TIxB8eVZ0a706BfRjxy6XhxgRUs7TcvYXEyekfPBIP6BomKFtSBRLImxBcwLDV6W23t2
         qcuA==
X-Gm-Message-State: AOAM532QjXY6ey3Yr5wVA3SflP04WGq87nAbk6nOvwm54LA34A3e2aGA
        RQbmB4YavZlKatSv8BqhsSpvduo+uOuYu0uE
X-Google-Smtp-Source: ABdhPJxiW5gufWgr8D/wCVPq1ErmxQIZQuiMltRK5N7k+d0zcINudCHswSVGed+yN2bATgeF4jKWnw==
X-Received: by 2002:a62:7781:0:b029:18b:5c31:5c27 with SMTP id s123-20020a6277810000b029018b5c315c27mr807702pfc.70.1604646875458;
        Thu, 05 Nov 2020 23:14:35 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e81sm841878pfh.104.2020.11.05.23.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 23:14:34 -0800 (PST)
Date:   Thu, 05 Nov 2020 23:14:34 -0800 (PST)
X-Google-Original-Date: Thu, 05 Nov 2020 23:10:34 PST (-0800)
Subject:     Re: [RFC PATCH 2/3] RISC-V: Initial DTS for Microchip ICICLE board
In-Reply-To: <20201028232759.1928479-3-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        padmarao.begari@microchip.com, daire.mcnamara@microchip.com,
        Cyril.Jean@microchip.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>, robh+dt@kernel.org
Message-ID: <mhng-8e51694c-a6c7-4a2f-99f9-1617e1220833@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 16:27:58 PDT (-0700), Atish Patra wrote:
> Add initial DTS for Microchip ICICLE board having only
> essential devcies (clocks, sdhci, ethernet, serial, etc).

This fails `make dtbs_check`.  The fu540 fails too, so I guess it's not exactly
fair, though.

>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/boot/dts/Makefile                  |   1 +
>  arch/riscv/boot/dts/microchip/Makefile        |   2 +
>  .../microchip/microchip-icicle-kit-a000.dts   | 313 ++++++++++++++++++
>  3 files changed, 316 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/microchip/Makefile
>  create mode 100644 arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dts
>
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index ca1f8cbd78c0..3ea94ea0a18a 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  subdir-y += sifive
>  subdir-y += kendryte
> +subdir-y += microchip
>
>  obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
> diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
> new file mode 100644
> index 000000000000..55ad77521304
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += microchip-icicle-kit-a000.dtb
> diff --git a/arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dts b/arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dts
> new file mode 100644
> index 000000000000..5848920af55c
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dts
> @@ -0,0 +1,313 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (c) 2020 Microchip Technology Inc */
> +
> +/dts-v1/;
> +
> +/* Clock frequency (in Hz) of the rtcclk */
> +#define RTCCLK_FREQ		1000000
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	model = "Microchip PolarFire-SoC";
> +	compatible = "microchip,polarfire-soc";
> +
> +	chosen {
> +		stdout-path = &serial0;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		timebase-frequency = <RTCCLK_FREQ>;
> +
> +		cpu@0 {
> +			clock-frequency = <0>;
> +			compatible = "sifive,rocket0", "riscv";
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <128>;
> +			i-cache-size = <16384>;
> +			reg = <0>;
> +			riscv,isa = "rv64imac";
> +			status = "disabled";
> +
> +			cpu0_intc: interrupt-controller {
> +				#interrupt-cells = <1>;
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu@1 {
> +			clock-frequency = <0>;
> +			compatible = "sifive,rocket0", "riscv";
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <64>;
> +			d-cache-size = <32768>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <32>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <64>;
> +			i-cache-size = <32768>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <32>;
> +			mmu-type = "riscv,sv39";
> +			reg = <1>;
> +			riscv,isa = "rv64imafdc";
> +			tlb-split;
> +			status = "okay";
> +
> +			cpu1_intc: interrupt-controller {
> +				#interrupt-cells = <1>;
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu@2 {
> +			clock-frequency = <0>;
> +			compatible = "sifive,rocket0", "riscv";
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <64>;
> +			d-cache-size = <32768>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <32>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <64>;
> +			i-cache-size = <32768>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <32>;
> +			mmu-type = "riscv,sv39";
> +			reg = <2>;
> +			riscv,isa = "rv64imafdc";
> +			tlb-split;
> +			status = "okay";
> +
> +			cpu2_intc: interrupt-controller {
> +				#interrupt-cells = <1>;
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu@3 {
> +			clock-frequency = <0>;
> +			compatible = "sifive,rocket0", "riscv";
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <64>;
> +			d-cache-size = <32768>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <32>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <64>;
> +			i-cache-size = <32768>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <32>;
> +			mmu-type = "riscv,sv39";
> +			reg = <3>;
> +			riscv,isa = "rv64imafdc";
> +			tlb-split;
> +			status = "okay";
> +
> +			cpu3_intc: interrupt-controller {
> +				#interrupt-cells = <1>;
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu@4 {
> +			clock-frequency = <0>;
> +			compatible = "sifive,rocket0", "riscv";
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <64>;
> +			d-cache-size = <32768>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <32>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <64>;
> +			i-cache-size = <32768>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <32>;
> +			mmu-type = "riscv,sv39";
> +			reg = <4>;
> +			riscv,isa = "rv64imafdc";
> +			tlb-split;
> +			status = "okay";
> +			cpu4_intc: interrupt-controller {
> +				#interrupt-cells = <1>;
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +			};
> +		};
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x40000000>;
> +		clocks = <&clkcfg 26>;
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		cache-controller@2010000 {
> +			compatible = "sifive,fu540-c000-ccache", "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-sets = <1024>;
> +			cache-size = <2097152>;
> +			cache-unified;
> +			interrupt-parent = <&plic>;
> +			interrupts = <1 2 3>;
> +			reg = <0x0 0x2010000 0x0 0x1000>;
> +		};
> +
> +		clint@2000000 {
> +			compatible = "riscv,clint0";
> +			reg = <0x0 0x2000000 0x0 0xC000>;
> +			interrupts-extended = <&cpu0_intc 3 &cpu0_intc 7
> +						&cpu1_intc 3 &cpu1_intc 7
> +						&cpu2_intc 3 &cpu2_intc 7
> +						&cpu3_intc 3 &cpu3_intc 7
> +						&cpu4_intc 3 &cpu4_intc 7>;
> +		};
> +
> +		plic: interrupt-controller@c000000 {
> +			#interrupt-cells = <1>;
> +			compatible = "sifive,plic-1.0.0";
> +			reg = <0x0 0xc000000 0x0 0x4000000>;
> +			riscv,ndev = <53>;
> +			interrupt-controller;
> +			interrupts-extended = <&cpu0_intc 11
> +					&cpu1_intc 11 &cpu1_intc 9
> +					&cpu2_intc 11 &cpu2_intc 9
> +					&cpu3_intc 11 &cpu3_intc 9
> +					&cpu4_intc 11 &cpu4_intc 9>;
> +		};
> +
> +		dma@3000000 {
> +			compatible = "sifive,fu540-c000-pdma";
> +			reg = <0x0 0x3000000 0x0 0x8000>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <23 24 25 26 27 28 29 30>;
> +			#dma-cells = <1>;
> +		};
> +
> +		refclk: refclk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <600000000>;
> +			clock-output-names = "msspllclk";
> +		};
> +
> +		clkcfg: clkcfg@20002000 {
> +			compatible = "microchip,pfsoc-clkcfg";
> +			reg = <0x0 0x20002000 0x0 0x1000>;
> +			reg-names = "mss_sysreg";
> +			clocks = <&refclk>;
> +			#clock-cells = <1>;
> +			clock-output-names = "cpuclk", "axiclk", "ahbclk", "ENVMclk", "MAC0clk", "MAC1clk", "MMCclk", "TIMERclk", "MMUART0clk", "MMUART1clk", "MMUART2clk", "MMUART3clk", "MMUART4clk", "SPI0clk", "SPI1clk", "I2C0clk", "I2C1clk", "CAN0clk", "CAN1clk", "USBclk", "RESERVED", "RTCclk", "QSPIclk", "GPIO0clk", "GPIO1clk", "GPIO2clk", "DDRCclk", "FIC0clk", "FIC1clk", "FIC2clk", "FIC3clk", "ATHENAclk", "CFMclk";
> +		};
> +
> +		serial0: serial@20000000 {
> +			compatible = "ns16550a";
> +			reg = <0x0 0x20000000 0x0 0x400>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <90>;
> +			current-speed = <115200>;
> +			clocks = <&clkcfg 8>;
> +			status = "okay";
> +		};
> +
> +		serial1: serial@20100000 {
> +			compatible = "ns16550a";
> +			reg = <0x0 0x20100000 0x0 0x400>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <91>;
> +			current-speed = <115200>;
> +			clocks = <&clkcfg 9>;
> +			status = "okay";
> +		};
> +
> +		serial2: serial@20102000 {
> +			compatible = "ns16550a";
> +			reg = <0x0 0x20102000 0x0 0x400>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <92>;
> +			current-speed = <115200>;
> +			clocks = <&clkcfg 10>;
> +			status = "okay";
> +		};
> +
> +		serial3: serial@20104000 {
> +			compatible = "ns16550a";
> +			reg = <0x0 0x20104000 0x0 0x400>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <93>;
> +			current-speed = <115200>;
> +			clocks = <&clkcfg 11>;
> +			status = "okay";
> +		};
> +
> +		sdcard: sdhc@20008000 {
> +			compatible = "cdns,sd4hc";
> +			reg = <0x0 0x20008000 0x0 0x1000>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <88>;
> +			pinctrl-names = "default";
> +			clocks = <&clkcfg 6>;
> +			bus-width = <4>;
> +			disable-wp;
> +			no-1-8-v;
> +			cap-mmc-highspeed;
> +			cap-sd-highspeed;
> +			card-detect-delay = <200>;
> +			sd-uhs-sdr12;
> +			sd-uhs-sdr25;
> +			sd-uhs-sdr50;
> +			sd-uhs-sdr104;
> +			max-frequency = <200000000>;
> +			status = "okay";
> +		};
> +
> +		emac1: ethernet@20112000 {
> +			compatible = "cdns,macb";
> +			reg = <0x0 0x20112000 0x0 0x2000>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <70 71 72 73>;
> +			mac-address = [56 34 12 00 FC 00];
> +			phy-mode = "sgmii";
> +			clocks = <&clkcfg 5>, <&clkcfg 2>;
> +			clock-names = "pclk", "hclk";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			phy1: ethernet-phy@9 {
> +				reg = <9>;
> +				ti,fifo-depth = <0x01>;
> +			};
> +		};
> +
> +		uio_axi_lsram@2030000000 {
> +			compatible = "generic-uio";
> +			reg = <0x20 0x30000000 0 0x80000000 >;
> +			status = "okay";
> +		};
> +	};
> +};
