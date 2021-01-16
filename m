Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E03C2F8B03
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 04:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbhAPDl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 22:41:28 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3019 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbhAPDl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 22:41:28 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6002603f0000>; Fri, 15 Jan 2021 19:40:47 -0800
Received: from [10.2.48.179] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 16 Jan
 2021 03:40:47 +0000
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
To:     David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
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
        "Oleg Nesterov" <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
References: <20210110004435.26382-1-aarcange@redhat.com>
 <bb071419-bf40-c5ed-4b2d-d5eb03031b0a@redhat.com>
 <20210115183721.GG4605@ziepe.ca>
 <a21e6fdf-5cac-6fda-242e-7909af96027a@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <cba836c6-4054-c966-8254-a11915351b6b@nvidia.com>
Date:   Fri, 15 Jan 2021 19:40:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <a21e6fdf-5cac-6fda-242e-7909af96027a@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610768447; bh=8WRo2pSy6GmhiZT69BhPZn1RMDf4lV1wNtgydXKBlEQ=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=LqRvAiHwiZoGNsjzttB+2zzVFY2LZDqGPUV4h0dc6gGlfnJsO6Bpnc5d2m9kQMyZY
         /Gytqa09GBKhM4FoCOcDhlMXzyRL0apx8gdUCF2Woue76BX4BlrTIRSNx/V+9f5+4E
         bFoAdV0zxcXMMg0w9OegSqghXOn5ik7qwDIFimLlDw3FtjbooqgjUJJIYks+UhEbaN
         2Qg9Bh3pWgS875JBk2m9JPmYkpFR2F7BeobTgnB5ACc70m69i/olhPz+YX3sD/111F
         jiV91bIaDPjKyw4xeirAcUrHElnSslRKQVhqr9nlFHJcWjDP/cUTkdojt+OXTEMgTf
         Gkp6q7lVcVFCw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/21 11:46 AM, David Hildenbrand wrote:
>>> 7) There is no easy way to detect if a page really was pinned: we might
>>> have false positives. Further, there is no way to distinguish if it was
>>> pinned with FOLL_WRITE or not (R vs R/W). To perform reliable tracking
>>> we most probably would need more counters, which we cannot fit into
>>> struct page. (AFAIU, for huge pages it's easier).
>>
>> I think this is the real issue. We can only store so much information,
>> so we have to decide which things work and which things are broken. So
>> far someone hasn't presented a way to record everything at least..
> 
> I do wonder how many (especially long-term) GUP readers/writers we have
> to expect, and especially, support for a single base page. Do we have a
> rough estimate?
> 
> With RDMA, I would assume we only need a single one (e.g., once RDMA
> device; I'm pretty sure I'm wrong, sounds too easy).
> With VFIO I guess we need one for each VFIO container (~ in the worst
> case one for each passthrough device).
> With direct I/O, vmsplice and other GUP users ?? No idea.
> 
> If we could somehow put a limit on the #GUP we support, and fail further
> GUP (e.g., -EAGAIN?) once a limit is reached, we could partition the
> refcount into something like (assume max #15 GUP READ and #15 GUP R/W,
> which is most probably a horribly bad choice)
> 
> [ GUP READ ][ GUP R/W ] [  ordinary ]
> 31  ...  28 27  ...  24 23   ....   0
> 
> But due to saturate handling in "ordinary", we would lose further 2 bits
> (AFAIU), leaving us "only" 22 bits for "ordinary". Now, I have no idea
> how many bits we actually need in practice.
> 
> Maybe we need less for GUP READ, because most users want GUP R/W? No idea.
> 
> Just wild ideas. Most probably that has already been discussed, and most
> probably people figured that it's impossible :)
> 

I proposed this exact idea a few days ago [1]. It's remarkable that we both
picked nearly identical values for the layout! :)

But as the responses show, security problems prevent pursuing that approach.


[1] https://lore.kernel.org/r/45806a5a-65c2-67ce-fc92-dc8c2144d766@nvidia.com

thanks,
-- 
John Hubbard
NVIDIA
