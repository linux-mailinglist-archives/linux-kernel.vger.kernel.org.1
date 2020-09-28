Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF7227B044
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgI1Oso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 10:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgI1Oso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:48:44 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5326A2083B;
        Mon, 28 Sep 2020 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601304523;
        bh=2RWukztD0ih+c2TxkNWDIpTZVxHWr1lB3uCiNAwqMJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z/1As4JdXTICmJeyR8FoS09xr1mgXXkwJPPTl2NZ/+IwXQ43cF4/lW0wPMELXt8m3
         84BV8bPxc2Uz9pO0IuqNPVCWf2YOI10VbcDabbolTdEuP7ffIzi3jwMmHoIqoFJkfW
         DRbKbiTmKUwGlC1qz+LIT7j0tT0tlLoANwLHZXws=
Date:   Mon, 28 Sep 2020 17:48:36 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] mm: __do_fault: fix pte_alloc_one spelling
Message-ID: <20200928144836.GZ2142832@kernel.org>
References: <20200914115833.2571188-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914115833.2571188-1-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

>On Mon, Sep 14, 2020 at 02:58:33PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Fix spelling of pte_alloc_one() in a comment in __do_fault().
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  mm/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 469af373ae76..d582ac79cb7d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3433,7 +3433,7 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
>  	 *				unlock_page(A)
>  	 * lock_page(B)
>  	 *				lock_page(B)
> -	 * pte_alloc_pne
> +	 * pte_alloc_one
>  	 *   shrink_page_list
>  	 *     wait_on_page_writeback(A)
>  	 *				SetPageWriteback(B)
> -- 
> 2.25.4
> 
> 

-- 
Sincerely yours,
Mike.
