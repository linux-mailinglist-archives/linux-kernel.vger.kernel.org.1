Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE892F8D22
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 12:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbhAPLoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 06:44:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59865 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725979AbhAPLoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 06:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610797354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lYWPEyiRYQkPrhW6cczH/pyf7YFbufnMuIaorWSwGGE=;
        b=GVCFQOaUTf9PrpPAsIRzGzC1zs2AgmjT4Afv76AEpaUYAysW+GSE6jdECjV2jYkh5LdNwZ
        Lxs0cgj2tzy76x/ZfxRiizXhuK4FEa3g7bd3sPxEiUywzb55HsJ7VbMhfuKPzcy2+3+Cja
        U+hSahg7vAkKyOfZUPK+ESwsJFGug4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-q1sYkXJwPEW5-YQUP0SaQg-1; Sat, 16 Jan 2021 06:42:30 -0500
X-MC-Unique: q1sYkXJwPEW5-YQUP0SaQg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E55E51005504;
        Sat, 16 Jan 2021 11:42:26 +0000 (UTC)
Received: from [10.36.112.59] (ovpn-112-59.ams2.redhat.com [10.36.112.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E35015C1C2;
        Sat, 16 Jan 2021 11:42:11 +0000 (UTC)
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
To:     John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
References: <20210110004435.26382-1-aarcange@redhat.com>
 <bb071419-bf40-c5ed-4b2d-d5eb03031b0a@redhat.com>
 <20210115183721.GG4605@ziepe.ca>
 <a21e6fdf-5cac-6fda-242e-7909af96027a@redhat.com>
 <cba836c6-4054-c966-8254-a11915351b6b@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b46a0eb9-f80f-e459-d31d-ed9074e38ede@redhat.com>
Date:   Sat, 16 Jan 2021 12:42:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <cba836c6-4054-c966-8254-a11915351b6b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.01.21 04:40, John Hubbard wrote:
> On 1/15/21 11:46 AM, David Hildenbrand wrote:
>>>> 7) There is no easy way to detect if a page really was pinned: we might
>>>> have false positives. Further, there is no way to distinguish if it was
>>>> pinned with FOLL_WRITE or not (R vs R/W). To perform reliable tracking
>>>> we most probably would need more counters, which we cannot fit into
>>>> struct page. (AFAIU, for huge pages it's easier).
>>>
>>> I think this is the real issue. We can only store so much information,
>>> so we have to decide which things work and which things are broken. So
>>> far someone hasn't presented a way to record everything at least..
>>
>> I do wonder how many (especially long-term) GUP readers/writers we have
>> to expect, and especially, support for a single base page. Do we have a
>> rough estimate?
>>
>> With RDMA, I would assume we only need a single one (e.g., once RDMA
>> device; I'm pretty sure I'm wrong, sounds too easy).
>> With VFIO I guess we need one for each VFIO container (~ in the worst
>> case one for each passthrough device).
>> With direct I/O, vmsplice and other GUP users ?? No idea.
>>
>> If we could somehow put a limit on the #GUP we support, and fail further
>> GUP (e.g., -EAGAIN?) once a limit is reached, we could partition the
>> refcount into something like (assume max #15 GUP READ and #15 GUP R/W,
>> which is most probably a horribly bad choice)
>>
>> [ GUP READ ][ GUP R/W ] [  ordinary ]
>> 31  ...  28 27  ...  24 23   ....   0
>>
>> But due to saturate handling in "ordinary", we would lose further 2 bits
>> (AFAIU), leaving us "only" 22 bits for "ordinary". Now, I have no idea
>> how many bits we actually need in practice.
>>
>> Maybe we need less for GUP READ, because most users want GUP R/W? No idea.
>>
>> Just wild ideas. Most probably that has already been discussed, and most
>> probably people figured that it's impossible :)
>>
> 
> I proposed this exact idea a few days ago [1]. It's remarkable that we both
> picked nearly identical values for the layout! :)

Heh! Somehow I missed that. But well, there were *a lot* of mails :)

> 
> But as the responses show, security problems prevent pursuing that approach.
It still feels kind of wrong to waste valuable space in the memmap.


In an ideal world (well, one that still only allows for a 64 byte memmap
:) ), we would:

1) Partition the refcount into separate fields that cannot overflow into
each other, similar to my example above, but maybe add even more fields.

2) Reject attempts that would result in an overflow to everything except
the "ordinary" field (e.g., GUP fields in my example above).

3) Put an upper limit on the "ordinary" field that we ever expect for
sane workloads (E.g., 10 bits). In addition, reserve some bits (like the
saturate logic) that we handle as a "red zone".

4) For the "ordinary" field, as soon as we enter the red zone, we know
we have an attack going on. We continue on paths that we cannot fail
(e.g., get_page()) but eventually try stopping the attacker(s). AFAIU,
we know the attacker(s) are something (e.g., one ore multiple processes)
that has direct access to the page in their address space. Of course,
the more paths we can reject, the better.


Now, we would:

a) Have to know what sane upper limits on the "ordinary" field are. I
have no idea which values we can expect. Attacker vs. sane workload.

b) Need a way to identify the attacker(s). In the simplest case, this is
a single process. In the hard case, this involves many processes.

c) Need a way to stop the attacker(s). Doing that out of random context
is problematic. Last resort is doing this asynchronously from another
thread, which leaves more time for the attacker to do harm.


Of course, problem gets more involved as soon as we might have a
malicious child process that uses a page from a well-behaving parent
process for the attack.

Imagine we kill relevant processes, we might end up killing someone
who's not responsible. And even if we don't kill, but instead reject
try_get_page(), we might degrade the well-behaving parent process AFAIKS.

Alternatives to killing the process might be unmapping the problematic
page from the address space.

Reminds me a little about handling memory errors for a page, eventually
killing all users of that page. mm/memory-failure.c:kill_procs().


Complicated problem :)

-- 
Thanks,

David / dhildenb

