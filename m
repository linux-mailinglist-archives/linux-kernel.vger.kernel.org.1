Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302E72D49F4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 20:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387636AbgLITRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 14:17:44 -0500
Received: from foss.arm.com ([217.140.110.172]:39164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387527AbgLITRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:17:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6C2A1FB;
        Wed,  9 Dec 2020 11:16:57 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE77A3F68F;
        Wed,  9 Dec 2020 11:16:55 -0800 (PST)
References: <20201023101158.088940906@infradead.org> <20201023102347.067278757@infradead.org> <ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com> <jhjpn4bwznx.mognet@arm.com> <c2c013282faf278ee6e0fc66deefbab165ff4e88.camel@redhat.com> <jhjsg8hto03.mognet@arm.com> <589c684a04b4e91e99b22409c614baea35dc93ad.camel@redhat.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qian Cai <qcai@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH v4 11/19] sched/core: Make migrate disable and CPU hotplug cooperative
In-reply-to: <589c684a04b4e91e99b22409c614baea35dc93ad.camel@redhat.com>
Date:   Wed, 09 Dec 2020 19:16:50 +0000
Message-ID: <jhjpn3iu6vx.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/12/20 13:46, Qian Cai wrote:
> On Mon, 2020-12-07 at 19:27 +0000, Valentin Schneider wrote:
>> Ok, can reproduce this on a TX2 on next-20201207. I didn't use your config,
>> I oldconfig'd my distro config and only modified it to CONFIG_PREEMPT_NONE.
>> Interestingly the BUG happens on CPU127 here too...
>
> I think that number is totally random. For example, on this x86, it could happen
> for CPU8 or CPU111.

Actually on the TX2 it seems to *always* happen on CPU127. Your hotplug
script sequentially offlines CPUs in increasing id values, so when CPU127
gets hotplugged it is the last online CPU of NUMA node 0.

I've been staring at traces collected via

  echo 2 > /proc/sys/kernel/ftrace_dump_on_oops
  trace-cmd start -e 'sched:*' -e 'cpuhp:*' -e 'workqueue:*'
  ./hotplug.sh

but it's still not entirely clear to me WTH is going on. I do see kworkers
getting their affinity reset in workqueue_offline_cpu(), but for some
reason there's a new one that wakes up on CPU127 sometime later. I haven't
been able to figure out where it comes from - it obviously isn't part of
the percpu worker pools, as it isn't handled during
workqueue_offline_cpu(), but it still ends up affined to a single CPU...

It looks something like this; traces are only from CPU127

  cpuhp:sched_cpu_wait_empty() # Resets the affinity of some kworker/127:x<2

  sched_switch(idle)

  sched_wakeup(kworker/127:2) # picks CPU127
  sched_switch(kworker/127:2)
  # maybe_create_worker() -> creates kworker/127:3
  sched_wakeup(kworker/127:3) # picks CPU127

  sched_switch(kworker/127:3)
  # maybe_create_worker() -> creates kworker/127:4
  sched_wakeup(kworker/127:4) # picks CPU127

  sched_switch(kworker/127:4)
  # maybe_create_worker() -> creates kworker/127:5
  sched_wakeup(kworker/127:5) # picks CPU127
  sched_wakeup(migration/127)

  sched_switch(migration/127)
  cpuhp:take_cpu_down()

  BUG
