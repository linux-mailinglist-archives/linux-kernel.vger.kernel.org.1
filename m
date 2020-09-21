Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EAE2736EC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 01:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgIUXxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 19:53:40 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7813 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgIUXxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 19:53:39 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f693cd50000>; Mon, 21 Sep 2020 16:52:53 -0700
Received: from [10.2.52.174] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Sep
 2020 23:53:39 +0000
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
To:     Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Jann Horn" <jannh@google.com>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-2-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <224908c1-5d0f-8e01-baa9-94ec2374971f@nvidia.com>
Date:   Mon, 21 Sep 2020 16:53:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921211744.24758-2-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600732373; bh=lUqOEjiyc0XMi6vf5IqR6vypRih/36Ro9Eiii1fmuqw=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=RNCsgmxC+mbUNEEUosTrnSCfikLaQTSMSkrd/NKWvLqAJ2DDbV9epgxcWRcD4YJDF
         wl5TPRKFF8ou1PEu+w1ayGPnvRQg1sAJ73KtW3QnOtDc2qeqIy4X1MGw7sVoGjmlb2
         UlicRQeoEKStiBSQ1O52vFWlQE2FCFVsaOLEZnYGrVrVp+JM5+5Co1vrePkJwDTNjF
         GQF/dHoUjM18ozs+CnaLA1rCKctyjr4JbLSr4NG0AO011J43hLwrEO5G/1MHO0vPgt
         DzolnQtk9w/KbZhyP8sStnhf0p/PZw9NkMUxpzQdZPUNf6aQYqsWzG5iXVJy+4TXGE
         ugEMF2ZMTMypg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/20 2:17 PM, Peter Xu wrote:
> (Commit message collected from Jason Gunthorpe)
> 
> Reduce the chance of false positive from page_maybe_dma_pinned() by keeping

Not yet, it doesn't. :)  More:

> track if the mm_struct has ever been used with pin_user_pages(). mm_structs
> that have never been passed to pin_user_pages() cannot have a positive
> page_maybe_dma_pinned() by definition. This allows cases that might drive up
> the page ref_count to avoid any penalty from handling dma_pinned pages.
> 
> Due to complexities with unpining this trivial version is a permanent sticky
> bit, future work will be needed to make this a counter.

How about this instead:

Subsequent patches intend to reduce the chance of false positives from
page_maybe_dma_pinned(), by also considering whether or not a page has
even been part of an mm struct that has ever had pin_user_pages*()
applied to any of its pages.

In order to allow that, provide a boolean value (even though it's not
implemented exactly as a boolean type) within the mm struct, that is
simply set once and never cleared. This will suffice for an early, rough
implementation that fixes a few problems.

Future work is planned, to provide a more sophisticated solution, likely
involving a counter, and *not* involving something that is set and never
cleared.

> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/linux/mm_types.h | 10 ++++++++++
>   kernel/fork.c            |  1 +
>   mm/gup.c                 |  6 ++++++
>   3 files changed, 17 insertions(+)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 496c3ff97cce..6f291f8b74c6 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -441,6 +441,16 @@ struct mm_struct {
>   #endif
>   		int map_count;			/* number of VMAs */
>   
> +		/**
> +		 * @has_pinned: Whether this mm has pinned any pages.  This can
> +		 * be either replaced in the future by @pinned_vm when it
> +		 * becomes stable, or grow into a counter on its own. We're
> +		 * aggresive on this bit now - even if the pinned pages were
> +		 * unpinned later on, we'll still keep this bit set for the
> +		 * lifecycle of this mm just for simplicity.
> +		 */
> +		int has_pinned;

I think this would be elegant as an atomic_t, and using atomic_set() and
atomic_read(), which seem even more self-documenting that what you have here.

But it's admittedly a cosmetic point, combined with my perennial fear that
I'm missing something when I look at a READ_ONCE()/WRITE_ONCE() pair. :)

It's completely OK to just ignore this comment, but I didn't want to completely
miss the opportunity to make it a tiny bit cleaner to the reader.

thanks,
-- 
John Hubbard
NVIDIA
