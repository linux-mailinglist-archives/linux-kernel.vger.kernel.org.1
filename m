Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C37303F73
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405612AbhAZN6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:58:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405105AbhAZN6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:58:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B8B42255F;
        Tue, 26 Jan 2021 13:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611669439;
        bh=y7F+oWWxh1fjhvS0/oYgJ5q2LarzXJddNMbpoRLzou8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AzigRl4/0g9GQwgdqBXyf3gsHha1GfHYFtbDU3N5jkW26gnAuZrcCF1OuW8D1TPYN
         jQh5WarDLnJy9ljEhBGhTiUA/fPOy95tClb5YkAi290zspzvb43FUVcMG5uN8XlK2/
         56O9nY0B7Y+/FXDc6MKQxykynjbEzTT2Nx7YVhSORkkZ20UFGeNHSsNAaI3kyO6NT6
         mNubMMkYjOQ9QMZV2qdaLXdDB2oXRlrikpKj9G/fXpHGCsof+1JOo+kqDn229E/ZSa
         HQ6OnnOuRbMEpJOCuM9ibcllbTALw9lwdlLfOQWZCskXhhpnPNJmXBNCk1+MrzJIZY
         7o2Ab+wqxH4BA==
Date:   Tue, 26 Jan 2021 13:57:13 +0000
From:   Will Deacon <will@kernel.org>
To:     Jia He <justin.he@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Steven Price <steven.price@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gavin Shan <gshan@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [RFC PATCH 1/2] arm64/cpuinfo: Move init_cpu_features() ahead of
 setup.c::early_fixmap_init()
Message-ID: <20210126135712.GA29956@willie-the-truck>
References: <20210113014047.14371-1-justin.he@arm.com>
 <20210113014047.14371-2-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113014047.14371-2-justin.he@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 09:40:46AM +0800, Jia He wrote:
> Move init_cpu_features() ahead of setup_arch()->early_fixmap_init(), which
> is the preparation work for checking the condition to assign
> arm64_use_ng_mappings as cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0).
> 
> Besides, jump_label_init() is also moved ahead because
> cpus_have_const_cap() depends on static key enable api.
> 
> Percpu helpers should be avoided in cpuinfo_store_boot_cpu() before percpu
> init at main.c::setup_per_cpu_areas()
> 
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  arch/arm64/include/asm/cpu.h |  1 +
>  arch/arm64/kernel/cpuinfo.c  | 13 ++++++++++---
>  arch/arm64/kernel/setup.c    | 14 +++++++++-----
>  arch/arm64/kernel/smp.c      |  3 +--
>  4 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
> index 7faae6ff3ab4..59f36f5e3c04 100644
> --- a/arch/arm64/include/asm/cpu.h
> +++ b/arch/arm64/include/asm/cpu.h
> @@ -63,6 +63,7 @@ DECLARE_PER_CPU(struct cpuinfo_arm64, cpu_data);
>  
>  void cpuinfo_store_cpu(void);
>  void __init cpuinfo_store_boot_cpu(void);
> +void __init save_boot_cpuinfo_data(void);
>  
>  void __init init_cpu_features(struct cpuinfo_arm64 *info);
>  void update_cpu_features(int cpu, struct cpuinfo_arm64 *info,
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 77605aec25fe..f8de5b8bae20 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -413,9 +413,16 @@ void cpuinfo_store_cpu(void)
>  
>  void __init cpuinfo_store_boot_cpu(void)
>  {
> -	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, 0);
> -	__cpuinfo_store_cpu(info);
> +	__cpuinfo_store_cpu(&boot_cpu_data);
>  
> -	boot_cpu_data = *info;
>  	init_cpu_features(&boot_cpu_data);
>  }
> +
> +void __init save_boot_cpuinfo_data(void)
> +{
> +	struct cpuinfo_arm64 *info;
> +
> +	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
> +	info = &per_cpu(cpu_data, 0);
> +	*info = boot_cpu_data;
> +}
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 1a57a76e1cc2..e078ab068f3b 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -297,16 +297,20 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  	 */
>  	arm64_use_ng_mappings = kaslr_requires_kpti();
>  
> -	early_fixmap_init();
> -	early_ioremap_init();
> -
> -	setup_machine_fdt(__fdt_pointer);
> -
>  	/*
>  	 * Initialise the static keys early as they may be enabled by the
>  	 * cpufeature code and early parameters.
>  	 */
>  	jump_label_init();

I don't think your patch changes this, but afaict jump_label_init() uses
per-cpu variables via cpus_read_lock(), yet we don't initialise our offset
until later on. Any idea how that works?

Will
