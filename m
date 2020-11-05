Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91362A780A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 08:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgKEHcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 02:32:15 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60392 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgKEHcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 02:32:15 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A57W9LW075453;
        Thu, 5 Nov 2020 01:32:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604561529;
        bh=TBAs5azRMtL2kgvAKGdeDXUMtHgfm26OZulLvGFJwUA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Q0ktcgHPPkcvKYNF2Ljb8Ctve8mCByI9W39b2OZ9ZUw63T5BXrOFJ31K5nYt4ufVr
         7LKszzpLt7KSpGHjfSYLRoyaYPtWj3nQQ9jy2iyc/sogc8j4Iw6734fhnQ/21swfeG
         nmSjnIYO8bTyj1mitv4r/E8KPsHCE6Ap2FVfuGPg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A57W8Bv087797
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Nov 2020 01:32:09 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 5 Nov
 2020 01:32:07 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 5 Nov 2020 01:32:07 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A57W4qM066176;
        Thu, 5 Nov 2020 01:32:05 -0600
Subject: Re: [PATCH 2/4] arm64: dts: ti: k3-j721e*: Cleanup disabled nodes at
 SoC dtsi level
To:     Nishanth Menon <nm@ti.com>, Roger Quadros <rogerq@ti.com>,
        Keerthy <j-keerthy@ti.com>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201104224356.18040-1-nm@ti.com>
 <20201104224356.18040-3-nm@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <d9324b76-5587-b583-97da-5cb52f294c31@ti.com>
Date:   Thu, 5 Nov 2020 09:32:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201104224356.18040-3-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth,

On 05/11/2020 0.43, Nishanth Menon wrote:
> The device tree standard sets the default node behavior when status
> property as enabled.

It should be:
When the status property is not present under a node, the "okay' value
is assumed.

Note: the device tree specification does not document default value as
such, see v0.3 (2.3.4, page 14).
Yes, the "okay" is used in case the status property is missing (by Linux
at least).

> There are many reasons for doing the same, number
> of strings in device tree,

with expense of loc and readability.

> default power management functionality etc

Right, so how does that helps with devices present in the SoC, but no
node at all? First thing which comes to mind is AASRC, we don't have
Linux driver for it (and no DT binding document), but that does not mean
that it is not present. How PM would take that into account?

> are few of the reasons.
> 
> In general, after a few rounds of discussions [1] there are few
> options one could take when dealing with SoC dtsi and board dts
> 
> a. SoC dtsi provide nodes as a super-set default (aka enabled) state and
>    to prevent messy board files, when more boards are added per SoC, we
>    optimize and disable commonly un-used nodes in board-common.dtsi
> b. SoC dtsi disables all hardware dependent nodes by default and board
>    dts files enable nodes based on a need basis.
> c. Subjectively pick and choose which nodes we will disable by default
>    in SoC dtsi and over the years we can optimize things and change
>    default state depending on the need.

For the record: c was not really an option. There were no subjectivity,
the reason was pragmatic.

We are all familiar with the Devicetree specification, but let me quote
from chapter 2.3.4:
"okay"
Indicates the device is operational.

"disabled"
Indicates that the device is not presently operational, but it might
become operational in the future (for example, something is not plugged
in, or switched off).
Refer to the device binding for details on what disabled means for a
given device.

The reason why we kept McASP nodes (and dss) disabled in the soc dtsi
file is that they are not operation in the form they present in there.
They _need_ additional properties to be operational and those properties
can only be added in the board dts file.

This is not remotely a subjective view, this is the opposite of
subjectivity.

As for things not owned by the OS we have the "reserved" status.

