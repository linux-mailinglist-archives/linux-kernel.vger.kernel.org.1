Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3292EE801
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 22:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbhAGVyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 16:54:06 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7476 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbhAGVyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:54:05 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff782d50000>; Thu, 07 Jan 2021 13:53:25 -0800
Received: from [10.2.53.45] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Jan
 2021 21:53:19 +0000
Subject: Re: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce
 wrprotect_tlb_flush_pending
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
CC:     Linux-MM <linux-mm@kvack.org>,
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Jann Horn" <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107200402.31095-3-aarcange@redhat.com>
 <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
 <X/d2DyLfXZmBIreY@redhat.com>
 <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <4100a6f5-ab0b-f7e5-962f-ea1dbcb1e47e@nvidia.com>
Date:   Thu, 7 Jan 2021 13:53:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610056405; bh=2Enr8zZzrRIuzaFBB3FnDpda0abNOlM4hlTcF1+lRRU=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=EQQubCwY/WGbBJymt8e1kbIlYKu/+WMVZvGF47CI1Gz9KMwEsOaiYykIJy+ADcbbt
         IPBLiJaYobTtGhzXqXSOFF8OHU2h2aXRJ+t7VzxjcZThQ+UeXH0HaZa/32p4wXSWz4
         GDP+DWt5YhQQz6btVZxcXf3xqqeUeEcs0W3d6+tomwMgvP6DCV9RDMR31+POAdZciu
         rK0DYCATEOUQuqNnB67T2JLuYD8EP1YClLw1q1dKsJEt14f9ONOZDp5F8SRWfDtc0q
         8wb9KvoB8QRgMdroRSA7EF34jopwqd4lFKYzv6pw6pPVaveInkIWr/4yJP7MXEidCm
         nstTSXm5KeL2w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/21 1:29 PM, Linus Torvalds wrote:
> On Thu, Jan 7, 2021 at 12:59 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>>
>> The problem is it's not even possible to detect reliably if there's
>> really a long term GUP pin because of speculative pagecache lookups.
> 
> So none of the normal code _needs_ that any more these days, which is
> what I think is so nice. Any pinning will do the COW, and then we have
> the logic to make sure it stays writable, and that keeps everything
> nicely coherent and is all fairly simple.
> 
> And yes, it does mean that if somebody then explicitly write-protects
> a page, it may end up being COW'ed after all, but if you first pinned
> it, and then started playing with the protections of that page, why
> should you be surprised?
> 
> So to me, this sounds like a "don't do that then" situation.
> 
> Anybody who does page pinning and wants coherency should NOT TOUCH THE
> MAPPING IT PINNED.
> 
> (And if you do touch it, it's your own fault, and you get to keep both
> of the broken pieces)
> 
> Now, I do agree that from a QoI standpoint, it would be really lovely
> if we actually enforced it. I'm not entirely sure we can, but maybe it
> would be reasonable to use that
> 
>    mm->has_pinned && page_maybe_dma_pinned(page)
> 
> at least as the beginning of a heuristic.
> 
> In fact, I do think that "page_maybe_dma_pinned()" could possibly be
> made stronger than it is. Because at *THAT* point, we might say "we

What exactly did you have in mind, to make it stronger? I think the
answer is in this email but I don't quite see it yet...

Also, now seems to be a good time to mention that I've been thinking about
a number of pup/gup pinning cases (Direct IO, GPU/NIC, NVMe/storage peer
to peer with GUP/NIC, and HMM support for atomic operations from a device).
And it seems like the following approach would help:

* Use pin_user_pages/FOLL_PIN for long-term pins. Long-term here (thanks
to Jason for this point) means "user space owns the lifetime". We might
even end up deleting either FOLL_PIN or FOLL_LONGTERM, because this would
make them mean the same thing. The idea is that there are no "short term"
pins of this kind of memory.

* Continue to use FOLL_GET (only) for Direct IO. That's a big change of plans,
because several of us had thought that Direct IO needs FOLL_PIN. However, this
recent conversation, plus my list of cases above, seems to indicate otherwise.
That's because we only have one refcount approach for marking pages in this way,
and we should spend it on the long-term pinned pages. Those are both hard to
identify otherwise, and actionable once we identify them.

Direct IO pins, on the other hand, are more transient. We can probably live
without tagging Direct IO pages as FOLL_PIN. I think.

This is all assuming that we make progress in the area of "if it's not a
page_maybe_dma_pinned() page, then we can wait for it or otherwise do reasonable
things about the refcount". So we end up with a clear (-ish) difference between
pages that can be waited for, and pages that should not be waited for in the
kernel.

I hope this helps, but if it's too much of a side-track, please disregard.


thanks,
-- 
John Hubbard
NVIDIA
