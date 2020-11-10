Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7637F2ADE8E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbgKJSmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:42:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKJSmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:42:05 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72B27206F1;
        Tue, 10 Nov 2020 18:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605033724;
        bh=VzXs8SJ8/igjWdXAhydCqALWYiTEP6ScB1g/03HJK3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sAiBxdXGC1j2G2xc9wBe/SyCI3EZ/UuP/gtvJqvuCkWnA8ZK4ykD3XxWuSL4DUOcH
         x6GqCKDTm/HAXQ7CbwMXu8I7kTlQsALUpJNwcBCb7kFYNWtApa3opADVNg/bxIQeBO
         BoX6uEa50pLzHLRkQkUTuaehDUzaRT5nq8fxpU1Q=
Date:   Tue, 10 Nov 2020 20:41:57 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
Subject: Re: [PATCH] mm: memblock: always inline memblock_alloc
Message-ID: <20201110184157.GD4758@kernel.org>
References: <1605010817-21065-1-git-send-email-faiyazm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605010817-21065-1-git-send-email-faiyazm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 10, 2020 at 05:50:17PM +0530, Faiyaz Mohammed wrote:
> Since memblock_alloc is not getting inlined, memblock_reserve owner info
> is lost. Below information is not enough for memory accounting.
> for example:
> [    0.000000] memblock_alloc_try_nid: 1490 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 memblock_alloc+0x20/0x2c
> [    0.000000] memblock_reserve: [0x000000023f09a3c0-0x000000023f09a991] memblock_alloc_range_nid+0xc0/0x188
> 
> Add "__always_inline" to make sure it get inlined and to get the exact
> owner of the memblock_reserve.
> After adding __always_inline:
> [    0.000000] memblock_alloc_try_nid: 1490 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 start_kernel+0xa4/0x568
> [    0.000000] memblock_reserve: [0x000000023f09a3c0-0x000000023f09a991] memblock_alloc_range_nid+0xc0/0x188
 
I agree that making memblock_alloc() inline as well as other similar
wrappers would improve the debugability.
Still, it has nothing to do with memory accounting and owner tracking.
Please update the patch description to better explain what it actually
improves.

> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
> ---
>  include/linux/memblock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index ef13125..54f9544 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -404,7 +404,7 @@ void *memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align,
>  			     phys_addr_t min_addr, phys_addr_t max_addr,
>  			     int nid);
>  
> -static inline void * __init memblock_alloc(phys_addr_t size,  phys_addr_t align)
> +static __always_inline void * __init memblock_alloc(phys_addr_t size,  phys_addr_t align)

I think simply dropping __init here will make memblock_alloc() inline.
There are also several more convenience wrappers marked __init, do you
mind removing the __init annotation for them as well?

>  {
>  	return memblock_alloc_try_nid(size, align, MEMBLOCK_LOW_LIMIT,
>  				      MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE);

-- 
Sincerely yours,
Mike.
