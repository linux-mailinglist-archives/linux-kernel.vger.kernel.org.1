Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0742E2A2B27
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgKBND3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:03:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:49978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728487AbgKBND1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:03:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED37FB02D;
        Mon,  2 Nov 2020 13:03:25 +0000 (UTC)
Subject: Re: [PATCH] mm/compaction: count pages and stop correctly during page
 isolation.
To:     Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Rik van Riel <riel@surriel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
References: <20201029200435.3386066-1-zi.yan@sent.com>
 <20201030094308.GG1478@dhcp22.suse.cz>
 <6CAAB1FC-2B41-490B-A67A-93063629C19B@nvidia.com>
 <20201030133625.GJ1478@dhcp22.suse.cz>
 <CAHbLzkqnmXqB-UThT9dMOwVpuweE6XwA78SF-_qD9=1EVpMSUg@mail.gmail.com>
 <BE903088-CF3E-4264-A9CA-8A27AC12EF65@nvidia.com>
 <CAHbLzkoSChyP4Jjz_LNxP3Maf-eVH0cfqRoN9=s75V0SMLEL-w@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <eb3be332-8fed-af88-b060-c710f6245f7d@suse.cz>
Date:   Mon, 2 Nov 2020 14:03:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkoSChyP4Jjz_LNxP3Maf-eVH0cfqRoN9=s75V0SMLEL-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/20 7:55 PM, Yang Shi wrote:
> On Fri, Oct 30, 2020 at 11:39 AM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 30 Oct 2020, at 14:33, Yang Shi wrote:
>>
>> > On Fri, Oct 30, 2020 at 6:36 AM Michal Hocko <mhocko@suse.com> wrote:
>> >>
>> >> On Fri 30-10-20 08:20:50, Zi Yan wrote:
>> >>> On 30 Oct 2020, at 5:43, Michal Hocko wrote:
>> >>>
>> >>>> [Cc Vlastimil]
>> >>>>
>> >>>> On Thu 29-10-20 16:04:35, Zi Yan wrote:
>> >>>>> From: Zi Yan <ziy@nvidia.com>
>> >>>>>
>> >>>>> In isolate_migratepages_block, when cc->alloc_contig is true, we are
>> >>>>> able to isolate compound pages, nr_migratepages and nr_isolated did not
>> >>>>> count compound pages correctly, causing us to isolate more pages than we
>> >>>>> thought. Use thp_nr_pages to count pages. Otherwise, we might be trapped
>> >>>>> in too_many_isolated while loop, since the actual isolated pages can go
>> >>>>> up to COMPACT_CLUSTER_MAX*512=16384, where COMPACT_CLUSTER_MAX is 32,
>> >>>>> since we stop isolation after cc->nr_migratepages reaches to
>> >>>>> COMPACT_CLUSTER_MAX.
>> >>>>>
>> >>>>> In addition, after we fix the issue above, cc->nr_migratepages could
>> >>>>> never be equal to COMPACT_CLUSTER_MAX if compound pages are isolated,
>> >>>>> thus page isolation could not stop as we intended. Change the isolation
>> >>>>> stop condition to >=.
>> >>>>>
>> >>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> >>>>> ---
>> >>>>>  mm/compaction.c | 8 ++++----
>> >>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>> >>>>>
>> >>>>> diff --git a/mm/compaction.c b/mm/compaction.c
>> >>>>> index ee1f8439369e..0683a4999581 100644
>> >>>>> --- a/mm/compaction.c
>> >>>>> +++ b/mm/compaction.c
>> >>>>> @@ -1012,8 +1012,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>> >>>>>
>> >>>>>  isolate_success:
>> >>>>>            list_add(&page->lru, &cc->migratepages);
>> >>>>> -          cc->nr_migratepages++;
>> >>>>> -          nr_isolated++;
>> >>>>> +          cc->nr_migratepages += thp_nr_pages(page);
>> >>>>> +          nr_isolated += thp_nr_pages(page);
>> >>>>
>> >>>> Does thp_nr_pages work for __PageMovable pages?
>> >>>
>> >>> Yes. It is the same as compound_nr() but compiled
>> >>> to 1 when THP is not enabled.
>> >>
>> >> I am sorry but I do not follow. First of all the implementation of the
>> >> two is different and also I was asking about __PageMovable which should
>> >> never be THP IIRC. Can they be compound though?
>> >
>> > I have the same question, can they be compound? If they can be
>> > compound, PageTransHuge() can't tell from THP and compound movable
>> > page, right?
>>
>> Right. I have updated the patch and use compound_nr instead.
> 
> Thanks. Actually I'm wondering what kind of movable page could be
> compound. Any real examples?

Looks like there's currently none. Compaction also wouldn't work properly with 
movable pages with order>0 as the free page scanner looks for order-0 pages 
only. But it won't hurt to use compound_nr() anyway.

>>
>> —
>> Best Regards,
>> Yan Zi
> 

