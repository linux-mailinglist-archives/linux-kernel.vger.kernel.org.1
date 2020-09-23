Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CBD2761E4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 22:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgIWUTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 16:19:10 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5127 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgIWUTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:19:09 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6bad8e0000>; Wed, 23 Sep 2020 13:18:22 -0700
Received: from [10.2.55.40] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Sep
 2020 20:19:08 +0000
Subject: Re: [PATCH 5/5] mm/thp: Split huge pmds/puds if they're pinned when
 fork()
To:     Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill Shutemov" <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212031.25233-1-peterx@redhat.com>
 <5e594e71-537f-3e9f-85b6-034b7f5fedbe@nvidia.com>
 <20200922103315.GD15112@quack2.suse.cz>
 <4a65586e-9282-beb0-1880-1ef8da03727c@nvidia.com>
 <20200923092205.GA6719@quack2.suse.cz> <20200923135004.GB59978@xz-x1>
 <20200923140114.GA15875@quack2.suse.cz> <20200923154418.GE59978@xz-x1>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <c77a99e6-c13d-a881-eb70-e0d12083dab9@nvidia.com>
Date:   Wed, 23 Sep 2020 13:19:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923154418.GE59978@xz-x1>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600892302; bh=r5vR4RQQYYxj0hqrOK7ZHOkTc2Yiu8s3wqtDVwwvNL4=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=aINlxSKQL25fqxpGaypjwiVEleTXGmWDHe4uaqSx5Zhy9Eza52rh/BxF2pdMFfSo9
         IwhmwtKexbNgraIGKpehrR0Deck4v1nqyllHbwSEvt4NaNCf5rxTOwyi9saA/Y/wRs
         WdmV6DAxtgVZKIi9Wd7FRleB3QV9xp1ICnJY8EFstOKUO4h1ws8kL9sACBwVPu3vcx
         295WTE/EnHfA3mrqxDGpVhnMboS3mISrkRDJAw4t38MQrc1M77hLkurruikHXifw78
         HOm4DShuOKh4vvjxsqptSU0YliDL60qgFHxril23S8wuZb5jNNDlfiODHmN0sW6qY7
         HmOIDTddktiGw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/20 8:44 AM, Peter Xu wrote:
> On Wed, Sep 23, 2020 at 04:01:14PM +0200, Jan Kara wrote:
>> On Wed 23-09-20 09:50:04, Peter Xu wrote:
...
>>>> But the problem is that if you apply mm->has_pinned check on file pages,
>>>> you can get false negatives now. And that's not acceptable...
>>>
>>> Do you mean the case where proc A pinned page P from a file, then proc B
>>> mapped the same page P on the file, then fork() on proc B?
>>
>> Yes.

aha, thanks for spelling out the false negative problem.

>>
>>> If proc B didn't explicitly pinned page P in B's address space too,
>>> shouldn't we return "false" for page_likely_dma_pinned(P)?  Because if
>>> proc B didn't pin the page in its own address space, I'd think it's ok to
>>> get the page replaced at any time as long as the content keeps the same.
>>> Or couldn't we?
>>
>> So it depends on the reason why you call page_likely_dma_pinned(). For your
>> COW purposes the check is correct but e.g. for "can filesystem safely
>> writeback this page" the page_likely_dma_pinned() would be wrong. So I'm
>> not objecting to the mechanism as such. I'm mainly objecting to the generic
>> function name which suggests something else than what it really checks and
>> thus it could be used in wrong places in the future... That's why I'd
>> prefer to restrict the function to PageAnon pages where there's no risk of
>> confusion what the check actually does.
> 
> How about I introduce the helper as John suggested, but rename it to
> 
>    page_maybe_dma_pinned_by_mm()
> 
> ?
> 
> Then we also don't need to judge on which is more likely to happen (between
> "maybe" and "likely", since that will confuse me if I only read these words..).
>

You're right, it is too subtle of a distinction after all. I agree that sticking
with "_maybe_" avoids that confusion.


> I didn't use any extra suffix like "cow" because I think it might be useful for
> things besides cow.  Fundamentally the new helper will be mm-based, so "by_mm"
> seems to suite better to me.
> 
> Does that sound ok?
> 

Actually, Jan nailed it. I just wasn't understanding his scenario, but now that
I do, and considering your other point about wording, I think we end up with:

     anon_page_maybe_pinned()

as a pretty good name for a helper function. (We don't want "_mm" because that
refers more to the mechanism used internally, rather than the behavior of the
function. "anon_" adds more meaning.)

...now I better go and try to grok what Jason is recommending for the new
meaning of FOLL_PIN, in another tributary of this thread. I don't *think* it affects
this naming point, though. :)

thanks,
-- 
John Hubbard
NVIDIA
