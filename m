Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA85298D74
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1776210AbgJZNGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:06:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:60692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1776202AbgJZNGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:06:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603717573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EuwFJyJQ6SmPuAbO6WZVV9gzy3Y+dmWIYy6nUyKrvlQ=;
        b=iqLgAPO48MiqAX3rtL+4tN5/NcwJLZK8oF05ptfg38DudFqf3Jodgtb7j9jiHUP10eSxqS
        InPw92TNQDRDDkgeRzcNTpxhh0v9/cAfMCfzTUsdtMNgZ+hyDq2EfxH0M4e2zfm8mKP0qm
        Lk6mYyMXSnhiqkX7M/7PemX0EoB9xM4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 127AFACD0;
        Mon, 26 Oct 2020 13:06:13 +0000 (UTC)
Subject: Re: possible lockdep regression introduced by 4d004099a668 ("lockdep:
 Fix lockdep recursion")
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>
References: <a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com>
 <20201026114009.GN2594@hirez.programming.kicks-ass.net>
 <0c0d815c-bd5a-ff2d-1417-28a41173f2b4@suse.com>
 <20201026125524.GP2594@hirez.programming.kicks-ass.net>
From:   Filipe Manana <fdmanana@suse.com>
Message-ID: <7edd5299-6b12-b8f1-046b-bccc8b0799b6@suse.com>
Date:   Mon, 26 Oct 2020 13:06:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201026125524.GP2594@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/10/20 12:55, Peter Zijlstra wrote:
> On Mon, Oct 26, 2020 at 11:56:03AM +0000, Filipe Manana wrote:
>>> That smells like the same issue reported here:
>>>
>>>   https://lkml.kernel.org/r/20201022111700.GZ2651@hirez.programming.kicks-ass.net
>>>
>>> Make sure you have commit:
>>>
>>>   f8e48a3dca06 ("lockdep: Fix preemption WARN for spurious IRQ-enable")
>>>
>>> (in Linus' tree by now) and do you have CONFIG_DEBUG_PREEMPT enabled?
>>
>> Yes, CONFIG_DEBUG_PREEMPT is enabled.
> 
> Bummer :/
> 
>> I'll try with that commit and let you know, however it's gonna take a
>> few hours to build a kernel and run all fstests (on that test box it
>> takes over 3 hours) to confirm that fixes the issue.
> 
> *ouch*, 3 hours is painful. How long to make it sick with the current
> kernel? quicker I would hope?

If generic/068 triggers the bug, than it's about 1 hour. If that passes,
which rarely happens, then have to wait to get into generic/390, which
is over 2 hours.

It sucks that running those tests alone never trigger the issue, but
running all fstests (first btrfs specific ones, followed by the generic
ones) reliably triggers the bug, almost always at generic/068, when that
passes, it's triggered by generic/390. To confirm everything is ok, I
let all tests run (last generic is 612).


> 
>> Thanks for the quick reply!
> 
> Anyway, I don't think that commit can actually explain the issue :/
> 
> The false positive on lockdep_assert_held() happens when the recursion
> count is !0, however we _should_ be having IRQs disabled when
> lockdep_recursion > 0, so that should never be observable.
> 
> My hope was that DEBUG_PREEMPT would trigger on one of the
> __this_cpu_{inc,dec}(lockdep_recursion) instance, because that would
> then be a clear violation.
> 
> And you're seeing this on x86, right?

Right.
It's in a qemu vm on x86, with '-cpu host' passed to qemu and kvm enabled.

Thanks.


> 
> Let me puzzle moar..
> 
