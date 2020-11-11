Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1527E2AEECA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgKKKci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:32:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29113 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726229AbgKKKch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605090756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nQanxT8X3ELig0XMX5/McNaRarJw9LhbTOfvsbkiJyA=;
        b=ejkvmBsyGlqVnbMqCGlI/MAup1rOADJ+yNAHh/e+qaAfEFy6kf/2+ZSn8c4ADcXuaZdNmC
        gtRD+W/FcmUkUrXIvMPOBH0p8/ofP+eHe6zT5VqPcPZBWuam97Ig9VmBfDWXGBAfBaTomj
        NzFfUoDILCDqh3/2DnANcBp5bloUhrU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-sLOqzFc1OsW-ZY8MMNDcjw-1; Wed, 11 Nov 2020 05:32:32 -0500
X-MC-Unique: sLOqzFc1OsW-ZY8MMNDcjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E5B3186DD4D;
        Wed, 11 Nov 2020 10:32:30 +0000 (UTC)
Received: from [10.36.114.151] (ovpn-114-151.ams2.redhat.com [10.36.114.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF30E7513C;
        Wed, 11 Nov 2020 10:32:26 +0000 (UTC)
Subject: Re: [PATCH v1] mm/page_alloc: clear pages in alloc_contig_pages()
 with init_on_alloc=1 or __GFP_ZERO
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
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
 <5e104380-c0b1-4911-b484-b6e1e1c46f7d@redhat.com>
 <20201111102207.GV12240@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c828742e-ce1c-08e1-5204-7bfb9e0f564a@redhat.com>
Date:   Wed, 11 Nov 2020 11:32:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201111102207.GV12240@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.20 11:22, Michal Hocko wrote:
> On Wed 11-11-20 11:05:21, David Hildenbrand wrote:
>> On 11.11.20 10:58, Vlastimil Babka wrote:
>>> On 11/11/20 10:06 AM, David Hildenbrand wrote:
>>>> On 11.11.20 09:47, Michal Hocko wrote:
>>>>> On Tue 10-11-20 20:32:40, David Hildenbrand wrote:
>>>>>> commit 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and
>>>>>> init_on_free=1 boot options") resulted with init_on_alloc=1 in all pages
>>>>>> leaving the buddy via alloc_pages() and friends to be
>>>>>> initialized/cleared/zeroed on allocation.
>>>>>>
>>>>>> However, the same logic is currently not applied to
>>>>>> alloc_contig_pages(): allocated pages leaving the buddy aren't cleared
>>>>>> with init_on_alloc=1 and init_on_free=0. Let's also properly clear
>>>>>> pages on that allocation path and add support for __GFP_ZERO.
>>>>>
>>>>> AFAIR we do not have any user for __GFP_ZERO right? Not that this is
>>>>
>>>> Sorry, I had extended information under "---" but accidentally
>>>> regenerated the patch before sending it out.
>>>>
>>>> __GFP_ZERO is not used yet. It's intended to be used in
>>>> https://lkml.kernel.org/r/20201029162718.29910-1-david@redhat.com
>>>> and I can move that change into a separate patch if desired.
> 
> OK, it would make sense to add it with its user.
> 
>>>>> harmful but it is better to call that explicitly because a missing
>>>>> implementation would be a real problem and as such a bug fix.
>>>>>
>>>>> I am also not sure handling init_on_free at the higher level is good.
>>>>> As we have discussed recently the primary point of this feature is to
>>>>> add clearing at very few well defined entry points rather than spill it over
>>>>> many places. In this case the entry point for the allocator is
>>>>> __isolate_free_page which removes pages from the page allocator. I
>>>>> haven't checked how much this is used elsewhere but I would expect
>>>>> init_on_alloc to be handled there.
>>>>
>>>> Well, this is the entry point to our range allocator, which lives in
>>>> page_alloc.c - used by actual high-level allocators (CMA, gigantic
>>>> pages, etc). It's just a matter of taste where we want to have that
>>>> handling exactly inside our allocator.
> 
> Yes I completely agree here. I just believe it should the lowest we can
> achieve.
> 
>>> I agree alloc_contig_range() is fine as an entry point.
>>
>> Thanks, let's see if Michal insists of having this somewhere inside
>> isolate_freepages_range() instead.
>   
> It's not that I would be insisting. I am just pointing out that changes
> like this one go against the idea of init_on_alloc because it is adding
> more special casing and long term more places to be really careful about
> when one has to be really careful to not undermine the security aspect
> of the feature. I haven't really checked why compaction is not the
> problem but I suspect it is the fact that it unconditionally copy the
> full page content to the isolated page so there is no way to sneak
> any data leak there. That is fine. We should however make that clear by

Exactly.

> using a special cased function which skips this particular
> initialization and make sure everybody else will just do the right thing
> without much thinking.

I totally agree, but I think we don't have many places where free pages 
actually leave the buddy besides alloc_pages() and friends (compaction 
is something special). I agree having a single place to handle that 
would be preferred. I'll have a look if that can be reworked without 
doing too much harm / affecting other hot paths.

-- 
Thanks,

David / dhildenb

