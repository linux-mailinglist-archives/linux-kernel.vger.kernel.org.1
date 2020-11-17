Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAAA2B7219
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgKQXUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgKQXUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:20:17 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856F9C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:15 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id z17so86396qvy.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJ9qgG3kneEPyWUb62Ix+0t9vh0ip/s+iFvW6sXwNjg=;
        b=FX9/l1g1qP9vRJqXuNbFKljOVaffUAbAvti5Fa2e1b8bI6Dmim8oGJyEFP4H3rw5S/
         lNOoxSQiFVtBmlQTSNTfcB7rbJii4J8IPR97YaQr7rWVN/2vj9sPi1nGn6higQTSbepC
         UPCJYYw0cOpeChsov/ms9Pe5qMxKjJPTynkd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJ9qgG3kneEPyWUb62Ix+0t9vh0ip/s+iFvW6sXwNjg=;
        b=pMlYEIkrgiqrwGWEKZEMb+4psBxJzyjRRDCDcHV4nrvb1XKT3NaJZn/8o6kqJRSwmr
         JfAtxPghpNQcRGwe+/Vrk7onAmOUB44ZM7bIQ3oHOK9LDcvOEhP3RCvtHC3cIrBmcoG1
         RpVF/PY2ph8TWy/sRgx2IzwRI/z5IoEXuItwtXLNvxp8fjziGSZgk3usGin3aEVwKCAN
         zOkO8eF41uJC1PJFMic0GBwZu3r4suTiUfq0UwG21KTe7zdYZG6K3Z6x8cgWk33cdmuE
         W+iLSi/RRbnEdi3Cv3Ndiz7SGlUC/KLDD5YM1CbE3Le+inrFoGXypsdJZJAsYr5MsYXt
         fBtw==
X-Gm-Message-State: AOAM532Cip07BN28Q/nY3MAHZeuSxehvEdmfzAAY0WanFBltdvX/gZwc
        ON1b6s7fWKkAwKa3E/mx1bMWfg==
X-Google-Smtp-Source: ABdhPJyIVsl9+RrZJJZdAy3vQ+XAITvIkHMrHv3Sezt/m+eEqtlYs5uIrVqIU5rjpod04Qi0QomQLA==
X-Received: by 2002:a0c:b181:: with SMTP id v1mr2277970qvd.36.1605655214618;
        Tue, 17 Nov 2020 15:20:14 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:20:13 -0800 (PST)
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
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH -tip 00/32] Core scheduling (v9)
Date:   Tue, 17 Nov 2020 18:19:30 -0500
Message-Id: <20201117232003.3580179-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Core-Scheduling
===============
Enclosed is series v9 of core scheduling.
v9 is rebased on tip/master (fe4adf6f92c4 ("Merge branch 'irq/core'"))..
I hope that this version is acceptable to be merged (pending any new review
comments that arise) as the main issues in the past are all resolved:
 1. Vruntime comparison.
 2. Documentation updates.
 3. CGroup and per-task interface developed by Google and Oracle.
 4. Hotplug fixes.
Almost all patches also have Reviewed-by or Acked-by tag. See below for full
list of changes in v9.

Introduction of feature
=======================
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

Both a CGroup and Per-task interface via prctl(2) are provided for configuring
core sharing. More details are provided in documentation patch.  Kselftests are
provided to verify the correctness/rules of the interface.

Testing
=======
ChromeOS testing shows 300% improvement in keypress latency on a Google
docs key press with Google hangout test (the maximum latency drops from 150ms
to 50ms for keypresses).

Julien: TPCC tests showed improvements with core-scheduling as below. With kernel
protection enabled, it does not show any regression. Possibly ASI will improve
the performance for those who choose kernel protection (can be toggled through
sched_core_protect_kernel sysctl).
				average		stdev		diff
baseline (SMT on)		1197.272	44.78312824	
core sched (   kernel protect)	412.9895	45.42734343	-65.51%
core sched (no kernel protect)	686.6515	71.77756931	-42.65%
nosmt				408.667		39.39042872	-65.87%
(Note these results are from v8).

Vineeth tested sysbench and does not see any regressions.
Hong and Aubrey tested v9 and see results similar to v8. There is a known issue
with uperf that does regress. This appears to be because of ksoftirq heavily
contending with other tasks on the core. The consensus is this can be improved
in the future.

Changes in v9
=============
- Note that the vruntime snapshot change is written in 2 patches to show the
  progression of the idea and prevent merge conflicts:
    sched/fair: Snapshot the min_vruntime of CPUs on force idle
    sched: Improve snapshotting of min_vruntime for CGroups
  Same with the RT priority inversion change:
    sched: Fix priority inversion of cookied task with sibling
    sched: Improve snapshotting of min_vruntime for CGroups
- Disable coresched on certain AMD HW.

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

