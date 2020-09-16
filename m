Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D82A26B981
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 03:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgIPBuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 21:50:50 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2826 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgIPBur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 21:50:47 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f616ee90001>; Tue, 15 Sep 2020 18:48:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 15 Sep 2020 18:50:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 15 Sep 2020 18:50:47 -0700
Received: from [10.2.57.195] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Sep
 2020 01:50:46 +0000
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
To:     Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        "Yang Shi" <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        "Kirill Shutemov" <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200914211515.GA5901@xz-x1> <20200914225542.GO904879@nvidia.com>
 <CAHk-=wgdn5sJ0UEVZRQvj6r5kqOkU24jA_V6cPkqb9tqoAKBJg@mail.gmail.com>
 <20200914232851.GH1221970@ziepe.ca> <20200915145040.GA2949@xz-x1>
 <20200915160553.GJ1221970@ziepe.ca> <20200915182933.GM1221970@ziepe.ca>
 <20200915191346.GD2949@xz-x1> <20200915193838.GN1221970@ziepe.ca>
 <20200915213330.GE2949@xz-x1> <20200915232238.GO1221970@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
Date:   Tue, 15 Sep 2020 18:50:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915232238.GO1221970@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600220905; bh=R8RK6+q/opEu27GaII0hstPQtlgYS8rx6zExB0/RPu4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=r11pzfubxATnhdYAblbr+/r3uMQ7KILDqrF5RvkYhbfCPZuBSgX6mQFkqvsuYBtU+
         8+i+2deMTM0ryZecHkYAitLrG68dubAOEjv6Y5y1FmJ7MjnJTpznBOx3O5RXjzDhsL
         unFt1AVAIF0b9vqlpiJy8BQJ0q7xBvoCth1/MCRafIuHOtyRh+PNE6NRa6j931nyIm
         BP5YV2nvbf09+LFdkuHv0jqTQdRvzJrtyIWKSU5j/sC+uMSLClO86jQ/mAEKG4k6mU
         MlEiT1wU8ZRfonl52gN2eAO776ScAaXhMRiN89N7Q4XVTmwlPUPjoqPH9NE+R8W+qN
         VLtd/ZaV/bVDA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/20 4:22 PM, Jason Gunthorpe wrote:
> On Tue, Sep 15, 2020 at 05:33:30PM -0400, Peter Xu wrote:
> 
>>> RDMA doesn't ever use !WRITE
>>>
>>> I'm guessing #5 is the issue, just with a different ordering. If the
>>> #3 pin_user_pages() preceeds the #2 fork, don't we get to the same #5?
>>
>> Right, but only if without MADV_DONTFORK?
> 
> Yes, results are that MADV_DONTFORK resolves the issue for initial
> tests. I should know if a bigger test suite passes in a few days.
>   
>>>> If this is a problem, we may still need the fix patch (maybe not as urgent as
>>>> before at least).  But I'd like to double confirm, just in case I miss some
>>>> obvious facts above.
>>>
>>> I'm worred that the sudden need to have MAD_DONTFORK is going to be a
>>> turn into a huge regression. It already blew up our first level of
>>> synthetic test cases. I'm worried what we will see when the
>>> application suite is run in a few months :\
>>
>> For my own preference I'll consider changing kernel behavior if the impact is
>> still under control (the performance report of 30%+ boost is also attractive
>> after the simplify-cow patch).  The other way is to maintain the old reuse
>> logic forever, that'll be another kind of burden.  Seems no easy way on either
>> side...
> 
> It seems very strange that a physical page exclusively owned by a
> process can become copied if pin_user_pages() is active and the
> process did fork() at some point.
> 
> Could the new pin_user_pages() logic help here? eg the
> GUP_PIN_COUNTING_BIAS stuff?
> 
> Could the COW code consider a refcount of GUP_PIN_COUNTING_BIAS + 1 as
> being owned by the current mm and not needing COW? The DMA pin would
> be 'invisible' for COW purposes?


Please do be careful to use the API, rather than the implementation. The
FOLL_PIN refcounting system results in being able to get a "maybe
DMA-pinned", or a "definitely not DMA-pinned", via this API call:

     static inline bool page_maybe_dma_pinned(struct page *page)

...which does *not* always use GUP_PIN_COUNTING_BIAS to provide that
answer.

thanks,
-- 
John Hubbard
NVIDIA
