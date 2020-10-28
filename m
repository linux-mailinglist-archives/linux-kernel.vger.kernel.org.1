Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B3929D964
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389760AbgJ1Wyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:54:54 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16470 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389708AbgJ1Wyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:54:46 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9908fa0001>; Tue, 27 Oct 2020 23:00:26 -0700
Received: from [10.2.58.85] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 06:00:22 +0000
Subject: Re: [PATCH 1/2] mm: reorganize internal_get_user_pages_fast()
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>
CC:     <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>, Peter Xu <peterx@redhat.com>
References: <1-v1-281e425c752f+2df-gup_fork_jgg@nvidia.com>
 <16c50bb0-431d-5bfb-7b80-a8af0b4da90f@nvidia.com>
 <20201027093301.GA16090@quack2.suse.cz> <20201027131509.GU36674@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <0e04a7ed-a3e6-76f6-0fa8-26e2bbf10ee3@nvidia.com>
Date:   Tue, 27 Oct 2020 23:00:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201027131509.GU36674@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603864826; bh=DvH8rRYN+1btG24CbugM+DbRy3SuuPBLL4zfqXI2x70=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=UFaVq85de//dl0Jhx4SQC8+HZZkH78201146S2/JEhYEqUWnkNzX+bMeKzceyFZ+O
         Rhp7WNN9kDmhSLbSbKObLLpQRN7fQnZFlriOgcBhZk/jZRuUv+cdgBCy4ozgOXwyFf
         M0OoKUIniQvD1XHkUS2491uLXIYc3w2nw/j/zUuJBHkyYETty9g5s0iVbrb14pOQ2Z
         6JdrsAKfifv5/4gJPJC1VmK7NUR2bXbZPhnQI6Rh/7YwIfzBrjayjqFMHLdAUx7yDC
         nOkr/JSsirijfDgHVdqy5zwq5PGxOk7sAdLE2bgHZ2rgb1QMQkJ5YljKeWKtpL0Grv
         GbQpwzb9V8wHw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/20 6:15 AM, Jason Gunthorpe wrote:
> On Tue, Oct 27, 2020 at 10:33:01AM +0100, Jan Kara wrote:
>> On Fri 23-10-20 21:44:17, John Hubbard wrote:
>>> On 10/23/20 5:19 PM, Jason Gunthorpe wrote:
>>>> +	start += (unsigned long)nr_pinned << PAGE_SHIFT;
>>>> +	pages += nr_pinned;
>>>> +	ret = __gup_longterm_unlocked(start, nr_pages - nr_pinned, gup_flags,
>>>> +				      pages);
>>>> +	if (ret < 0) {
>>>>    		/* Have to be a bit careful with return values */
>>>
>>> ...and can we move that comment up one level, so that it reads:
>>>
>>> 	/* Have to be a bit careful with return values */
>>> 	if (ret < 0) {
>>> 		if (nr_pinned)
>>> 			return nr_pinned;
>>> 		return ret;
>>> 	}
>>> 	return ret + nr_pinned;
>>>
>>> Thinking about this longer term, it would be nice if the whole gup/pup API
>>> set just stopped pretending that anyone cares about partial success, because
>>> they *don't*. If we had return values of "0 or -ERRNO" throughout, and an
>>> additional set of API wrappers that did some sort of limited retry just like
>>> some of the callers do, that would be a happier story.
>>
>> Actually there are callers that care about partial success. See e.g.
>> iov_iter_get_pages() usage in fs/direct_io.c:dio_refill_pages() or
>> bio_iov_iter_get_pages(). These places handle partial success just fine and
>> not allowing partial success from GUP could regress things...
> 
> I looked through a bunch of call sites, and there are a wack that

So did I! :)

> actually do only want a complete return and are carrying a bunch of
> code to fix it:
> 
> 	pvec = kvmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
> 	if (!pvec)
> 		return -ENOMEM;
> 
> 	do {
> 		unsigned num_pages = npages - pinned;
> 		uint64_t ptr = userptr->ptr + pinned * PAGE_SIZE;
> 		struct page **pages = pvec + pinned;
> 
> 		ret = pin_user_pages_fast(ptr, num_pages,
> 					  !userptr->ro ? FOLL_WRITE : 0, pages);
> 		if (ret < 0) {
> 			unpin_user_pages(pvec, pinned);
> 			kvfree(pvec);
> 			return ret;
> 		}
> 
> 		pinned += ret;
> 
> 	} while (pinned < npages);
> 
> Is really a lot better if written as:
> 
>     	pvec = kvmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
> 	if (!pvec)
> 		return -ENOMEM;
> 	ret = pin_user_pages_fast(userptr->ptr, npages, FOLL_COMPLETE |
> 	                          (!userptr->ro ? FOLL_WRITE : 0),
> 				  pvec);
>          if (ret) {
>                kvfree(pvec);
> 	      return ret;
>          }
> 
> (eg FOLL_COMPLETE says to return exactly npages or fail)


Yes, exactly. And if I reverse the polarity (to Christoph's FOLL_PARTIAL, instead
of FOLL_COMPLETE) it's even smaller, slightly. Which is where I am leaning now.


> 
> Some code assumes things work that way already anyhow:
> 
> 	/* Pin user pages for DMA Xfer */
> 	err = pin_user_pages_unlocked(user_dma.uaddr, user_dma.page_count,
> 			dma->map, FOLL_FORCE);
> 
> 	if (user_dma.page_count != err) {
> 		IVTV_DEBUG_WARN("failed to map user pages, returned %d instead of %d\n",
> 			   err, user_dma.page_count);
> 		if (err >= 0) {
> 			unpin_user_pages(dma->map, err);
> 			return -EINVAL;
> 		}
> 		return err;
> 	}
> 
> Actually I'm quite surprised I didn't find too many missing the tricky
> unpin_user_pages() on the error path - eg
> videobuf_dma_init_user_locked() is wrong.
> 

Well. That's not accidental. "Some People" (much thanks to Souptick Joarder, btw) have
been fixing up many of those sites, during the pin_user_pages() conversions. Otherwise
you would have found about 10 or 15 more.

I'll fix up that one above (using your Reported-by, I assume), unless someone else is
already taking care of it.


thanks,
-- 
John Hubbard
NVIDIA
