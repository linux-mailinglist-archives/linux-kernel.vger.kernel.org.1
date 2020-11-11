Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE372AEE66
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgKKKFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:05:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbgKKKFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605089130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bNnwE/rGG9S0P+Kb0qM8Z9JriAsIW+8BA3E4vilBdmc=;
        b=BWViT7TOrJueHmjVq3vc2XeoMcIRDrNgWvja7O6AKrv5xmoXrkvgoiwH7y+2pakZLHolWL
        cqj2Mxivgod/rjZqkg+7JcHTT3VGctyuHuHFdFHgHc0y8FnEFPlBGcvYRPkpQ767nrSpov
        XWUpyiW8jL7nPhnUhAChSo1iDvwSX/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-SuXopVekMZWZAFOiF4iqNQ-1; Wed, 11 Nov 2020 05:05:26 -0500
X-MC-Unique: SuXopVekMZWZAFOiF4iqNQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40FDF188C129;
        Wed, 11 Nov 2020 10:05:24 +0000 (UTC)
Received: from [10.36.114.151] (ovpn-114-151.ams2.redhat.com [10.36.114.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1CE016EF5B;
        Wed, 11 Nov 2020 10:05:21 +0000 (UTC)
Subject: Re: [PATCH v1] mm/page_alloc: clear pages in alloc_contig_pages()
 with init_on_alloc=1 or __GFP_ZERO
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
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
 <b2d29dc2-cfe9-415d-7037-402dcc0c0f17@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5e104380-c0b1-4911-b484-b6e1e1c46f7d@redhat.com>
Date:   Wed, 11 Nov 2020 11:05:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b2d29dc2-cfe9-415d-7037-402dcc0c0f17@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.20 10:58, Vlastimil Babka wrote:
> On 11/11/20 10:06 AM, David Hildenbrand wrote:
>> On 11.11.20 09:47, Michal Hocko wrote:
>>> On Tue 10-11-20 20:32:40, David Hildenbrand wrote:
>>>> commit 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and
>>>> init_on_free=1 boot options") resulted with init_on_alloc=1 in all pages
>>>> leaving the buddy via alloc_pages() and friends to be
>>>> initialized/cleared/zeroed on allocation.
>>>>
>>>> However, the same logic is currently not applied to
>>>> alloc_contig_pages(): allocated pages leaving the buddy aren't cleared
>>>> with init_on_alloc=1 and init_on_free=0. Let's also properly clear
>>>> pages on that allocation path and add support for __GFP_ZERO.
>>>
>>> AFAIR we do not have any user for __GFP_ZERO right? Not that this is
>>
>> Sorry, I had extended information under "---" but accidentally
>> regenerated the patch before sending it out.
>>
>> __GFP_ZERO is not used yet. It's intended to be used in
>> https://lkml.kernel.org/r/20201029162718.29910-1-david@redhat.com
>> and I can move that change into a separate patch if desired.
>>
>>> harmful but it is better to call that explicitly because a missing
>>> implementation would be a real problem and as such a bug fix.
>>>
>>> I am also not sure handling init_on_free at the higher level is good.
>>> As we have discussed recently the primary point of this feature is to
>>> add clearing at very few well defined entry points rather than spill it over
>>> many places. In this case the entry point for the allocator is
>>> __isolate_free_page which removes pages from the page allocator. I
>>> haven't checked how much this is used elsewhere but I would expect
>>> init_on_alloc to be handled there.
>>
>> Well, this is the entry point to our range allocator, which lives in
>> page_alloc.c - used by actual high-level allocators (CMA, gigantic
>> pages, etc). It's just a matter of taste where we want to have that
>> handling exactly inside our allocator.
> 
> I agree alloc_contig_range() is fine as an entry point.

Thanks, let's see if Michal insists of having this somewhere inside 
isolate_freepages_range() instead.

-- 
Thanks,

David / dhildenb

