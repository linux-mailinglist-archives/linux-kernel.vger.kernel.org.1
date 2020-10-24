Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB03297CEB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 16:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762108AbgJXOsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 10:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756171AbgJXOsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 10:48:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3352C0613CE;
        Sat, 24 Oct 2020 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Pc0tPJ+2gLNyCWPDXA3+iryc+AiLLhMWdQeLQo+DJBY=; b=LjjpnNPLHYbTvYAsjwjBqPacCA
        E4Ynu7QWK51pqovwA6pUVwuTVJbHMCg+97uJzEqspdrupc5oQYXC/gIUQ6xlpvDpOIFNnGLmw3uZ+
        O0oY9CPA+wofVPsN4qFuyTQxN9KQesJWCYuolQ3zhozuUn2jLNdcvzpX1sBAMGo07dV9mSK5/cQiI
        BClqxy2pMR5M8lfGY+VugQm36SRQVhOk6ZHLSBu1s8Hbny2ilUM5Ljj6WkPVNDD01SDV0ppvC0xwL
        JVxZypnNVI+TTR5EpnJFSvToyI6LHkpKC+3Nwx95ArXTjKBAT8RRZkrFYu8XQQWQuyGonWPYXxy+e
        Qvqzj5Jw==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWKqS-0000tw-VQ; Sat, 24 Oct 2020 14:48:38 +0000
Subject: Re: [PATCH] arch/Kconfig: fix a few trivial spelling mistakes in
 Kconfig
To:     Colin King <colin.king@canonical.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201024125549.78254-1-colin.king@canonical.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <92ed2fc0-0894-55ec-2cba-885acc66662f@infradead.org>
Date:   Sat, 24 Oct 2020 07:48:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201024125549.78254-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/20 5:55 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are a couple of trivial spelling mistakes, fix these.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 56b6ccc0e32d..ce4e84366418 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -261,7 +261,7 @@ config ARCH_HAS_SET_DIRECT_MAP
>  
>  #
>  # Select if the architecture provides the arch_dma_set_uncached symbol to
> -# either provide an uncached segement alias for a DMA allocation, or
> +# either provide an uncached segment alias for a DMA allocation, or
>  # to remap the page tables in place.
>  #
>  config ARCH_HAS_DMA_SET_UNCACHED
> @@ -314,14 +314,14 @@ config ARCH_32BIT_OFF_T
>  config HAVE_ASM_MODVERSIONS
>  	bool
>  	help
> -	  This symbol should be selected by an architecure if it provides
> +	  This symbol should be selected by an architecture if it provides
>  	  <asm/asm-prototypes.h> to support the module versioning for symbols
>  	  exported from assembly code.
>  
>  config HAVE_REGS_AND_STACK_ACCESS_API
>  	bool
>  	help
> -	  This symbol should be selected by an architecure if it supports
> +	  This symbol should be selected by an architecture if it supports
>  	  the API needed to access registers and stack entries from pt_regs,
>  	  declared in asm/ptrace.h
>  	  For example the kprobes-based event tracer needs this API.
> @@ -336,7 +336,7 @@ config HAVE_RSEQ
>  config HAVE_FUNCTION_ARG_ACCESS_API
>  	bool
>  	help
> -	  This symbol should be selected by an architecure if it supports
> +	  This symbol should be selected by an architecture if it supports
>  	  the API needed to access function arguments from pt_regs,
>  	  declared in asm/ptrace.h
>  
> 


-- 
~Randy
