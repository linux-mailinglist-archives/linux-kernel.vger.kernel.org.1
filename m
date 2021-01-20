Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AB12FDB84
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbhATU4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:56:06 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53860 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388549AbhATUvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 15:51:04 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10KKo4q6047968;
        Wed, 20 Jan 2021 14:50:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611175804;
        bh=7/hhNavleejKSmTt64PV/hnP/QVVJqHVJl/lX11+bMY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=n9tyN7X5uUFEqANHyM0DlA/JrqvWdEnK3bnAHveaPbtPy/IO/OE22J2Sv32jnlzgl
         HNhCxRGgJ2O/+lSh8uFziBdo5nJehj2ZEBtaS5SrUZ/fCbNn9oYCUowoqJpJeSO02A
         VGadrNVdUT77ZfC4WnMlHSTN0moHmc1u1wavLrlc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10KKo4J0030938
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jan 2021 14:50:04 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 20
 Jan 2021 14:50:03 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 20 Jan 2021 14:50:03 -0600
Received: from [10.250.35.71] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10KKo3dS089721;
        Wed, 20 Jan 2021 14:50:03 -0600
Subject: Re: [PATCH] arm64: dts: ti: k3*: Fixup PMU compatibility to be CPU
 specific
To:     Nishanth Menon <nm@ti.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Dave Gerlach <d-gerlach@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210120195145.32259-1-nm@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <dbd31e85-fc72-1a94-f143-6ed0777ffa9a@ti.com>
Date:   Wed, 20 Jan 2021 14:49:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210120195145.32259-1-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/21 1:51 PM, Nishanth Menon wrote:
> We can use CPU specific pmu configuration to expose the appropriate
> CPU specific events rather than just the basic generic pmuv3 perf
> events.
> 
> Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Tested-by: Suman Anna <s-anna@ti.com>

regards
Suman

> ---
> 
> AM65: https://pastebin.ubuntu.com/p/TF2cCMySkt/
> J721E: https://pastebin.ubuntu.com/p/jgGPNmNgG3/
> J7200: https://pastebin.ubuntu.com/p/Kfc3VHHXNB/
> 
> Original report: https://lore.kernel.org/linux-arm-kernel/20210119172412.smsjdo2sjzqi5vcn@bogus/
> 
> I have'nt split this patch up for fixes tag primarily because the
> basic functionality works and this is an improvement than a critical
> fixup to backport for older kernels.
> 
>  arch/arm64/boot/dts/ti/k3-am65.dtsi  | 2 +-
>  arch/arm64/boot/dts/ti/k3-j7200.dtsi | 2 +-
>  arch/arm64/boot/dts/ti/k3-j721e.dtsi | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> index d84c0bc05023..a9fc1af03f27 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> @@ -56,7 +56,7 @@ a53_timer0: timer-cl0-cpu0 {
>  	};
>  
>  	pmu: pmu {
> -		compatible = "arm,armv8-pmuv3";
> +		compatible = "arm,cortex-a53-pmu";
>  		/* Recommendation from GIC500 TRM Table A.3 */
>  		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>  	};
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200.dtsi b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
> index 66169bcf7c9a..b7005b803149 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
> @@ -114,7 +114,7 @@ a72_timer0: timer-cl0-cpu0 {
>  	};
>  
>  	pmu: pmu {
> -		compatible = "arm,armv8-pmuv3";
> +		compatible = "arm,cortex-a72-pmu";
>  		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> index cc483f7344af..f0587fde147e 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> @@ -115,7 +115,7 @@ a72_timer0: timer-cl0-cpu0 {
>  	};
>  
>  	pmu: pmu {
> -		compatible = "arm,armv8-pmuv3";
> +		compatible = "arm,cortex-a72-pmu";
>  		/* Recommendation from GIC500 TRM Table A.3 */
>  		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>  	};
> 

