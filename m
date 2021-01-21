Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1772FF080
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387961AbhAUQgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 11:36:32 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59174 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387838AbhAUQgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:36:15 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10LGYY9Z015105;
        Thu, 21 Jan 2021 10:34:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611246874;
        bh=0C95p2TJTee5NxsyRqKfLfHSXpWD72818vOy9G5u+38=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FH8Xhebb3350iM8nhIDQOnYQxWmoOTkgmoitHE8kxCyvg7xTpSt3686nNM9Z9dVRE
         Dk3d7VwtM1jZYfUBDWr/uGU/4+QfQt+ErnceXkBQcx8nOeZirg/5e/h7xE5YGthAhm
         f7bJ7aZzGKXs1Glgz7r3ECrwE4tW5QTzjm4HBX44=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10LGYYDs048024
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Jan 2021 10:34:34 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 Jan 2021 10:34:34 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 Jan 2021 10:34:34 -0600
Received: from [10.250.35.71] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10LGYXba105581;
        Thu, 21 Jan 2021 10:34:33 -0600
Subject: Re: [PATCH] arm64: dts: ti: k3: mmc: fix dtbs_check warnings
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Faiz Abbas <faiz_abbas@ti.com>
CC:     <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Aswath Govindraju <a-govindraju@ti.com>
References: <20210115193016.5581-1-grygorii.strashko@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <fd37ce1c-9aaa-5bce-e683-3c2fd09657b8@ti.com>
Date:   Thu, 21 Jan 2021 10:34:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210115193016.5581-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/21 1:30 PM, Grygorii Strashko wrote:
> Now the dtbs_check produces below warnings
>  sdhci@4f80000: clock-names:0: 'clk_ahb' was expected
>  sdhci@4f80000: clock-names:1: 'clk_xin' was expected
>  $nodename:0: 'sdhci@4f80000' does not match '^mmc(@.*)?$'
> 
> Fix above warnings by updating mmc DT definitions to follow
> sdhci-am654.yaml bindings:
>  - rename sdhci dt nodes to 'mmc@'
>  - swap clk_xin/clk_ahb clocks, the clk_ahb clock expected to be defined
> first
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Thanks for fixing these Grygorii,

Reviewed-by: Suman Anna <s-anna@ti.com>

On a side note, there are still couple more warnings on J721E dtb

