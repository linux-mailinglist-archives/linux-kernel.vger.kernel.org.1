Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834162D102B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgLGMNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgLGMND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:13:03 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD4EC0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 04:12:23 -0800 (PST)
Received: from zn.tnic (p4fed31e1.dip0.t-ipconnect.de [79.237.49.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D1DB31EC03D5;
        Mon,  7 Dec 2020 13:12:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607343142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TdtSOyTOpTjTSBOSgG4WDCQi7gPbDzXTXixxH5iz0PY=;
        b=eX7eg8p0nul6zE+SUdm2p04WXKmuUIInXYNksw2VWei44SQTwFAk42XavAhC//9uYU+wNm
        GebsHHz8Oe9bQ/Lm38I/L1EHhlw4LskTSgUhcpmdrausspGRD4auhVlnGB/GbIIsGlzeuA
        7cMICkJACDC6Df/fOQBHai9ejX6ggyo=
Date:   Mon, 7 Dec 2020 13:10:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     konrad.wilk@oracle.com, hch@lst.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org, dave.hansen@linux-intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        brijesh.singh@amd.com, Thomas.Lendacky@amd.com, Jon.Grimm@amd.com,
        rientjes@google.com
Subject: Re: [PATCH v7] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201207121007.GD20489@zn.tnic>
References: <20201203032559.3388-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201203032559.3388-1-Ashish.Kalra@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 03:25:59AM +0000, Ashish Kalra wrote:
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 1bcfbcd2bfd7..46549bd3d840 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -485,7 +485,38 @@ static void print_mem_encrypt_feature_info(void)
>  	pr_cont("\n");
>  }

Any text about why 6% was chosen? A rule of thumb or so? Measurements?

> +#define SEV_ADJUST_SWIOTLB_SIZE_PERCENT	6
> +
>  /* Architecture __weak replacement functions */
> +unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
> +{
> +	unsigned long size = iotlb_default_size;
> +
> +	/*
> +	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> +	 * SEV uses SWOTLB to make this happen without changing device
> +	 * drivers. However, depending on the workload being run, the
> +	 * default 64MB of SWIOTLB may not be enough and`SWIOTLB may
> +	 * run out of buffers for DMA, resulting in I/O errors and/or
> +	 * performance degradation especially with high I/O workloads.
> +	 * Adjust the default size of SWIOTLB for SEV guests using
> +	 * a percentage of guest memory for SWIOTLB buffers.
> +	 * Also as the SWIOTLB bounce buffer memory is allocated
> +	 * from low memory, ensure that the adjusted size is within
> +	 * the limits of low available memory.
> +	 *
> +	 */
> +	if (sev_active()) {
> +		phys_addr_t total_mem = memblock_phys_mem_size();

Please integrate scripts/checkpatch.pl into your patch creation
workflow. Some of the warnings/errors *actually* make sense:

WARNING: Missing a blank line after declarations
#95: FILE: arch/x86/mm/mem_encrypt.c:511:
+               phys_addr_t total_mem = memblock_phys_mem_size();
+               size = total_mem * SEV_ADJUST_SWIOTLB_SIZE_PERCENT / 100;

But no need to resend now - just a hint for the future.

Konrad, ack?

On a 2G guest here, it says:

[    0.018373] SWIOTLB bounce buffer size adjusted to 122MB for SEV

so it makes sense to me.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
