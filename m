Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2323A2B8098
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgKRPcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:32:05 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:54568 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgKRPcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:32:04 -0500
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0AIFW2iK017849;
        Thu, 19 Nov 2020 00:32:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp);
 Thu, 19 Nov 2020 00:32:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0AIFW2Rm017846
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Nov 2020 00:32:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] lockdep: Allow tuning tracing capacity constants.
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <384ce711-25c5-553b-8d22-965847132fbd@i-love.sakura.ne.jp>
 <0eb519fa-e77b-b655-724a-4e9eecc64626@i-love.sakura.ne.jp>
 <6933e938-f219-5e13-aee6-fe4de87eb43e@i-love.sakura.ne.jp>
 <81ab0ffd-6e80-c96c-053a-b1b4fe8694c1@i-love.sakura.ne.jp>
 <20201118142357.GW3121392@hirez.programming.kicks-ass.net>
 <1778f2e5-0a0c-2c6e-2c83-fe51d938e8a2@i-love.sakura.ne.jp>
 <20201118151038.GX3121392@hirez.programming.kicks-ass.net>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <9bc4e07d-2a58-077b-b4c7-ab056ba33cf1@i-love.sakura.ne.jp>
Date:   Thu, 19 Nov 2020 00:31:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201118151038.GX3121392@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/19 0:10, Peter Zijlstra wrote:
> On Wed, Nov 18, 2020 at 11:30:05PM +0900, Tetsuo Handa wrote:
>> The problem is that we can't know what exactly is consuming these resources.
>> My question is do you have a plan to make it possible to know what exactly is
>> consuming these resources.
> 
> I'm pretty sure it's in /proc/lockdep* somewhere.

OK. Then...

Dmitry, can you update syzkaller to dump /proc/lockdep* before terminating as
a crash as soon as encountering one of

  BUG: MAX_LOCKDEP_ENTRIES too low!
  BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
  BUG: MAX_LOCKDEP_CHAINS too low!
  BUG: MAX_LOCKDEP_KEYS too low!
  WARNING in print_bfs_bug

messages?

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