/uhome/projects/opensrc/kernels/linux-next/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dt.yaml:
mmc@4fb0000: compatible: More than one condition true in oneOf schema:
	{'oneOf': [{'additionalItems': False,
	            'items': [{'const': 'ti,am654-sdhci-5.1'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {'additionalItems': False,
	            'items': [{'const': 'ti,j721e-sdhci-8bit'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {'additionalItems': False,
	            'items': [{'const': 'ti,j721e-sdhci-4bit'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {'additionalItems': False,
	            'items': [{'const': 'ti,j721e-sdhci-4bit'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {'additionalItems': False,
	            'items': [{'const': 'ti,am64-sdhci-8bit'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {'additionalItems': False,
	            'items': [{'const': 'ti,am64-sdhci-4bit'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {'additionalItems': False,
	            'items': [{'const': 'ti,j7200-sdhci-8bit'},
	                      {'const': 'ti,j721e-sdhci-8bit'}],
	            'maxItems': 2,
	            'minItems': 2,
	            'type': 'array'},
	           {'additionalItems': False,
	            'items': [{'const': 'ti,j7200-sdhci-4bit'},
	                      {'const': 'ti,j721e-sdhci-4bit'}],
	            'maxItems': 2,
	            'minItems': 2,
	            'type': 'array'}]}
	From schema:
/uhome/projects/opensrc/kernels/linux-next/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml

Also, the YAML itself can do with some improvements. I see a minItems of 1, so I
am assuming clk_ahb is always the mandatory clock where applicable, can you confirm?

regards
Suman

> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi  |  4 ++--
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi |  8 ++++----
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 18 +++++++++---------
>  3 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 12591a854020..ceb579fb427d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -256,7 +256,7 @@
>  		#size-cells = <0>;
>  	};
>  
> -	sdhci0: sdhci@4f80000 {
> +	sdhci0: mmc@4f80000 {
>  		compatible = "ti,am654-sdhci-5.1";
>  		reg = <0x0 0x4f80000 0x0 0x260>, <0x0 0x4f90000 0x0 0x134>;
>  		power-domains = <&k3_pds 47 TI_SCI_PD_EXCLUSIVE>;
> @@ -280,7 +280,7 @@
>  		dma-coherent;
>  	};
>  
> -	sdhci1: sdhci@4fa0000 {
> +	sdhci1: mmc@4fa0000 {
>  		compatible = "ti,am654-sdhci-5.1";
>  		reg = <0x0 0x4fa0000 0x0 0x260>, <0x0 0x4fb0000 0x0 0x134>;
>  		power-domains = <&k3_pds 48 TI_SCI_PD_EXCLUSIVE>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index 4e39f0325c03..3f23b913b498 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -506,8 +506,8 @@
>  		reg = <0x00 0x04f80000 0x00 0x260>, <0x00 0x4f88000 0x00 0x134>;
>  		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
>  		power-domains = <&k3_pds 91 TI_SCI_PD_EXCLUSIVE>;
> -		clock-names = "clk_xin", "clk_ahb";
> -		clocks = <&k3_clks 91 3>, <&k3_clks 91 0>;
> +		clock-names = "clk_ahb", "clk_xin";
> +		clocks = <&k3_clks 91 0>, <&k3_clks 91 3>;
>  		ti,otap-del-sel-legacy = <0x0>;
>  		ti,otap-del-sel-mmc-hs = <0x0>;
>  		ti,otap-del-sel-ddr52 = <0x6>;
> @@ -525,8 +525,8 @@
>  		reg = <0x00 0x04fb0000 0x00 0x260>, <0x00 0x4fb8000 0x00 0x134>;
>  		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
>  		power-domains = <&k3_pds 92 TI_SCI_PD_EXCLUSIVE>;
> -		clock-names = "clk_xin", "clk_ahb";
> -		clocks = <&k3_clks 92 2>, <&k3_clks 92 1>;
> +		clock-names = "clk_ahb", "clk_xin";
> +		clocks = <&k3_clks 92 1>, <&k3_clks 92 2>;
>  		ti,otap-del-sel-legacy = <0x0>;
>  		ti,otap-del-sel-sd-hs = <0x0>;
>  		ti,otap-del-sel-sdr12 = <0xf>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 2d526ea44a85..8c84dafb7125 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -1032,13 +1032,13 @@
>  		clock-names = "gpio";
>  	};
>  
> -	main_sdhci0: sdhci@4f80000 {
> +	main_sdhci0: mmc@4f80000 {
>  		compatible = "ti,j721e-sdhci-8bit";
>  		reg = <0x0 0x4f80000 0x0 0x1000>, <0x0 0x4f88000 0x0 0x400>;
>  		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
>  		power-domains = <&k3_pds 91 TI_SCI_PD_EXCLUSIVE>;
> -		clock-names = "clk_xin", "clk_ahb";
> -		clocks = <&k3_clks 91 1>, <&k3_clks 91 0>;
> +		clock-names = "clk_ahb", "clk_xin";
> +		clocks = <&k3_clks 91 0>, <&k3_clks 91 1>;
>  		assigned-clocks = <&k3_clks 91 1>;
>  		assigned-clock-parents = <&k3_clks 91 2>;
>  		bus-width = <8>;
> @@ -1054,13 +1054,13 @@
>  		dma-coherent;
>  	};
>  
> -	main_sdhci1: sdhci@4fb0000 {
> +	main_sdhci1: mmc@4fb0000 {
>  		compatible = "ti,j721e-sdhci-4bit";
>  		reg = <0x0 0x04fb0000 0x0 0x1000>, <0x0 0x4fb8000 0x0 0x400>;
>  		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
>  		power-domains = <&k3_pds 92 TI_SCI_PD_EXCLUSIVE>;
> -		clock-names = "clk_xin", "clk_ahb";
> -		clocks = <&k3_clks 92 0>, <&k3_clks 92 5>;
> +		clock-names = "clk_ahb", "clk_xin";
> +		clocks = <&k3_clks 92 5>, <&k3_clks 92 0>;
>  		assigned-clocks = <&k3_clks 92 0>;
>  		assigned-clock-parents = <&k3_clks 92 1>;
>  		ti,otap-del-sel-legacy = <0x0>;
> @@ -1074,13 +1074,13 @@
>  		dma-coherent;
>  	};
>  
> -	main_sdhci2: sdhci@4f98000 {
> +	main_sdhci2: mmc@4f98000 {
>  		compatible = "ti,j721e-sdhci-4bit";
>  		reg = <0x0 0x4f98000 0x0 0x1000>, <0x0 0x4f90000 0x0 0x400>;
>  		interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>  		power-domains = <&k3_pds 93 TI_SCI_PD_EXCLUSIVE>;
> -		clock-names = "clk_xin", "clk_ahb";
> -		clocks = <&k3_clks 93 0>, <&k3_clks 93 5>;
> +		clock-names = "clk_ahb", "clk_xin";
> +		clocks = <&k3_clks 93 5>, <&k3_clks 93 0>;
>  		assigned-clocks = <&k3_clks 93 0>;
>  		assigned-clock-parents = <&k3_clks 93 1>;
>  		ti,otap-del-sel-legacy = <0x0>;
> 

