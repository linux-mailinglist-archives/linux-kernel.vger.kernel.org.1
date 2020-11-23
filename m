Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FE82C03DE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgKWLMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:12:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbgKWLMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:12:19 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A390C20729;
        Mon, 23 Nov 2020 11:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606129938;
        bh=pb4Go2JyNL0QLyA7eUeTpK8YGyPsHlVFVkkpOAFF2+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KnAR0eBjYg503oHliulkSYZ2BQv7U0mnNXsrxwOyUY/K7+HcLZV6BW762+cAlbBYY
         amxkA39BVs9oOwlv1fNGhQxuwD3ReQO/5IuOqCUoK2dc3Wqto3yDzJr39t0BEojsoP
         Hn8bqO0YGK+o97t8GzJ6k2rPprm5pzestGnqADWU=
Date:   Mon, 23 Nov 2020 11:12:14 +0000
From:   Will Deacon <will@kernel.org>
To:     youngjun <her0gyugyu@gmail.com>, rossmeikleham@gmail.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: update RANDOMIZE_MODULE_REGION_FULL config
 description
Message-ID: <20201123111213.GB9957@willie-the-truck>
References: <20201122070855.10506-1-her0gyugyu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122070855.10506-1-her0gyugyu@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 21, 2020 at 11:08:55PM -0800, youngjun wrote:
> module randomization is reduced. (range to 2 GB)
> RANDOMIZE_MODULE_REGION_FULL config description is not updated.
> update RANDOMIZE_MODULE_REGION_FULL config description.
> 
> Signed-off-by: youngjun <her0gyugyu@gmail.com>
> ---
>  arch/arm64/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This looks like the same patch as the one I reviewed here:

https://lore.kernel.org/r/20201109112705.GC14356@willie-the-truck

but the commit message isn't a lot better. Please could you (or Ross)
post a version with a fixed commit message?

Thanks,

Will

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1515f6f153a0..0da551828a59 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1804,11 +1804,11 @@ config RANDOMIZE_BASE
>  	  If unsure, say N.
>  
>  config RANDOMIZE_MODULE_REGION_FULL
> -	bool "Randomize the module region over a 4 GB range"
> +	bool "Randomize the module region over a 2 GB range"
>  	depends on RANDOMIZE_BASE
>  	default y
>  	help
> -	  Randomizes the location of the module region inside a 4 GB window
> +	  Randomizes the location of the module region inside a 2 GB window
>  	  covering the core kernel. This way, it is less likely for modules
>  	  to leak information about the location of core kernel data structures
>  	  but it does imply that function calls between modules and the core
> -- 
> 2.17.1
> 
