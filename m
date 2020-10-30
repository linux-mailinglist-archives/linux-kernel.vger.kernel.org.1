Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9292A088D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgJ3Ozs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:55:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:38524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgJ3Ozr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:55:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 035CCAC12;
        Fri, 30 Oct 2020 14:55:46 +0000 (UTC)
Subject: Re: [PATCH] mm/compaction: count pages and stop correctly during page
 isolation.
To:     Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
References: <20201029200435.3386066-1-zi.yan@sent.com>
 <20201030094308.GG1478@dhcp22.suse.cz>
 <6CAAB1FC-2B41-490B-A67A-93063629C19B@nvidia.com>
 <20201030133625.GJ1478@dhcp22.suse.cz>
 <400B3460-65C0-4C48-A7EA-1A9F5780EC9C@nvidia.com>
 <20201030144917.GK1478@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e0f38829-8e47-62d7-924a-920096aae739@suse.cz>
Date:   Fri, 30 Oct 2020 15:55:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201030144917.GK1478@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/20 3:49 PM, Michal Hocko wrote:
> On Fri 30-10-20 10:35:43, Zi Yan wrote:
>> On 30 Oct 2020, at 9:36, Michal Hocko wrote:
>> 
>> > On Fri 30-10-20 08:20:50, Zi Yan wrote:
>> >> On 30 Oct 2020, at 5:43, Michal Hocko wrote:
>> >>
>> >>> [Cc Vlastimil]
>> >>>
>> >>> On Thu 29-10-20 16:04:35, Zi Yan wrote:
>> >>>
>> >>> Does thp_nr_pages work for __PageMovable pages?
>> >>
>> >> Yes. It is the same as compound_nr() but compiled
>> >> to 1 when THP is not enabled.
>> >
>> > I am sorry but I do not follow. First of all the implementation of the
>> > two is different and also I was asking about __PageMovable which should
>> > never be THP IIRC. Can they be compound though?
>> 
>> __PageMovable, non-lru movable pages, can be compound and thp_nr_page cannot
>> be used for it, since when THP is off, thp_nr_page will return the wrong number.
>> I got confused by its name, sorry.
> 
> OK, this matches my understanding. Good we are on the same page.
> 
>> But __PageMovable is irrelevant to this patch, since we are using
>> __isolate_lru_page to isolate pages. non-lru __PageMovable should not appear
>> after isolate_succes. thp_nr_pages can be used here.
> 
> But this is still not clear to me. __PageMovable pages are isolated by
> isolate_movable_page and then jump to isolate_succes. Does that somehow
> changes the nature of the page being compound or tat thp_nr_page would
> start working on those pages.

Agreed that page movable can appear after isolate_success. compound_nr() should 
work for both.
Note that too_many_isolated() doesn't see __PageMovable isolated pages, as they 
are not counted as NR_ISOLATED_FILE/NR_ISOLATED_ANON, AFAIK. So in that sense 
they are irrelevant to the bug at hand... for now.

