Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2710B22F6A9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 19:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbgG0RaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 13:30:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731008AbgG0RaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:30:21 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16E9D20714;
        Mon, 27 Jul 2020 17:30:17 +0000 (UTC)
Date:   Mon, 27 Jul 2020 18:30:15 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dyoung@redhat.com,
        bhe@redhat.com, will@kernel.org, james.morse@arm.com,
        robh+dt@kernel.org, arnd@arndb.de, John.P.donnelly@oracle.com,
        prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de, corbet@lwn.net,
        bhsharma@redhat.com, horms@verge.net.au, guohanjun@huawei.com,
        xiexiuqi@huawei.com, huawei.libin@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 4/5] arm64: kdump: fix kdump broken with ZONE_DMA
 reintroduced
Message-ID: <20200727173014.GL13938@gaia>
References: <20200703035816.31289-1-chenzhou10@huawei.com>
 <20200703035816.31289-5-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703035816.31289-5-chenzhou10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 11:58:15AM +0800, Chen Zhou wrote:
> commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
> broken the arm64 kdump. If the memory reserved for crash dump kernel
> falled in ZONE_DMA32, the devices in crash dump kernel need to use
> ZONE_DMA will alloc fail.
> 
> This patch addressed the above issue based on "reserving crashkernel
> above 4G". Originally, we reserve low memory below 4G, and now just need
> to adjust memory limit to arm64_dma_phys_limit in reserve_crashkernel_low
> if ZONE_DMA is enabled. That is, if there are devices need to use ZONE_DMA
> in crash dump kernel, it is a good choice to use parameters
> "crashkernel=X crashkernel=Y,low".
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  kernel/crash_core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index a7580d291c37..e8ecbbc761a3 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -320,6 +320,7 @@ int __init reserve_crashkernel_low(void)
>  	unsigned long long base, low_base = 0, low_size = 0;
>  	unsigned long total_low_mem;
>  	int ret;
> +	phys_addr_t crash_max = 1ULL << 32;
>  
>  	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
>  
> @@ -352,7 +353,11 @@ int __init reserve_crashkernel_low(void)
>  			return 0;
>  	}
>  
> -	low_base = memblock_find_in_range(0, 1ULL << 32, low_size, CRASH_ALIGN);
> +#ifdef CONFIG_ARM64
> +	if (IS_ENABLED(CONFIG_ZONE_DMA))
> +		crash_max = arm64_dma_phys_limit;
> +#endif
> +	low_base = memblock_find_in_range(0, crash_max, low_size, CRASH_ALIGN);
>  	if (!low_base) {
>  		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
>  		       (unsigned long)(low_size >> 20));

Given the number of #ifdefs we end up with in this function, I think
it's better to simply copy to the code to arch/arm64 and tailor it
accordingly.

Anyway, there are two series solving slightly different issues with
kdump reservations:

1. This series which relaxes the crashkernel= allocation to go anywhere
   in the accessible space while having a dedicated crashkernel=X,low
   option for ZONE_DMA.

2. Bhupesh's series [1] forcing crashkernel=X allocations only from
   ZONE_DMA.

For RPi4 support, we limited ZONE_DMA allocations to the 1st GB.
Existing crashkernel= uses may no longer work, depending on where the
allocation falls. Option (2) above is a quick fix assuming that the
crashkernel reservation is small enough. What's a typical crashkernel
option here? That series is probably more prone to reservation failures.

Option (1), i.e. this series, doesn't solve the problem raised by
Bhupesh unless one uses the crashkernel=X,low argument. It can actually
make it worse even for ZONE_DMA32 since the allocation can go above 4G
(assuming that we change the ZONE_DMA configuration to only limit it to
1GB on RPi4).

I'm more inclined to keep the crashkernel= behaviour to ZONE_DMA
allocations. If this is too small for typical kdump, we can look into
expanding ZONE_DMA to 4G on non-RPi4 hardware (we had patches on the
list). In addition, if Chen thinks allocations above 4G are still needed
or if RPi4 needs a sufficiently large crashkernel=, I'd rather have a
",high" option to explicitly require such access.

[1] http://lists.infradead.org/pipermail/kexec/2020-July/020777.html

-- 
Catalin
