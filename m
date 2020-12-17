Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2152DCDA0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 09:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgLQI2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 03:28:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgLQI2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:28:03 -0500
Date:   Thu, 17 Dec 2020 10:27:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608193642;
        bh=frpXPBgDVHFosWMul7jo1G7mud658hMgY0gDjD8FzmM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=I+KHhrtBFQ9uN0v4rQDUWJEj9kiScJue0SpkR9fQkMH9UKQGlUABKYKefZtQ+bPjv
         3V5k70FQljpXOTht4ob7nI6+AV3BBE6XgBpe73zONGlsqUNtyww7a9gqPGsgoX9Tw7
         i2sYigy713Xw4EIQfA1Em1mwBHoXD3mAOQ8CfgB9soeWQgHE9mPQbe4wNzAGSm1q3c
         lr06/CQWkYksKnHiOfUZQhUJ87VdxY8WAg6A7w/AzrjdDUJJem8luZ+HP39EjE3u0f
         k32RgbCJz4SdDdXtFEHDmj0+krI96a+9D+wEVlOXoQqWnBEBbFxtnXtIwu41eJezH8
         /HlnIE7BBm1Tg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH] RISC-V: Fix usage of memblock_enforce_memory_limit
Message-ID: <20201217082714.GA366777@kernel.org>
References: <20201217074855.1948743-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217074855.1948743-1-atish.patra@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 11:48:55PM -0800, Atish Patra wrote:
> memblock_enforce_memory_limit accepts the maximum memory size not the last
> address. Fix the function invocation correctly.
> 
> Fixes: 1bd14a66ee52 ("RISC-V: Remove any memblock representing unusable memory area")
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/riscv/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 8e577f14f120..e4133c20744c 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -174,7 +174,7 @@ void __init setup_bootmem(void)
>  	 * Make sure that any memory beyond mem_start + (-PAGE_OFFSET) is removed
>  	 * as it is unusable by kernel.
>  	 */
> -	memblock_enforce_memory_limit(mem_start - PAGE_OFFSET);
> +	memblock_enforce_memory_limit(-PAGE_OFFSET);
>  
>  	/* Reserve from the start of the kernel to the end of the kernel */
>  	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
