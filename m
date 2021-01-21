Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B102FE7F4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbhAUKsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:48:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729698AbhAUKiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:38:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DE5F2137B;
        Thu, 21 Jan 2021 10:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611225450;
        bh=1Etgxdl7G90TmACNnd/HP+WyqVm5tYgY7rcqWBkqz1o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L3pYFv9W108WGMDPWi2nQT4KorANRg8DC1BzTytUbdgR4M6NlMNlffrcpWdcPuIW3
         EzEUQw2KV/ujhqu2GBookYeDWnnnFUZG8JbgYM5AqlBsUdsXMYsIKp9uuvpN9/UdvW
         qEex+BXxq4+C8/6g+nbXeiSvuPCjYEr6g0tvTspjSKpyL12T+EXdZS+tloCa2GwWeF
         vWImlQp+bye98LMj682xhVUxPMuGGKh0iNkSVrQ6rmBXeztFqwU5I69lZEZE7iNNRv
         fPBI//Ul0nam2uf+jXOHEAJDseh7PQ4IbVNnaNJttoRaDoJGOQTxxKzeoCU/lVNoQo
         EijkIVLoHZd/w==
Subject: Re: [PATCH] arm64: dts: ti: k3*: Fixup PMU compatibility to be CPU
 specific
To:     Nishanth Menon <nm@ti.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Suman Anna <s-anna@ti.com>, Dave Gerlach <d-gerlach@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210120195145.32259-1-nm@ti.com>
From:   Tero Kristo <kristo@kernel.org>
Message-ID: <4a57ef04-75ca-5d24-54ef-15aff1ede46e@kernel.org>
Date:   Thu, 21 Jan 2021 12:37:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210120195145.32259-1-nm@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2021 21:51, Nishanth Menon wrote:
> We can use CPU specific pmu configuration to expose the appropriate
> CPU specific events rather than just the basic generic pmuv3 perf
> events.
> 
> Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Tero Kristo <kristo@kernel.org>

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
>   arch/arm64/boot/dts/ti/k3-am65.dtsi  | 2 +-
>   arch/arm64/boot/dts/ti/k3-j7200.dtsi | 2 +-
>   arch/arm64/boot/dts/ti/k3-j721e.dtsi | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> index d84c0bc05023..a9fc1af03f27 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> @@ -56,7 +56,7 @@ a53_timer0: timer-cl0-cpu0 {
>   	};
>   
>   	pmu: pmu {
> -		compatible = "arm,armv8-pmuv3";
> +		compatible = "arm,cortex-a53-pmu";
>   		/* Recommendation from GIC500 TRM Table A.3 */
>   		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>   	};
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200.dtsi b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
> index 66169bcf7c9a..b7005b803149 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
> @@ -114,7 +114,7 @@ a72_timer0: timer-cl0-cpu0 {
>   	};
>   
>   	pmu: pmu {
> -		compatible = "arm,armv8-pmuv3";
> +		compatible = "arm,cortex-a72-pmu";
>   		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>   	};
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> index cc483f7344af..f0587fde147e 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> @@ -115,7 +115,7 @@ a72_timer0: timer-cl0-cpu0 {
>   	};
>   
>   	pmu: pmu {
> -		compatible = "arm,armv8-pmuv3";
> +		compatible = "arm,cortex-a72-pmu";
>   		/* Recommendation from GIC500 TRM Table A.3 */
>   		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>   	};
> 

