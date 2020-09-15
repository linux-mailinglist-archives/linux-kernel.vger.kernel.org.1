Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02B526B22C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgIOWmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727544AbgIOWlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 18:41:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6534B20770;
        Tue, 15 Sep 2020 22:41:20 +0000 (UTC)
Date:   Tue, 15 Sep 2020 18:41:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     peterz@infradead.org, gengdongjiu <gengdongjiu@huawei.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "thara.gopinath@linaro.org" <thara.gopinath@linaro.org>,
        "pauld@redhat.com" <pauld@redhat.com>,
        "vincent.donnefort@arm.com" <vincent.donnefort@arm.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RE???[PATCH] sched: Add trace for task wake up latency and
 leave running time
Message-ID: <20200915184118.211214b6@gandalf.local.home>
In-Reply-To: <20200903084925.GB3117@suse.de>
References: <6995260be2ca4fd18bc773fe9f50f420@huawei.com>
        <20200903074232.GW1362448@hirez.programming.kicks-ass.net>
        <20200903084925.GB3117@suse.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Sep 2020 09:49:25 +0100
Mel Gorman <mgorman@suse.de> wrote:

> If state is to be accumulated between multiple tracepoints then the
> primary options are BPF, systemtap, trace-cmd for offline analysis or

Note, ftrace now has histograms which use the "synthetic events" that Peter
mentioned, which can give you state between two different trace points. For
example:

  # cd /sys/kernel/tracing
  # echo latency u64 lat pid_t pid int prio > synthetic_events
  # echo 'hist:keys=pid:ts0=common_timestamp.usecs' > events/sched/sched_waking/trigger
  # echo 'hist:keys=next_pid:lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).trace(latency,$lat,next_pid,next_prio) if next_prio < 100' > events/sched/sched_switch/trigger

Which will trigger the synthetic event "latency" when the sched_switch
"next_pid" matches the sched_waking "pid" only if "next_prio" is less than
100 (note lower inside the kernel means higher priority, so these are only
real time tasks).

  # echo 1 > events/synthetic/latency/enable

  # cat trace
            sshd-1049  [000] d...411  3739.316424: latency: lat=3 pid=277 prio=49
          <idle>-0     [001] d...4..  3739.316466: latency: lat=30 pid=275 prio=49
            grep-9054  [000] d...4..  3739.316564: latency: lat=3 pid=277 prio=49
            grep-9054  [000] d...411  3739.316671: latency: lat=3 pid=277 prio=49
          <idle>-0     [001] d...4..  3739.316709: latency: lat=31 pid=275 prio=49
            grep-9054  [000] d...4..  3739.316759: latency: lat=3 pid=277 prio=49
            sshd-1049  [000] d...411  3739.316835: latency: lat=4 pid=277 prio=49
          <idle>-0     [001] d...4..  3739.316893: latency: lat=50 pid=275 prio=49
            sshd-1049  [000] d...4..  3739.316968: latency: lat=4 pid=277 prio=49
            sshd-1049  [000] d...4..  3739.317082: latency: lat=6 pid=277 prio=49
          <idle>-0     [001] d...4..  3739.317115: latency: lat=29 pid=275 prio=49
            sshd-1049  [000] d...411  3739.317194: latency: lat=4 pid=277 prio=49

  # echo 'hist:keys=prio,lat:sort=lat' > events/synthetic/latency/trigger
  # cat events/synthetic/latency/hist

# event histogram
#
# trigger info: hist:keys=prio,lat:vals=hitcount:sort=lat:size=2048 [active]
#

{ prio:         98, lat:          2 } hitcount:          1
{ prio:         98, lat:          3 } hitcount:          1
{ prio:          0, lat:          3 } hitcount:          2
{ prio:         98, lat:          4 } hitcount:          1
{ prio:         98, lat:          5 } hitcount:          3
{ prio:         98, lat:          6 } hitcount:          1
{ prio:         49, lat:          8 } hitcount:          2
{ prio:         49, lat:          9 } hitcount:          1
{ prio:         49, lat:         10 } hitcount:          1
{ prio:         49, lat:         11 } hitcount:          1
{ prio:         98, lat:         22 } hitcount:          2
{ prio:         98, lat:         25 } hitcount:          1
{ prio:         49, lat:         25 } hitcount:          1
{ prio:         98, lat:         26 } hitcount:          1
{ prio:         98, lat:         28 } hitcount:          2
{ prio:         49, lat:         30 } hitcount:          2
{ prio:         49, lat:         31 } hitcount:          1
{ prio:         98, lat:         33 } hitcount:          1
{ prio:         49, lat:         34 } hitcount:          1
{ prio:         49, lat:         35 } hitcount:          1
{ prio:         49, lat:         41 } hitcount:          1
{ prio:         49, lat:         44 } hitcount:          2
{ prio:         49, lat:         54 } hitcount:          1
{ prio:          0, lat:        172 } hitcount:          1

Totals:
    Hits: 32
    Entries: 24
    Dropped: 0

Just FYI ;-)

-- Steve


> opening trace_pipe with a script, parsing the events and accumulate the
> state that way. This can lead to a concern that the script must be running
> from system start to track the data and yes, this is exactly what you
> have to do.  It's not that different to having to monitor /proc/vmstat
> over time to get some interesting vm stats as the accumulated state since
> the system started is often useless.

