Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0C42707C0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 23:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgIRVGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 17:06:25 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1768 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRVGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 17:06:24 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6521430001>; Fri, 18 Sep 2020 14:06:12 -0700
Received: from [10.2.52.182] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 21:06:23 +0000
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
To:     Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
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
References: <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca> <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca>
 <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1> <20200918173240.GY8409@ziepe.ca>
 <20200918204048.GC5962@xz-x1>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <0af8c77e-ff60-cada-7d22-c7cfcf859b19@nvidia.com>
Date:   Fri, 18 Sep 2020 14:06:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200918204048.GC5962@xz-x1>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600463172; bh=EeYfA5vQuzdloR5edxzjymDs6wbsfA1RfZq/g/2zM0E=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=iDmZKip4T8DFhdtzdKAJCCQt7lVpKLnha4ua/0z62dcmNcgryyBs5ZCUp96AOOHzx
         dIb9rBEiZD6pinrehYKdbKlxbRVJ8nfG9rD2pCy4CxxTB5CHLarS/Q1Q/qQh1NSCIZ
         j9WYBC/3vg2HKlUvcbnsFJSRWf8G5vjQvxPZLEInuHeg3RdQbNwrLdOshUGn/ajgai
         Qr9b0lM0aTl/wRUr5jAjs0pMbNOwn6aKpZz2SdnuecHINaHX1+GEg4elEXad5moCBb
         EJszH0hOYcn3oHpF9PBshmFo07VoEAShacH6jHL2N4erLc9BhfozBAdsY100ACrdRz
         fzSHOaKH5fc2w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/20 1:40 PM, Peter Xu wrote:
> On Fri, Sep 18, 2020 at 02:32:40PM -0300, Jason Gunthorpe wrote:
>> On Fri, Sep 18, 2020 at 12:40:32PM -0400, Peter Xu wrote:
>>
>>> Firstly in the draft patch mm->has_pinned is introduced and it's written to 1
>>> as long as FOLL_GUP is called once.  It's never reset after set.
>>
>> Worth thinking about also adding FOLL_LONGTERM here, at last as long
>> as it is not a counter. That further limits the impact.
> 
> But theoritically we should also trigger COW here for pages even with PIN &&
> !LONGTERM, am I right?  Assuming that FOLL_PIN is already a corner case.
> 

This note, plus Linus' comment about "I'm a normal process, I've never
done any special rdma page pinning", has me a little worried. Because
page_maybe_dma_pinned() is counting both short- and long-term pins,
actually. And that includes O_DIRECT callers.

O_DIRECT pins are short-term, and RDMA systems are long-term (and should
be setting FOLL_LONGTERM). But there's no way right now to discern
between them, once the initial pin_user_pages*() call is complete. All
we can do today is to count the number of FOLL_PIN calls, not the number
of FOLL_PIN | FOLL_LONGTERM calls.

The reason it's that way, is that writeback and such can experience
problems regardless of the duration of the pin. There are ideas about
how to deal with the pins, and the filesystem (layout leases...) but
still disagreement, which is why there's basically no
page_maybe_dma_pinned() callers yet.

Although I think we're getting closer to using it. There was a recent
attempt at using this stuff, from Chris Wilson. [1]


[1] https://lore.kernel.org/intel-gfx/20200624191417.16735-1-chris%40chris-wilson.co.uk/


thanks,
-- 
John Hubbard
NVIDIA
