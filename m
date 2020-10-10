Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D1428A44C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgJJWxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:53:09 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:44291 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731284AbgJJTFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:05:49 -0400
X-IronPort-AV: E=Sophos;i="5.77,359,1596492000"; 
   d="scan'208";a="471929582"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2020 18:14:23 +0200
Date:   Sat, 10 Oct 2020 18:14:23 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Valentin Schneider <valentin.schneider@arm.com>
cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>
Subject: Re: SD_LOAD_BALANCE
In-Reply-To: <jhj7dtaokxe.mognet@arm.com>
Message-ID: <alpine.DEB.2.22.394.2010101740290.2691@hadrien>
References: <alpine.DEB.2.22.394.2009031605190.2496@hadrien> <jhj7dtaokxe.mognet@arm.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Previously, I was wondering about why starting in Linux v5.8 my unblocking
threads were moving to different sockets more frequently than in previous
releases.  Now, I think that I have found the reason.

The first issue is the change from runnable load average to load average
in computing wake_affine_weight:

---

commit 11f10e5420f6cecac7d4823638bff040c257aba9
Author: Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri Oct 18 15:26:36 2019 +0200

    sched/fair: Use load instead of runnable load in wakeup path

    Runnable load was originally introduced to take into account the case where
    blocked load biases the wake up path which may end to select an overloaded
    CPU with a large number of runnable tasks instead of an underutilized
    CPU with a huge blocked load.

    Tha wake up path now starts looking for idle CPUs before comparing
    runnable load and it's worth aligning the wake up path with the
    load_balance() logic.

---

