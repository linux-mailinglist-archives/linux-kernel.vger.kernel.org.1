Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AB32A9EBC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 21:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgKFUzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 15:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbgKFUzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 15:55:10 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8A2C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 12:55:08 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id l2so2402976qkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 12:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5kw0LCQ9rnLogSkHq/xBST3mEaaTtqaoIO9b0dmuA60=;
        b=ojeoa0gYDlYWyNab8zodtuSlldeEpccWDtevKg6OMubHn0h/YPz6QcdvAFkbsW5SD9
         Z4SaCpd6tI+gMOmpOqZgG9hXiuaHuacQS4i/Bc/5G2nfd3TSduBQEF0lPzbeSsBQJCfA
         jInsFe9CvvD/ceosKMjNqia5N5dNORji3MzTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5kw0LCQ9rnLogSkHq/xBST3mEaaTtqaoIO9b0dmuA60=;
        b=goxihiRwM4fpztoOeMSlajn/4cQ3W7iNqW/FNhZlPMTiDSYL3bTEcJxi+lidPy8opN
         iMS3uKDE0BdC+KQLe8hUF77ZM204WNHfmAARjGLw2YHgWGPMWdOhaXL/DAOLbQoi3erT
         mxfwIiY5L4B6ub4NCnMpGBhc6nbCYKU5gVtY8SHELdj90MYXfRhCAnVAcIcdjzaoS1O/
         KfGF/oedbzruWsss68u1C0maMdSJrAtQbmPzLRBJcqaicthlMp6URRg9lB+BlISlIBkh
         HnJUFzOxHNvRGkfp2adaY5UEeo35172ZRlP5IX47A/5faWUguTAbzMt+K4atE7hDyE9m
         BNSQ==
X-Gm-Message-State: AOAM530A5DmjCRsH9SK0+RCzs+7rxP9paMyPpWSFr1g2mgi9aqGRsqos
        ZtZNVb55Lk9ou7YcKZ5i4Pe1mA==
X-Google-Smtp-Source: ABdhPJz6p5v/TE828f4V0ZJDFoJSqsP5twwqgLQNwQCiqwaJwKD66YY8SFIY+Up8KuygBS0zkIBdaA==
X-Received: by 2002:a05:620a:7ea:: with SMTP id k10mr1856950qkk.292.1604696107421;
        Fri, 06 Nov 2020 12:55:07 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d82sm1359520qkc.14.2020.11.06.12.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 12:55:06 -0800 (PST)
Date:   Fri, 6 Nov 2020 15:55:06 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hongyu.ning@linux.intel.com
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
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
Subject: [RFT for v9] (Was Re: [PATCH v8 -tip 00/26] Core scheduling)
Message-ID: <20201106205506.GA3109656@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I am getting ready to send the next v9 series based on tip/master
branch. Could you please give the below tree a try and report any results in
your testing?
git tree:
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (branch coresched)
git log:
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=coresched

The major changes in this series are the improvements:
(1)
"sched: Make snapshotting of min_vruntime more CGroup-friendly"
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=coresched-v9-for-test&id=9a20a6652b3c50fd51faa829f7947004239a04eb

(2)
"sched: Simplify the core pick loop for optimized case"
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=coresched-v9-for-test&id=0370117b4fd418cdaaa6b1489bfc14f305691152

And a bug fix:
(1)
"sched: Enqueue task into core queue only after vruntime is updated"
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=coresched-v9-for-test&id=401dad5536e7e05d1299d0864e6fc5072029f492

There are also 2 more bug fixes that I squashed-in related to kernel
protection and a crash seen on the tip/master branch.

Hoping to send the series next week out to the list.

Have a great weekend, and Thanks!

 - Joel


