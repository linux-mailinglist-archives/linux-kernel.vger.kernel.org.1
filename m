Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE29A26C531
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 18:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgIPQdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 12:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgIPQTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:19:55 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08891C0611BC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 04:13:54 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z19so6558663lfr.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 04:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ulziYxRdZ0MQknNtI0gQrRWTyPDclBN7Ur2ES5F9lNc=;
        b=KpU44mYIdAvb8RdogyVQ7DXO10QcNpOebBNw5QgfSPhlLov9Bb8PGGhKRmObeh5Xfr
         ONVX+Y9HphhlxZTmlHMcKIxcx+I8f+Ebw0dLsIEFZapF4PRPpz6OzQvQmTrwAt5YBIZa
         hgzGvDK3NNOgBH1bF7nyWYmv6ZBK0w3GDlPeHhPwVP/osdWZCwEZ1A89zGCSBIe2ncSg
         oTYergGC46K/dUQGGRKHnF5ONYNx8w5LFqt5pRXy2XQvq4EWxVPI1aXdjnHVh7YeDUBH
         zSu45y1C0z5zv+lB4QTzWJXTu1WlJMW8QOzijl9rzGLBPsfaqM9jAesx+vWOftx6mJRh
         dW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ulziYxRdZ0MQknNtI0gQrRWTyPDclBN7Ur2ES5F9lNc=;
        b=YatpJyJSxw5W/Pi5e0rEeJrSt6DOUaxdYUTx4u49+i2/xHnQw6YAWGECe3CH5l4MjM
         xoOIqVfpg1zb0hhZ0FsObRAc9NK71XdMpJ1fuMF/j8YEWI3Ob+EOTCjRSkiBKbbZDPkm
         ZRANqa/taT+pV66o6ATcooc1+7wHax8vh3ibd3/9B5nQWTbkoT27IquVJtkPsCtVOPIm
         SG7QfzWJ+oVDOfopoPel4MmJiMH1hb4ALoByOw6j56NVIpVrKsn1MBrjS55HKRAnj+hn
         jl+kVFqsO1ogU9krHRH05ZC0PgZCYxIDkls7+UJWkeM1Yr2c9tRdB65S8dGM+TveDvcc
         qVaA==
X-Gm-Message-State: AOAM530FaoV5dbr68wrNruwtBTxypuxD1hRouAu96cl674DCq0FdGDoh
        8Dhpg88u8h3BzsrHOsuVU/I71uD3Ffs+bA==
X-Google-Smtp-Source: ABdhPJwGojRxukMZdzJAf8ylMPIj5ve/oi4386fEdCSgACX1u9DsH2GLqaG/EBkOEJlQ4KcXGGw3lg==
X-Received: by 2002:a19:8142:: with SMTP id c63mr7488186lfd.175.1600254832412;
        Wed, 16 Sep 2020 04:13:52 -0700 (PDT)
Received: from [192.168.8.100] (188.147.112.12.nat.umts.dynamic.t-mobile.pl. [188.147.112.12])
        by smtp.gmail.com with ESMTPSA id 140sm4528272lfj.146.2020.09.16.04.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 04:13:51 -0700 (PDT)
Subject: Re: [RFC PATCH] mm/page_alloc.c: micro-optimization reduce oom
 critical section size
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
References: <20200914100654.21746-1-mateusznosek0@gmail.com>
 <20200914142233.GT16999@dhcp22.suse.cz>
 <e26d7699-cc51-ffec-321e-ffabc49110e1@gmail.com>
 <20200915140406.GE3736@dhcp22.suse.cz>
From:   Mateusz Nosek <mateusznosek0@gmail.com>
Message-ID: <8a02fa51-c2b8-e1ec-66b3-1b00954b7040@gmail.com>
Date:   Wed, 16 Sep 2020 13:13:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915140406.GE3736@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thank you for your comments.
I will modify the patch where necessary and resend v2, but first I will 
make 100% sure about the lack of synchronization problem, that might 
potentially be there as you mentioned in previous mail , and try to 
check some numbers for my support.

Sincerely yours,
Mateusz Nosek

