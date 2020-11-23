Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F358D2C1596
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgKWUEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:04:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbgKWUEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:04:35 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC23420717;
        Mon, 23 Nov 2020 20:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1606161873;
        bh=8vMh6ZMp9z9BdPbBFZToxbqCwtSHMtbDr/NVvgJkd8A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S0FNdtUxNi/hpadZtgAByV84DtYvwCNoorHIAlnF8WyvUJ397wGpePVoxqFVBSLUm
         bslj1JXYmNJ6Npp5UyNKCPbI6F8/MLHYD7IbLw4hPtXqKW1M1BUoRIkRak6YE3m7bW
         8mv6K93hQf+AOehcNmzXxsX9mIx5m7pRu2YIB32Y=
Date:   Mon, 23 Nov 2020 12:04:32 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lin Feng <linf@wangsu.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net
Subject: Re: [PATCH] [RFC] init/main: fix broken buffer_init when
 DEFERRED_STRUCT_PAGE_INIT set
Message-Id: <20201123120432.3c0cb9b7e2f46150f132d592@linux-foundation.org>
In-Reply-To: <20201123110500.103523-1-linf@wangsu.com>
References: <20201123110500.103523-1-linf@wangsu.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020 19:05:00 +0800 Lin Feng <linf@wangsu.com> wrote:

> In the booting phase if CONFIG_DEFERRED_STRUCT_PAGE_INIT is set,
> we have following callchain:
> 
> start_kernel
> ...
>   mm_init
>     mem_init
>      memblock_free_all
>        reset_all_zones_managed_pages
>        free_low_memory_core_early
> ...
>   buffer_init
>     nr_free_buffer_pages
>       zone->managed_pages
> ...
>   rest_init
>     kernel_init
>       kernel_init_freeable
>         page_alloc_init_late
>           kthread_run(deferred_init_memmap, NODE_DATA(nid), "pgdatinit%d", nid);
>           wait_for_completion(&pgdat_init_all_done_comp);
>           ...
>           files_maxfiles_init
> 
> It's clear that buffer_init depends on zone->managed_pages, but it's reset
> in reset_all_zones_managed_pages after that pages are readded into
>  zone->managed_pages, but when buffer_init runs this process is half done
>  and most of them will finally be added till deferred_init_memmap done.
> In large memory couting of nr_free_buffer_pages drifts too much, also
> drifting from kernels to kernels on same hardware.
> 
> Fix is simple, it delays buffer_init run till deferred_init_memmap all done.
> 
> But as corrected by this patch, max_buffer_heads becomes very large,
> the value is roughly as many as 4 times of totalram_pages, formula:
> max_buffer_heads = nrpages * (10%) * (PAGE_SIZE / sizeof(struct buffer_head));
> 
> Say in a 64GB memory box we have 16777216 pages, then max_buffer_heads
> turns out to be roughly 67,108,864.
> In common cases, should a buffer_head be mapped to one page/block(4KB)?
> So max_buffer_heads never exceeds totalram_pages.
> IMO it's likely to make buffer_heads_over_limit bool value alwasy false,
> then make codes 'if (buffer_heads_over_limit)' test in vmscan unnecessary.
> Correct me if it's not true.

I agree - seems that on such a system we'll allow enough buffer_heads
to manage about 250GB worth of pagecache, for a 4kb filesystem
blocksize.

Perhaps this code is all a remnant of highmem systems, where
ZONE_NORMAL is considerably smaller than ZONE_HIGHMEM, and we don't
want to be consuming all of ZONE_NORMAL for highmem-attached
buffer_heads.

I'm not sure that it's all very harmful - we don't *need* to be
trimming away at the buffer_heads on a 64GB 4-bit system so the code is
really only functional on highmem machines.  And as far as I know, it
works OK on such machines.

