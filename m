Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAA02FD786
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbhATRvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:51:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389093AbhATRuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:50:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FEEE22287;
        Wed, 20 Jan 2021 17:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611164978;
        bh=gWJ3LYkk8EdHO2U/O11zpJu6VZAjhVPlgiFK9NxvnQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NzlzrhGhR64hLDNjdUnWz792iIICFwDeMfctE/Aq4GidHmoQV3zMFzq840JTrIKv9
         sYTm0N5YeEIPwszztezGhkeO8kmA4ZWAsaw2oytAoxQD1u1LpM7QHEzGlP/X6fS0jD
         MwAGVg1fq8mG4WchHTH7wZrosxaDPdMKNIDdfk+5NoxZJ7ChNUUFbTOSFbxFd1LI3U
         Ukh/4h/GuSH0RK4Ct35Z0ytGFu0YcKeuP14lKpz11V2aDvEZCXypH95+fZ4T9xQrgr
         fEsiEbi97YuqZvSHp8a0ru87WJPT2oNXKNaAqHP8Kts9q1BLlTETFrx/tjCIvhL1Gd
         iKgxCND99RFUQ==
Date:   Wed, 20 Jan 2021 17:49:33 +0000
From:   Will Deacon <will@kernel.org>
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        anshuman.khandual@arm.com, david@redhat.com,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 1/1] arm64: reduce section size for sparsemem
Message-ID: <20210120174933.GA20981@willie-the-truck>
References: <cover.1610146597.git.sudaraja@codeaurora.org>
 <15cf9a2359197fee0168f820c5c904650d07939e.1610146597.git.sudaraja@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15cf9a2359197fee0168f820c5c904650d07939e.1610146597.git.sudaraja@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 03:16:00PM -0800, Sudarshan Rajagopalan wrote:
> Reducing the section size helps reduce wastage of reserved memory
> for huge memory holes in sparsemem model. But having a much smaller
> section size bits could break PMD mappings for vmemmap and wouldn't
> accomodate the highest order page for certain page size granule configs.
> It is determined that SECTION_SIZE_BITS of 27 (128MB) could be ideal
> default value for 4K_PAGES that gives least section size without breaking
> PMD based vmemmap mappings. For simplicity, 16K_PAGES could follow the
> same as 4K_PAGES. And the least SECTION_SIZE_BITS for 64K_PAGES is 29
> that could accomodate MAX_ORDER.
> 
> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> ---
>  arch/arm64/include/asm/sparsemem.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
> index 1f43fcc79738..ff08ff6b677c 100644
> --- a/arch/arm64/include/asm/sparsemem.h
> +++ b/arch/arm64/include/asm/sparsemem.h
> @@ -7,7 +7,13 @@
>  
>  #ifdef CONFIG_SPARSEMEM
>  #define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
> -#define SECTION_SIZE_BITS	30
> -#endif
> +
> +#if defined(CONFIG_ARM64_4K_PAGES) || defined(CONFIG_ARM64_16K_PAGES)
> +#define SECTION_SIZE_BITS 27
> +#else
> +#define SECTION_SIZE_BITS 29
> +#endif /* CONFIG_ARM64_4K_PAGES || CONFIG_ARM64_16K_PAGES */
> +
> +#endif /* CONFIG_SPARSEMEM*/

Please can you repost this in light of the comments from Anshuman?

Thanks,

Will
