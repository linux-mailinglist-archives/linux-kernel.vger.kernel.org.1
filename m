Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1792A41A1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgKCKXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:23:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:52608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgKCKXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:23:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604398980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oA05hKkSinrULQd9HqpNn4BV4DmkhbfIuecGB6U/Gks=;
        b=GZm12Nl6nfFexDQp4rA4hOXzs4wiv2AKM2zyaDzejrpWDDkdyFFiWO0qndQtg+5RI2oage
        WJITtkIPeFnnQSd8Ex2jxEdQO2O+csLoGcS1aBoJVNhBcqj2qghiqJYUlPIQ6YaQGg/3ga
        0t2NwYvLfu1P5lb6X92U3bWB/YgM0Ec=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 935C3AC1F;
        Tue,  3 Nov 2020 10:23:00 +0000 (UTC)
Subject: Re: possible lockdep regression introduced by 4d004099a668 ("lockdep:
 Fix lockdep recursion")
To:     Jan Kara <jack@suse.cz>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, matorola@gmail.com,
        mingo@kernel.org, darrick.wong@oracle.com
References: <a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com>
 <20201026114009.GN2594@hirez.programming.kicks-ass.net>
 <0c0d815c-bd5a-ff2d-1417-28a41173f2b4@suse.com>
 <20201026125524.GP2594@hirez.programming.kicks-ass.net>
 <20201026152256.GB2651@hirez.programming.kicks-ass.net>
 <968c6023-612c-342b-aa69-ec9e1e428eb0@suse.com>
 <20201103101543.GC3440@quack2.suse.cz>
From:   Filipe Manana <fdmanana@suse.com>
Message-ID: <61e43415-36a7-e270-e61d-59173d701f97@suse.com>
Date:   Tue, 3 Nov 2020 10:22:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201103101543.GC3440@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/11/20 10:15, Jan Kara wrote:
> On Mon 02-11-20 17:58:54, Filipe Manana wrote:
>>
>>
>> On 26/10/20 15:22, Peter Zijlstra wrote:
>>> On Mon, Oct 26, 2020 at 01:55:24PM +0100, Peter Zijlstra wrote:
>>>> On Mon, Oct 26, 2020 at 11:56:03AM +0000, Filipe Manana wrote:
>>>>>> That smells like the same issue reported here:
>>>>>>
>>>>>>   https://lkml.kernel.org/r/20201022111700.GZ2651@hirez.programming.kicks-ass.net
>>>>>>
>>>>>> Make sure you have commit:
>>>>>>
>>>>>>   f8e48a3dca06 ("lockdep: Fix preemption WARN for spurious IRQ-enable")
>>>>>>
>>>>>> (in Linus' tree by now) and do you have CONFIG_DEBUG_PREEMPT enabled?
>>>>>
>>>>> Yes, CONFIG_DEBUG_PREEMPT is enabled.
>>>>
>>>> Bummer :/
>>>>
>>>>> I'll try with that commit and let you know, however it's gonna take a
>>>>> few hours to build a kernel and run all fstests (on that test box it
>>>>> takes over 3 hours) to confirm that fixes the issue.
>>>>
>>>> *ouch*, 3 hours is painful. How long to make it sick with the current
>>>> kernel? quicker I would hope?
>>>>
>>>>> Thanks for the quick reply!
>>>>
>>>> Anyway, I don't think that commit can actually explain the issue :/
>>>>
>>>> The false positive on lockdep_assert_held() happens when the recursion
>>>> count is !0, however we _should_ be having IRQs disabled when
>>>> lockdep_recursion > 0, so that should never be observable.
>>>>
>>>> My hope was that DEBUG_PREEMPT would trigger on one of the
>>>> __this_cpu_{inc,dec}(lockdep_recursion) instance, because that would
>>>> then be a clear violation.
>>>>
>>>> And you're seeing this on x86, right?
>>>>
>>>> Let me puzzle moar..
>>>
>>> So I might have an explanation for the Sparc64 fail, but that can't
>>> explain x86 :/
>>>
>>> I initially thought raw_cpu_read() was OK, since if it is !0 we have
>>> IRQs disabled and can't get migrated, so if we get migrated both CPUs
>>> must have 0 and it doesn't matter which 0 we read.
>>>
>>> And while that is true; it isn't the whole store, on pretty much all
>>> architectures (except x86) this can result in computing the address for
>>> one CPU, getting migrated, the old CPU continuing execution with another
>>> task (possibly setting recursion) and then the new CPU reading the value
>>> of the old CPU, which is no longer 0.
>>>
>>> I already fixed a bunch of that in:
>>>
>>>   baffd723e44d ("lockdep: Revert "lockdep: Use raw_cpu_*() for per-cpu variables"")
>>>
>>> but clearly this one got crossed.
>>>
>>> Still, that leaves me puzzled over you seeing this on x86 :/
>>
>> Hi Peter,
>>
>> I still get the same issue with 5.10-rc2.
>> Is there any non-merged patch I should try, or anything I can help with?
> 
> BTW, I've just hit the same deadlock issue with ext4 on generic/390 so I
> confirm this isn't btrfs specific issue (as we already knew from the
> analysis but still it's good to have that confirmed).

Indeed, yesterday Darrick was mentioning on IRC that he has run into it
too with fstests on XFS (5.10-rc).

> 
> 								Honza
> 
