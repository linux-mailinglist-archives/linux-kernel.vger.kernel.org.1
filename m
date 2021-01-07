Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9ED82EE8D8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 23:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbhAGWiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 17:38:21 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19865 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbhAGWiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 17:38:20 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff78d340000>; Thu, 07 Jan 2021 14:37:40 -0800
Received: from [10.2.53.45] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Jan
 2021 22:37:36 +0000
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
 <394e17bc-8bed-4d17-5dba-9ab8052c8bea@nvidia.com>
 <CAHk-=wi691+mXC4NCXZ_f1+kf_YAB9WBM-LqhrX8=eSmYM=WFw@mail.gmail.com>
 <CAHk-=wgDhSzz56=us=X2PXHh2XfvcYc76PkarZYNnVaUG=iSmw@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <b5024da1-c1ee-263c-cd32-814846a8d7f0@nvidia.com>
Date:   Thu, 7 Jan 2021 14:37:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgDhSzz56=us=X2PXHh2XfvcYc76PkarZYNnVaUG=iSmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610059060; bh=WLexG3mwccsWz032chhqLUoQKIYVeN3uLdxDYE6jTFk=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=fiHQFzpgncVHW6vVq4qgLhx+bpYi7akpoT6QJg38qyOWLHsNQHHtgB2xMRmV3lG4T
         HSRD5E4gCsAj2WM4U5Wyga/2pUVHgvaCoE2NnLK8Sj+KC3GFBVYLeL3GM+Q7qs5ldU
         O5HzvIfzHMic+U+De1aahxyV3KPhFV9Db08bVwpIy0ZwQEgAHGkHT2dKckoZ6A6LXJ
         i2QHkqKT5Mtu84MIbu14obXWlxUq3DSjsoBgTbsHniYDbH2uQlZq4jNRhCltYBKyG7
         s4dM19fkt1uTEnHdiISTSWHkVUPfdaQimioIi/Q2yMdaQdY9LrOD28PJwwQSpgGCJe
         i/Eqsm+evbfHA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/21 2:24 PM, Linus Torvalds wrote:
> On Thu, Jan 7, 2021 at 2:20 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Hmm, add a check for the page being PageAnon(), perhaps?
>>
>> If it's a shared vma, then the page can be pinned shared with multiple
>> mappings, I agree.
> 
> Or check the vma directly for whether it's a COW vma. That's probably
> a more obvious test, but would have to be done outside of
> page_maybe_dma_pinned().
> 
> For example, in copy_present_page(), we've already done that COW-vma
> test, so if we want to strengthen just _that_ test, then it would be
> sufficient to just add a
> 
>          /* This cannot be a pinned page if it has more than one mapping */
>          if (page_mappings(page) != 1)
>                  return 1;
> 
> to copy_present_page() along with the existing page_maybe_dma_pinned() test.
> 
> No?
> 
>              Linus

That approach makes me a lot happier, yes. Because it doesn't add constraints
to the RDMA cases, but still does what we need here.


thanks,
-- 
John Hubbard
NVIDIA
