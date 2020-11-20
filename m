Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCA82BA094
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 03:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgKTCj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 21:39:26 -0500
Received: from foss.arm.com ([217.140.110.172]:42298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgKTCjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 21:39:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA0811478;
        Thu, 19 Nov 2020 18:39:24 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8C3E3F70D;
        Thu, 19 Nov 2020 18:39:22 -0800 (PST)
Subject: Re: [PATCH] arm/mm: Convert PUD level pgtable helper macros into
 functions
To:     linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
References: <1604979410-23997-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <44b9c9d4-4c45-4efa-9c1a-289d917d2a9e@arm.com>
Date:   Fri, 20 Nov 2020 08:09:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1604979410-23997-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/20 9:06 AM, Anshuman Khandual wrote:
> Macros used as functions can be problematic from the compiler perspective.
> There was a build failure report caused primarily because of non reference
> of an argument variable. Hence convert PUD level pgtable helper macros into
> functions in order to avoid such problems in the future. In the process, it
> fixes the argument variables sequence in set_pud() which probably remained
> hidden for being a macro.
> 
> https://lore.kernel.org/linux-mm/202011020749.5XQ3Hfzc-lkp@intel.com/
> https://lore.kernel.org/linux-mm/5fa49698.Vu2O3r+dU20UoEJ+%25lkp@intel.com/
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Only build tested.

Hello Russel,

Any updates on this ? These changes come from an earlier discussion
on the mm list. Wondering if this too can also be submitted in the
arm patch tracking system. Thank you.

- Anshuman

+ Linus Walleij <linus.walleij@linaro.org>

> 
>  arch/arm/include/asm/pgtable-2level.h | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
> index 3502c2f..9d4f5ee 100644
> --- a/arch/arm/include/asm/pgtable-2level.h
> +++ b/arch/arm/include/asm/pgtable-2level.h
> @@ -177,11 +177,28 @@
>   * the pud: the pud entry is never bad, always exists, and can't be set or
>   * cleared.
>   */
> -#define pud_none(pud)		(0)
> -#define pud_bad(pud)		(0)
> -#define pud_present(pud)	(1)
> -#define pud_clear(pudp)		do { } while (0)
> -#define set_pud(pud,pudp)	do { } while (0)
> +static inline int pud_none(pud_t pud)
> +{
> +	return 0;
> +}
> +
> +static inline int pud_bad(pud_t pud)
> +{
> +	return 0;
> +}
> +
> +static inline int pud_present(pud_t pud)
> +{
> +	return 1;
> +}
> +
> +static inline void pud_clear(pud_t *pudp)
> +{
> +}
> +
> +static inline void set_pud(pud_t *pudp, pud_t pud)
> +{
> +}
>  
>  static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
>  {
> 
