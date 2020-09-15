Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E6D26A5FA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 15:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgIONLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 09:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgIONKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:10:02 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A91C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:10:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l15so8069565wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hKA55yydGJaTrJiWxa6JG96BHh3kRKn+Kk9OofCwosc=;
        b=MTFRqZhpWlkWO7t6Z7RMTlT5nPq4SliLoyjb7qaS+vB0Y+d2zAppfcb9x1SIJptmUL
         H2kdnIFG6tsrWe/jGPmO6TvEDVEOlu31MJzaooDRkBd7IV3ITkneoAE+FehEyPLJ60Bs
         DGGO7upu1rprAApmr1pL7JYeDFhLWfNRGPm55fxWKr0icqxuVwdP8HXO1Q1uFRIf7lhs
         wnv+p7hU0pUYPYGJux1j3vWD+Xw4ARFh6TCLVwNq7hNVX+xNmAdjkSBy1v46K4f6XY2y
         rdngWO+F3JiYdYFDVGWdjV2jZjCU8AnPgRZowsh0EYPebb1wZpyWZE3qQoVyxgF25+Nx
         xdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hKA55yydGJaTrJiWxa6JG96BHh3kRKn+Kk9OofCwosc=;
        b=A1SPCN1pZOfnC3selLioweaJRqeV7PBSf32grzj4MQpb7crd3ykB+5w3hLV1/k22ou
         2FapJ+bNlZoBzdhJv8K1JHd5Uywn1oCuZAFfmyOAyRBdfaoEaCPFAuHivC259kGrE25C
         RcBuNnYkNl504tF/0PZC8K91dwoeqjdMcOBbGKNXYhV5eiQS11V5STlILYCS5ahjcyzL
         Idc4DdGVVhsiRZsjJvwJ6hzQKKSZZRPw+YcaXUBKm2CqMBTNutNjZqYBp/lteEapYRyo
         aF8i5KqD1cDd0oWUtupR0Nji9gtYkk/1nlm50imyA9cmK83VXWyvAn4FTvFYKBSDvp7w
         aV2g==
X-Gm-Message-State: AOAM530zS2ZhzvyPxlL+A5gupmb3Jusnh54NFL7K82y8Nv5LRfxDr8qD
        F0U36Ej1sVFh4hmG2gzSN2YRgWwR403SGg==
X-Google-Smtp-Source: ABdhPJzEWWZimcNCofcdC3Q02c6ZtXS+/hJd6yq4BugQiDxU3EZ78To/1S2D+6FGDsW5exgjj/zjDQ==
X-Received: by 2002:a1c:4c0d:: with SMTP id z13mr4492958wmf.113.1600175400761;
        Tue, 15 Sep 2020 06:10:00 -0700 (PDT)
Received: from [192.168.8.100] (188.147.112.12.nat.umts.dynamic.t-mobile.pl. [188.147.112.12])
        by smtp.gmail.com with ESMTPSA id e1sm20132305wrp.49.2020.09.15.06.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:10:00 -0700 (PDT)
Subject: Re: [RFC PATCH] mm/page_alloc.c: micro-optimization reduce oom
 critical section size
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
References: <20200914100654.21746-1-mateusznosek0@gmail.com>
 <20200914142233.GT16999@dhcp22.suse.cz>
From:   Mateusz Nosek <mateusznosek0@gmail.com>
Message-ID: <e26d7699-cc51-ffec-321e-ffabc49110e1@gmail.com>
Date:   Tue, 15 Sep 2020 15:09:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914142233.GT16999@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/2020 4:22 PM, Michal Hocko wrote:
> On Mon 14-09-20 12:06:54, mateusznosek0@gmail.com wrote:
>> From: Mateusz Nosek <mateusznosek0@gmail.com>
>>
>> Most operations from '__alloc_pages_may_oom' do not require oom_mutex hold.
>> Exception is 'out_of_memory'. The patch refactors '__alloc_pages_may_oom'
>> to reduce critical section size and improve overall system performance.
> 
> This is a real slow path. What is the point of optimizing it? Do you
> have any numbers?
> 

I agree that as this is the slow path, then the hard, complicated 
optimizations are not recommended. In my humble opinion introduced patch 
is not complex and does not decrease code readability or 
maintainability. In a nutshell I see no drawbacks of applying it.

Even despite the fact that optimization is 'micro' I think that code in 
question should be optimized, since it is possible without introducing 
additional problems, (assuming after verifying that it is safe as you 
mentioned below) and especially as it is in 'the heart' of memory 
allocation in kernel.

