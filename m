Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29482D7056
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 07:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436520AbgLKGtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 01:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390670AbgLKGte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 01:49:34 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E4DC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 22:48:54 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id x12so3650616plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 22:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6sBOEH48LyHr+qjsw0kos3f6YjDEBYmti7I8QWsLHXE=;
        b=DOVIPDbDt7/sS0WYIOhD1X4/7JBBD2I1MSjHbdcdcv/6y8YLuV1k8zI1YhczMGAXSJ
         xsyGHqZ/tF1DskN+TY2L0okEUjdtcz5g7NTfxznbQz4Z85yJ1A5hZFryNjRq8X2ZfsfT
         QU1xEv+3I2q6AXtx88ReLIW9GrgEKEP0IItfV3fMxGl1vItQrx2C+pDPgQX/JeYBC6VU
         8EFHSbsEU4QS6ST1RGODrCrNCwjr2zOAL6FIMgzsyH7mk6szmYJ49scu+gVI7PHBoEsd
         /SjwOpDcbEwV7yHozh6GtwXm0nNvcX2UQQhcO2LDSx/Kdo1phUywzlY/RngWbZDD7Zcn
         wmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6sBOEH48LyHr+qjsw0kos3f6YjDEBYmti7I8QWsLHXE=;
        b=WLVNM8uRTyUBQ6fh19uZwYKQKVi5us077DJlBeKUaqjZ1Y9AliSXqte7dTvT7bNhhs
         +7etlgAAJRJVd4zZ6cxeynNZzGA1W9SIFXUbPBiZwVEsToikSarNs9KoUiNPtjs1EmHp
         0z8QCuHwJPUivAgRGCmeOY3OU3AzGmFZI3UChK1074nP/EMqOe/tmP3l/Z7HymQfpTcc
         ilTPRmkFCUv7PQsHPJAoJ+881mSI5sVzdoC7Py5/GogjRESJ/Hv2vz3dD78oMCNqmPzY
         x0AfmRP4R7hM3tNP+xKLVp1gArEcyTY7f8HGSqhAjOhHNVPpk1nK/7aDxmHVF9rrxtO8
         EyAQ==
X-Gm-Message-State: AOAM531pa2iHpWJRt0+g3+Ivf1AV/vphXrZ7rtrt6G63jAzXq+U5mt76
        ArFNLZWRWESGivoHdd7DQiFZcA==
X-Google-Smtp-Source: ABdhPJxzCgCYAlMSewsnX3/fWz1wKniCNCI5w6xQof6FLJCJFhCsBSQyJSSfxeIIYTn0WcdP7VsOvA==
X-Received: by 2002:a17:902:ed44:b029:da:91e5:e09 with SMTP id y4-20020a170902ed44b02900da91e50e09mr9668543plb.24.1607669334085;
        Thu, 10 Dec 2020 22:48:54 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id v126sm8610154pfb.137.2020.12.10.22.48.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 22:48:53 -0800 (PST)
Date:   Fri, 11 Dec 2020 12:18:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: topology: Drop the useless update to per-cpu
 cycles
Message-ID: <20201211064850.gsqsszwhxx5lzqgw@vireshk-i7>
References: <7a171f710cdc0f808a2bfbd7db839c0d265527e7.1607579234.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a171f710cdc0f808a2bfbd7db839c0d265527e7.1607579234.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-12-20, 11:17, Viresh Kumar wrote:
> The previous call to update_freq_counters_refs() has already updated the
> per-cpu variables, don't overwrite them with the same value again.
> 
> Fixes: 4b9cf23c179a ("arm64: wrap and generalise counter read functions")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/kernel/topology.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index c8308befdb1e..f6faa697e83e 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -314,7 +314,7 @@ void topology_scale_freq_tick(void)
>  
>  	if (unlikely(core_cnt <= prev_core_cnt ||
>  		     const_cnt <= prev_const_cnt))
> -		goto store_and_exit;
> +		return;
>  
>  	/*
>  	 *	    /\core    arch_max_freq_scale
> @@ -331,10 +331,6 @@ void topology_scale_freq_tick(void)
>  
>  	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
>  	this_cpu_write(freq_scale, (unsigned long)scale);
> -
> -store_and_exit:
> -	this_cpu_write(arch_core_cycles_prev, core_cnt);
> -	this_cpu_write(arch_const_cycles_prev, const_cnt);
>  }
>  
>  #ifdef CONFIG_ACPI_CPPC_LIB

Catalin: Can you please pick this up for 5.11-rc1, the earlier patch
(from fixes) is already in your tree. Thanks.

-- 
viresh