The unfortunate case is illustrated by the following trace (*** on the
important lines):

       trace-cmd-8006  [118]   451.444751: sched_migrate_task:   comm=containerd pid=2481 prio=120 orig_cpu=114 dest_cpu=118
          ua.B.x-8007  [105]   451.444752: sched_switch:         ua.B.x:8007 [120] S ==> swapper/105:0 [120]
       trace-cmd-8006  [118]   451.444769: sched_switch:         ua.B.x:8006 [120] S ==> containerd:2481 [120] ***
      containerd-2481  [118]   451.444859: sched_switch:         containerd:2481 [120] S ==> swapper/118:0 [120] ***
          ua.B.x-8148  [016]   451.444910: sched_switch:         ua.B.x:8148 [120] S ==> swapper/16:0 [120]
          ua.B.x-8154  [127]   451.445186: sched_switch:         ua.B.x:8154 [120] S ==> swapper/127:0 [120]
          ua.B.x-8145  [047]   451.445199: sched_switch:         ua.B.x:8145 [120] S ==> swapper/47:0 [120]
          ua.B.x-8138  [147]   451.445200: sched_switch:         ua.B.x:8138 [120] S ==> swapper/147:0 [120]
          ua.B.x-8152  [032]   451.445210: sched_switch:         ua.B.x:8152 [120] S ==> swapper/32:0 [120]
          ua.B.x-8144  [067]   451.445215: sched_switch:         ua.B.x:8144 [120] S ==> swapper/67:0 [120]
          ua.B.x-8137  [000]   451.445219: sched_switch:         ua.B.x:8137 [120] S ==> swapper/0:0 [120]
          ua.B.x-8140  [075]   451.445225: sched_switch:         ua.B.x:8140 [120] S ==> swapper/75:0 [120]
          ua.B.x-8155  [084]   451.445229: sched_switch:         ua.B.x:8155 [120] S ==> swapper/84:0 [120]
          ua.B.x-8161  [155]   451.445232: sched_switch:         ua.B.x:8161 [120] S ==> swapper/155:0 [120]
          ua.B.x-8156  [095]   451.445261: sched_switch:         ua.B.x:8156 [120] S ==> swapper/95:0 [120]
          ua.B.x-8153  [134]   451.445268: sched_switch:         ua.B.x:8153 [120] S ==> swapper/134:0 [120]
          ua.B.x-8151  [154]   451.445268: sched_switch:         ua.B.x:8151 [120] S ==> swapper/154:0 [120]
          ua.B.x-8141  [107]   451.445273: sched_switch:         ua.B.x:8141 [120] S ==> swapper/107:0 [120]
          ua.B.x-8146  [131]   451.445275: sched_switch:         ua.B.x:8146 [120] S ==> swapper/131:0 [120]
          ua.B.x-8160  [035]   451.445286: sched_switch:         ua.B.x:8160 [120] S ==> swapper/35:0 [120]
          ua.B.x-8136  [088]   451.445286: sched_switch:         ua.B.x:8136 [120] S ==> swapper/88:0 [120]
          ua.B.x-8159  [056]   451.445290: sched_switch:         ua.B.x:8159 [120] S ==> swapper/56:0 [120]
          ua.B.x-8147  [036]   451.445294: sched_switch:         ua.B.x:8147 [120] S ==> swapper/36:0 [120]
          ua.B.x-8150  [150]   451.445298: sched_switch:         ua.B.x:8150 [120] S ==> swapper/150:0 [120]
          ua.B.x-8142  [159]   451.445300: sched_switch:         ua.B.x:8142 [120] S ==> swapper/159:0 [120]
          ua.B.x-8157  [058]   451.445309: sched_switch:         ua.B.x:8157 [120] S ==> swapper/58:0 [120]
          ua.B.x-8149  [123]   451.445311: sched_switch:         ua.B.x:8149 [120] S ==> swapper/123:0 [120]
          ua.B.x-8162  [156]   451.445313: sched_switch:         ua.B.x:8162 [120] S ==> swapper/156:0 [120]
          ua.B.x-8164  [019]   451.445317: sched_switch:         ua.B.x:8164 [120] S ==> swapper/19:0 [120]
          ua.B.x-8139  [068]   451.445319: sched_switch:         ua.B.x:8139 [120] S ==> swapper/68:0 [120]
          ua.B.x-8143  [126]   451.445335: sched_switch:         ua.B.x:8143 [120] S ==> swapper/126:0 [120]
          ua.B.x-8163  [062]   451.445361: sched_switch:         ua.B.x:8163 [120] S ==> swapper/62:0 [120]
          ua.B.x-8158  [129]   451.445371: sched_switch:         ua.B.x:8158 [120] S ==> swapper/129:0 [120]
          ua.B.x-8040  [043]   451.445413: sched_wake_idle_without_ipi: cpu=0
          ua.B.x-8165  [098]   451.445451: sched_switch:         ua.B.x:8165 [120] S ==> swapper/98:0 [120]
          ua.B.x-8069  [009]   451.445622: sched_waking:         comm=ua.B.x pid=8007 prio=120 target_cpu=105
          ua.B.x-8069  [009]   451.445635: sched_wake_idle_without_ipi: cpu=105
          ua.B.x-8069  [009]   451.445638: sched_wakeup:         ua.B.x:8007 [120] success=1 CPU:105
          ua.B.x-8069  [009]   451.445639: sched_waking:         comm=ua.B.x pid=8006 prio=120 target_cpu=118
          <idle>-0     [105]   451.445641: sched_switch:         swapper/105:0 [120] R ==> ua.B.x:8007 [120]
          ua.B.x-8069  [009]   451.445645: bprint:               select_task_rq_fair: wake_affine_weight2 returning this_cpu: 614400 < 2981888
          ua.B.x-8069  [009]   451.445650: sched_migrate_task:   comm=ua.B.x pid=8006 prio=120 orig_cpu=118 dest_cpu=129 ***

Basically, core 118 has run both a thread of the NAS UA benchmark and a
containerd, and so it seems to have a higher load average than this_cpu, ie
9, when it wakes up.  The commit says "The wake up path now starts looking
for idle CPUs", but this is not always the case.  Here the target and prev
are not on the same socket, and in that case cpus_share_cache(prev, target)
fails and there is no check as to whether prev is idle.  The result is that
an idle core is left idle and the thread is migrated to another socket,
perhaps impacting locality.

Prior to v5.8 on my machine this was a rare event, because there were not
many of these background processes.  But in v5.8, the default governor for
Intel machines without the HWP feature was changed from intel_pstate to
intel_cpufreq.  The use of intel_cpufreq triggers very frequent kworkers on
all cores, which makes it much more likely that cores that are currently
idle, and are overall not at all overloaded, will have a higher load
average even with the waking thread deducted, than the core managing the
wakeup of the threads.

Would it be useful to always check whether prev is idle, perhaps in
wake_affine_idle or perhaps in select_idle_sibling?

Traces from various versions are available at
https://pages.lip6.fr/Julia.Lawall/uas.pdf.  5.8 and 5.9-rc7 are toward the
end of the file.  In these versions, all the threads systematically move
around at synchronization points in the program.

thanks,
julia
