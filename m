Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC20C298C84
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 12:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774584AbgJZL7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 07:59:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:39334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1768805AbgJZL7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 07:59:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603713570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gqulQtP8BApT2uUsXYPPjeATxjR9kCdGx0S8oTQNfDk=;
        b=PKfyGuDIvymAcXcce2412s4YMYLNQNn5GY4PDBvItTfzBZDN8PESOv8kpOcb6+HAvylWRX
        0EWRqoavlFdvzM6aaRL0VqmyS/YS17IMyx6oiHnS8pE1kNNI/vSd+0s5A+7yc3naswgPIj
        f2UGzwFCGEfYFsd81/GOb1dbdavO+vI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ACB43AC8B;
        Mon, 26 Oct 2020 11:59:30 +0000 (UTC)
Subject: Re: possible lockdep regression introduced by 4d004099a668 ("lockdep:
 Fix lockdep recursion")
To:     Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com>
 <20201026114009.GN2594@hirez.programming.kicks-ass.net>
 <20201026115541.GC28769@quack2.suse.cz>
From:   Filipe Manana <fdmanana@suse.com>
Message-ID: <546907be-1d9c-45c8-921e-6b7308648f18@suse.com>
Date:   Mon, 26 Oct 2020 11:59:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201026115541.GC28769@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/10/20 11:55, Jan Kara wrote:
> On Mon 26-10-20 12:40:09, Peter Zijlstra wrote:
>> On Mon, Oct 26, 2020 at 11:26:49AM +0000, Filipe Manana wrote:
>>> Hello,
>>>
>>> I've recently started to hit a warning followed by tasks hanging after
>>> attempts to freeze a filesystem. A git bisection pointed to the
>>> following commit:
>>>
>>> commit 4d004099a668c41522242aa146a38cc4eb59cb1e
>>> Author: Peter Zijlstra <peterz@infradead.org>
>>> Date:   Fri Oct 2 11:04:21 2020 +0200
>>>
>>>     lockdep: Fix lockdep recursion
>>>
>>> This happens very reliably when running all xfstests with lockdep
>>> enabled, and the tested filesystem is btrfs (haven't tried other
>>> filesystems, but it shouldn't matter). The warning and task hangs always
>>> happen at either test generic/068 or test generic/390, and (oddly)
>>> always have to run all tests for it to trigger, running those tests
>>> individually on an infinite loop doesn't seem to trigger it (at least
>>> for a couple hours).
>>>
>>> The warning triggered is at fs/super.c:__sb_start_write() which always
>>> results later in several tasks hanging on a percpu rw_sem:
>>>
>>> https://pastebin.com/qnLvf94E
>>>
>>> What happens is percpu_rwsem_is_held() is apparently returning a false
>>> positive,
>>
>> That smells like the same issue reported here:
>>
>>   https://lkml.kernel.org/r/20201022111700.GZ2651@hirez.programming.kicks-ass.net
>>
>> Make sure you have commit:
>>
>>   f8e48a3dca06 ("lockdep: Fix preemption WARN for spurious IRQ-enable")
>>
>> (in Linus' tree by now) and do you have CONFIG_DEBUG_PREEMPT enabled?
> 
> Hum, I am at 5.10-rc1 now and above mentioned commit doesn't appear to be
> there? Also googling for the title doesn't help...

Same here, can't find in Linus' tree neither through google.

> 
> 								Honza
> 
