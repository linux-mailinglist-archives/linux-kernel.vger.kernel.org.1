Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8963828BA8D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbgJLOO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbgJLOOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:14:55 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B4BC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 07:14:55 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g4so17149362edk.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 07:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=E87q4v5LVlUJLK+86nbpSCAUPrE/juoIz7BdG94Kus8=;
        b=Zjrs0Hz92Vkp2F5IR7IwiyNp2s68sLdqUN1mpmEZrQNmnN2NrHK7RPCE6iZiLuudIk
         2OvhC6Nc0Zki2XQXlQ7VW2uddnmnPJ2/hPr3LxavV+pTq3UdaFPw5OajbbiX5nvLGZcQ
         Jo1ISQcNbeykvgQ6qlMbCKrx1+LClgTkOSo1+P+O9Kscvq2f6IAOCxmuqsV3XqO3iSHz
         88mbxRzjvTYAyyPADoTIbo0M0pn09nOi88fAjdvouYuj0fTB78ghph2rp13mILWxVO7z
         3gEBkUKpXbfo/GJcN5kjNvkI1dm4Ko9X8c8ZwBaEcjD9F3V1louZ0uhNJpJTdTN3/6km
         hitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=E87q4v5LVlUJLK+86nbpSCAUPrE/juoIz7BdG94Kus8=;
        b=IWBuJs8mDagd12zk6aTAZ6GCCcz6GFgfNMEBSCtsY36xztSLEf3Uy9M8b9SmM4RwjG
         /eShFg75bj9d0kg0fUldieUio0938DfOU79MBHJ9gv3VxhNj/EX3R5yuAIOHOfEmcK5/
         UF4rPtKig3SD9YAcROHBlBU7IIjJsrLPi2IEskU+oG0OK7ZiFiTQmAeRjkxHLkR9CIE1
         n7PbuJKNpq1S384g2eKutkcLD7YHHMqYl15NH8U/5FduRxrnihtyAheEjvPL9LU6kJAy
         rBrM+pI1hMaP9kTx7/1/w40ge/Be3/lQttyq9AAgaOv6+6LezeAr6XBcyLNRJ4nrDLaN
         yVmg==
X-Gm-Message-State: AOAM531ruvCOKVHxWcNQwgz7B3jKFkIfvLAs45R1aATYpHimv/tbwSxL
        5s/OTkdRPi8I0r8dQsegk9Y=
X-Google-Smtp-Source: ABdhPJzHlbKWiafPIhdccKKgF3O56PbtnJwJ/gYZXgtGFss3pzBCOjnxnir2W22zPvwMs8CU2Fm8qQ==
X-Received: by 2002:a50:9e87:: with SMTP id a7mr14586540edf.297.1602512094017;
        Mon, 12 Oct 2020 07:14:54 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id u26sm10824852edt.39.2020.10.12.07.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 07:14:53 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 12 Oct 2020 16:14:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] RCU changes for v5.10
Message-ID: <20201012141451.GA3425471@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core/rcu git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-2020-10-12

   # HEAD: c6de896fa0a4546c799c86513d99bd011b4a6177 Merge branch 'rcu/fix-rt' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into core/rcu

RCU changes for v5.10:

 - Debugging for smp_call_function()
 - RT raw/non-raw lock ordering fixes
 - Strict grace periods for KASAN
 - New smp_call_function() torture test
 - Torture-test updates
 - Documentation updates
 - Miscellaneous fixes

 Thanks,

	Ingo

------------------>
Alexander A. Klimov (1):
      rcutorture: Replace HTTP links with HTTPS ones

Colin Ian King (1):
      refperf: Avoid null pointer dereference when buf fails to allocate

Joel Fernandes (Google) (6):
      rcu/trace: Print negative GP numbers correctly
      rcu/trace: Use gp_seq_req in acceleration's rcu_grace_period tracepoint
      rcu: Clarify comments about FQS loop reporting quiescent states
      rcu: Make FQS more aggressive in complaining about offline CPUs
      rcutorture: Output number of elapsed grace periods
      rcu/segcblist: Prevent useless GP start if no CBs to accelerate