On Mon, Oct 19, 2020 at 09:43:10PM -0400, Joel Fernandes (Google) wrote:
> Eighth iteration of the Core-Scheduling feature.
> 
> Core scheduling is a feature that allows only trusted tasks to run
> concurrently on cpus sharing compute resources (eg: hyperthreads on a
> core). The goal is to mitigate the core-level side-channel attacks
> without requiring to disable SMT (which has a significant impact on
> performance in some situations). Core scheduling (as of v7) mitigates
> user-space to user-space attacks and user to kernel attack when one of
> the siblings enters the kernel via interrupts or system call.
> 
> By default, the feature doesn't change any of the current scheduler
> behavior. The user decides which tasks can run simultaneously on the
> same core (for now by having them in the same tagged cgroup). When a tag
> is enabled in a cgroup and a task from that cgroup is running on a
> hardware thread, the scheduler ensures that only idle or trusted tasks
> run on the other sibling(s). Besides security concerns, this feature can
> also be beneficial for RT and performance applications where we want to
> control how tasks make use of SMT dynamically.
> 
> This iteration focuses on the the following stuff:
> - Redesigned API.
> - Rework of Kernel Protection feature based on Thomas's entry work.
> - Rework of hotplug fixes.
> - Address review comments in v7
> 
> Joel: Both a CGroup and Per-task interface via prctl(2) are provided for
> configuring core sharing. More details are provided in documentation patch.
> Kselftests are provided to verify the correctness/rules of the interface.
> 
> Julien: TPCC tests showed improvements with core-scheduling. With kernel
> protection enabled, it does not show any regression. Possibly ASI will improve
> the performance for those who choose kernel protection (can be toggled through
> sched_core_protect_kernel sysctl). Results:
> v8				average		stdev		diff
> baseline (SMT on)		1197.272	44.78312824	
> core sched (   kernel protect)	412.9895	45.42734343	-65.51%
> core sched (no kernel protect)	686.6515	71.77756931	-42.65%
> nosmt				408.667		39.39042872	-65.87%
> 
> v8 is rebased on tip/master.
> 
> Future work
> ===========
> - Load balancing/Migration fixes for core scheduling.
>   With v6, Load balancing is partially coresched aware, but has some
>   issues w.r.t process/taskgroup weights:
>   https://lwn.net/ml/linux-kernel/20200225034438.GA617271@z...
> - Core scheduling test framework: kselftests, torture tests etc
> 
> Changes in v8
> =============
> - New interface/API implementation
>   - Joel
> - Revised kernel protection patch
>   - Joel
> - Revised Hotplug fixes
>   - Joel
> - Minor bug fixes and address review comments
>   - Vineeth
> 
> Changes in v7
> =============
> - Kernel protection from untrusted usermode tasks
>   - Joel, Vineeth
> - Fix for hotplug crashes and hangs
>   - Joel, Vineeth
> 
> Changes in v6
> =============
> - Documentation
>   - Joel
> - Pause siblings on entering nmi/irq/softirq
>   - Joel, Vineeth
> - Fix for RCU crash
>   - Joel
> - Fix for a crash in pick_next_task
>   - Yu Chen, Vineeth
> - Minor re-write of core-wide vruntime comparison
>   - Aaron Lu
> - Cleanup: Address Review comments
> - Cleanup: Remove hotplug support (for now)
> - Build fixes: 32 bit, SMT=n, AUTOGROUP=n etc
>   - Joel, Vineeth
> 
> Changes in v5
> =============
> - Fixes for cgroup/process tagging during corner cases like cgroup
>   destroy, task moving across cgroups etc
>   - Tim Chen
> - Coresched aware task migrations
>   - Aubrey Li
> - Other minor stability fixes.
> 
> Changes in v4
> =============
> - Implement a core wide min_vruntime for vruntime comparison of tasks
>   across cpus in a core.
>   - Aaron Lu
> - Fixes a typo bug in setting the forced_idle cpu.
>   - Aaron Lu
> 
> Changes in v3
> =============
> - Fixes the issue of sibling picking up an incompatible task
>   - Aaron Lu
>   - Vineeth Pillai
>   - Julien Desfossez
> - Fixes the issue of starving threads due to forced idle
>   - Peter Zijlstra
> - Fixes the refcounting issue when deleting a cgroup with tag
>   - Julien Desfossez
> - Fixes a crash during cpu offline/online with coresched enabled
>   - Vineeth Pillai
> - Fixes a comparison logic issue in sched_core_find
>   - Aaron Lu
> 
> Changes in v2
> =============
> - Fixes for couple of NULL pointer dereference crashes
>   - Subhra Mazumdar
>   - Tim Chen
> - Improves priority comparison logic for process in different cpus
>   - Peter Zijlstra
>   - Aaron Lu
> - Fixes a hard lockup in rq locking
>   - Vineeth Pillai
>   - Julien Desfossez
> - Fixes a performance issue seen on IO heavy workloads
>   - Vineeth Pillai
>   - Julien Desfossez
> - Fix for 32bit build
>   - Aubrey Li
> 
> Aubrey Li (1):
> sched: migration changes for core scheduling
> 
> Joel Fernandes (Google) (13):
> sched/fair: Snapshot the min_vruntime of CPUs on force idle
> arch/x86: Add a new TIF flag for untrusted tasks
> kernel/entry: Add support for core-wide protection of kernel-mode
> entry/idle: Enter and exit kernel protection during idle entry and
> exit
> sched: Split the cookie and setup per-task cookie on fork
> sched: Add a per-thread core scheduling interface
> sched: Add a second-level tag for nested CGroup usecase
> sched: Release references to the per-task cookie on exit
> sched: Handle task addition to CGroup
> sched/debug: Add CGroup node for printing group cookie if SCHED_DEBUG
> kselftest: Add tests for core-sched interface
> sched: Move core-scheduler interfacing code to a new file
> Documentation: Add core scheduling documentation
> 
> Peter Zijlstra (10):
> sched: Wrap rq::lock access
> sched: Introduce sched_class::pick_task()
> sched: Core-wide rq->lock
> sched/fair: Add a few assertions
> sched: Basic tracking of matching tasks
> sched: Add core wide task selection and scheduling.
> sched: Trivial forced-newidle balancer
> irq_work: Cleanup
> sched: cgroup tagging interface for core scheduling
> sched: Debug bits...
> 
> Vineeth Pillai (2):
> sched/fair: Fix forced idle sibling starvation corner case
> entry/kvm: Protect the kernel when entering from guest
> 
> .../admin-guide/hw-vuln/core-scheduling.rst   |  312 +++++
> Documentation/admin-guide/hw-vuln/index.rst   |    1 +
> .../admin-guide/kernel-parameters.txt         |    7 +
> arch/x86/include/asm/thread_info.h            |    2 +
> arch/x86/kvm/x86.c                            |    3 +
> drivers/gpu/drm/i915/i915_request.c           |    4 +-
> include/linux/entry-common.h                  |   20 +-
> include/linux/entry-kvm.h                     |   12 +
> include/linux/irq_work.h                      |   33 +-
> include/linux/irqflags.h                      |    4 +-
> include/linux/sched.h                         |   27 +-
> include/uapi/linux/prctl.h                    |    3 +
> kernel/Kconfig.preempt                        |    6 +
> kernel/bpf/stackmap.c                         |    2 +-
> kernel/entry/common.c                         |   25 +-
> kernel/entry/kvm.c                            |   13 +
> kernel/fork.c                                 |    1 +
> kernel/irq_work.c                             |   18 +-
> kernel/printk/printk.c                        |    6 +-
> kernel/rcu/tree.c                             |    3 +-
> kernel/sched/Makefile                         |    1 +
> kernel/sched/core.c                           | 1135 ++++++++++++++++-
> kernel/sched/coretag.c                        |  468 +++++++
> kernel/sched/cpuacct.c                        |   12 +-
> kernel/sched/deadline.c                       |   34 +-
> kernel/sched/debug.c                          |    8 +-
> kernel/sched/fair.c                           |  272 ++--
> kernel/sched/idle.c                           |   24 +-
> kernel/sched/pelt.h                           |    2 +-
> kernel/sched/rt.c                             |   22 +-
> kernel/sched/sched.h                          |  302 ++++-
> kernel/sched/stop_task.c                      |   13 +-
> kernel/sched/topology.c                       |    4 +-
> kernel/sys.c                                  |    3 +
> kernel/time/tick-sched.c                      |    6 +-
> kernel/trace/bpf_trace.c                      |    2 +-
> tools/include/uapi/linux/prctl.h              |    3 +
> tools/testing/selftests/sched/.gitignore      |    1 +
> tools/testing/selftests/sched/Makefile        |   14 +
> tools/testing/selftests/sched/config          |    1 +
> .../testing/selftests/sched/test_coresched.c  |  840 ++++++++++++
> 41 files changed, 3437 insertions(+), 232 deletions(-)
> create mode 100644 Documentation/admin-guide/hw-vuln/core-scheduling.rst
> create mode 100644 kernel/sched/coretag.c
> create mode 100644 tools/testing/selftests/sched/.gitignore
> create mode 100644 tools/testing/selftests/sched/Makefile
> create mode 100644 tools/testing/selftests/sched/config
> create mode 100644 tools/testing/selftests/sched/test_coresched.c
> 
> --
> 2.29.0.rc1.297.gfa9743e501-goog
> 
