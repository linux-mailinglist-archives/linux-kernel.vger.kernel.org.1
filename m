Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D3D27A4B9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 02:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgI1AZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 20:25:15 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51903 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgI1AZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 20:25:14 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 08S0Ojt1060573;
        Mon, 28 Sep 2020 09:24:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp);
 Mon, 28 Sep 2020 09:24:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 08S0OjNX060563
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 28 Sep 2020 09:24:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] lockdep: Allow tuning tracing capacity constants.
To:     Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <384ce711-25c5-553b-8d22-965847132fbd@i-love.sakura.ne.jp>
 <0f7233f7-a04a-e9c9-7920-3a170cc97e4b@i-love.sakura.ne.jp>
 <CACT4Y+bjPr=64Lq1-ARD6T=K9LmC_Aor4BRXPcZVtUU8vF0oGg@mail.gmail.com>
 <20200916115057.GO2674@hirez.programming.kicks-ass.net>
 <CACT4Y+agTiEF-1i9LbAgp-q_02oYF0kAPZGAAJ==-wx2Xh7xzQ@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <72b034b7-f9ff-c744-5307-6fd84f38ae26@i-love.sakura.ne.jp>
Date:   Mon, 28 Sep 2020 09:24:44 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+agTiEF-1i9LbAgp-q_02oYF0kAPZGAAJ==-wx2Xh7xzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/09/16 21:14, Dmitry Vyukov wrote:
> On Wed, Sep 16, 2020 at 1:51 PM <peterz@infradead.org> wrote:
>>
>> On Wed, Sep 16, 2020 at 01:28:19PM +0200, Dmitry Vyukov wrote:
>>> On Fri, Sep 4, 2020 at 6:05 PM Tetsuo Handa
>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>>
>>>> Hello. Can we apply this patch?
>>>>
>>>> This patch addresses top crashers for syzbot, and applying this patch
>>>> will help utilizing syzbot's resource for finding other bugs.
>>>
>>> Acked-by: Dmitry Vyukov <dvyukov@google.com>
>>>
>>> Peter, do you still have concerns with this?
>>
>> Yeah, I still hate it with a passion; it discourages thinking. A bad
>> annotation that blows up the lockdep storage, no worries, we'll just
>> increase this :/
>>
>> IIRC the issue with syzbot is that the current sysfs annotation is
>> pretty terrible and generates a gazillion classes, and syzbot likes
>> poking at /sys a lot and thus floods the system.
>>
>> I don't know enough about sysfs to suggest an alternative, and haven't
>> exactly had spare time to look into it either :/
>>
>> Examples of bad annotations is getting every CPU a separate class, that
>> leads to nr_cpus! chains if CPUs arbitrarily nest (nr_cpus^2 if there's
>> only a single nesting level).
> 
> Maybe on "BUG: MAX_LOCKDEP_CHAINS too low!" we should then aggregate,
> sort and show existing chains so that it's possible to identify if
> there are any worst offenders and who they are.
> 
> Currently we only have a hypothesis that there are some worst
> offenders vs lots of normal load. And we can't point fingers which
> means that, say, sysfs, or other maintainers won't be too inclined to
> fix anything.
> 
> If we would know for sure that lock class X is guilty. That would make
> the situation much more actionable.
> 

Dmitry is thinking that we need to use CONFIG_LOCKDEP=n temporary until lockdep
problems are resolved. ( https://github.com/google/syzkaller/issues/2140 )

But I think it is better to apply this patch (and revert this patch when it became
possible to identify if there are any worst offenders and who they are) than using
CONFIG_LOCKDEP=n.

CONFIG_LOCKDEP=n causes "#syz test" request to cause false response regarding locking
related issues, for we are not ready to enforce "retest without proposed patch
when test with proposed patch did not reproduce the crash".

I think that "not detecting lock related problems introduced by new patches" costs
more than "postpone fixing lock related problems in existing code".
