Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE0F30364C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbhAZGK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:10:27 -0500
Received: from foss.arm.com ([217.140.110.172]:47072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbhAYNDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:03:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A65411FB;
        Mon, 25 Jan 2021 05:02:18 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.45.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EA8B3F66E;
        Mon, 25 Jan 2021 05:02:15 -0800 (PST)
Date:   Mon, 25 Jan 2021 13:02:04 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v4 1/3] arm64: Improve kernel address detection of
 __is_lm_address()
Message-ID: <20210125130204.GA4565@C02TD0UTHF1T.local>
References: <20210122155642.23187-1-vincenzo.frascino@arm.com>
 <20210122155642.23187-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122155642.23187-2-vincenzo.frascino@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincenzo,

On Fri, Jan 22, 2021 at 03:56:40PM +0000, Vincenzo Frascino wrote:
> Currently, the __is_lm_address() check just masks out the top 12 bits
> of the address, but if they are 0, it still yields a true result.
> This has as a side effect that virt_addr_valid() returns true even for
> invalid virtual addresses (e.g. 0x0).
> 
> Improve the detection checking that it's actually a kernel address
> starting at PAGE_OFFSET.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Looking around, it seems that there are some existing uses of
virt_addr_valid() that expect it to reject addresses outside of the
TTBR1 range. For example, check_mem_type() in drivers/tee/optee/call.c.

Given that, I think we need something that's easy to backport to stable.

This patch itself looks fine, but it's not going to backport very far,
so I suspect we might need to write a preparatory patch that adds an
explicit range check to virt_addr_valid() which can be trivially
backported.

For this patch:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  arch/arm64/include/asm/memory.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 18fce223b67b..99d7e1494aaa 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -247,9 +247,11 @@ static inline const void *__tag_set(const void *addr, u8 tag)
>  
>  
>  /*
> - * The linear kernel range starts at the bottom of the virtual address space.
> + * Check whether an arbitrary address is within the linear map, which
> + * lives in the [PAGE_OFFSET, PAGE_END) interval at the bottom of the
> + * kernel's TTBR1 address range.
>   */
> -#define __is_lm_address(addr)	(((u64)(addr) & ~PAGE_OFFSET) < (PAGE_END - PAGE_OFFSET))
> +#define __is_lm_address(addr)	(((u64)(addr) ^ PAGE_OFFSET) < (PAGE_END - PAGE_OFFSET))
>  
>  #define __lm_to_phys(addr)	(((addr) & ~PAGE_OFFSET) + PHYS_OFFSET)
>  #define __kimg_to_phys(addr)	((addr) - kimage_voffset)
> -- 
> 2.30.0
> 
