Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB102AEE4A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgKKJ6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:58:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:59556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgKKJ6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:58:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04BB2AC23;
        Wed, 11 Nov 2020 09:58:14 +0000 (UTC)
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20201110193240.25401-1-david@redhat.com>
 <20201111084738.GT12240@dhcp22.suse.cz>
 <4ebc711e-7fbc-62aa-b88f-3d6ffa9379ff@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1] mm/page_alloc: clear pages in alloc_contig_pages()
 with init_on_alloc=1 or __GFP_ZERO
Message-ID: <b2d29dc2-cfe9-415d-7037-402dcc0c0f17@suse.cz>
Date:   Wed, 11 Nov 2020 10:58:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <4ebc711e-7fbc-62aa-b88f-3d6ffa9379ff@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/20 10:06 AM, David Hildenbrand wrote:
> On 11.11.20 09:47, Michal Hocko wrote:
>> On Tue 10-11-20 20:32:40, David Hildenbrand wrote:
>>> commit 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and
>>> init_on_free=1 boot options") resulted with init_on_alloc=1 in all pages
>>> leaving the buddy via alloc_pages() and friends to be
>>> initialized/cleared/zeroed on allocation.
>>>
>>> However, the same logic is currently not applied to
>>> alloc_contig_pages(): allocated pages leaving the buddy aren't cleared
>>> with init_on_alloc=1 and init_on_free=0. Let's also properly clear
>>> pages on that allocation path and add support for __GFP_ZERO.
>> 
>> AFAIR we do not have any user for __GFP_ZERO right? Not that this is
> 
> Sorry, I had extended information under "---" but accidentally
> regenerated the patch before sending it out.
> 
> __GFP_ZERO is not used yet. It's intended to be used in
> https://lkml.kernel.org/r/20201029162718.29910-1-david@redhat.com
> and I can move that change into a separate patch if desired.
> 
>> harmful but it is better to call that explicitly because a missing
>> implementation would be a real problem and as such a bug fix.
>> 
>> I am also not sure handling init_on_free at the higher level is good.
>> As we have discussed recently the primary point of this feature is to
>> add clearing at very few well defined entry points rather than spill it over
>> many places. In this case the entry point for the allocator is
>> __isolate_free_page which removes pages from the page allocator. I
>> haven't checked how much this is used elsewhere but I would expect
>> init_on_alloc to be handled there.
> 
> Well, this is the entry point to our range allocator, which lives in
> page_alloc.c - used by actual high-level allocators (CMA, gigantic
> pages, etc). It's just a matter of taste where we want to have that
> handling exactly inside our allocator.

I agree alloc_contig_range() is fine as an entry point.

> isolate_freepages_range()->split_map_pages() does the post_alloc_hook
> call. As we certainly don't want to zero pages during compaction, we
> could either pass the gfp_mask/"bool clear" down to that functions and
> handle it in there, or handle it in isolate_freepages_range(), after the
> ->split_map_pages() call. Whatever you prefer.

I'd rather not put it in post_alloc_hook() where the bool would then get checked 
from allocator fast path as well.
Maybe split_map_page() then as it contains a for-cycle already.

> Thanks!
> 

