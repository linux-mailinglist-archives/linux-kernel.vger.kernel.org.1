Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97992EB5CF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 00:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbhAEXGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 18:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbhAEXGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 18:06:15 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A42C061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 15:05:34 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id d20so1382793otl.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 15:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n+MJiDk+gXd8k7pAMaE3lFIIuuxOtCtew6SzM8WyLRI=;
        b=f8gWn4bcjQkrBcOdgHhO9K16Z15wBUVuMNNmQCjs5VG+5U48Yl5XuJclGqsXY+ik2x
         aZc8HUHpgIAo+RZ0El6XcsTUTtMoGbi0M/Q4cYd4W2Vb3l1xSoyGHFPdB+1ZECv+1gkx
         s1Y1gDXSALeZxfB43E/byafO1D+6QdH9hRM5M8J07JzX1j6nkDwU9xvSfUkwJL5QU3V6
         Q+r1jDaTSsi2DPI5ihe1eRcoPp70prrFCAsKDJjgbpAthWRmcSmJgW3OvNC3YPA+EOK4
         USd48BckBVwePrwWnp/j1rK8Jnx9bI6WaEvgYLRoAz0/7AeS/pVCeZt1jp9lw/RQnBJF
         YvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n+MJiDk+gXd8k7pAMaE3lFIIuuxOtCtew6SzM8WyLRI=;
        b=DA1CnjyV7q5ESop1QwQWeNkeHfLCnUDnhVot0KYuME+YttGLUBxKgs84zw/wX2B6eE
         x4RMK/XZSr3dePbg39GfVgLO0dloVzCULIZovtoxgf6hMsWsRFM1wnTLRcEFuoMOTtBJ
         oSZhR6JdikSGXHhyCrBrSx2l079U3OZU3xlK7zP0u2lCaILzymwJ51udL05gTqM/LTK1
         o3yz58Wbj4bhRYtALFyw4+U7BK47sZDeQPcTyC5CAxzOO6MN9mrrLiVWuFwYmVU6zLMi
         /cN34rvNYRbLBoAX86iPRNPgdOZfOoU8vh2VTpyltILnJq2H9nwAuRsTRFI+mXFkXtXn
         3Dsg==
X-Gm-Message-State: AOAM531eS+fJQrwU3ZRZ+zAvfFdWnXTAOUxGkzxrHy8gB3JEn8StsY9i
        7dzr81cahXFjJ+Bp7GYuXRcEaPx9ELdgHw==
X-Google-Smtp-Source: ABdhPJyTenkh5M6v8nX5Go1HWJLvlgwkSUUuj1HVOsFjsXLeFfgzn+4ZO2Men6HQs/ZUaIg1q1pxmA==
X-Received: by 2002:a05:6830:1d0:: with SMTP id r16mr1360944ota.54.1609887933704;
        Tue, 05 Jan 2021 15:05:33 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o64sm201617oif.43.2021.01.05.15.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 15:05:33 -0800 (PST)
Date:   Tue, 5 Jan 2021 15:05:59 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Danny Lin <danny@kdrag0n.dev>, ulf.hansson@linaro.org
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: Add support for deep CPU
 cluster idle
Message-ID: <X/Tw13VgA5fOnlCV@ripper>
References: <20210105201000.913183-1-danny@kdrag0n.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105201000.913183-1-danny@kdrag0n.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05 Jan 12:10 PST 2021, Danny Lin wrote:

> This commit adds support for deep idling of the entire unified DynamIQ
> CPU cluster on sm8150. In this idle state, the LLCC (Last-Level Cache
> Controller) is powered off and the AOP (Always-On Processor) enters a
> low-power sleep state.
> 
> I'm not sure what the per-CPU 0x400000f4 idle state previously
> contributed by Qualcomm as the "cluster sleep" state is, but the
> downstream kernel has no such state. The real deep cluster idle state
> is 0x41000c244, composed of:
> 
>     Cluster idle state: (0xc24) << 4 = 0xc240
>     Is reset state: 1 << 30 = 0x40000000
>     Affinity level: 1 << 24 = 0x1000000
>     CPU idle state: 0x4 (power collapse)
> 
> This setup can be replicated with the PSCI power domain cpuidle driver,
> which utilizes OSI to enter cluster idle when the last active CPU
> enters idle.
> 
> The cluster idle state cannot be used as a plain cpuidle state because
> it requires that all CPUs in the cluster are idling.
> 

