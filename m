Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670882EE831
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 23:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbhAGWPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 17:15:30 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19365 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbhAGWP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 17:15:29 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff787d90002>; Thu, 07 Jan 2021 14:14:49 -0800
Received: from [10.2.53.45] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Jan
 2021 22:14:46 +0000
Subject: Re: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce
 wrprotect_tlb_flush_pending
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Minchan Kim" <minchan@kernel.org>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107200402.31095-3-aarcange@redhat.com>
 <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
 <X/d2DyLfXZmBIreY@redhat.com>
 <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
 <4100a6f5-ab0b-f7e5-962f-ea1dbcb1e47e@nvidia.com>
 <CAHk-=wjde11Wz+GiVeuttdAPaNBrNydkvUcVm3xBmVWjwA-kNQ@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <394e17bc-8bed-4d17-5dba-9ab8052c8bea@nvidia.com>
Date:   Thu, 7 Jan 2021 14:14:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjde11Wz+GiVeuttdAPaNBrNydkvUcVm3xBmVWjwA-kNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610057689; bh=mvMt3QV0kxLxxUJ0iTscamiEGgHeUeuZhDh1c1xneBs=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=afxZ3z0kPyVRwdvpJCH3q64AwBm5K/Ggg+Hzr/lRkexTGNAaJrDyc06ZCeMZoYCOj
         CjvOZK3MLvTKT6Pwc9p5IByX2pxAhyCBvw+/NG1cf+hmQU41UUJ3bJe1xHuwoDz0lN
         ReYmK9FZmAHhg7vEl1INn854JWe2cWWhLEPpINXbAjdihhQhVZWFk152WjEhPNIa/j
         Q2ADPLf8eomtRQnfIL7yR39+zoAnqsx4dYOu8KtncCV6afFKkHvcitdrx18b5O5GT7
         92PD4bN/G32nzm3kCGe2CPWCJF/Cycm9hG11uANRc+SOjv8YHz0NSbjT3wV5iw4MrU
         qe2bO9eFfEAGg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/21 2:00 PM, Linus Torvalds wrote:
> On Thu, Jan 7, 2021 at 1:53 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>>>
>>> Now, I do agree that from a QoI standpoint, it would be really lovely
>>> if we actually enforced it. I'm not entirely sure we can, but maybe it
>>> would be reasonable to use that
>>>
>>>     mm->has_pinned && page_maybe_dma_pinned(page)
>>>
>>> at least as the beginning of a heuristic.
>>>
>>> In fact, I do think that "page_maybe_dma_pinned()" could possibly be
>>> made stronger than it is. Because at *THAT* point, we might say "we
>>
>> What exactly did you have in mind, to make it stronger? I think the
>> answer is in this email but I don't quite see it yet...
> 
> Literally just adding a " && page_mapcount(page) == 1" in there
> (probably best done inside page_maybe_dma_pinned() itself)

Well, that means that pages that are used for pinned DMA like this, can
not be shared with other processes. Is that an acceptable limitation
for the RDMA users? It seems a bit constraining, at first glance anyway.

> 
>> Direct IO pins, on the other hand, are more transient. We can probably live
>> without tagging Direct IO pages as FOLL_PIN. I think.
> 
> Yes. I think direct-IO writes should be able to just do a transient
> GUP, and if it causes a COW fault that isn't coherent, that's the
> correct semantics, I think (ie the direct-IO will see the original
> data, the COW faulter will get it's own private copy to make changes
> to).
> 
> I think pinning should be primarily limited to things that _require_
> coherency (ie you pin because you're going to do some active two-way
> communication using that page)
> 
> Does that match your thinking?
> 

Yes, perfectly. I'm going to update Documentation/core-api/pin_user_pages.rst
accordingly, once the dust settles on these discussions.

thanks,
-- 
John Hubbard
NVIDIA
