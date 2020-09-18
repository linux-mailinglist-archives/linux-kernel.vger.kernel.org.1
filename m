Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DC8270166
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIRPy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:54:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42480 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRPy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:54:29 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08IFsPkr015228;
        Fri, 18 Sep 2020 10:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600444465;
        bh=mZca12QdjutSUgtx8i6xeoCkiMtA63bYwdbL9ND/Ui0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=zCkQlQBmP1WGWVxHxUeRJXlNhgJwa7S+sTMMH3KVActX5V0VkA7y0l1eaosEL3RZE
         k24RlvTLEl2C0RxfwYruopXVRyc0FKz1VtyNkGL78xDphYa9H18jHwEuppmktDxjN8
         0UMqUHdjV/mOxGAbIRQzHsC0wVruncQGbqZwuLQM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IFsPYw081290;
        Fri, 18 Sep 2020 10:54:25 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 10:54:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 10:54:25 -0500
Received: from [10.250.66.210] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IFsOQC044792;
        Fri, 18 Sep 2020 10:54:24 -0500
Subject: Re: [PATCH v3 3/4] arm64: dts: ti: k3-j7200-mcu: add mcu cpsw nuss
 node
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20200918153829.14686-1-grygorii.strashko@ti.com>
 <20200918153829.14686-4-grygorii.strashko@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <e63ec6f1-d4f0-2b14-5513-eb3eeb3f6fe2@ti.com>
Date:   Fri, 18 Sep 2020 10:54:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200918153829.14686-4-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/20 10:38 AM, Grygorii Strashko wrote:
> Add DT node for The TI j7200 MCU SoC Gigabit Ethernet two ports Switch
> subsystem (MCU CPSW NUSS).

nit, %s/j7200/J7200/ on this patch and the next.

regards
Suman

> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Tested-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index 7ecdfdb46436..a994276a8b3d 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -34,6 +34,20 @@
>  		};
>  	};
>  
> +	mcu_conf: syscon@40f00000 {
> +		compatible = "syscon", "simple-mfd";
> +		reg = <0x0 0x40f00000 0x0 0x20000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x40f00000 0x20000>;
> +
> +		phy_gmii_sel: phy@4040 {
> +			compatible = "ti,am654-phy-gmii-sel";
> +			reg = <0x4040 0x4>;
> +			#phy-cells = <1>;
> +		};
> +	};
> +
>  	chipid@43000014 {
>  		compatible = "ti,am654-chipid";
>  		reg = <0x00 0x43000014 0x00 0x4>;
> @@ -136,4 +150,64 @@
>  			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
>  		};
>  	};
> +
> +	mcu_cpsw: ethernet@46000000 {
> +		compatible = "ti,j721e-cpsw-nuss";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		reg = <0x0 0x46000000 0x0 0x200000>;
> +		reg-names = "cpsw_nuss";
> +		ranges = <0x0 0x0 0x0 0x46000000 0x0 0x200000>;
> +		dma-coherent;
> +		clocks = <&k3_clks 18 21>;
> +		clock-names = "fck";
> +		power-domains = <&k3_pds 18 TI_SCI_PD_EXCLUSIVE>;
> +
> +		dmas = <&mcu_udmap 0xf000>,
> +		       <&mcu_udmap 0xf001>,
> +		       <&mcu_udmap 0xf002>,
> +		       <&mcu_udmap 0xf003>,
> +		       <&mcu_udmap 0xf004>,
> +		       <&mcu_udmap 0xf005>,
> +		       <&mcu_udmap 0xf006>,
> +		       <&mcu_udmap 0xf007>,
> +		       <&mcu_udmap 0x7000>;
> +		dma-names = "tx0", "tx1", "tx2", "tx3",
> +			    "tx4", "tx5", "tx6", "tx7",
> +			    "rx";
> +
> +		ethernet-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			cpsw_port1: port@1 {
> +				reg = <1>;
> +				ti,mac-only;
> +				label = "port1";
> +				ti,syscon-efuse = <&mcu_conf 0x200>;
> +				phys = <&phy_gmii_sel 1>;
> +			};
> +		};
> +
> +		davinci_mdio: mdio@f00 {
> +			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
> +			reg = <0x0 0xf00 0x0 0x100>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&k3_clks 18 21>;
> +			clock-names = "fck";
> +			bus_freq = <1000000>;
> +		};
> +
> +		cpts@3d000 {
> +			compatible = "ti,am65-cpts";
> +			reg = <0x0 0x3d000 0x0 0x400>;
> +			clocks = <&k3_clks 18 2>;
> +			clock-names = "cpts";
> +			interrupts-extended = <&gic500 GIC_SPI 858 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "cpts";
> +			ti,cpts-ext-ts-inputs = <4>;
> +			ti,cpts-periodic-outputs = <2>;
> +		};
> +	};
>  };
> 

