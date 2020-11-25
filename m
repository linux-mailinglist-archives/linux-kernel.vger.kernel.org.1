Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA59F2C3B75
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 09:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgKYI56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 03:57:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:34306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbgKYI55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 03:57:57 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3423D206F7;
        Wed, 25 Nov 2020 08:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606294677;
        bh=i6ZqGfCBVCuxgZ+sLcYeDYGjVzau4pyveyA9EW2XQmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hC8B3Ccs+kPWQSCAuObmGCUqJwnHPLg3/Eb2K1mwXPFxCHmnx2dd3d6NkE2uLvXXO
         FyUeHZWO9xdfoZxM1DtxtH5OXu3Omc1SV0S/JRxN6VYfmBm6JpS4i0jzfl7KDfDW3K
         G710+LPLNzVGqhrIKAkBDAl5WCEkk6Eeu9komIuY=
Date:   Wed, 25 Nov 2020 10:57:50 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] sparc: Fix handling of page table constructor failure
Message-ID: <20201125085750.GL8537@kernel.org>
References: <20201125034655.27687-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125034655.27687-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 03:46:54AM +0000, Matthew Wilcox (Oracle) wrote:
> The page has just been allocated, so its refcount is 1.  free_unref_page()
> is for use on pages which have a zero refcount.  Use __free_page()
> like the other implementations of pte_alloc_one().
> 
> Fixes: 1ae9ae5f7df7 ("sparc: handle pgtable_page_ctor() fail")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/sparc/mm/init_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 96edf64d4fb3..182bb7bdaa0a 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -2894,7 +2894,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
>  	if (!page)
>  		return NULL;
>  	if (!pgtable_pte_page_ctor(page)) {
> -		free_unref_page(page);
> +		__free_page(page);
>  		return NULL;
>  	}
>  	return (pte_t *) page_address(page);
> -- 
> 2.29.2
> 

-- 
Sincerely yours,
Mike.
