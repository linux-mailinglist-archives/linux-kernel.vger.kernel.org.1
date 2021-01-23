Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190DF301487
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 11:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbhAWKal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 05:30:41 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:62450 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbhAWKag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 05:30:36 -0500
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 10NATWoY066298;
        Sat, 23 Jan 2021 19:29:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Sat, 23 Jan 2021 19:29:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 10NATWWg066295
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jan 2021 19:29:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: BUG: MAX_LOCKDEP_KEYS too low!
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Hillf Danton <hdanton@sina.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <c099ad52-0c2c-b886-bae2-c64bd8626452@ozlabs.ru>
 <CACT4Y+Z+kwPM=WUzJ-e359PWeLLqmF0w4Yxp1spzZ=+J0ekrag@mail.gmail.com>
 <6af41136-4344-73da-f821-e831674be473@i-love.sakura.ne.jp>
 <70d427e8-7281-0aae-c524-813d73eca2d7@ozlabs.ru>
 <CACT4Y+bqidtwh1HUFFoyyKyVy0jnwrzhVBgqmU+T9sN1yPMO=g@mail.gmail.com>
 <eb71cc37-afbd-5446-6305-8c7abcc6e91f@i-love.sakura.ne.jp>
 <6eaafbd8-1c10-75df-75ae-9afa0861f69b@i-love.sakura.ne.jp>
 <20210123060145.18356-1-hdanton@sina.com>
 <8b1fff6b-1acc-4582-0abe-86f948ac4b4a@ozlabs.ru>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <0bfad7f4-550a-0645-d24b-940e399e9c2c@i-love.sakura.ne.jp>
Date:   Sat, 23 Jan 2021 19:29:30 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <8b1fff6b-1acc-4582-0abe-86f948ac4b4a@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/01/23 15:35, Alexey Kardashevskiy wrote:
> this behaves quite different but still produces the message (i have show_workqueue_state() right after the bug message):
> 
> 
> [   85.803991] BUG: MAX_LOCKDEP_KEYS too low!
> [   85.804338] turning off the locking correctness validator.
> [   85.804474] Showing busy workqueues and worker pools:
> [   85.804620] workqueue events_unbound: flags=0x2
> [   85.804764]   pwq 16: cpus=0-7 flags=0x4 nice=0 active=1/512 refcnt=3
> [   85.804965]     in-flight: 81:bpf_map_free_deferred
> [   85.805229] workqueue events_power_efficient: flags=0x80
> [   85.805357]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
> [   85.805558]     in-flight: 57:gc_worker
> [   85.805877] pool 4: cpus=2 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 82 24
> [   85.806147] pool 16: cpus=0-7 flags=0x4 nice=0 hung=69s workers=3 idle: 7 251
> ^C[  100.129747] maxlockdep (5104) used greatest stack depth: 8032 bytes left
> 
> root@le-dbg:~# grep "lock-classes" /proc/lockdep_stats
>  lock-classes:                         8192 [max: 8192]
> 

Right. Hillf's patch can reduce number of active workqueue's worker threads, for
only one worker thread can call bpf_map_free_deferred() (which is nice because
it avoids bloat of active= and refcnt= fields). But Hillf's patch is not for
fixing the cause of "BUG: MAX_LOCKDEP_KEYS too low!" message.

Like Dmitry mentioned, bpf syscall allows producing work items faster than
bpf_map_free_deferred() can consume. (And a similar problem is observed for
network namespaces.) Unless there is a bug that prevents bpf_map_free_deferred()
 from completing, the classical solution is to put pressure on producers (i.e.
slow down bpf syscall side) in a way that consumers (i.e. __bpf_map_put())
will not schedule thousands of backlog "struct bpf_map" works.
