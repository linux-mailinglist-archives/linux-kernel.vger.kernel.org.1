Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47ED624838D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 13:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgHRLHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 07:07:40 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51341 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgHRLHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:07:36 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 07IB7E6u053360;
        Tue, 18 Aug 2020 20:07:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Tue, 18 Aug 2020 20:07:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 07IB7DMZ053348
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 18 Aug 2020 20:07:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] lockdep: Introduce CONFIG_LOCKDEP_LARGE
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CACT4Y+YXT9iLij-AbrUwj=yPq-YNFw=Au9g0LQJCKwYonaHCDQ@mail.gmail.com>
 <46674d71-1e41-cb68-ed99-72c25a73dfef@i-love.sakura.ne.jp>
 <37b60b14-4eb6-36b3-1195-97c2d27b7ed8@i-love.sakura.ne.jp>
 <CACT4Y+Y0ptJDj1F89jKQEKB_L8U2yFCUUZ7pwxh+fcE-ZpsBkg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <8fc12fea-bf70-874e-fc19-067d504fa5cc@i-love.sakura.ne.jp>
Date:   Tue, 18 Aug 2020 20:07:09 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Y0ptJDj1F89jKQEKB_L8U2yFCUUZ7pwxh+fcE-ZpsBkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/08/18 18:57, Dmitry Vyukov wrote:
> On Tue, Aug 4, 2020 at 4:36 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Hello, Peter, Ingo and Will.
>>
>> (Q1) Can we change the capacity using kernel config?
>>
>> (Q2) If we can change the capacity, is it OK to specify these constants
>>      independently? (In other words, is there inter-dependency among
>>      these constants?)
> 
> 
> I think we should do this.
> syzbot uses a very beefy kernel config and very broad load.
> We are hitting "BUG: MAX_LOCKDEP_ENTRIES too low!" for the part 428
> days and already hit it 96K times. It's just harming overall kernel
> testing:
> https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b
> 
> I think it's better if exact values are not hardcoded, but rather
> specified in the config. Today we are switching from 4K to 8K, but as
> we enable more configs and learn to reach more code, we may need 16K.

For short term, increasing the capacity would be fine. But for long term, I doubt.

Learning more locks being held within one boot by enabling more configs, I suspect
that it becomes more and more timing dependent and difficult to hold all locks that
can generate a lockdep warning.

> 
> 
>> (Q3) Do you think that we can extend lockdep to be used as a tool for auditing
>>      locks held in kernel space and rebuilding lock dependency map in user space?
> 
> This looks like lots of work. Also unpleasant dependencies on
> user-space. If there is a user-space component, it will need to be
> deployed to _all_ of kernel testing systems and for all users of
> syzkaller. And it will also be a dependency for reproducers. Currently
> one can run a C reproducer and get the errors message from LOCKDEP. It
> seems that a user-space component will make it significantly more
> complicated.

My suggestion is to detach lockdep warning from realtime alarming.

Since not all locks are always held (e.g. some locks are held only if exceeding
some threshold), requiring all locks being held within one boot sounds difficult.
Such requirement results in flaky bisection like "Fix bisection: failed" in
https://syzkaller.appspot.com/bug?id=b23ec126241ad0d86628de6eb5c1cff57d282632 .

Then, I'm wishing that we could build non-realtime alarming based on all locks held
across all boots on each vmlinux file.

> 
> 
>> On 2020/07/25 14:23, Tetsuo Handa wrote:
>>>> Also somebody may use it to _reduce_ size of the table for a smaller kernel.
>>>
>>> Maybe. But my feeling is that it is very rare that the kernel actually deadlocks
>>> as soon as lockdep warned the possibility of deadlock.
>>>
>>> Since syzbot runs many instances in parallel, a lot of CPU resource is spent for
>>> checking the same dependency tree. However, the possibility of deadlock can be
>>> warned for only locks held within each kernel boot, and it is impossible to hold
>>> all locks with one kernel boot.
>>>
>>> Then, it might be nice if lockdep can audit only "which lock was held from which
>>> context and what backtrace" and export that log like KCOV data (instead of evaluating
>>> the possibility of deadlock), and rebuild the whole dependency (and evaluate the
>>> possibility of deadlock) across multiple kernel boots in userspace.
>>

