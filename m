Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2428B298C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 12:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774562AbgJZL4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 07:56:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:37382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1768348AbgJZL4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 07:56:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603713364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JrUGiQKa+nOgpLR5+3rPTLPO7SRFbfxNLKSQsjR/B3s=;
        b=MjxjTVAiOfYhK3XVQIdkQb8lFquMPAQpngX7TK0Z9Hi2JU3hJqKttoLw4PMbqU3YMWLwfK
        7K/S4qzkc6UjhuKNJ83dnujc6fHvHo9dROnoAvhE3HHn5RJ7kjdSypyQjpuCDpHqDJKcKO
        VcW7P2n41IrrM9LVJymJALYDnzdVrMU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59E6DAC8B;
        Mon, 26 Oct 2020 11:56:04 +0000 (UTC)
Subject: Re: possible lockdep regression introduced by 4d004099a668 ("lockdep:
 Fix lockdep recursion")
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>
References: <a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com>
 <20201026114009.GN2594@hirez.programming.kicks-ass.net>
From:   Filipe Manana <fdmanana@suse.com>
Message-ID: <0c0d815c-bd5a-ff2d-1417-28a41173f2b4@suse.com>
Date:   Mon, 26 Oct 2020 11:56:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201026114009.GN2594@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/10/20 11:40, Peter Zijlstra wrote:
> On Mon, Oct 26, 2020 at 11:26:49AM +0000, Filipe Manana wrote:
>> Hello,
>>
>> I've recently started to hit a warning followed by tasks hanging after
>> attempts to freeze a filesystem. A git bisection pointed to the
>> following commit:
>>
>> commit 4d004099a668c41522242aa146a38cc4eb59cb1e
>> Author: Peter Zijlstra <peterz@infradead.org>
>> Date:   Fri Oct 2 11:04:21 2020 +0200
>>
>>     lockdep: Fix lockdep recursion
>>
>> This happens very reliably when running all xfstests with lockdep
>> enabled, and the tested filesystem is btrfs (haven't tried other
>> filesystems, but it shouldn't matter). The warning and task hangs always
>> happen at either test generic/068 or test generic/390, and (oddly)
>> always have to run all tests for it to trigger, running those tests
>> individually on an infinite loop doesn't seem to trigger it (at least
>> for a couple hours).
>>
>> The warning triggered is at fs/super.c:__sb_start_write() which always
>> results later in several tasks hanging on a percpu rw_sem:
>>
>> https://pastebin.com/qnLvf94E
>>
>> What happens is percpu_rwsem_is_held() is apparently returning a false
>> positive,
> 
> That smells like the same issue reported here:
> 
>   https://lkml.kernel.org/r/20201022111700.GZ2651@hirez.programming.kicks-ass.net
> 
> Make sure you have commit:
> 
>   f8e48a3dca06 ("lockdep: Fix preemption WARN for spurious IRQ-enable")
> 
> (in Linus' tree by now) and do you have CONFIG_DEBUG_PREEMPT enabled?

Yes, CONFIG_DEBUG_PREEMPT is enabled.
I'll try with that commit and let you know, however it's gonna take a
few hours to build a kernel and run all fstests (on that test box it
takes over 3 hours) to confirm that fixes the issue.

Thanks for the quick reply!

> 
> 
> 
> 
