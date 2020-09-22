Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D8B2748D7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgIVTLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:11:05 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7548 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgIVTLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:11:04 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6a4c190002>; Tue, 22 Sep 2020 12:10:17 -0700
Received: from [10.2.52.174] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Sep
 2020 19:11:03 +0000
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
To:     Peter Xu <peterx@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Jann Horn" <jannh@google.com>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-2-peterx@redhat.com>
 <224908c1-5d0f-8e01-baa9-94ec2374971f@nvidia.com>
 <20200922151736.GD19098@xz-x1>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <68a95df9-87eb-86c8-4a80-cb1421884e51@nvidia.com>
Date:   Tue, 22 Sep 2020 12:11:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200922151736.GD19098@xz-x1>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600801817; bh=Y4P3+5U25Weu7EkCQ0DqguAbg7GLoekbh+l+VhO64gI=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=MXGd/NnxuhFTFj1EURN6eETl8lKwXRX8YFZ9NPQfCnbmORXuZCjEUeMcY0NO69M5M
         3J5DQ/YAQOfF4sFVIt/gDTSBQx+522GGN1z3xpWGi6lgA1yjbRWk2s+vqR0YlwbtPh
         Sn6ZCvugRm3r1/KL4nuo+SofukdvwWDCOLBgZMyXLzleEdyn8JsdBfEPxNcIhxn4W0
         jSfgBFuqHFgdQs7WC/+W+0yPxIyuipfEif5n/xhz3Q2YiRb3+C/8Q4R0fau2p1uWZZ
         mvt91gz2IULtGV3bfC6XXxwm92fDnhWiSAJgewXYIxzCyBfwUi7uxdXR2hN520vm7K
         mY0reffpibNzQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/20 8:17 AM, Peter Xu wrote:
> On Mon, Sep 21, 2020 at 04:53:38PM -0700, John Hubbard wrote:
>> On 9/21/20 2:17 PM, Peter Xu wrote:
...
>>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>>> index 496c3ff97cce..6f291f8b74c6 100644
>>> --- a/include/linux/mm_types.h
>>> +++ b/include/linux/mm_types.h
>>> @@ -441,6 +441,16 @@ struct mm_struct {
>>>    #endif
>>>    		int map_count;			/* number of VMAs */
>>> +		/**
>>> +		 * @has_pinned: Whether this mm has pinned any pages.  This can
>>> +		 * be either replaced in the future by @pinned_vm when it
>>> +		 * becomes stable, or grow into a counter on its own. We're
>>> +		 * aggresive on this bit now - even if the pinned pages were
>>> +		 * unpinned later on, we'll still keep this bit set for the
>>> +		 * lifecycle of this mm just for simplicity.
>>> +		 */
>>> +		int has_pinned;
>>
>> I think this would be elegant as an atomic_t, and using atomic_set() and
>> atomic_read(), which seem even more self-documenting that what you have here.
>>
>> But it's admittedly a cosmetic point, combined with my perennial fear that
>> I'm missing something when I look at a READ_ONCE()/WRITE_ONCE() pair. :)
> 
> Yeah but I hope I'm using it right.. :) I used READ_ONCE/WRITE_ONCE explicitly
> because I think they're cheaper than atomic operations, (which will, iiuc, lock
> the bus).
> 

The "cheaper" argument vanishes if the longer-term plan is to use atomic ops.
Given the intent of this patchset, simpler is better, and "simpler that has the
same performance as the longer term solution" is definitely OK.

>>
>> It's completely OK to just ignore this comment, but I didn't want to completely
>> miss the opportunity to make it a tiny bit cleaner to the reader.
> 
> This can always become an atomic in the future, or am I wrong?  Actually if
> we're going to the counter way I feel like it's a must.
> 

Yes it can change. But you can get the simplicity and clarity now, rather
than waiting.

thanks,
-- 
John Hubbard
NVIDIA
