Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E3F284891
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 10:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgJFIZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 04:25:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbgJFIZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 04:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601972756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=0aeOdWVbZAHk4o1fXf8LWAjGuj7aq9NtCl1Z2juiW9Y=;
        b=cH85SpgcMwU79/fvUlX/l6V/kzXJmBZ+lNp4jzbV7fZ/3YydTvbetaT6Q7bAU2Wnq8uQ+i
        CbR6qyVNLUnZ4liTCdnF1Mqs2ZFVSnQy8whJ8ANPV32kgbztCoZQ8OYh5iG6yjlnenWvQ7
        QN2p7RgNV7E1aXABYyDJqyb0RoZVIp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-LUC0rFTUOk-3ABuCxHbaXg-1; Tue, 06 Oct 2020 04:25:52 -0400
X-MC-Unique: LUC0rFTUOk-3ABuCxHbaXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 387CC1084D62;
        Tue,  6 Oct 2020 08:25:49 +0000 (UTC)
Received: from [10.36.114.219] (ovpn-114-219.ams2.redhat.com [10.36.114.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1513A9CBA;
        Tue,  6 Oct 2020 08:25:44 +0000 (UTC)
Subject: Re: [RFC PATCH v2 00/30] 1GB PUD THP support on x86_64
To:     Roman Gushchin <guro@fb.com>
Cc:     Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
References: <73394A41-16D8-431C-9E48-B14D44F045F8@nvidia.com>
 <20201002073205.GC20872@dhcp22.suse.cz>
 <9a7600e2-044a-50ca-acde-bf647932c751@redhat.com>
 <20201002081023.GA4555@dhcp22.suse.cz>
 <645b35a5-970d-dcfe-2b4a-04ebd4444756@redhat.com>
 <F3606096-EF9F-4F69-89DC-287095B649DC@nvidia.com>
 <20201005171632.GB2990415@carbon.DHCP.thefacebook.com>
 <bb654219-8df6-60a7-3cf5-f886ef5ca565@redhat.com>
 <20201005182518.GA3001706@carbon.dhcp.thefacebook.com>
 <824eee1c-a47b-361b-ad5b-6ed64a9cbd38@redhat.com>
 <20201005191118.GB3001706@carbon.dhcp.thefacebook.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <f7c6b7b2-f534-5a06-3d42-ec3e7f6962c1@redhat.com>
Date:   Tue, 6 Oct 2020 10:25:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005191118.GB3001706@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.10.20 21:11, Roman Gushchin wrote:
> On Mon, Oct 05, 2020 at 08:33:44PM +0200, David Hildenbrand wrote:
>> On 05.10.20 20:25, Roman Gushchin wrote:
>>> On Mon, Oct 05, 2020 at 07:27:47PM +0200, David Hildenbrand wrote:
>>>> On 05.10.20 19:16, Roman Gushchin wrote:
>>>>> On Mon, Oct 05, 2020 at 11:03:56AM -0400, Zi Yan wrote:
>>>>>> On 2 Oct 2020, at 4:30, David Hildenbrand wrote:
>>>>>>
>>>>>>> On 02.10.20 10:10, Michal Hocko wrote:
>>>>>>>> On Fri 02-10-20 09:50:02, David Hildenbrand wrote:
>>>>>>>>>>>> - huge page sizes controllable by the userspace?
>>>>>>>>>>>
>>>>>>>>>>> It might be good to allow advanced users to choose the page sizes, so they
>>>>>>>>>>> have better control of their applications.
>>>>>>>>>>
>>>>>>>>>> Could you elaborate more? Those advanced users can use hugetlb, right?
>>>>>>>>>> They get a very good control over page size and pool preallocation etc.
>>>>>>>>>> So they can get what they need - assuming there is enough memory.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I am still not convinced that 1G THP (TGP :) ) are really what we want
>>>>>>>>> to support. I can understand that there are some use cases that might
>>>>>>>>> benefit from it, especially:
>>>>>>>>
>>>>>>>> Well, I would say that internal support for larger huge pages (e.g. 1GB)
>>>>>>>> that can transparently split under memory pressure is a useful
>>>>>>>> funtionality. I cannot really judge how complex that would be
>>>>>>>
>>>>>>> Right, but that's then something different than serving (scarce,
>>>>>>> unmovable) gigantic pages from CMA / reserved hugetlbfs pool. Nothing
>>>>>>> wrong about *real* THP support, meaning, e.g., grouping consecutive
>>>>>>> pages and converting them back and forth on demand. (E.g., 1GB ->
>>>>>>> multiple 2MB -> multiple single pages), for example, when having to
>>>>>>> migrate such a gigantic page. But that's very different from our
>>>>>>> existing gigantic page code as far as I can tell.
>>>>>>
>>>>>> Serving 1GB PUD THPs from CMA is a compromise, since we do not want to
>>>>>> bump MAX_ORDER to 20 to enable 1GB page allocation in buddy allocator,
>>>>>> which needs section size increase. In addition, unmoveable pages cannot
>>>>>> be allocated in CMA, so allocating 1GB pages has much higher chance from
>>>>>> it than from ZONE_NORMAL.
>>>>>
>>>>> s/higher chances/non-zero chances
>>>>
>>>> Well, the longer the system runs (and consumes a significant amount of
>>>> available main memory), the less likely it is.
>>>>
>>>>>
>>>>> Currently we have nothing that prevents the fragmentation of the memory
>>>>> with unmovable pages on the 1GB scale. It means that in a common case
>>>>> it's highly unlikely to find a continuous GB without any unmovable page.
>>>>> As now CMA seems to be the only working option.
>>>>>
>>>>
>>>> And I completely dislike the use of CMA in this context (for example,
>>>> allocating via CMA and freeing via the buddy by patching CMA when
>>>> splitting up PUDs ...).
>>>>
>>>>> However it seems there are other use cases for the allocation of continuous
>>>>> 1GB pages: e.g. secretfd ( https://urldefense.proofpoint.com/v2/url?u=https-3A__lwn.net_Articles_831628_&d=DwIDaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=mdcwiGna7gQ4-RC_9XdaxFZ271PEQ09M0YtCcRoCkf8&s=4KlK2p0AVh1QdL8XDVeWyXPz4F63pdbbSCoxQlkNaa4&e=  ), where using
>>>>> 1GB pages can reduce the fragmentation of the direct mapping.
>>>>
>>>> Yes, see RFC v1 where I already cced Mike.
>>>>
>>>>>
>>>>> So I wonder if we need a new mechanism to avoid fragmentation on 1GB/PUD scale.
>>>>> E.g. something like a second level of pageblocks. That would allow to group
>>>>> all unmovable memory in few 1GB blocks and have more 1GB regions available for
>>>>> gigantic THPs and other use cases. I'm looking now into how it can be done.
>>>>
>>>> Anything bigger than sections is somewhat problematic: you have to track
>>>> that data somewhere. It cannot be the section (in contrast to pageblocks)
>>>
>>> Well, it's not a large amount of data: the number of 1GB regions is not that
>>> high even on very large machines.
>>
>> Yes, but then you can have very sparse systems. And some use cases would
>> actually want to avoid fragmentation on smaller levels (e.g., 128MB) -
>> optimizing memory efficiency by turning off banks and such ...
> 
> It's a definitely a good question.

Oh, and I forgot that there might be users that want bigger granularity
:) (primarily, memory hotunplug that wants to avoid ZONE_MOVABLE  but
still have higher chances to eventually unplug some memory)

