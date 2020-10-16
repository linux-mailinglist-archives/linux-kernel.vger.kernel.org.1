Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066132907F3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 17:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409781AbgJPPFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 11:05:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:55946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409774AbgJPPFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 11:05:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E21BBADA2;
        Fri, 16 Oct 2020 15:05:52 +0000 (UTC)
Subject: Re: [PATCH] mm/compaction: Remove some useless code in compact_zone()
To:     David Hildenbrand <david@redhat.com>, yanfei.xu@windriver.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20201014072349.34494-1-yanfei.xu@windriver.com>
 <dc40599d-e964-3a53-f3e7-94c03d3a162c@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ec5c9395-23f9-2b6a-0709-887751ff2d56@suse.cz>
Date:   Fri, 16 Oct 2020 17:05:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <dc40599d-e964-3a53-f3e7-94c03d3a162c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/20 2:28 PM, David Hildenbrand wrote:
> On 14.10.20 09:23, yanfei.xu@windriver.com wrote:
>> From: Yanfei Xu <yanfei.xu@windriver.com>
>> 
>> start_pfn has been declared at the begin of compact_zone(), it's
>> no need to declare it again. And remove an useless semicolon.
>> 
>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
>> ---
>>  mm/compaction.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 176dcded298e..5e69c1f94d96 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -2272,7 +2272,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>>  
>>  	while ((ret = compact_finished(cc)) == COMPACT_CONTINUE) {
>>  		int err;
>> -		unsigned long start_pfn = cc->migrate_pfn;
>> +		start_pfn = cc->migrate_pfn;
> 
> There is a user in
> 
> trace_mm_compaction_end(start_pfn, cc->migrate_pfn, cc->free_pfn,
> end_pfn, sync, ret);
> 
> we would now trace a different value, no?

Agreed. We should rather rename the while-local one to avoid confusion. 
Something like "iteration_start_pfn" ?

>>  
>>  		/*
>>  		 * Avoid multiple rescans which can happen if a page cannot be
>> @@ -2309,7 +2309,6 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>>  		case ISOLATE_SUCCESS:
>>  			update_cached = false;
>>  			last_migrated_pfn = start_pfn;
>> -			;
> 
> Huh, how does something like that happen :)

Looks like "case ISOLATE_SUCCESS:" used to be an empty implementation, then 
statements got added, but semicolon not removed.
