Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92F32932C1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390110AbgJTBnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390104AbgJTBnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:43:46 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C172C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:43:46 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j17so323926ilr.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8z+LgpuimDI2JYSTCMKwzzGzWHiXIYremNKLDyZ1A0=;
        b=HkeXBeyYnT8HaWZkPBuidBaotNQFjpBpXcuPGSyHcXgzCzsodbITmX96ZuU9ls+Jhd
         hA0yK5kam6/DmypWfABFaVeloorxdpRMb574dZU5QhkJlFW5Uk0YwGehjdECcuwwzvgm
         fHo5IP/MCLvw4izh7TLNnvrrCpXREeSWnzS2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8z+LgpuimDI2JYSTCMKwzzGzWHiXIYremNKLDyZ1A0=;
        b=Y+CGj1lv29AmJAQl9iDKGBACDFBpMvw1X7Xbrf4krWKCsSJlY1qcUgptIDOFYouKQA
         GG8VdBh7C8JB+Fib/jGhd+zV9XbbsmFZUad7YL15KeBzx0BCTEyjjYfJZciqg6tG9sBz
         iCprrmAJbMwlQqYh8cjrPapoUU7k/WaTeEbv+UCaKIgIJWz+NaVKQ+r9HnKXv0g7Au9Y
         Q0etqSoa4t6NWGD33SUzJVBUxbeftNaWhzJWIja+tQNEPA1TfeZO2iXufFfWh9ylEi7R
         VqT0G1YW9b/wvf3S4g04lQmr0f3oaBF04WLdVOW6vYPg8viYvip7j0oPBLzgKSzblKTf
         a+gA==
X-Gm-Message-State: AOAM531YD1rTXDoJS0t7As5jcsp2Vi0eL28VqLRGkTDrH4fhxt7NBL+J
        s3XuJLUbrqziAIFGTByL347gJg==
X-Google-Smtp-Source: ABdhPJyZLchS+PeHc1i1e7ypO1VtSJaIwJ50QY9Q+NbwdR+x43+MEs+P8Dp5Yz1t1aYrCnjt8FRzTg==
X-Received: by 2002:a92:de07:: with SMTP id x7mr217119ilm.285.1603158225635;
        Mon, 19 Oct 2020 18:43:45 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t22sm485306ili.9.2020.10.19.18.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:43:44 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH v8 -tip 00/26] Core scheduling
Date:   Mon, 19 Oct 2020 21:43:10 -0400
Message-Id: <20201020014336.2076526-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eighth iteration of the Core-Scheduling feature.

Core scheduling is a feature that allows only trusted tasks to run
concurrently on cpus sharing compute resources (eg: hyperthreads on a
core). The goal is to mitigate the core-level side-channel attacks
without requiring to disable SMT (which has a significant impact on
performance in some situations). Core scheduling (as of v7) mitigates
user-space to user-space attacks and user to kernel attack when one of
the siblings enters the kernel via interrupts or system call.

By default, the feature doesn't change any of the current scheduler
behavior. The user decides which tasks can run simultaneously on the
same core (for now by having them in the same tagged cgroup). When a tag
is enabled in a cgroup and a task from that cgroup is running on a
hardware thread, the scheduler ensures that only idle or trusted tasks
run on the other sibling(s). Besides security concerns, this feature can
also be beneficial for RT and performance applications where we want to
control how tasks make use of SMT dynamically.

This iteration focuses on the the following stuff:
- Redesigned API.
- Rework of Kernel Protection feature based on Thomas's entry work.
- Rework of hotplug fixes.
- Address review comments in v7

Joel: Both a CGroup and Per-task interface via prctl(2) are provided for
configuring core sharing. More details are provided in documentation patch.
Kselftests are provided to verify the correctness/rules of the interface.

Julien: TPCC tests showed improvements with core-scheduling. With kernel
protection enabled, it does not show any regression. Possibly ASI will improve
the performance for those who choose kernel protection (can be toggled through
sched_core_protect_kernel sysctl). Results:
v8				average		stdev		diff
baseline (SMT on)		1197.272	44.78312824	
core sched (   kernel protect)	412.9895	45.42734343	-65.51%
core sched (no kernel protect)	686.6515	71.77756931	-42.65%
nosmt				408.667		39.39042872	-65.87%

v8 is rebased on tip/master.

Future work
===========
- Load balancing/Migration fixes for core scheduling.
  With v6, Load balancing is partially coresched aware, but has some
  issues w.r.t process/taskgroup weights:
  https://lwn.net/ml/linux-kernel/20200225034438.GA617271@z...
- Core scheduling test framework: kselftests, torture tests etc

Changes in v8
=============
- New interface/API implementation
  - Joel
- Revised kernel protection patch
  - Joel
- Revised Hotplug fixes
  - Joel
- Minor bug fixes and address review comments
  - Vineeth

Changes in v7
=============
- Kernel protection from untrusted usermode tasks
  - Joel, Vineeth
- Fix for hotplug crashes and hangs
  - Joel, Vineeth

Changes in v6
=============
- Documentation
  - Joel
- Pause siblings on entering nmi/irq/softirq
  - Joel, Vineeth
- Fix for RCU crash
  - Joel
- Fix for a crash in pick_next_task
  - Yu Chen, Vineeth
- Minor re-write of core-wide vruntime comparison
  - Aaron Lu
- Cleanup: Address Review comments
- Cleanup: Remove hotplug support (for now)
- Build fixes: 32 bit, SMT=n, AUTOGROUP=n etc
  - Joel, Vineeth