Future work
===========
- Load balancing/Migration fixes for core scheduling.
  With v6, Load balancing is partially coresched aware, but has some
  issues w.r.t process/taskgroup weights:
  https://lwn.net/ml/linux-kernel/20200225034438.GA617271@z...

Aubrey Li (1):
sched: migration changes for core scheduling

Joel Fernandes (Google) (16):
sched/fair: Snapshot the min_vruntime of CPUs on force idle
sched: Enqueue task into core queue only after vruntime is updated
sched: Simplify the core pick loop for optimized case
sched: Improve snapshotting of min_vruntime for CGroups
arch/x86: Add a new TIF flag for untrusted tasks
kernel/entry: Add support for core-wide protection of kernel-mode
entry/idle: Enter and exit kernel protection during idle entry and
exit
sched: Split the cookie and setup per-task cookie on fork
sched: Add a per-thread core scheduling interface
sched: Release references to the per-task cookie on exit
sched/debug: Add CGroup node for printing group cookie if SCHED_DEBUG
kselftest: Add tests for core-sched interface
sched: Move core-scheduler interfacing code to a new file
Documentation: Add core scheduling documentation
sched: Add a coresched command line option
sched: Debug bits...

Josh Don (2):
sched: Refactor core cookie into struct
sched: Add a second-level tag for nested CGroup usecase

Peter Zijlstra (11):
sched: Wrap rq::lock access
sched: Introduce sched_class::pick_task()
sched/fair: Fix pick_task_fair crashes due to empty rbtree
sched: Core-wide rq->lock
sched/fair: Add a few assertions
sched: Basic tracking of matching tasks
sched: Add core wide task selection and scheduling.
sched: Fix priority inversion of cookied task with sibling
sched: Trivial forced-newidle balancer
irq_work: Cleanup
sched: CGroup tagging interface for core scheduling

Vineeth Pillai (2):
sched/fair: Fix forced idle sibling starvation corner case
entry/kvm: Protect the kernel when entering from guest

.../admin-guide/hw-vuln/core-scheduling.rst   |  330 +++++
Documentation/admin-guide/hw-vuln/index.rst   |    1 +
.../admin-guide/kernel-parameters.txt         |   25 +
arch/x86/include/asm/thread_info.h            |    2 +
arch/x86/kernel/cpu/bugs.c                    |   19 +
arch/x86/kvm/x86.c                            |    2 +
drivers/gpu/drm/i915/i915_request.c           |    4 +-
include/linux/cpu.h                           |    1 +
include/linux/entry-common.h                  |   30 +-
include/linux/entry-kvm.h                     |   12 +
include/linux/irq_work.h                      |   33 +-
include/linux/irqflags.h                      |    4 +-
include/linux/sched.h                         |   28 +-
include/linux/sched/smt.h                     |    4 +
include/uapi/linux/prctl.h                    |    3 +
kernel/Kconfig.preempt                        |    5 +
kernel/bpf/stackmap.c                         |    2 +-
kernel/cpu.c                                  |   43 +
kernel/entry/common.c                         |   28 +-
kernel/entry/kvm.c                            |   33 +
kernel/fork.c                                 |    1 +
kernel/irq_work.c                             |   18 +-
kernel/printk/printk.c                        |    6 +-
kernel/rcu/tree.c                             |    3 +-
kernel/sched/Makefile                         |    1 +
kernel/sched/core.c                           | 1278 +++++++++++++++--
kernel/sched/coretag.c                        |  819 +++++++++++
kernel/sched/cpuacct.c                        |   12 +-
kernel/sched/deadline.c                       |   38 +-
kernel/sched/debug.c                          |   12 +-
kernel/sched/fair.c                           |  313 +++-
kernel/sched/idle.c                           |   24 +-
kernel/sched/pelt.h                           |    2 +-
kernel/sched/rt.c                             |   31 +-
kernel/sched/sched.h                          |  315 +++-
kernel/sched/stop_task.c                      |   14 +-
kernel/sched/topology.c                       |    4 +-
kernel/sys.c                                  |    3 +
kernel/time/tick-sched.c                      |    6 +-
kernel/trace/bpf_trace.c                      |    2 +-
tools/include/uapi/linux/prctl.h              |    3 +
tools/testing/selftests/sched/.gitignore      |    1 +
tools/testing/selftests/sched/Makefile        |   14 +
tools/testing/selftests/sched/config          |    1 +
.../testing/selftests/sched/test_coresched.c  |  818 +++++++++++
45 files changed, 4033 insertions(+), 315 deletions(-)
create mode 100644 Documentation/admin-guide/hw-vuln/core-scheduling.rst
create mode 100644 kernel/sched/coretag.c
create mode 100644 tools/testing/selftests/sched/.gitignore
create mode 100644 tools/testing/selftests/sched/Makefile
create mode 100644 tools/testing/selftests/sched/config
create mode 100644 tools/testing/selftests/sched/test_coresched.c

--
2.29.2.299.gdc1121823c-goog

