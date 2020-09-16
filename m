Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560E826BF48
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgIPI21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:28:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgIPI2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:28:25 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F17D20872;
        Wed, 16 Sep 2020 08:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600244904;
        bh=OTC3FlcJE6Dg/iOvApxI6QhF/kIkiQWIOKiqpniO2sM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCskcxSo5A5L9/apeK6y3IFpTwgjRRq917gJ6PED0ff0/VbCYwWZxNOz7oidzbmFI
         TupfIAhdJIJuQ/1ksgkNXQx/YZqSMWJoKA7O9uipPPPgYFEdyErlMOJWhE1WfmaUjI
         OAdacoiJWpPhCFxmaghj3rGA5zCvOjRLtvFJQ9+0=
Date:   Wed, 16 Sep 2020 09:28:20 +0100
From:   Will Deacon <will@kernel.org>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, shan.gavin@gmail.com
Subject: Re: [PATCH 2/2] arm64/mm: Enable color zero pages
Message-ID: <20200916082819.GB27496@willie-the-truck>
References: <20200916032523.13011-1-gshan@redhat.com>
 <20200916032523.13011-3-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916032523.13011-3-gshan@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 01:25:23PM +1000, Gavin Shan wrote:
> This enables color zero pages by allocating contigous page frames
> for it. The number of pages for this is determined by L1 dCache
> (or iCache) size, which is probbed from the hardware.
> 
>    * Add cache_total_size() to return L1 dCache (or iCache) size
> 
>    * Implement setup_zero_pages(), which is called after the page
>      allocator begins to work, to allocate the contigous pages
>      needed by color zero page.
> 
>    * Reworked ZERO_PAGE() and define __HAVE_COLOR_ZERO_PAGE.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/include/asm/cache.h   | 22 ++++++++++++++++++++
>  arch/arm64/include/asm/pgtable.h |  9 ++++++--
>  arch/arm64/kernel/cacheinfo.c    | 34 +++++++++++++++++++++++++++++++
>  arch/arm64/mm/init.c             | 35 ++++++++++++++++++++++++++++++++
>  arch/arm64/mm/mmu.c              |  7 -------
>  5 files changed, 98 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> index a4d1b5f771f6..420e9dde2c51 100644
> --- a/arch/arm64/include/asm/cache.h
> +++ b/arch/arm64/include/asm/cache.h
> @@ -39,6 +39,27 @@
>  #define CLIDR_LOC(clidr)	(((clidr) >> CLIDR_LOC_SHIFT) & 0x7)
>  #define CLIDR_LOUIS(clidr)	(((clidr) >> CLIDR_LOUIS_SHIFT) & 0x7)
>  
> +#define CSSELR_TND_SHIFT	4
> +#define CSSELR_TND_MASK		(UL(1) << CSSELR_TND_SHIFT)
> +#define CSSELR_LEVEL_SHIFT	1
> +#define CSSELR_LEVEL_MASK	(UL(7) << CSSELR_LEVEL_SHIFT)
> +#define CSSELR_IND_SHIFT	0
> +#define CSSERL_IND_MASK		(UL(1) << CSSELR_IND_SHIFT)
> +
> +#define CCSIDR_64_LS_SHIFT	0
> +#define CCSIDR_64_LS_MASK	(UL(7) << CCSIDR_64_LS_SHIFT)
> +#define CCSIDR_64_ASSOC_SHIFT	3
> +#define CCSIDR_64_ASSOC_MASK	(UL(0x1FFFFF) << CCSIDR_64_ASSOC_SHIFT)
> +#define CCSIDR_64_SET_SHIFT	32
> +#define CCSIDR_64_SET_MASK	(UL(0xFFFFFF) << CCSIDR_64_SET_SHIFT)
> +
> +#define CCSIDR_32_LS_SHIFT	0
> +#define CCSIDR_32_LS_MASK	(UL(7) << CCSIDR_32_LS_SHIFT)
> +#define CCSIDR_32_ASSOC_SHIFT	3
> +#define CCSIDR_32_ASSOC_MASK	(UL(0x3FF) << CCSIDR_32_ASSOC_SHIFT)
> +#define CCSIDR_32_SET_SHIFT	13
> +#define CCSIDR_32_SET_MASK	(UL(0x7FFF) << CCSIDR_32_SET_SHIFT)

I don't think we should be inferring cache structure from these register
values. The Arm ARM helpfully says:

  | You cannot make any inference about the actual sizes of caches based
  | on these parameters.

so we need to take the topology information from elsewhere.

But before we get into that, can you justify why we need to do this at all,
please? Do you have data to show the benefit of adding this complexity?

Cheers,

Will