This looks quite reasonable to me.

@Ulf, this seems to be the first attempt at wiring up the domain idle
pieces upstream, would you mind having a look?

The SM8150 pretty much identical to RB3 in this regard.

Regards,
Bjorn

> Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> ---
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 91 ++++++++++++++++++++++------
>  1 file changed, 73 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 309e00b6fa44..8956c6986744 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -52,10 +52,10 @@ CPU0: cpu@0 {
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <488>;
>  			dynamic-power-coefficient = <232>;
> -			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> -					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_0>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> +			power-domains = <&CPU_PD0>;
> +			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_0: l2-cache {
>  				compatible = "cache";
> @@ -73,10 +73,10 @@ CPU1: cpu@100 {
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <488>;
>  			dynamic-power-coefficient = <232>;
> -			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> -					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_100>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> +			power-domains = <&CPU_PD1>;
> +			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_100: l2-cache {
>  				compatible = "cache";
> @@ -92,10 +92,10 @@ CPU2: cpu@200 {
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <488>;
>  			dynamic-power-coefficient = <232>;
> -			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> -					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_200>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> +			power-domains = <&CPU_PD2>;
> +			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_200: l2-cache {
>  				compatible = "cache";
> @@ -110,10 +110,10 @@ CPU3: cpu@300 {
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <488>;
>  			dynamic-power-coefficient = <232>;
> -			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> -					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_300>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> +			power-domains = <&CPU_PD3>;
> +			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_300: l2-cache {
>  				compatible = "cache";
> @@ -128,10 +128,10 @@ CPU4: cpu@400 {
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
>  			dynamic-power-coefficient = <369>;
> -			cpu-idle-states = <&BIG_CPU_SLEEP_0
> -					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_400>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
> +			power-domains = <&CPU_PD4>;
> +			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_400: l2-cache {
>  				compatible = "cache";
> @@ -146,10 +146,10 @@ CPU5: cpu@500 {
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
>  			dynamic-power-coefficient = <369>;
> -			cpu-idle-states = <&BIG_CPU_SLEEP_0
> -					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_500>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
> +			power-domains = <&CPU_PD5>;
> +			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_500: l2-cache {
>  				compatible = "cache";
> @@ -164,10 +164,10 @@ CPU6: cpu@600 {
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
>  			dynamic-power-coefficient = <369>;
> -			cpu-idle-states = <&BIG_CPU_SLEEP_0
> -					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_600>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
> +			power-domains = <&CPU_PD6>;
> +			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_600: l2-cache {
>  				compatible = "cache";
> @@ -182,10 +182,10 @@ CPU7: cpu@700 {
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
>  			dynamic-power-coefficient = <421>;
> -			cpu-idle-states = <&BIG_CPU_SLEEP_0
> -					   &CLUSTER_SLEEP_0>;
>  			next-level-cache = <&L2_700>;
>  			qcom,freq-domain = <&cpufreq_hw 2>;
> +			power-domains = <&CPU_PD7>;
> +			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_700: l2-cache {
>  				compatible = "cache";
> @@ -251,11 +251,13 @@ BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
>  				min-residency-us = <4488>;
>  				local-timer-stop;
>  			};
> +		};
>  
> +		domain-idle-states {
>  			CLUSTER_SLEEP_0: cluster-sleep-0 {
> -				compatible = "arm,idle-state";
> +				compatible = "domain-idle-state";
>  				idle-state-name = "cluster-power-collapse";
> -				arm,psci-suspend-param = <0x400000F4>;
> +				arm,psci-suspend-param = <0x4100c244>;
>  				entry-latency-us = <3263>;
>  				exit-latency-us = <6562>;
>  				min-residency-us = <9987>;
> @@ -291,6 +293,59 @@ pmu {
>  	psci {
>  		compatible = "arm,psci-1.0";
>  		method = "smc";
> +
> +		CPU_PD0: cpu0 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD1: cpu1 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD2: cpu2 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD3: cpu3 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD4: cpu4 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD5: cpu5 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD6: cpu6 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD7: cpu7 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CLUSTER_PD: cpu-cluster0 {
> +			#power-domain-cells = <0>;
> +			domain-idle-states = <&CLUSTER_SLEEP_0>;
> +		};
>  	};
>  
>  	reserved-memory {
> -- 
> 2.29.2
> 
