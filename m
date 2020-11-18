Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF92B2B87D3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 23:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgKRWjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 17:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgKRWjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 17:39:23 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D6BC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 14:39:23 -0800 (PST)
Received: from zn.tnic (p200300ec2f0caf003ca6ed11c9851040.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:af00:3ca6:ed11:c985:1040])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 242FF1EC0473;
        Wed, 18 Nov 2020 23:39:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605739162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Nucy5FwvBOpAW9Hru//1nPQRh1YMjfPMlPyS0c5OiG8=;
        b=r2cucCQAalfzAmb1gka6cmeJJZu5vVOJt6QvkwJvhppmv/9taW0ffqEZE5PzEFMzbAAr4M
        k9qceZmAZqsjznzd3IN3/qieoKLjlDNNCHR+NJ4ZrPz5Qqtn6o6SZZGBth4AzeSJsSa1SM
        BcIpO6VANxCaalJJLYsMCuy7a7Z5Ty0=
Date:   Wed, 18 Nov 2020 23:39:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     konrad.wilk@oracle.com, hch@lst.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org, dave.hansen@linux-intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        brijesh.singh@amd.com, Thomas.Lendacky@amd.com, jon.grimm@amd.com,
        rientjes@google.com
Subject: Re: [PATCH v5] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201118223916.GP7472@zn.tnic>
References: <20201118201243.18510-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201118201243.18510-1-Ashish.Kalra@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 08:12:43PM +0000, Ashish Kalra wrote:
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3511736fbc74..0f42911cea57 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1166,6 +1166,10 @@ void __init setup_arch(char **cmdline_p)
>  	if (boot_cpu_has(X86_FEATURE_GBPAGES))
>  		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
>  
> +#ifdef CONFIG_X86_64
> +	swiotlb_adjust();
> +#endif

Add an empty stub in include/linux/swiotlb.h for the !CONFIG_SWIOTLB
case and get rid of the ifdeffery please.

> +unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
> +{
> +	unsigned long size = 0;
> +
> +	/*
> +	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> +	 * SEV uses SWOTLB to make this happen without changing device
> +	 * drivers. However, depending on the workload being run, the
> +	 * default 64MB of SWIOTLB may not be enough & SWIOTLB may
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
> +		pr_info("SEV adjusted max SWIOTLB size = %luMB",

Please make that message more user-friendly.

...

> +void __init swiotlb_adjust(void)
> +{
> +	unsigned long size;
> +
> +	/*
> +	 * If swiotlb parameter has not been specified, give a chance to
> +	 * architectures such as those supporting memory encryption to
> +	 * adjust/expand SWIOTLB size for their use.
> +	 */
> +	if (!io_tlb_nslabs) {
> +		size = arch_swiotlb_adjust(IO_TLB_DEFAULT_SIZE);
> +		if (size) {
> +			size = ALIGN(size, 1 << IO_TLB_SHIFT);
> +			io_tlb_nslabs = size >> IO_TLB_SHIFT;
> +			io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
> +
> +			pr_info("architecture adjusted SWIOTLB slabs = %lu\n",

That one too: what does "architecture adjusted SWIOTLB slabs" even
mean?!

Put yourself in your code user's shoes and see if that message makes
sense to her/him.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