On 9/15/2020 4:04 PM, Michal Hocko wrote:
> On Tue 15-09-20 15:09:59, Mateusz Nosek wrote:
>>
>>
>> On 9/14/2020 4:22 PM, Michal Hocko wrote:
>>> On Mon 14-09-20 12:06:54, mateusznosek0@gmail.com wrote:
>>>> From: Mateusz Nosek <mateusznosek0@gmail.com>
>>>>
>>>> Most operations from '__alloc_pages_may_oom' do not require oom_mutex hold.
>>>> Exception is 'out_of_memory'. The patch refactors '__alloc_pages_may_oom'
>>>> to reduce critical section size and improve overall system performance.
>>>
>>> This is a real slow path. What is the point of optimizing it? Do you
>>> have any numbers?
>>>
>>
>> I agree that as this is the slow path, then the hard, complicated
>> optimizations are not recommended. In my humble opinion introduced patch is
>> not complex and does not decrease code readability or maintainability. In a
>> nutshell I see no drawbacks of applying it.
> 
> This is clearly a matter of taste. I do not see a good reason to apply
> it TBH. It is a claimed optimization without any numbers to back that
> claim. It is also a tricky area so I am usually very careful to touch
> this code without a strong reason.  Others might feel differently of
> course.
> 
> [...]
> 
> Anyway, I have only now looked closer at the patch...
> 
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index b9bd75cacf02..b07f950a5825 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -3935,18 +3935,7 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>>>>    		.order = order,
>>>>    	};
>>>>    	struct page *page;
>>>> -
>>>> -	*did_some_progress = 0;
>>>> -
>>>> -	/*
>>>> -	 * Acquire the oom lock.  If that fails, somebody else is
>>>> -	 * making progress for us.
>>>> -	 */
>>>> -	if (!mutex_trylock(&oom_lock)) {
>>>> -		*did_some_progress = 1;
>>>> -		schedule_timeout_uninterruptible(1);
>>>> -		return NULL;
>>>> -	}
>>>> +	bool success;
>>>>    	/*
>>>>    	 * Go through the zonelist yet one more time, keep very high watermark
>>>> @@ -3959,14 +3948,17 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>>>>    				      ~__GFP_DIRECT_RECLAIM, order,
>>>>    				      ALLOC_WMARK_HIGH|ALLOC_CPUSET, ac);
>>>>    	if (page)
>>>> -		goto out;
>>>> +		return page;
>>>> +
>>>> +	/* Check if somebody else is making progress for us. */
>>>> +	*did_some_progress = mutex_is_locked(&oom_lock);
> 
> This is not only quite ugly but wrong as well. In general checking for a
> lock state is racy unless the lock is taken somewhere up the call chain.
> 
> In this particular case it wouldn't be a big deal because an additional
> retry (did_some_progress = 1) is not really critical. It would likely be
> nicer to be deterministic here and not retry on all the early bailouts
> regardless of the lock state.
> 
>>>>    	/* Coredumps can quickly deplete all memory reserves */
>>>>    	if (current->flags & PF_DUMPCORE)
>>>> -		goto out;
>>>> +		return NULL;
>>>>    	/* The OOM killer will not help higher order allocs */
>>>>    	if (order > PAGE_ALLOC_COSTLY_ORDER)
>>>> -		goto out;
>>>> +		return NULL;
>>>>    	/*
>>>>    	 * We have already exhausted all our reclaim opportunities without any
>>>>    	 * success so it is time to admit defeat. We will skip the OOM killer
>>>> @@ -3976,12 +3968,12 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>>>>    	 * The OOM killer may not free memory on a specific node.
>>>>    	 */
>>>>    	if (gfp_mask & (__GFP_RETRY_MAYFAIL | __GFP_THISNODE))
>>>> -		goto out;
>>>> +		return NULL;
>>>>    	/* The OOM killer does not needlessly kill tasks for lowmem */
>>>>    	if (ac->highest_zoneidx < ZONE_NORMAL)
>>>> -		goto out;
>>>> +		return NULL;
>>>>    	if (pm_suspended_storage())
>>>> -		goto out;
>>>> +		return NULL;
>>>>    	/*
>>>>    	 * XXX: GFP_NOFS allocations should rather fail than rely on
>>>>    	 * other request to make a forward progress.
>>>> @@ -3992,8 +3984,20 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>>>>    	 * failures more gracefully we should just bail out here.
>>>>    	 */
>>>> +	/*
>>>> +	 * Acquire the oom lock.  If that fails, somebody else is
>>>> +	 * making progress for us.
>>>> +	 */
>>>> +	if (!mutex_trylock(&oom_lock)) {
>>>> +		*did_some_progress = 1;
>>>> +		schedule_timeout_uninterruptible(1);
>>>> +		return NULL;
>>>> +	}
>>>> +	success = out_of_memory(&oc);
>>>> +	mutex_unlock(&oom_lock);
>>>> +
>>>>    	/* Exhausted what can be done so it's blame time */
>>>> -	if (out_of_memory(&oc) || WARN_ON_ONCE(gfp_mask & __GFP_NOFAIL)) {
>>>> +	if (success || WARN_ON_ONCE(gfp_mask & __GFP_NOFAIL)) {
>>>>    		*did_some_progress = 1;
>>>>    		/*
>>>> @@ -4004,8 +4008,7 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>>>>    			page = __alloc_pages_cpuset_fallback(gfp_mask, order,
>>>>    					ALLOC_NO_WATERMARKS, ac);
>>>>    	}
>>>> -out:
>>>> -	mutex_unlock(&oom_lock);
>>>> +
>>>>    	return page;
>>>>    }
>>>> -- 
>>>> 2.20.1
>>>>
>>>
>> Sincerely yours,
>> Mateusz Nosek
> 
