Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E902F46FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbhAMI7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:59:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57493 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727118AbhAMI7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610528297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mVNNiUHtKnN+lrpIVyZO4RzDAKrpGJ9Oe0vLEJ6Epqc=;
        b=azt4/+/E/ux3vGxbZ+BBSGV1JlKjvZYjeMCs0nYzxGDjZ7O2m2Vw0hdEYzCrQob+ui4739
        LqUi8BfBUejLE8bHK+QUl6nr/tpxosounI8ngZLEXWLWYrqD/qBCLyLn7wC4VGEm+SSFUX
        mhPhAjG3SITo7Iji970le1EnS0sKaAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-6UqFg2SxOjKvrJS-nDy2Jg-1; Wed, 13 Jan 2021 03:58:13 -0500
X-MC-Unique: 6UqFg2SxOjKvrJS-nDy2Jg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66276AFA81;
        Wed, 13 Jan 2021 08:58:10 +0000 (UTC)
Received: from [10.36.114.135] (ovpn-114-135.ams2.redhat.com [10.36.114.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE56574453;
        Wed, 13 Jan 2021 08:57:59 +0000 (UTC)
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
From:   David Hildenbrand <david@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
References: <20210110004435.26382-1-aarcange@redhat.com>
 <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
 <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
 <X/prosulFrEoNnoF@redhat.com>
 <CAHk-=wjZTMsv0_GOyQpLRk_5U1r5W8e21f8sV0jykK=z47hjGQ@mail.gmail.com>
 <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com>
 <45806a5a-65c2-67ce-fc92-dc8c2144d766@nvidia.com>
 <CAHk-=wipa-9wEuWHBjourmXAVHdeqDa59UxW6ZJ_Oqg6-Dwvdw@mail.gmail.com>
 <CAHk-=wje9r3fREBdZcOu=NihGczBtkqkhXRPDhY-ZkNVv=thiQ@mail.gmail.com>
 <20210113021619.GL35215@casper.infradead.org>
 <CAHk-=wjWMieNV3nAJgoG5prEHBEcOZiREmLUr499tA9NMttEqQ@mail.gmail.com>
 <0cbefee2-70e9-9666-2d0c-ee2807e0fef9@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ad270819-31c4-82c2-25c8-7c8436495805@redhat.com>
Date:   Wed, 13 Jan 2021 09:57:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <0cbefee2-70e9-9666-2d0c-ee2807e0fef9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.01.21 09:52, David Hildenbrand wrote:
> On 13.01.21 04:31, Linus Torvalds wrote:
>> On Tue, Jan 12, 2021 at 6:16 PM Matthew Wilcox <willy@infradead.org> wrote:
>>>
>>> The thing about the speculative page cache references is that they can
>>> temporarily bump a refcount on a page which _used_ to be in the page
>>> cache and has now been reallocated as some other kind of page.
>>
>> Oh, and thinking about this made me think we might actually have a
>> serious bug here, and it has nothing what-so-ever to do with COW, GUP,
>> or even the page count itself.
>>
>> It's unlikely enough that I think it's mostly theoretical, but tell me
>> I'm wrong.
>>
>> PLEASE tell me I'm wrong:
>>
>> CPU1 does page_cache_get_speculative under RCU lock
>>
>> CPU2 frees and re-uses the page
>>
>>     CPU1                CPU2
>>     ----                ----
>>
>>     page = xas_load(&xas);
>>     if (!page_cache_get_speculative(page))
>>             goto repeat;
>>     .. succeeds ..
>>
>>                         remove page from XA
>>                         release page
>>                         reuse for something else
>>
>>     .. and then re-check ..
>>     if (unlikely(page != xas_reload(&xas))) {
>>             put_page(page);
>>             goto repeat;
>>     }
>>
>> ok, the above all looks fine. We got the speculative ref, but then we
>> noticed that its' not valid any more, so we put it again. All good,
>> right?
>>
>> Wrong.
>>
>> What if that "reuse for something else" was actually really quick, and
>> both allocated and released it?
>>
>> That still sounds good, right? Yes, now the "put_page()" will be the
>> one that _actually_ releases the page, but we're still fine, right?
>>
>> Very very wrong.
>>
>> The "reuse for something else" on CPU2 might have gotten not an
>> order-0 page, but a *high-order* page. So it allocated (and then
>> immediately free'd) maybe an order-2 allocation with _four_ pages, and
>> the re-use happened when we had coalesced the buddy pages.
>>
>> But when we release the page on CPU1, we will release just _one_ page,
>> and the other three pages will be lost forever.
>>
>> IOW, we restored the page count perfectly fine, but we screwed up the
>> page sizes and buddy information.
>>
>> Ok, so the above is so unlikely from a timing standpoint that I don't
>> think it ever happens, but I don't see why it couldn't happen in
>> theory.
>>
>> Please somebody tell me I'm missing some clever thing we do to make
>> sure this can actually not happen..
> 
> Wasn't that tackled by latest (not merged AFAIKs) __free_pages() changes?
> 
> I'm only able to come up with the doc update, not with the oroginal
> fix/change
> 
> https://lkml.kernel.org/r/20201027025523.3235-1-willy@infradead.org
> 

Sorry, found it, it's in v5.10

commit e320d3012d25b1fb5f3df4edb7bd44a1c362ec10
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Tue Oct 13 16:56:04 2020 -0700

    mm/page_alloc.c: fix freeing non-compound pages

and

commit 7f194fbb2dd75e9346b305b8902e177b423b1062
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Mon Dec 14 19:11:09 2020 -0800

    mm/page_alloc: add __free_pages() documentation

is in v5.11-rc1

-- 
Thanks,

David / dhildenb