> 
>>>
>>>>
>>>>> If anybody has any ideas here, I'll appreciate a lot.
>>>>
>>>> I already brought up the idea of ZONE_PREFER_MOVABLE (see RFC v1). That
>>>> somewhat mimics what CMA does (when sized reasonably), works well with
>>>> memory hot(un)plug, and is immune to misconfiguration. Within such a
>>>> zone, we can try to optimize the placement of larger blocks.
>>>
>>> Thank you for pointing at it!
>>>
>>> The main problem with it is the same as with ZONE_MOVABLE: it does require
>>> a boot-time educated guess on a good size. I admit that the CMA does too.
>>
>> "Educated guess" of ratios like 1:1. 1:2, and even 1:4 (known from
>> highmem times) ares usually perfectly fine. And if you mess up - in
>> comparison to CMA - you won't shoot yourself in the foot, you get less
>> gigantic pages - which is usually better than before. I consider that a
>> clear win. Perfect? No. Can we be perfect? unlikely.
> 
> I'm not necessarily opposing your idea, I just think it will be tricky
> to not introduce an additional overhead if the ratio is not perfectly
> chosen. And there is simple a cost of adding a zone.

Not sure this will be really visible - and if your kernel requires more
than 20%..50% unmovable data than something is usually really
fishy/special. The nice thing is that Linux will try to "auto-optimize"
within each zone already.

My gut feeling is that it's way easier to teach Linux (add zone, add
mmop_type, build zonelists, split memory similar to movablecore) -
however, that doesn't imply that it's better. We'll have to see.

> 
> But fundamentally we're speaking about the same thing: grouping pages
> by their movability on a smaller scale. With a new zone we'll split
> pages into two parts with a fixed border, with new pageblock layer
> in 1GB blocks.

I also discussed moving the border on demand, which is way more tricky
and would definitely be stuff for the future.

There are some papers about similar fragmentation-avoidance techniques,
mostly in the context of energy efficiency IIRC. Especially:
- PALLOC: https://ieeexplore.ieee.org/document/6925999
- Adaptive-buddy:
https://ieeexplore.ieee.org/document/7397629?reload=true&arnumber=7397629

IIRC, the problem about such approaches is that they are quite invasive
and degrade some workloads due to overhead.

> 
> I think the agreement is that we need such functionality.

Yeah, on my long todo list. I'll be prototyping ZONE_RPEFER_MOVABLE
soon, to see how it looks/feels/performs.

-- 
Thanks,

David / dhildenb