Madhuparna Bhowmik (2):
      rculist: Introduce list/hlist_for_each_entry_srcu() macros
      kvm: mmu: page_track: Fix RCU list API usage

Neeraj Upadhyay (2):
      rcu/tree: Force quiescent state on callback overload
      rcu/tree: Remove CONFIG_PREMPT_RCU check in force_qs_rnp()

Paul E. McKenney (56):
      lib: Add backtrace_idle parameter to force backtrace of idle CPUs
      rcu: Remove KCSAN stubs
      rcu: Remove KCSAN stubs from update.c
      srcu: Remove KCSAN stubs
      rcu: Initialize at declaration time in rcu_exp_handler()
      nocb: Clarify RCU nocb CPU error message
      nocb: Remove show_rcu_nocb_state() false positive printout
      rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_divisor
      rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_resched_ns
      rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_kick_kthreads
      rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_cpu_stall_ftrace_dump
      rcu: Move rcu_cpu_started per-CPU variable to rcu_data
      rcu/nocb: Add a warning for non-GP kthread running GP code
      rcu: Remove unused __rcu_is_watching() function
      scftorture: Add smp_call_function() torture test
      torture: Declare parse-console.sh independence from rcutorture
      torture: Add scftorture to the rcutorture scripting
      scftorture: Implement weighted primitive selection
      tick-sched: Clarify "NOHZ: local_softirq_pending" warning
      scftorture: Summarize per-thread statistics
      scftorture: Add smp_call_function_single() memory-ordering checks
      scftorture: Add smp_call_function_many() memory-ordering checks
      scftorture: Add smp_call_function() memory-ordering checks
      scftorture: Consolidate scftorture_invoke_one() check and kfree()
      scftorture: Consolidate scftorture_invoke_one() scf_check initialization
      scftorture: Flag errors in torture-compatible manner
      scftorture: Prevent compiler from reducing race probabilities
      scftorture: Check unexpected "switch" statement value
      scftorture: Block scftorture_invoker() kthreads for offline CPUs
      scftorture: Adapt memory-ordering test to UP operation
      scftorture: Add cond_resched() to test loop
      rcuperf: Change rcuperf to rcuscale
      rcu: Add Kconfig option for strict RCU grace periods
      rcu: Reduce leaf fanout for strict RCU grace periods
      rcu: Restrict default jiffies_till_first_fqs for strict RCU GPs
      rcu: Force DEFAULT_RCU_BLIMIT to 1000 for strict RCU GPs
      rcu: Always set .need_qs from __rcu_read_lock() for strict GPs
      rcu: Do full report for .need_qs for strict GPs
      rcu: Attempt QS when CPU discovers GP for strict GPs
      rcu: IPI all CPUs at GP start for strict GPs
      rcu: IPI all CPUs at GP end for strict GPs
      rcu: Provide optional RCU-reader exit delay for strict GPs
      rcu: Execute RCU reader shortly after rcu_core for strict GPs
      rcu: Report QS for outermost PREEMPT=n rcu_read_unlock() for strict GPs
      rcu: Remove unused "cpu" parameter from rcu_report_qs_rdp()
      rcutorture: Remove KCSAN stubs
      torture: Update initrd documentation
      rcutorture: Add CONFIG_PROVE_RCU_LIST to TREE05
      torture: Add kvm.sh --help and update help message
      rcutorture: Properly set rcu_fwds for OOM handling
      rcutorture: Properly synchronize with OOM notifier
      rcutorture: Hoist OOM registry up one level
      rcutorture: Allow pointer leaks to test diagnostic code
      torture: Add gdb support
      smp: Add source and destination CPUs to __call_single_data
      kernel/smp: Provide CSD lock timeout diagnostics

Paul Gortmaker (1):
      torture: document --allcpus argument added to the kvm.sh script

Randy Dunlap (2):
      doc: Drop doubled words from RCU Data-Structures.rst
      doc: Drop doubled words from RCU requirements documentation

