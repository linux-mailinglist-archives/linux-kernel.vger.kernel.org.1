Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB20D2702C2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 19:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgIRRAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 13:00:25 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44186 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRRAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 13:00:25 -0400
X-Greylist: delayed 4044 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 13:00:24 EDT
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08IFqtbb033341;
        Fri, 18 Sep 2020 10:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600444375;
        bh=7gW6gTQJdOVwNlqKTJNVl4znuxZVzW2mSfwN/tuARX0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HS7SgsywzqM+tceCGhdG7URTqQLMOLtAdk+hRgUzoPOsgDQTxgowUZS6D+1xtmffB
         G5Sd9MRVagBKrWO+M2sKmK/tzSPTn0Glg+Hc0PymB8Mqm/BL/WIkjN5lVfMOdnXUp+
         fG4OBbmzVLIGomdFwcuywROM8HGuPrqWo5Zaj1jA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08IFqtTp040670
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 10:52:55 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 10:52:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 10:52:54 -0500
Received: from [10.250.66.210] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IFqsCk042333;
        Fri, 18 Sep 2020 10:52:54 -0500
Subject: Re: [PATCH v3 1/4] arm64: dts: ti: k3-j7200: add DMA support
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
 <20200918153829.14686-2-grygorii.strashko@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <414fc839-51e7-915e-5d14-b28b85675872@ti.com>
Date:   Fri, 18 Sep 2020 10:52:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200918153829.14686-2-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grygorii,

On 9/18/20 10:38 AM, Grygorii Strashko wrote:
> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Add the intr, inta, ringacc and udmap nodes for main and mcu NAVSS.

Need to update the changelog, intr and inta are not part of this revised series.

> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Tested-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 36 +++++++++++++++
>  .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 44 +++++++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index 3df49577b06a..c5015df58cd4 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -93,6 +93,42 @@
>  			interrupt-names = "rx_011";
>  			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> +
> +		main_ringacc: ringacc@3c000000 {
> +			compatible = "ti,am654-navss-ringacc";
> +			reg =	<0x0 0x3c000000 0x0 0x400000>,
> +				<0x0 0x38000000 0x0 0x400000>,
> +				<0x0 0x31120000 0x0 0x100>,
> +				<0x0 0x33000000 0x0 0x40000>;
> +			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
> +			ti,num-rings = <1024>;
> +			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
> +			ti,sci = <&dmsc>;
> +			ti,sci-dev-id = <211>;
> +			msi-parent = <&main_udmass_inta>;
> +		};
> +
> +		main_udmap: dma-controller@31150000 {
> +			compatible = "ti,j721e-navss-main-udmap";
> +			reg =	<0x0 0x31150000 0x0 0x100>,
> +				<0x0 0x34000000 0x0 0x100000>,
> +				<0x0 0x35000000 0x0 0x100000>;
> +			reg-names = "gcfg", "rchanrt", "tchanrt";
> +			msi-parent = <&main_udmass_inta>;
> +			#dma-cells = <1>;
> +
> +			ti,sci = <&dmsc>;
> +			ti,sci-dev-id = <212>;
> +			ti,ringacc = <&main_ringacc>;
> +
> +			ti,sci-rm-range-tchan = <0x0d>, /* TX_CHAN */
> +						<0x0f>, /* TX_HCHAN */
> +						<0x10>; /* TX_UHCHAN */
> +			ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
> +						<0x0b>, /* RX_HCHAN */
> +						<0x0c>; /* RX_UHCHAN */
> +			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
> +		};
>  	};
>  
>  	main_pmx0: pinctrl@11c000 {
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index ec2745e0768e..7ecdfdb46436 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -92,4 +92,48 @@
>  		ti,sci-dev-id = <137>;
>  		ti,interrupt-ranges = <16 960 16>;
>  	};
> +
> +	cbass_mcu_navss: navss@28380000 {
> +		compatible = "simple-mfd";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		dma-coherent;
> +		dma-ranges;
> +		ti,sci-dev-id = <232>;
> +
> +		mcu_ringacc: ringacc@2b800000 {
> +			compatible = "ti,am654-navss-ringacc";
> +			reg =	<0x0 0x2b800000 0x0 0x400000>,
> +				<0x0 0x2b000000 0x0 0x400000>,
> +				<0x0 0x28590000 0x0 0x100>,
> +				<0x0 0x2a500000 0x0 0x40000>;

Please use style consistent with existing dts nodes, not a fan of mismatched
usage. We are using 0x00 for the higher 32-bit addresses and sizes. Comment
applies to all the nodes and all patches in the series.

regards
Suman

> +			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
> +			ti,num-rings = <286>;
> +			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
> +			ti,sci = <&dmsc>;
> +			ti,sci-dev-id = <235>;
> +			msi-parent = <&main_udmass_inta>;
> +		};
> +
> +		mcu_udmap: dma-controller@285c0000 {
> +			compatible = "ti,j721e-navss-mcu-udmap";
> +			reg =	<0x0 0x285c0000 0x0 0x100>,
> +				<0x0 0x2a800000 0x0 0x40000>,
> +				<0x0 0x2aa00000 0x0 0x40000>;
> +			reg-names = "gcfg", "rchanrt", "tchanrt";
> +			msi-parent = <&main_udmass_inta>;
> +			#dma-cells = <1>;
> +
> +			ti,sci = <&dmsc>;
> +			ti,sci-dev-id = <236>;
> +			ti,ringacc = <&mcu_ringacc>;
> +
> +			ti,sci-rm-range-tchan = <0x0d>, /* TX_CHAN */
> +						<0x0f>; /* TX_HCHAN */
> +			ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
> +						<0x0b>; /* RX_HCHAN */
> +			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
> +		};
> +	};
>  };
> 

