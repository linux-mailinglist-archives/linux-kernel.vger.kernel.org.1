Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA8C2FA38B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405183AbhAROsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405260AbhAROrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:47:20 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729C9C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 06:46:40 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v15so13060865wrx.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 06:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XW5nfZgpoFkc4MpoG+G2l89kBAOPYjtlcQxlsdxxH1M=;
        b=r5Ai3uTZhku8aQJq9tizY3Yw68CMO7+HZYlNZhw8fTCzOvdRkrOudtY5rQmIi7ikxw
         t/CMV2AQ9R0fhx+/EvVBN/6PDz/r4J2cG9IL2uZpAWBgipgNXe/RSD30BPRfX1cqGdmQ
         wTPgdP7O+Yvj5qq/deZOtP16MzHNx9iUgC5vqf5VX6yOOMbgkLbGSqrIq8oeMYZcsUqJ
         sR+Ko4lPjPXDEpm/0EzgFnLOW5wuLfd4s0Jkbgm6/SEK36hxDfgs2q54TNs24GvqNDMA
         HxuSr9PrZaaDkTrO73wzvKh2WXoyVHOnojEXP/U9RA+lfRA63YwQjmDPV62/ZjAdU9Dn
         4MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XW5nfZgpoFkc4MpoG+G2l89kBAOPYjtlcQxlsdxxH1M=;
        b=oKnsGSrzQ9o2M4UxGE9J3eZ2xRyq5TKVIcRmFsNqVVPHLyM2tqQLs3I7V26H4kWXPs
         QFOSgqqR5KMdvgQk+1OHwRKYkpzHB6+IT7abdq3SABRMqEen6xKkEVIrKGadjp0uvlvx
         oYwfDnfeZ/+rJVBzIDzM/OvZHlwOyt1HmqQZxN1ggc/L5DElyHOCTEjv/tLtKl1a3QuL
         YFIFraX+eA6GbCi70+/QVaKnaSUvM0qyASWRhoLo6UB1rEm+GMK6hLaSjUD7WrPVf2EY
         pewiTQcOpJaMKMorv7hYmqgcNQBw910WBYjxoLCmrddKUH2HsBkO2E25M0VpuJUIvl3I
         1QPQ==
X-Gm-Message-State: AOAM530OZfhMKWdt2MJS4HDFmwxOWxdueA76w17naXqb+gNbSBE4ZHaj
        Z6Dl1noa09uU7+KS7Rj8bEWOi4JRkmMzfg==
X-Google-Smtp-Source: ABdhPJwRGpx3YsnEW08CMr1seaCnvmc8zx+6grzzj7e7TtfTpL/2RgskjlYeoxYD3YtuShG9uGetYA==
X-Received: by 2002:adf:e84f:: with SMTP id d15mr26439606wrn.245.1610981199072;
        Mon, 18 Jan 2021 06:46:39 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:3d4d:985d:87b7:4d55])
        by smtp.gmail.com with ESMTPSA id g194sm27599927wme.39.2021.01.18.06.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 06:46:38 -0800 (PST)
Date:   Mon, 18 Jan 2021 14:46:36 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v4 18/21] arm64: Move "nokaslr" over to the early
 cpufeature infrastructure
Message-ID: <20210118144636.kysdvnmcdm7it5zp@google.com>
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-19-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118094533.2874082-19-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:45:30AM +0000, Marc Zyngier wrote:
> Given that the early cpufeature infrastructure has borrowed quite
> a lot of code from the kaslr implementation, let's reimplement
> the matching of the "nokaslr" option with it.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: David Brazdil <dbrazdil@google.com>

> ---
>  arch/arm64/kernel/idreg-override.c | 17 ++++++++++++++
>  arch/arm64/kernel/kaslr.c          | 37 +++---------------------------
>  2 files changed, 20 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
> index 1db54878b2c4..143fe7b8e3ce 100644
> --- a/arch/arm64/kernel/idreg-override.c
> +++ b/arch/arm64/kernel/idreg-override.c
> @@ -33,8 +33,24 @@ static const struct reg_desc mmfr1 __initdata = {
>  	},
>  };
>  
> +extern u64 kaslr_feature_val;
> +extern u64 kaslr_feature_mask;
> +
> +static const struct reg_desc kaslr __initdata = {
> +	.name		= "kaslr",
> +#ifdef CONFIG_RANDOMIZE_BASE
> +	.val		= &kaslr_feature_val,
> +	.mask		= &kaslr_feature_mask,
> +#endif
> +	.fields		= {
> +		{ "disabled", 0 },
> +		{}
> +	},
> +};
> +
>  static const struct reg_desc * const regs[] __initdata = {
>  	&mmfr1,
> +	&kaslr,
>  };
>  
>  static const struct {
> @@ -43,6 +59,7 @@ static const struct {
>  } aliases[] __initdata = {
>  	{ "kvm-arm.mode=nvhe",		"id_aa64mmfr1.vh=0" },
>  	{ "kvm-arm.mode=protected",	"id_aa64mmfr1.vh=0" },
> +	{ "nokaslr",			"kaslr.disabled=1" },
>  };
>  
>  static int __init find_field(const char *cmdline, const struct reg_desc *reg,
> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> index 5fc86e7d01a1..dcc4a5aadbe2 100644
> --- a/arch/arm64/kernel/kaslr.c
> +++ b/arch/arm64/kernel/kaslr.c
> @@ -51,39 +51,8 @@ static __init u64 get_kaslr_seed(void *fdt)
>  	return ret;
>  }
>  
> -static __init bool cmdline_contains_nokaslr(const u8 *cmdline)
> -{
> -	const u8 *str;
> -
> -	str = strstr(cmdline, "nokaslr");
> -	return str == cmdline || (str > cmdline && *(str - 1) == ' ');
> -}
> -
> -static __init bool is_kaslr_disabled_cmdline(void *fdt)
> -{
> -	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
> -		int node;
> -		const u8 *prop;
> -
> -		node = fdt_path_offset(fdt, "/chosen");
> -		if (node < 0)
> -			goto out;
> -
> -		prop = fdt_getprop(fdt, node, "bootargs", NULL);
> -		if (!prop)
> -			goto out;
> -
> -		if (cmdline_contains_nokaslr(prop))
> -			return true;
> -
> -		if (IS_ENABLED(CONFIG_CMDLINE_EXTEND))
> -			goto out;
> -
> -		return false;
> -	}
> -out:
> -	return cmdline_contains_nokaslr(CONFIG_CMDLINE);
> -}
> +u64 kaslr_feature_val __initdata;
> +u64 kaslr_feature_mask __initdata;
>  
>  /*
>   * This routine will be executed with the kernel mapped at its default virtual
> @@ -126,7 +95,7 @@ u64 __init kaslr_early_init(void)
>  	 * Check if 'nokaslr' appears on the command line, and
>  	 * return 0 if that is the case.
>  	 */
> -	if (is_kaslr_disabled_cmdline(fdt)) {
> +	if (kaslr_feature_val & kaslr_feature_mask & 0xf) {

nit: Isn't the 0xf redundant here? You don't re-mask for VH either.

>  		kaslr_status = KASLR_DISABLED_CMDLINE;
>  		return 0;
>  	}
> -- 
> 2.29.2
> 
