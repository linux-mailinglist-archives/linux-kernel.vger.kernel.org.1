Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300862CFD8D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgLESiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:38:08 -0500
Received: from foss.arm.com ([217.140.110.172]:44454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgLESiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 13:38:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE886D6E;
        Sat,  5 Dec 2020 10:37:13 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BF5B3F575;
        Sat,  5 Dec 2020 10:37:11 -0800 (PST)
References: <20201023101158.088940906@infradead.org> <20201023102347.067278757@infradead.org> <ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com> <jhjpn4bwznx.mognet@arm.com> <c2c013282faf278ee6e0fc66deefbab165ff4e88.camel@redhat.com>
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
In-reply-to: <c2c013282faf278ee6e0fc66deefbab165ff4e88.camel@redhat.com>
Date:   Sat, 05 Dec 2020 18:37:06 +0000
Message-ID: <jhjwnxwt7zh.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/12/20 21:19, Qian Cai wrote:
> On Tue, 2020-11-17 at 19:28 +0000, Valentin Schneider wrote:
>> We did have some breakage in that area, but all the holes I was aware of
>> have been plugged. What would help here is to see which tasks are still
>> queued on that outgoing CPU, and their recent activity.
>>
>> Something like
>> - ftrace_dump_on_oops on your kernel cmdline
>> - trace-cmd start -e 'sched:*'
>>  <start the test here>
>>
>> ought to do it. Then you can paste the (tail of the) ftrace dump.
>>
>> I also had this laying around, which may or may not be of some help:
>
> Okay, your patch did not help, since it can still be reproduced using this,
>

It wasn't meant to fix this, only add some more debug prints :)

> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
>
> # while :; do cpuhotplug04.sh -l 1; done
>
> The ftrace dump has too much output on this 256-CPU system, so I have not had
> the patient to wait for it to finish after 15-min. But here is the log capturing
> so far (search for "kernel BUG" there).
>
> http://people.redhat.com/qcai/console.log
>

From there I see:

[20798.166987][  T650] CPU127 nr_running=2
[20798.171185][  T650]  p=migration/127
[20798.175161][  T650]  p=kworker/127:1

so this might be another workqueue hurdle. This should be prevented by:

  06249738a41a ("workqueue: Manually break affinity on hotplug")

In any case, I'll give this a try on a TX2 next week and see where it gets
me.

Note that much earlier in your log, you have a softlockup on CPU127:

[   74.278367][  C127] watchdog: BUG: soft lockup - CPU#127 stuck for 23s! [swapper/0:1]