> While there are pros and cons on each of these approaches, the right
> thing to do will be to stick with device tree default standards and
> work within those established rules. So, we choose to go with option
> (a).
> 
> Lets cleanup defaults of j721e SoC dtsi before this gets more harder
> to cleanup later on and new SoCs are added.
> 
> The only functional difference between the dtb generated is
> status='okay' is no longer necessary for mcasp10 and depends on the
> default state.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20201027130701.GE5639@atomide.com/
> 
> Fixes: 1c4d35265fb2 ("arm64: dts: ti: k3-j721e-main: Add McASP nodes")
> Fixes: 76921f15acc0 ("arm64: dts: ti: k3-j721e-main: Add DSS node")
> Cc: Jyri Sarha <jsarha@ti.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  .../dts/ti/k3-j721e-common-proc-board.dts     | 48 ++++++++++++++++++-
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 26 ----------
>  2 files changed, 47 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> index 52e121155563..9416528caa8a 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> @@ -540,6 +540,46 @@ &dss {
>  				 <&k3_clks 152 18>;	/* PLL23_HSDIV0 */
>  };
>  
> +&mcasp0 {
> +	status = "disabled";
> +};
> +
> +&mcasp1 {
> +	status = "disabled";
> +};
> +
> +&mcasp2 {
> +	status = "disabled";
> +};
> +
> +&mcasp3 {
> +	status = "disabled";
> +};
> +
> +&mcasp4 {
> +	status = "disabled";
> +};
> +
> +&mcasp5 {
> +	status = "disabled";
> +};
> +
> +&mcasp6 {
> +	status = "disabled";
> +};
> +
> +&mcasp7 {
> +	status = "disabled";
> +};
> +
> +&mcasp8 {
> +	status = "disabled";
> +};
> +
> +&mcasp9 {
> +	status = "disabled";
> +};
> +
>  &mcasp10 {
>  	#sound-dai-cells = <0>;
>  
> @@ -556,8 +596,10 @@ &mcasp10 {
>  	>;
>  	tx-num-evt = <0>;
>  	rx-num-evt = <0>;
> +};
>  
> -	status = "okay";
> +&mcasp11 {
> +	status = "disabled";
>  };

Looks much better in this way.
?

I always wondered what is _not_ used by the board...
But it is not really about that, we need to disable these nodes as they
are incomplete in dtsi, they are not operational...

>  &serdes0 {
> @@ -639,3 +681,7 @@ &pcie3_rc {
>  &pcie3_ep {
>  	status = "disabled";
>  };
> +
> +&dss {
> +	status = "disabled";
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index e2a96b2c423c..b54332d6fdc5 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -1327,8 +1327,6 @@ dss: dss@04a00000 {
>  				  "common_s1",
>  				  "common_s2";
>  
> -		status = "disabled";
> -
>  		dss_ports: ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -1350,8 +1348,6 @@ mcasp0: mcasp@2b00000 {
>  		clocks = <&k3_clks 174 1>;
>  		clock-names = "fck";
>  		power-domains = <&k3_pds 174 TI_SCI_PD_EXCLUSIVE>;
> -
> -		status = "disabled";
>  	};
>  
>  	mcasp1: mcasp@2b10000 {
> @@ -1369,8 +1365,6 @@ mcasp1: mcasp@2b10000 {
>  		clocks = <&k3_clks 175 1>;
>  		clock-names = "fck";
>  		power-domains = <&k3_pds 175 TI_SCI_PD_EXCLUSIVE>;
> -
> -		status = "disabled";
>  	};
>  
>  	mcasp2: mcasp@2b20000 {
> @@ -1388,8 +1382,6 @@ mcasp2: mcasp@2b20000 {
>  		clocks = <&k3_clks 176 1>;
>  		clock-names = "fck";
>  		power-domains = <&k3_pds 176 TI_SCI_PD_EXCLUSIVE>;
> -
> -		status = "disabled";
>  	};
>  
>  	mcasp3: mcasp@2b30000 {
> @@ -1407,8 +1399,6 @@ mcasp3: mcasp@2b30000 {
>  		clocks = <&k3_clks 177 1>;
>  		clock-names = "fck";
>  		power-domains = <&k3_pds 177 TI_SCI_PD_EXCLUSIVE>;
> -
> -		status = "disabled";
>  	};
>  
>  	mcasp4: mcasp@2b40000 {
> @@ -1426,8 +1416,6 @@ mcasp4: mcasp@2b40000 {
>  		clocks = <&k3_clks 178 1>;
>  		clock-names = "fck";
>  		power-domains = <&k3_pds 178 TI_SCI_PD_EXCLUSIVE>;
> -
> -		status = "disabled";
>  	};
>  
>  	mcasp5: mcasp@2b50000 {
> @@ -1445,8 +1433,6 @@ mcasp5: mcasp@2b50000 {
>  		clocks = <&k3_clks 179 1>;
>  		clock-names = "fck";
>  		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
> -
> -		status = "disabled";
>  	};
>  
>  	mcasp6: mcasp@2b60000 {
> @@ -1464,8 +1450,6 @@ mcasp6: mcasp@2b60000 {
>  		clocks = <&k3_clks 180 1>;
>  		clock-names = "fck";
>  		power-domains = <&k3_pds 180 TI_SCI_PD_EXCLUSIVE>;
> -
> -		status = "disabled";
>  	};
>  
>  	mcasp7: mcasp@2b70000 {
> @@ -1483,8 +1467,6 @@ mcasp7: mcasp@2b70000 {
>  		clocks = <&k3_clks 181 1>;
>  		clock-names = "fck";
>  		power-domains = <&k3_pds 181 TI_SCI_PD_EXCLUSIVE>;
> -
> -		status = "disabled";
>  	};
>  
>  	mcasp8: mcasp@2b80000 {
> @@ -1502,8 +1484,6 @@ mcasp8: mcasp@2b80000 {
>  		clocks = <&k3_clks 182 1>;
>  		clock-names = "fck";
>  		power-domains = <&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
> -
> -		status = "disabled";
>  	};
>  
>  	mcasp9: mcasp@2b90000 {
> @@ -1521,8 +1501,6 @@ mcasp9: mcasp@2b90000 {
>  		clocks = <&k3_clks 183 1>;
>  		clock-names = "fck";
>  		power-domains = <&k3_pds 183 TI_SCI_PD_EXCLUSIVE>;
> -
> -		status = "disabled";
>  	};
>  
>  	mcasp10: mcasp@2ba0000 {
> @@ -1540,8 +1518,6 @@ mcasp10: mcasp@2ba0000 {
>  		clocks = <&k3_clks 184 1>;
>  		clock-names = "fck";
>  		power-domains = <&k3_pds 184 TI_SCI_PD_EXCLUSIVE>;
> -
> -		status = "disabled";
>  	};
>  
>  	mcasp11: mcasp@2bb0000 {
> @@ -1559,8 +1535,6 @@ mcasp11: mcasp@2bb0000 {
>  		clocks = <&k3_clks 185 1>;
>  		clock-names = "fck";
>  		power-domains = <&k3_pds 185 TI_SCI_PD_EXCLUSIVE>;
> -
> -		status = "disabled";
>  	};
>  
>  	watchdog0: watchdog@2200000 {
> 

There is no such a tag, but:
whatever-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
