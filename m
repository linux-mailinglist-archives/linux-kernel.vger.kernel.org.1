Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73C9273F09
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 11:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIVJ5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 05:57:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgIVJ5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 05:57:41 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCDA92388B;
        Tue, 22 Sep 2020 09:57:39 +0000 (UTC)
Date:   Tue, 22 Sep 2020 10:57:37 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Chen Jun <chenjun102@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rui.xiang@huawei.com,
        weiyongjun1@huawei.com
Subject: Re: [PATCH -next 3/5] mm/kmemleak: Add support for percpu memory
 leak detect
Message-ID: <20200922095736.GB15643@gaia>
References: <20200921020007.35803-1-chenjun102@huawei.com>
 <20200921020007.35803-4-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921020007.35803-4-chenjun102@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 02:00:05AM +0000, Chen Jun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Currently the reporting of the percpu chunks leaking problem
> are not supported. This patch introduces this function.
> 
> Since __percpu pointer is not pointing directly to the actual chunks,
> this patch creates an object for __percpu pointer, but marks it as no
> scan block, only check whether this pointer is referenced by other
> blocks.

OK, so you wanted NO_SCAN to not touch the block at all, not even update
the checksum. Maybe better add a new flag, NO_ACCESS (and we could use
it to track ioremap leaks, it's been on my wishlist for years).

> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index c09c6b59eda6..feedb72f06f2 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -283,6 +288,9 @@ static void hex_dump_object(struct seq_file *seq,
>  	const u8 *ptr = (const u8 *)object->pointer;
>  	size_t len;
>  
> +	if (object->flags & OBJECT_PERCPU)
> +		ptr = this_cpu_ptr((void __percpu *)object->pointer);

You may want to print the CPU number as well since the information is
likely different on another CPU. Also, I think this context is
preemptable, so it's better with a get_cpu/put_cpu().

> @@ -651,6 +672,19 @@ static void create_object(unsigned long ptr, size_t size, int min_count,
>  	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
>  }
>  
> +static void create_object(unsigned long ptr, size_t size, int min_count,
> +			  gfp_t gfp)
> +{
> +	__create_object(ptr, size, min_count, 0, gfp);
> +}
> +
> +static void create_object_percpu(unsigned long ptr, size_t size, int min_count,
> +				 gfp_t gfp)
> +{
> +	__create_object(ptr, size, min_count, OBJECT_PERCPU | OBJECT_NO_SCAN,
> +			gfp);
> +}
> +
>  /*
>   * Mark the object as not allocated and schedule RCU freeing via put_object().
>   */
> @@ -912,10 +946,12 @@ void __ref kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
>  	 * Percpu allocations are only scanned and not reported as leaks
>  	 * (min_count is set to 0).
>  	 */
> -	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
> +	if (kmemleak_enabled && ptr && !IS_ERR(ptr)) {
>  		for_each_possible_cpu(cpu)
>  			create_object((unsigned long)per_cpu_ptr(ptr, cpu),
>  				      size, 0, gfp);
> +		create_object_percpu((unsigned long)ptr, size, 1, gfp);
> +	}
>  }

A concern I have here is that ptr may overlap with an existing object
and the insertion in the rb tree will fail. For example, with !SMP,
ptr == per_cpu_ptr(ptr, 0), so create_object() will fail and kmemleak
gets disabled.

An option would to figure out how to allow overlapping ranges with rb
tree (or find a replacement for it if not possible).

Another option would be to have an additional structure to track the
__percpu pointers since they have their own range. If size is not
relevant, maybe go for an xarray, otherwise another rb tree (do we have
any instance of pointers referring some inner member of a __percpu
object?). The scan_object() function will have to search two trees.

-- 
Catalin