Changes in v5
=============
- Fixes for cgroup/process tagging during corner cases like cgroup
  destroy, task moving across cgroups etc
  - Tim Chen
- Coresched aware task migrations
  - Aubrey Li
- Other minor stability fixes.

Changes in v4
=============
- Implement a core wide min_vruntime for vruntime comparison of tasks
  across cpus in a core.
  - Aaron Lu
- Fixes a typo bug in setting the forced_idle cpu.
  - Aaron Lu

Changes in v3
=============
- Fixes the issue of sibling picking up an incompatible task
  - Aaron Lu
  - Vineeth Pillai
  - Julien Desfossez
- Fixes the issue of starving threads due to forced idle
  - Peter Zijlstra
- Fixes the refcounting issue when deleting a cgroup with tag
  - Julien Desfossez
- Fixes a crash during cpu offline/online with coresched enabled
  - Vineeth Pillai
- Fixes a comparison logic issue in sched_core_find
  - Aaron Lu

Changes in v2
=============
- Fixes for couple of NULL pointer dereference crashes
  - Subhra Mazumdar
  - Tim Chen
- Improves priority comparison logic for process in different cpus
  - Peter Zijlstra
  - Aaron Lu
- Fixes a hard lockup in rq locking
  - Vineeth Pillai
  - Julien Desfossez
- Fixes a performance issue seen on IO heavy workloads
  - Vineeth Pillai
  - Julien Desfossez
- Fix for 32bit build
  - Aubrey Li

Aubrey Li (1):
sched: migration changes for core scheduling

Joel Fernandes (Google) (13):
sched/fair: Snapshot the min_vruntime of CPUs on force idle
arch/x86: Add a new TIF flag for untrusted tasks
kernel/entry: Add support for core-wide protection of kernel-mode
entry/idle: Enter and exit kernel protection during idle entry and
exit
sched: Split the cookie and setup per-task cookie on fork
sched: Add a per-thread core scheduling interface
sched: Add a second-level tag for nested CGroup usecase
sched: Release references to the per-task cookie on exit
sched: Handle task addition to CGroup
sched/debug: Add CGroup node for printing group cookie if SCHED_DEBUG
kselftest: Add tests for core-sched interface
sched: Move core-scheduler interfacing code to a new file
Documentation: Add core scheduling documentation

Peter Zijlstra (10):
sched: Wrap rq::lock access
sched: Introduce sched_class::pick_task()
sched: Core-wide rq->lock
sched/fair: Add a few assertions
sched: Basic tracking of matching tasks
sched: Add core wide task selection and scheduling.
sched: Trivial forced-newidle balancer
irq_work: Cleanup
sched: cgroup tagging interface for core scheduling
sched: Debug bits...

Vineeth Pillai (2):
sched/fair: Fix forced idle sibling starvation corner case
entry/kvm: Protect the kernel when entering from guest

.../admin-guide/hw-vuln/core-scheduling.rst   |  312 +++++
Documentation/admin-guide/hw-vuln/index.rst   |    1 +
.../admin-guide/kernel-parameters.txt         |    7 +
arch/x86/include/asm/thread_info.h            |    2 +
arch/x86/kvm/x86.c                            |    3 +
drivers/gpu/drm/i915/i915_request.c           |    4 +-
include/linux/entry-common.h                  |   20 +-
include/linux/entry-kvm.h                     |   12 +
include/linux/irq_work.h                      |   33 +-
include/linux/irqflags.h                      |    4 +-
include/linux/sched.h                         |   27 +-
include/uapi/linux/prctl.h                    |    3 +
kernel/Kconfig.preempt                        |    6 +
kernel/bpf/stackmap.c                         |    2 +-
kernel/entry/common.c                         |   25 +-
kernel/entry/kvm.c                            |   13 +
kernel/fork.c                                 |    1 +
kernel/irq_work.c                             |   18 +-
kernel/printk/printk.c                        |    6 +-
kernel/rcu/tree.c                             |    3 +-
kernel/sched/Makefile                         |    1 +
kernel/sched/core.c                           | 1135 ++++++++++++++++-
kernel/sched/coretag.c                        |  468 +++++++
kernel/sched/cpuacct.c                        |   12 +-
kernel/sched/deadline.c                       |   34 +-
kernel/sched/debug.c                          |    8 +-
kernel/sched/fair.c                           |  272 ++--
kernel/sched/idle.c                           |   24 +-
kernel/sched/pelt.h                           |    2 +-
kernel/sched/rt.c                             |   22 +-
kernel/sched/sched.h                          |  302 ++++-
kernel/sched/stop_task.c                      |   13 +-
kernel/sched/topology.c                       |    4 +-
kernel/sys.c                                  |    3 +
kernel/time/tick-sched.c                      |    6 +-
kernel/trace/bpf_trace.c                      |    2 +-
tools/include/uapi/linux/prctl.h              |    3 +
tools/testing/selftests/sched/.gitignore      |    1 +
tools/testing/selftests/sched/Makefile        |   14 +
tools/testing/selftests/sched/config          |    1 +
.../testing/selftests/sched/test_coresched.c  |  840 ++++++++++++
41 files changed, 3437 insertions(+), 232 deletions(-)
create mode 100644 Documentation/admin-guide/hw-vuln/core-scheduling.rst
create mode 100644 kernel/sched/coretag.c
create mode 100644 tools/testing/selftests/sched/.gitignore
create mode 100644 tools/testing/selftests/sched/Makefile
create mode 100644 tools/testing/selftests/sched/config
create mode 100644 tools/testing/selftests/sched/test_coresched.c

--
2.29.0.rc1.297.gfa9743e501-goog