> Also I am not convinced the patch is entirely safe. At least the last
> allocation attempt is meant to be done under the lock to allow only one
> task to perform this. I have forgot the complete reasoning behind that
> but at least the changelog should argue why that is ok.
> 

The last allocation just calls 'get_page_from_freelist' with two 
different sets of flags. I cannot see an obvious reason for it to 
require synchronization. I am investigating this deeper but if you 
happen to remember the reasoning or just any part of it and would be 
willing to share it, it would come with a lot of help.

>> Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
>> ---
>>   mm/page_alloc.c | 45 ++++++++++++++++++++++++---------------------
>>   1 file changed, 24 insertions(+), 21 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index b9bd75cacf02..b07f950a5825 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -3935,18 +3935,7 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>>   		.order = order,
>>   	};
>>   	struct page *page;
>> -
>> -	*did_some_progress = 0;
>> -
>> -	/*
>> -	 * Acquire the oom lock.  If that fails, somebody else is
>> -	 * making progress for us.
>> -	 */
>> -	if (!mutex_trylock(&oom_lock)) {
>> -		*did_some_progress = 1;
>> -		schedule_timeout_uninterruptible(1);
>> -		return NULL;
>> -	}
>> +	bool success;
>>   
>>   	/*
>>   	 * Go through the zonelist yet one more time, keep very high watermark
>> @@ -3959,14 +3948,17 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>>   				      ~__GFP_DIRECT_RECLAIM, order,
>>   				      ALLOC_WMARK_HIGH|ALLOC_CPUSET, ac);
>>   	if (page)
>> -		goto out;
>> +		return page;
>> +
>> +	/* Check if somebody else is making progress for us. */
>> +	*did_some_progress = mutex_is_locked(&oom_lock);
>>   
>>   	/* Coredumps can quickly deplete all memory reserves */
>>   	if (current->flags & PF_DUMPCORE)
>> -		goto out;
>> +		return NULL;
>>   	/* The OOM killer will not help higher order allocs */
>>   	if (order > PAGE_ALLOC_COSTLY_ORDER)
>> -		goto out;
>> +		return NULL;
>>   	/*
>>   	 * We have already exhausted all our reclaim opportunities without any
>>   	 * success so it is time to admit defeat. We will skip the OOM killer
>> @@ -3976,12 +3968,12 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>>   	 * The OOM killer may not free memory on a specific node.
>>   	 */
>>   	if (gfp_mask & (__GFP_RETRY_MAYFAIL | __GFP_THISNODE))
>> -		goto out;
>> +		return NULL;
>>   	/* The OOM killer does not needlessly kill tasks for lowmem */
>>   	if (ac->highest_zoneidx < ZONE_NORMAL)
>> -		goto out;
>> +		return NULL;
>>   	if (pm_suspended_storage())
>> -		goto out;
>> +		return NULL;
>>   	/*
>>   	 * XXX: GFP_NOFS allocations should rather fail than rely on
>>   	 * other request to make a forward progress.
>> @@ -3992,8 +3984,20 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>>   	 * failures more gracefully we should just bail out here.
>>   	 */
>>   
>> +	/*
>> +	 * Acquire the oom lock.  If that fails, somebody else is
>> +	 * making progress for us.
>> +	 */
>> +	if (!mutex_trylock(&oom_lock)) {
>> +		*did_some_progress = 1;
>> +		schedule_timeout_uninterruptible(1);
>> +		return NULL;
>> +	}
>> +	success = out_of_memory(&oc);
>> +	mutex_unlock(&oom_lock);
>> +
>>   	/* Exhausted what can be done so it's blame time */
>> -	if (out_of_memory(&oc) || WARN_ON_ONCE(gfp_mask & __GFP_NOFAIL)) {
>> +	if (success || WARN_ON_ONCE(gfp_mask & __GFP_NOFAIL)) {
>>   		*did_some_progress = 1;
>>   
>>   		/*
>> @@ -4004,8 +4008,7 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>>   			page = __alloc_pages_cpuset_fallback(gfp_mask, order,
>>   					ALLOC_NO_WATERMARKS, ac);
>>   	}
>> -out:
>> -	mutex_unlock(&oom_lock);
>> +
>>   	return page;
>>   }
>>   
>> -- 
>> 2.20.1
>>
> 
Sincerely yours,
Mateusz Nosek
