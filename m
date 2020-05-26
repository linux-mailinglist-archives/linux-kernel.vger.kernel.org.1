Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD181E1E09
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 11:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbgEZJLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 05:11:12 -0400
Received: from foss.arm.com ([217.140.110.172]:47932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731491AbgEZJLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 05:11:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8251B1FB;
        Tue, 26 May 2020 02:11:10 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C1AA3F52E;
        Tue, 26 May 2020 02:11:09 -0700 (PDT)
Date:   Tue, 26 May 2020 10:11:07 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/z3fold: silence kmemleak false positives of slots
Message-ID: <20200526091106.GA17051@gaia>
References: <20200522220052.2225-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522220052.2225-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 06:00:52PM -0400, Qian Cai wrote:
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 8c3bb5e508b8..460b0feced26 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -43,6 +43,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/zpool.h>
>  #include <linux/magic.h>
> +#include <linux/kmemleak.h>
>  
>  /*
>   * NCHUNKS_ORDER determines the internal allocation granularity, effectively
> @@ -215,6 +216,8 @@ static inline struct z3fold_buddy_slots *alloc_slots(struct z3fold_pool *pool,
>  				 (gfp & ~(__GFP_HIGHMEM | __GFP_MOVABLE)));
>  
>  	if (slots) {
> +		/* It will be freed separately in free_handle(). */
> +		kmemleak_not_leak(slots);
>  		memset(slots->slot, 0, sizeof(slots->slot));
>  		slots->pool = (unsigned long)pool;
>  		rwlock_init(&slots->lock);

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

An alternative would have been a kmemleak_alloc(zhdr, sizeof(*zhdr), 1)
in init_z3fold_page() and a corresponding kmemleak_free() in
free_z3fold_page() (if !headless) since kmemleak doesn't track page
allocations. The advantage is that it would track the slots in case
there is a leak. But if the code is clear enough that the slots are
freed, just keep the kmemleak_not_leak() annotation.

-- 
Catalin
