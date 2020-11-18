Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B502B832F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 18:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgKRRjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 12:39:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgKRRjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 12:39:02 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F97E248CE;
        Wed, 18 Nov 2020 17:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605721141;
        bh=ect8hrurvHpqV7LsIdFQA4NZMDGMnFxigrdnNDKCjfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lM2rvn/2KA3q0c3yoB1RQpJ2Pi/bhIapgVQIJs4hSbc/RHw2YZ2WuqsSnI/FLJlxq
         1rSENn6dcpe3NO1uO6q9LhD10fQj3HsfowIY7mjCmvOd1IIIiciEm1qyVMrqC6vJGs
         4z1h6/eBUubqF2v4W/i1B9kvAWRdvEgdZqTeHTLU=
Date:   Wed, 18 Nov 2020 19:38:54 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        linuxarm@huawei.com
Subject: Re: [PATCH] arm64: mm: add support for memmap kernel parameters
Message-ID: <20201118173854.GA8537@kernel.org>
References: <20201118063314.22940-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118063314.22940-1-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barry,

On Wed, Nov 18, 2020 at 07:33:14PM +1300, Barry Song wrote:
> memmap should be an useful kernel parameter which has been supported by
> x86, mips and xtensa.

Why is this parameter should be useful for ARM64? 
My understanding is that it is required only to work around really
broken bootloaders, isn't it?

> This patch adds support for ARM64. At this stage,
> the below two modes are supported only:
> memmap=nn[KMG]@ss[KMG]
> Force usage of a specific region of memory
> 
> memmap=nn[KMG]$ss[KMG]
> Region of memory to be reserved is from ss to ss+nn
> 
> If users set memmap=exactmap before memmap=nn[KMG]@ss[KMG], they will
> get the exact memory specified by memmap=nn[KMG]@ss[KMG]. For example,
> on one machine with 4GB memory, "memmap=exactmap memmap=1G@1G" will
> make kernel use the memory from 1GB to 2GB only.
> 
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  arch/arm64/mm/init.c | 59 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 095540667f0f..f1c6bfdbc953 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -235,6 +235,65 @@ static int __init early_mem(char *p)
>  }
>  early_param("mem", early_mem);
>  
> +static int need_remove_real_memblock __initdata;
> +
> +static void __init parse_memmap_one(char *p)
> +{
> +	char *oldp;
> +	unsigned long start_at, mem_size;
> +
> +	if (!p)
> +		return;
> +
> +	if (!strncmp(p, "exactmap", 8)) {
> +		need_remove_real_memblock = 1;
> +		return;
> +	}
> +
> +	oldp = p;
> +	mem_size = memparse(p, &p);
> +	if (p == oldp)
> +		return;
> +
> +	switch (*p) {
> +	case '@':
> +		start_at = memparse(p + 1, &p);
> +		/*
> +		 * use the exactmap defined by nn[KMG]@ss[KMG], remove
> +		 * memblock populated by DT etc.
> +		 */
> +		if (need_remove_real_memblock) {
> +			need_remove_real_memblock = 0;
> +			memblock_remove(0, ULLONG_MAX);
> +		}
> +		memblock_add(start_at, mem_size);
> +		break;
> +	case '$':
> +		start_at = memparse(p + 1, &p);
> +		memblock_reserve(start_at, mem_size);
> +		break;
> +	default:
> +		pr_warn("Unrecognized memmap syntax: %s\n", p);
> +		break;
> +	}
> +}
> +
> +static int __init parse_memmap_opt(char *str)
> +{
> +	while (str) {
> +		char *k = strchr(str, ',');
> +
> +		if (k)
> +			*k++ = 0;
> +
> +		parse_memmap_one(str);
> +		str = k;
> +	}
> +
> +	return 0;
> +}
> +early_param("memmap", parse_memmap_opt);
> +
>  static int __init early_init_dt_scan_usablemem(unsigned long node,
>  		const char *uname, int depth, void *data)
>  {
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
