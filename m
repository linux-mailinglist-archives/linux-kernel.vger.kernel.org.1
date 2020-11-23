Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA8E2C1194
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 18:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390304AbgKWRG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 12:06:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43806 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390295AbgKWRGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:06:54 -0500
Received: from zn.tnic (p200300ec2f0bbc0000a4f4bc59f4c3b0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:bc00:a4:f4bc:59f4:c3b0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3A19A1EC0453;
        Mon, 23 Nov 2020 18:06:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606151213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XCdr223yFPf0fIu1JE5bbRlc9o/DCKzzYdZoouood6g=;
        b=peGB592Kii+J5hllpaKDM+2d6k8bvzKbro3E7pgl9EMNtkCnTPdytqULIcto1VCYCE40H2
        iqwYUAA925pWMBjIcRNXMxCJ9bGyIjZ5oHpB9mgr+wDxZNRCbEjuhgJRhQZF2Vv13R+q6m
        fTQzmmgIYgQvYEuhHoeqEyI5hD2dfM8=
Date:   Mon, 23 Nov 2020 18:06:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     konrad.wilk@oracle.com, hch@lst.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org, dave.hansen@linux-intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        brijesh.singh@amd.com, Thomas.Lendacky@amd.com, jon.grimm@amd.com,
        rientjes@google.com
Subject: Re: [PATCH v6] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201123170647.GE15044@zn.tnic>
References: <20201119214205.11062-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201119214205.11062-1-Ashish.Kalra@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 09:42:05PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> For SEV, all DMA to and from guest has to use shared (un-encrypted) pages.
> SEV uses SWIOTLB to make this happen without requiring changes to device
> drivers.  However, depending on workload being run, the default 64MB of
> SWIOTLB might not be enough and SWIOTLB may run out of buffers to use
> for DMA, resulting in I/O errors and/or performance degradation for
> high I/O workloads.
> 
> Increase the default size of SWIOTLB for SEV guests using a minimum
> value of 128MB and a maximum value of 512MB, determining on amount
> of provisioned guest memory.

That sentence needs massaging.

> Using late_initcall() interface to invoke swiotlb_adjust() does not
> work as the size adjustment needs to be done before mem_encrypt_init()
> and reserve_crashkernel() which use the allocated SWIOTLB buffer size,
> hence calling it explicitly from setup_arch().

"hence call it ... "

> 
> The SWIOTLB default size adjustment is added as an architecture specific

"... is added... " needs to be "Add ..."

> interface/callback to allow architectures such as those supporting memory
> encryption to adjust/expand SWIOTLB size for their use.
> 
> v5 fixed build errors and warnings as
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/kernel/setup.c   |  2 ++
>  arch/x86/mm/mem_encrypt.c | 32 ++++++++++++++++++++++++++++++++
>  include/linux/swiotlb.h   |  6 ++++++
>  kernel/dma/swiotlb.c      | 24 ++++++++++++++++++++++++
>  4 files changed, 64 insertions(+)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3511736fbc74..b073d58dd4a3 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1166,6 +1166,8 @@ void __init setup_arch(char **cmdline_p)
>  	if (boot_cpu_has(X86_FEATURE_GBPAGES))
>  		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
>  
> +	swiotlb_adjust();
> +
>  	/*
>  	 * Reserve memory for crash kernel after SRAT is parsed so that it
>  	 * won't consume hotpluggable memory.
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 3f248f0d0e07..c79a0d761db5 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -490,6 +490,38 @@ static void print_mem_encrypt_feature_info(void)
>  }
>  
>  /* Architecture __weak replacement functions */
> +unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
> +{
> +	unsigned long size = 0;

	unsigned long size = iotlb_default_size;

> +
> +	/*
> +	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> +	 * SEV uses SWOTLB to make this happen without changing device
> +	 * drivers. However, depending on the workload being run, the
> +	 * default 64MB of SWIOTLB may not be enough & SWIOTLB may
						     ^

Use words pls, not "&".


> +	 * run out of buffers for DMA, resulting in I/O errors and/or
> +	 * performance degradation especially with high I/O workloads.
> +	 * Increase the default size of SWIOTLB for SEV guests using
> +	 * a minimum value of 128MB and a maximum value of 512MB,
> +	 * depending on amount of provisioned guest memory.
> +	 */
> +	if (sev_active()) {
> +		phys_addr_t total_mem = memblock_phys_mem_size();
> +
> +		if (total_mem <= SZ_1G)
> +			size = max(iotlb_default_size, (unsigned long) SZ_128M);
> +		else if (total_mem <= SZ_4G)
> +			size = max(iotlb_default_size, (unsigned long) SZ_256M);
> +		else
> +			size = max(iotlb_default_size, (unsigned long) SZ_512M);
> +
> +		pr_info("SWIOTLB bounce buffer size adjusted to %luMB for SEV platform",

just "... for SEV" - no need for "platform".

...

> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c19379fabd20..3be9a19ea0a5 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -163,6 +163,30 @@ unsigned long swiotlb_size_or_default(void)
>  	return size ? size : (IO_TLB_DEFAULT_SIZE);
>  }
>  
> +unsigned long __init __weak arch_swiotlb_adjust(unsigned long size)
> +{
> +	return 0;

That, of course, needs to return size, not 0.

> +}
> +
> +void __init swiotlb_adjust(void)
> +{
> +	unsigned long size;
> +
> +	/*
> +	 * If swiotlb parameter has not been specified, give a chance to
> +	 * architectures such as those supporting memory encryption to
> +	 * adjust/expand SWIOTLB size for their use.
> +	 */

And when you preset the function-local argument "size" with the size
coming in as the size argument of arch_swiotlb_adjust()...

> +	if (!io_tlb_nslabs) {
> +		size = arch_swiotlb_adjust(IO_TLB_DEFAULT_SIZE);
> +		if (size) {

... you don't have to do if (size) here either but simply use size to
compute io_tlb_nslabs, I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