Thomas Gleixner (13):
      lib/debug: Remove pointless ARCH_NO_PREEMPT dependencies
      preempt: Make preempt count unconditional
      preempt: Cleanup PREEMPT_COUNT leftovers
      lockdep: Cleanup PREEMPT_COUNT leftovers
      mm/pagemap: Cleanup PREEMPT_COUNT leftovers
      locking/bitspinlock: Cleanup PREEMPT_COUNT leftovers
      uaccess: Cleanup PREEMPT_COUNT leftovers
      sched: Cleanup PREEMPT_COUNT leftovers
      ARM: Cleanup PREEMPT_COUNT leftovers
      xtensa: Cleanup PREEMPT_COUNT leftovers
      drm/i915: Cleanup PREEMPT_COUNT leftovers
      rcutorture: Cleanup PREEMPT_COUNT leftovers
      preempt: Remove PREEMPT_COUNT from Kconfig

Tobias Klauser (2):
      docs: Fix typo in synchronize_rcu() function name
      rcu: Fix kerneldoc comments in rcupdate.h

Uladzislau Rezki (Sony) (1):
      rcu/tree: Allocate a page when caller is preemptible

Wei Yongjun (3):
      scftorture: Make symbol 'scf_torture_rand' static
      locktorture: Make function torture_percpu_rwsem_init() static
      smp: Make symbol 'csd_bug_count' static

Zqiang (1):
      rcu: Shrink each possible cpu krcp

