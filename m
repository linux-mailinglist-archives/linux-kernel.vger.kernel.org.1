Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062542BB1E8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgKTSB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:01:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729059AbgKTSBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:01:25 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E163F2240B;
        Fri, 20 Nov 2020 18:01:22 +0000 (UTC)
Date:   Fri, 20 Nov 2020 18:01:20 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     jannh@google.com, hch@infradead.org, davem@davemloft.net,
        akpm@linux-foundation.org, anthony.yznaga@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH] sparc64: Use arch_validate_flags() to validate ADI flag
Message-ID: <20201120180119.GM24344@gaia>
References: <20201023175611.12819-1-khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023175611.12819-1-khalid.aziz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Khalid,

On Fri, Oct 23, 2020 at 11:56:11AM -0600, Khalid Aziz wrote:
> diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
> index f94532f25db1..274217e7ed70 100644
> --- a/arch/sparc/include/asm/mman.h
> +++ b/arch/sparc/include/asm/mman.h
> @@ -57,35 +57,39 @@ static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
>  {
>  	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_ADI))
>  		return 0;
> -	if (prot & PROT_ADI) {
> -		if (!adi_capable())
> -			return 0;
> +	return 1;
> +}

We kept the equivalent of !adi_capable() check in the arm64
arch_validate_prot() and left arch_validate_flags() more relaxed. I.e.
you can pass PROT_MTE to mmap() even if the hardware doesn't support
MTE. This is in line with the pre-MTE ABI where unknown mmap() flags
would be ignored while mprotect() would reject them. This discrepancy
isn't nice but we decided to preserve the pre-MTE mmap ABI behaviour.
Anyway, it's up to you if you want to change the sparc behaviour, I
don't think it matters in practice.

I think with this patch, arch_validate_prot() no longer needs the 'addr'
argument. Maybe you can submit an additional patch to remove them (not
urgent, the compiler should get rid of them).

>  
> -		if (addr) {
> -			struct vm_area_struct *vma;
> +#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
> +/* arch_validate_flags() - Ensure combination of flags is valid for a
> + *	VMA.
> + */
> +static inline bool arch_validate_flags(unsigned long vm_flags)
> +{
> +	/* If ADI is being enabled on this VMA, check for ADI
> +	 * capability on the platform and ensure VMA is suitable
> +	 * for ADI
> +	 */
> +	if (vm_flags & VM_SPARC_ADI) {
> +		if (!adi_capable())
> +			return false;
>  
> -			vma = find_vma(current->mm, addr);
> -			if (vma) {
> -				/* ADI can not be enabled on PFN
> -				 * mapped pages
> -				 */
> -				if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
> -					return 0;
> +		/* ADI can not be enabled on PFN mapped pages */
> +		if (vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
> +			return false;
>  
> -				/* Mergeable pages can become unmergeable
> -				 * if ADI is enabled on them even if they
> -				 * have identical data on them. This can be
> -				 * because ADI enabled pages with identical
> -				 * data may still not have identical ADI
> -				 * tags on them. Disallow ADI on mergeable
> -				 * pages.
> -				 */
> -				if (vma->vm_flags & VM_MERGEABLE)
> -					return 0;
> -			}
> -		}
> +		/* Mergeable pages can become unmergeable
> +		 * if ADI is enabled on them even if they
> +		 * have identical data on them. This can be
> +		 * because ADI enabled pages with identical
> +		 * data may still not have identical ADI
> +		 * tags on them. Disallow ADI on mergeable
> +		 * pages.
> +		 */
> +		if (vm_flags & VM_MERGEABLE)
> +			return false;

Ah, you added a check to the madvise(MADV_MERGEABLE) path to ignore the
flag if VM_SPARC_ADI. On arm64 we intercept memcmp_pages() but we have a
PG_arch_2 flag to mark a page as containing tags. Either way should
work.

FWIW, if you are happy with the mmap() rejecting PROT_ADI on
!adi_capable() hardware:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
