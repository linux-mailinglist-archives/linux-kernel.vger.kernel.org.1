Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD08525C8A6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 20:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgICSUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 14:20:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58281 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726543AbgICSUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599157249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=0UIC2NSBsCNMgkAltaGZh0CBg73kHE0laj9TQr9BdTk=;
        b=OTr1pux/atLhMEG3OHIQ0liXuCUpwTj4Er1AjD4IwG6dRnSskLAcy1P5ixesK+AvLKKHZ8
        4OLbES63e8dgL5d+MxJsPZDsRw2WhIGztpegdnstg0Uyc1HchBx6YABGA9NlTSUUNH0K2P
        FbTVCHM1O259+haW3reUltvAwG3I97c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-y10KQSXPNhWLWlisuwDbIg-1; Thu, 03 Sep 2020 14:20:45 -0400
X-MC-Unique: y10KQSXPNhWLWlisuwDbIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 833E61DE11;
        Thu,  3 Sep 2020 18:20:44 +0000 (UTC)
Received: from [10.36.112.104] (ovpn-112-104.ams2.redhat.com [10.36.112.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 282577C0B3;
        Thu,  3 Sep 2020 18:20:43 +0000 (UTC)
Subject: Re: [PATCH] mm/memory_hotplug: drain per-cpu pages again during
 memory offline
To:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
References: <20200901124615.137200-1-pasha.tatashin@soleen.com>
 <20200902140851.GJ4617@dhcp22.suse.cz>
 <CA+CK2bBZdN56fmsC2jyY_ju8rQfG2-9hForf1CEdcUVL1+wrrA@mail.gmail.com>
 <74f2341a-7834-3e37-0346-7fbc48d74df3@suse.cz>
 <20200902151306.GL4617@dhcp22.suse.cz>
 <e6bf05cb-044c-47a9-3c65-e41b1e42b702@suse.cz>
 <20200903063806.GM4617@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <c6b11905-2456-52a0-3b15-d4ceae6e7f54@redhat.com>
Date:   Thu, 3 Sep 2020 20:20:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903063806.GM4617@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.09.20 08:38, Michal Hocko wrote:
> On Wed 02-09-20 19:51:45, Vlastimil Babka wrote:
>> On 9/2/20 5:13 PM, Michal Hocko wrote:
>>> On Wed 02-09-20 16:55:05, Vlastimil Babka wrote:
>>>> On 9/2/20 4:26 PM, Pavel Tatashin wrote:
>>>>> On Wed, Sep 2, 2020 at 10:08 AM Michal Hocko <mhocko@suse.com> wrote:
>>>>>>
>>>>>>>
>>>>>>> Thread#1 - continue
>>>>>>>          free_unref_page_commit
>>>>>>>            migratetype = get_pcppage_migratetype(page);
>>>>>>>               // get old migration type
>>>>>>>            list_add(&page->lru, &pcp->lists[migratetype]);
>>>>>>>               // add new page to already drained pcp list
>>>>>>>
>>>>>>> Thread#2
>>>>>>> Never drains pcp again, and therefore gets stuck in the loop.
>>>>>>>
>>>>>>> The fix is to try to drain per-cpu lists again after
>>>>>>> check_pages_isolated_cb() fails.
>>>>>>
>>>>>> But this means that the page is not isolated and so it could be reused
>>>>>> for something else. No?
>>>>>
>>>>> The page is in a movable zone, has zero references, and the section is
>>>>> isolated (i.e. set_pageblock_migratetype(page, MIGRATE_ISOLATE);) is
>>>>> set. The page should be offlinable, but it is lost in a pcp list as
>>>>> that list is never drained again after the first failure to migrate
>>>>> all pages in the range.
>>>>
>>>> Yeah. To answer Michal's "it could be reused for something else" - yes, somebody
>>>> could allocate it from the pcplist before we do the extra drain. But then it
>>>> becomes "visible again" and the loop in __offline_pages() should catch it by
>>>> scan_movable_pages() - do_migrate_range(). And this time the pageblock is
>>>> already marked as isolated, so the page (freed by migration) won't end up on the
>>>> pcplist again.
>>>
>>> So the page block is marked MIGRATE_ISOLATE but the allocation itself
>>> could be used for non migrateable objects. Or does anything prevent that
>>> from happening?
>>
>> In a movable zone, the allocation should not be used for non migrateable
>> objects. E.g. if the zone was not ZONE_MOVABLE, the offlining could fail
>> regardless of this race (analogically for migrating away from CMA pageblocks).
>>
>>> We really do depend on isolation to not allow reuse when offlining.
>>
>> This is not really different than if the page on pcplist was allocated just a
>> moment before the offlining, thus isolation started. We ultimately rely on being
>> able to migrate any allocated pages away during the isolation. This "freeing to
>> pcplists" race doesn't fundamentally change anything in this regard. We just
>> have to guarantee that pages on pcplists will be eventually flushed, to make
>> forward progress, and there was a bug in this aspect.
> 
> You are right. I managed to confuse myself yesterday. The race is
> impossible for !ZONE_MOVABLE because we do PageBuddy check there. And on
> the movable zone we are not losing the migrateability property.
> 
> Pavel I think this will be a useful information to add to the changelog.
> We should also document this in the code to prevent from further
> confusion. I would suggest something like the following:
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 242c03121d73..56d4892bceb8 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -170,6 +170,14 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>   * pageblocks we may have modified and return -EBUSY to caller. This
>   * prevents two threads from simultaneously working on overlapping ranges.
>   *
> + * Please note that there is no strong synchronization with the page allocator
> + * either. Pages might be freed while their page blocks are marked ISOLATED.
> + * In some cases pages might still end up on pcp lists and that would allow
> + * for their allocation even when they are in fact isolated already. Depending on
> + * how strong of a guarantee the caller needs drain_all_pages might be needed
> + * (e.g. __offline_pages will need to call it after check for isolated range for
> + * a next retry).
> + *

As expressed in reply to v2, I dislike this hack. There is strong
synchronization, just PCP is special. Allocating from MIGRATE_ISOLATE is
just plain ugly.

Can't we temporarily disable PCP (while some pageblock in the zone is
isolated, which we know e.g., due to the counter), so no new pages get
put into PCP lists after draining, and re-enable after no pageblocks are
isolated again? We keep draining the PCP, so it doesn't seem to be of a
lot of use during that period, no? It's a performance hit already.

Then, we would only need exactly one drain. And we would only have to
check on the free path whether PCP is temporarily disabled.

-- 
Thanks,

David / dhildenb