kernel test robot (1):
      kvfree_rcu(): Fix ifnullfree.cocci warnings


 .../RCU/Design/Data-Structures/Data-Structures.rst |   2 +-
 .../RCU/Design/Requirements/Requirements.rst       |   4 +-
 Documentation/RCU/whatisRCU.rst                    |   2 +-
 Documentation/admin-guide/kernel-parameters.txt    | 153 +++++-
 MAINTAINERS                                        |   3 +-
 arch/arm/include/asm/assembler.h                   |  11 -
 arch/arm/kernel/iwmmxt.S                           |   2 -
 arch/arm/mach-ep93xx/crunch-bits.S                 |   2 -
 arch/x86/kvm/mmu/page_track.c                      |   6 +-
 arch/xtensa/kernel/entry.S                         |   2 +-
 drivers/gpu/drm/i915/Kconfig.debug                 |   1 -
 drivers/gpu/drm/i915/i915_utils.h                  |   3 +-
 include/linux/bit_spinlock.h                       |   4 +-
 include/linux/lockdep.h                            |   6 +-
 include/linux/pagemap.h                            |   4 +-
 include/linux/preempt.h                            |  37 +-
 include/linux/rculist.h                            |  48 ++
 include/linux/rcupdate.h                           |  19 +-
 include/linux/rcutiny.h                            |   1 -
 include/linux/rcutree.h                            |   1 -
 include/linux/smp.h                                |   3 +
 include/linux/smp_types.h                          |   3 +
 include/linux/uaccess.h                            |   6 +-
 include/trace/events/rcu.h                         |  54 +-
 kernel/Kconfig.preempt                             |   4 -
 kernel/Makefile                                    |   2 +
 kernel/entry/common.c                              |   2 +-
 kernel/locking/locktorture.c                       |   2 +-
 kernel/rcu/Kconfig                                 |   8 +-
 kernel/rcu/Kconfig.debug                           |  17 +-
 kernel/rcu/Makefile                                |   2 +-
 kernel/rcu/rcu_segcblist.c                         |  10 +-
 kernel/rcu/{rcuperf.c => rcuscale.c}               | 330 ++++++------
 kernel/rcu/rcutorture.c                            |  61 ++-
 kernel/rcu/refscale.c                              |   8 +-
 kernel/rcu/srcutree.c                              |  13 -
 kernel/rcu/tree.c                                  | 244 +++++----
 kernel/rcu/tree.h                                  |   2 +
 kernel/rcu/tree_exp.h                              |   6 +-
 kernel/rcu/tree_plugin.h                           |  40 +-
 kernel/rcu/tree_stall.h                            |   8 +-
 kernel/rcu/update.c                                |  13 -
 kernel/scftorture.c                                | 575 +++++++++++++++++++++
 kernel/sched/core.c                                |   6 +-
 kernel/smp.c                                       | 134 +++++
 kernel/time/tick-sched.c                           |   2 +-
 lib/Kconfig.debug                                  |  24 +-
 lib/nmi_backtrace.c                                |   6 +-
 ...rf-ftrace.sh => kvm-recheck-rcuscale-ftrace.sh} |   6 +-
 ...-recheck-rcuperf.sh => kvm-recheck-rcuscale.sh} |  14 +-
 .../selftests/rcutorture/bin/kvm-recheck-scf.sh    |  38 ++
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |  33 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  36 +-
 .../selftests/rcutorture/bin/parse-console.sh      |  11 +-
 .../selftests/rcutorture/configs/rcu/SRCU-t        |   1 -
 .../selftests/rcutorture/configs/rcu/SRCU-u        |   1 -
 .../selftests/rcutorture/configs/rcu/TINY01        |   1 -
 .../selftests/rcutorture/configs/rcu/TREE05        |   1 +
 .../selftests/rcutorture/configs/rcuperf/CFcommon  |   2 -
 .../configs/{rcuperf => rcuscale}/CFLIST           |   0
 .../selftests/rcutorture/configs/rcuscale/CFcommon |   2 +
 .../rcutorture/configs/{rcuperf => rcuscale}/TINY  |   0
 .../rcutorture/configs/{rcuperf => rcuscale}/TREE  |   0
 .../configs/{rcuperf => rcuscale}/TREE54           |   0
 .../configs/{rcuperf => rcuscale}/ver_functions.sh |   4 +-
 .../selftests/rcutorture/configs/scf/CFLIST        |   2 +
 .../selftests/rcutorture/configs/scf/CFcommon      |   2 +
 .../selftests/rcutorture/configs/scf/NOPREEMPT     |   9 +
 .../rcutorture/configs/scf/NOPREEMPT.boot          |   1 +
 .../selftests/rcutorture/configs/scf/PREEMPT       |   9 +
 .../rcutorture/configs/scf/ver_functions.sh        |  30 ++
 .../testing/selftests/rcutorture/doc/TINY_RCU.txt  |   5 +-
 .../selftests/rcutorture/doc/TREE_RCU-kconfig.txt  |   1 -
 tools/testing/selftests/rcutorture/doc/initrd.txt  |  36 +-
 .../selftests/rcutorture/doc/rcu-test-image.txt    |  41 +-
 .../rcutorture/formal/srcu-cbmc/src/config.h       |   1 -
 76 files changed, 1626 insertions(+), 557 deletions(-)
 rename kernel/rcu/{rcuperf.c => rcuscale.c} (64%)
 create mode 100644 kernel/scftorture.c
 rename tools/testing/selftests/rcutorture/bin/{kvm-recheck-rcuperf-ftrace.sh => kvm-recheck-rcuscale-ftrace.sh} (92%)
 rename tools/testing/selftests/rcutorture/bin/{kvm-recheck-rcuperf.sh => kvm-recheck-rcuscale.sh} (84%)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-recheck-scf.sh
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcuperf/CFcommon
 rename tools/testing/selftests/rcutorture/configs/{rcuperf => rcuscale}/CFLIST (100%)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
 rename tools/testing/selftests/rcutorture/configs/{rcuperf => rcuscale}/TINY (100%)
 rename tools/testing/selftests/rcutorture/configs/{rcuperf => rcuscale}/TREE (100%)
 rename tools/testing/selftests/rcutorture/configs/{rcuperf => rcuscale}/TREE54 (100%)
 rename tools/testing/selftests/rcutorture/configs/{rcuperf => rcuscale}/ver_functions.sh (88%)
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/CFLIST
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/CFcommon
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/PREEMPT
 create mode 100644 tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh

