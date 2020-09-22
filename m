Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AF32749B9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 22:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgIVUBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 16:01:15 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15118 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgIVUBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 16:01:14 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6a57ac0000>; Tue, 22 Sep 2020 12:59:40 -0700
Received: from [10.2.52.174] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Sep
 2020 20:01:14 +0000
Subject: Re: [PATCH 5/5] mm/thp: Split huge pmds/puds if they're pinned when
 fork()
To:     Jan Kara <jack@suse.cz>
CC:     Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
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
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <4a65586e-9282-beb0-1880-1ef8da03727c@nvidia.com>
Date:   Tue, 22 Sep 2020 13:01:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200922103315.GD15112@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600804780; bh=YRzr4MXKIVqdNO7ktu5glQ0JCVg8EzQ8Vf8cqhDwAPQ=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=Tde9CBw9i4FTYZdoQ+BZOyvSSyyK9tfAUY6tej1s7YdKStE5rjEv2ZbcpO3mWq8og
         6G4oyPTK3tDtwaUmke4V/h1xPiyKzeoa/sCr9IzKhnUnbv1rUe5hxEnJIqJyRt0Bp5
         SBHW4exjcXhLgSLey6guHt0tb+QoFNS1zm2ZFcwHz40DAWTeKM7t7XfI4lSQWX02Jv
         G7S3Tw8swWSWRqSbDjsEYlNsRRevJfQyz+HnfeuHk1Fv98R+mlUQMBq3lJJIgkFToR
         +OOJ4Tc5lHycHJ7sJpi0Cpt8x8a6LtUm6G97vw9aBuPFBgdE2v9J4JOKaCg67SWI5N
         lqCJqEZy+wcfQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/20 3:33 AM, Jan Kara wrote:
> On Mon 21-09-20 23:41:16, John Hubbard wrote:
>> On 9/21/20 2:20 PM, Peter Xu wrote:
>> ...
>>> +	if (unlikely(READ_ONCE(src_mm->has_pinned) &&
>>> +		     page_maybe_dma_pinned(src_page))) {
>>
>> This condition would make a good static inline function. It's used in 3
>> places, and the condition is quite special and worth documenting, and
>> having a separate function helps with that, because the function name
>> adds to the story. I'd suggest approximately:
>>
>>      page_likely_dma_pinned()
>>
>> for the name.
> 
> Well, but we should also capture that this really only works for anonymous
> pages. For file pages mm->has_pinned does not work because the page may be
> still pinned by completely unrelated process as Jann already properly
> pointed out earlier in the thread. So maybe anon_page_likely_pinned()?
> Possibly also assert PageAnon(page) in it if we want to be paranoid...
> 
> 								Honza

The file-backed case doesn't really change anything, though:
page_maybe_dma_pinned() is already a "fuzzy yes" in the same sense: you
can get a false positive. Just like here, with an mm->has_pinned that
could be a false positive for a process.

And for that reason, I'm also not sure an "assert PageAnon(page)" is
desirable. That assertion would prevent file-backed callers from being
able to call a function that provides a fuzzy answer, but I don't see
why you'd want or need to do that. The goal here is to make the fuzzy
answer a little bit more definite, but it's not "broken" just because
the result is still fuzzy, right?

Apologies if I'm missing a huge point here... :)


thanks,
-- 
John Hubbard
NVIDIA
