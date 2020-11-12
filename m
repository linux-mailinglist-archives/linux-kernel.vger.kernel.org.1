Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2315F2B0A42
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgKLQkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:40:00 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36686 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgKLQkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:40:00 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACGdsNH028587;
        Thu, 12 Nov 2020 10:39:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605199194;
        bh=uG3pGeJtn/GA4ZpaaCR+z7IOHmsFG0YkeuQj4RKf7sw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xMUaaUcCoEGuR00W+glOX5N4SQwj7BN0NLgCfp6FI54uY9EpxJ/ucgNjFdkOCtO1c
         sSjZDl7Q1A1a14uU1XFwmcBQM7ssUGmL5PewgOPv+vfaarQZSVthYVmYAV1/XOkhea
         vfWtVaDh/z5ompsoP/06UAyI9Uql9d2iMjDLAt9w=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACGdsOU050133
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 10:39:54 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 10:39:53 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 10:39:53 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACGdr4v045918;
        Thu, 12 Nov 2020 10:39:53 -0600
Date:   Thu, 12 Nov 2020 10:39:53 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <t-kristo@ti.com>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j7200-main: Add gpio nodes in
 main domain
Message-ID: <20201112163953.soia5cje4ry42ujf@kahuna>
References: <20201102191120.20380-1-faiz_abbas@ti.com>
 <20201102191120.20380-2-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201102191120.20380-2-faiz_abbas@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 00:41-20201103, Faiz Abbas wrote:
> There are 4 instances of gpio modules in main domain:
> 	gpio0, gpio2, gpio4 and gpio6
> 
> Groups are created to provide protection between different processor virtual
> worlds. Each of these modules I/O pins are muxed within the group. Exactly
> one module can be selected to control the corresponding pin by selecting it
> in the pad mux configuration registers.
Could you check with checkpatch --strict please?

I see:

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)

> 
> This group pins out 69 lines (5 banks).
> 
> Add DT modes for each module instance in the main domain.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 68 +++++++++++++++++++++++

dtbs_check: we added:
arch/arm64/boot/dts/ti/k3-j7200-main.dtsi: /bus@100000/gpio@600000: Missing #address-cells in interrupt provider
arch/arm64/boot/dts/ti/k3-j7200-main.dtsi: /bus@100000/gpio@610000: Missing #address-cells in interrupt provider
arch/arm64/boot/dts/ti/k3-j7200-main.dtsi: /bus@100000/gpio@620000: Missing #address-cells in interrupt provider
arch/arm64/boot/dts/ti/k3-j7200-main.dtsi: /bus@100000/gpio@630000: Missing #address-cells in interrupt provider

>  1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index 72d6496e88dd..c22ef2efa531 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -446,4 +446,72 @@
>  			dr_mode = "otg";
>  		};
>  	};
> +
> +	main_gpio0: gpio@600000 {
> +		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
> +		reg = <0x00 0x00600000 0x00 0x100>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&main_gpio_intr>;
> +		interrupts = <145>, <146>, <147>, <148>,
> +			     <149>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		ti,ngpio = <69>;
> +		ti,davinci-gpio-unbanked = <0>;
> +		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 105 0>;
> +		clock-names = "gpio";
> +	};
> +
> +	main_gpio2: gpio@610000 {
> +		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
> +		reg = <0x00 0x00610000 0x00 0x100>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&main_gpio_intr>;
> +		interrupts = <154>, <155>, <156>, <157>,
> +			     <158>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		ti,ngpio = <69>;
> +		ti,davinci-gpio-unbanked = <0>;
> +		power-domains = <&k3_pds 107 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 107 0>;
> +		clock-names = "gpio";
> +	};
> +
> +	main_gpio4: gpio@620000 {
> +		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
> +		reg = <0x00 0x00620000 0x00 0x100>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&main_gpio_intr>;
> +		interrupts = <163>, <164>, <165>, <166>,
> +			     <167>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		ti,ngpio = <69>;
> +		ti,davinci-gpio-unbanked = <0>;
> +		power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 109 0>;
> +		clock-names = "gpio";
> +	};
> +
> +	main_gpio6: gpio@630000 {
> +		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
> +		reg = <0x00 0x00630000 0x00 0x100>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&main_gpio_intr>;
> +		interrupts = <172>, <173>, <174>, <175>,
> +			     <176>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		ti,ngpio = <69>;
> +		ti,davinci-gpio-unbanked = <0>;
> +		power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 111 0>;
> +		clock-names = "gpio";
> +	};
>  };
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
