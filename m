Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C135C303FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405716AbhAZORc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:17:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405570AbhAZOPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:15:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A295B206CA;
        Tue, 26 Jan 2021 14:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611670476;
        bh=RvBv8OiKMpnXhfJIv79PWnLPx+g1GLbxzjdTClMkCQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hVrahg1lPzZR9zI6+D6/TVWm0CgxiNzxjS+VuHdKpNlozOW4ABe6X35d2JiXoOHRK
         qgsrNWK/BAX6DH2uRCfW8p5HBHQpW31GWnlxSGroKMuKQAiv47wB+5tEKbvZK1KdIK
         4TFKN2kNaTdO3YXwiUdc9yrXcGS8CBG7NOJMM1+/GoU5btRX0fsykOhAzqu4VzjCNZ
         NWFQ1uxzjfrmxwhif5vzy9Tg7LeYL28WpB5aiOe2IGCbSLltb+ThKUxMtc9HcD9YjT
         7/PTIesU2grNw6d59A8l85c+EtzJX92M/KvSy8RU6pZ4iOjAL+MxkKVGI6r/8xPce9
         lkBXfrn32H7Tg==
Date:   Tue, 26 Jan 2021 14:14:30 +0000
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
Subject: Re: [RFC PATCH 2/2] arm64: kpti: Update arm64_use_ng_mappings before
 pagetable mapping
Message-ID: <20210126141430.GB29956@willie-the-truck>
References: <20210113014047.14371-1-justin.he@arm.com>
 <20210113014047.14371-3-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113014047.14371-3-justin.he@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 09:40:47AM +0800, Jia He wrote:
> There is a 10s stall in idmap_kpti_install_ng_mappings when kernel boots
> on a Ampere EMAG server.
> 
> Commit f992b4dfd58b ("arm64: kpti: Add ->enable callback to remap
> swapper using nG mappings") updates the nG bit runtime if kpti is required.
> But things get worse if rodata=full in map_mem(). NO_BLOCK_MAPPINGS |
> NO_CONT_MAPPINGS is required when creating pagetable mapping. Hence all
> ptes are fully mapped in this case. On a Ampere EMAG server with 256G
> memory(pagesize=4k), it causes the 10s stall.
> 
> After previous commit moving init_cpu_features(), we can use
> cpu_have_const_cap earlier than before. Hence we can avoid this stall
> by updating arm64_use_ng_mappings.
> 
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  arch/arm64/kernel/setup.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index e078ab068f3b..51098ceb7159 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -306,6 +306,10 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  	/* Init the cpu feature codes for boot cpu */
>  	cpuinfo_store_boot_cpu();
>  
> +	/* ARM64_UNMAP_KERNEL_AT_EL0 cap can be updated in cpuinfo_store_boot_cpu() */
> +	if (!arm64_use_ng_mappings)
> +		arm64_use_ng_mappings = cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);

Are you sure it's safe to run the cpu feature initialisation code this
early? For example, we haven't even parsed the command-line yet, so I think
a fair amount of stuff will break.

Of course, you could also just pass "mitigations=off" if you want your
performance back.

Will
