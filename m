Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D4128B940
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbgJLN6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731563AbgJLN6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:58:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF63C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:58:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v19so17024230edx.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=P+dNMVvbO+nkzYnOUH+UTIc/u1rflIhF02dP7DPvhdI=;
        b=FudtRG0xTIJXQPKNb0c55My39Cb3uThRF9UgRLsxFPVm6JRzkRhSIm+xLiwDVyTO1K
         xu61ecchQSPfAQ1cSLOCIEnTZDU5pjNBhGNWkVDJ5037gcrLaitl7+ALZgN6FeemRYcu
         WUp0Bf4SKKue6G4g3kCHtlwWEh0wCW88B9+HVskU6fGt1bcJcd4IJz8cStxh+NDiM67S
         25kxRdwwSL4oXKCxMqXgsppbm72+beWWQyn27ZrlBNY0QYCS/XPZFdDsu6H3q1VFHguX
         f3ysapdGp/EkMklF9MaLuHXQ4zHLeThpzllqug2rfZI0nDbnAy3UyrpiHvOS6cnArE/M
         750A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=P+dNMVvbO+nkzYnOUH+UTIc/u1rflIhF02dP7DPvhdI=;
        b=eaU4rifW1A998lHH3x/h8/vPGI6S986xCoSIal3LQLB7IJiERNc/ZHIOIa6uteQOt1
         6A5V3J1EBU+T4h10SUq1kFdiluxhLWCE3npIlVHLfH0oQB3T+qTEkHjd6K8vwXKJwNNA
         hKbhzi688zluN8GMkKhZifOr0sveMLx/krZUbRBWByGJOcmsJTESrzg1ak0wy09Ycspc
         w3+DMm0qp6W9H5h2RoqZ9Fm9kr4yz7ok2+tSK0LA+noerU2KYn8cFBsJETMETmK0S5Nq
         KpZtN9m1Oe34GVLQgryGYXDyD80Emm06iq19lBbkCuIrzs5SNuuv01ssE1SSdiF/RIGC
         OKwQ==
X-Gm-Message-State: AOAM532brjCME4Ihszer4M8y3EvHt+VfXJwA4w73NFXcKc1QjXTpdLVo
        DFol311Rg+ZqpYYghQR8jPk=
X-Google-Smtp-Source: ABdhPJwEnh/AL8mREtV/Goy8RfpTiENtihnECoN3BO3X7oKk2Ft/9W9RHP9V/8LjyVOkKRhghi3+sA==
X-Received: by 2002:aa7:d783:: with SMTP id s3mr14534013edq.214.1602511082967;
        Mon, 12 Oct 2020 06:58:02 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id q14sm10697927ejo.53.2020.10.12.06.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:58:02 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 12 Oct 2020 15:58:00 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Subject: [GIT PULL] locking changes for v5.10
Message-ID: <20201012135800.GA3240531@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2020-10-12

   # HEAD: 2116d708b0580c0048fc80b82ec4b53f4ddaa166 Merge branch 'lkmm' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into locking/core

These are the locking updates for v5.10:

 - Add deadlock detection for recursive read-locks. The rationale is outlined
   in:

     224ec489d3cd: ("lockdep/Documention: Recursive read lock detection reasoning")

   The main deadlock pattern we want to detect is:

           TASK A:                 TASK B:

           read_lock(X);
                                   write_lock(X);
           read_lock_2(X);

 - Add "latch sequence counters" (seqcount_latch_t):

      A sequence counter variant where the counter even/odd value is used to
      switch between two copies of protected data. This allows the read path,
      typically NMIs, to safely interrupt the write side critical section.

   We utilize this new variant for sched-clock, and to make x86 TSC handling safer.

 - Other seqlock cleanups, fixes and enhancements

 - KCSAN updates

 - LKMM updates

 - Misc updates, cleanups and fixes.

Note that there's a pending bugreport against:

   4d004099a668: ("lockdep: Fix lockdep recursion")

this fix triggers a non-fatal RCU warning on some systems - but that looks 
like a real bug which was masked by a lockdep bug, with fixes being worked 
on and tested. The new boot time warning does not appear to be widespread 
(read: we couldn't reproduce it locally).

 Thanks,

	Ingo

------------------>
Ahmed S. Darwish (13):
      time/sched_clock: Use raw_read_seqcount_latch() during suspend
      mm/swap: Do not abuse the seqcount_t latching API
      seqlock: Introduce seqcount_latch_t
      time/sched_clock: Use seqcount_latch_t
      timekeeping: Use seqcount_latch_t
      x86/tsc: Use seqcount_latch_t
      rbtree_latch: Use seqcount_latch_t
      seqlock: seqcount latch APIs: Only allow seqcount_latch_t
      seqlock: seqcount_LOCKNAME_t: Standardize naming convention
      seqlock: Use unique prefix for seqcount_t property accessors
      seqlock: seqcount_t: Implement all read APIs as statement expressions
      seqlock: seqcount_LOCKNAME_t: Introduce PREEMPT_RT support
      seqlock: PREEMPT_RT: Do not starve seqlock_t writers

Alexander A. Klimov (1):
      Replace HTTP links with HTTPS ones: LKMM

Boqun Feng (20):
      locking: More accurate annotations for read_lock()
      lockdep/Documention: Recursive read lock detection reasoning
      lockdep: Demagic the return value of BFS
      lockdep: Make __bfs() visit every dependency until a match
      lockdep: Reduce the size of lock_list::distance
      lockdep: Introduce lock_list::dep
      lockdep: Extend __bfs() to work with multiple types of dependencies
      lockdep: Make __bfs(.match) return bool
      lockdep: Support deadlock detection for recursive read locks in check_noncircular()
      lockdep: Adjust check_redundant() for recursive read change
      lockdep: Fix recursive read lock related safe->unsafe detection
      lockdep: Add recursive read locks into dependency graph
      lockdep/selftest: Add a R-L/L-W test case specific to chain cache behavior
      lockdep: Take read/write status in consideration when generate chainkey
      lockdep/selftest: Unleash irq_read_recursion2 and add more
      lockdep/selftest: Add more recursive read related test cases
      Revert "locking/lockdep/selftests: Fix mixed read-write ABBA tests"
      locking/selftest: Add test cases for queued_read_lock()
      lockdep/selftest: Introduce recursion3
      lockdep: Optimize the memory usage of circular queue

Marco Elver (19):
      kcsan: Add support for atomic builtins
      objtool: Add atomic builtin TSAN instrumentation to uaccess whitelist
      kcsan: Add atomic builtin test case
      kcsan: Support compounded read-write instrumentation
      objtool, kcsan: Add __tsan_read_write to uaccess whitelist
      kcsan: Skew delay to be longer for certain access types
      kcsan: Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks
      kcsan: Test support for compound instrumentation
      instrumented.h: Introduce read-write instrumentation hooks
      asm-generic/bitops: Use instrument_read_write() where appropriate
      locking/atomics: Use read-write instrumentation for atomic RMWs
      kcsan: Simplify debugfs counter to name mapping
      kcsan: Simplify constant string handling
      kcsan: Remove debugfs test command
      kcsan: Show message if enabled early
      kcsan: Use pr_fmt for consistency
      kcsan: Optimize debugfs stats counters
      bitops, kcsan: Partially revert instrumentation for non-atomic bitops
      kcsan: Use tracing-safe version of prandom

Marta Rybczynska (1):
      Documentation/locking/locktypes: Fix local_locks documentation

Paul Bolle (1):
      locking/atomics: Check atomic-arch-fallback.h too

Paul E. McKenney (4):
      tools/memory-model: Update recipes.txt prime_numbers.c path
      tools/memory-model: Improve litmus-test documentation
      tools/memory-model: Add a simple entry point document
      tools/memory-model: Expand the cheatsheet.txt notion of relaxed

Peter Zijlstra (5):
      seqlock,tags: Add support for SEQCOUNT_LOCKTYPE()
      locking/refcount: Provide __refcount API to obtain the old value
      lockdep: Fix usage_traceoverflow
      lockdep: Fix lockdep recursion
      lockdep: Revert "lockdep: Use raw_cpu_*() for per-cpu variables"

Randy Dunlap (1):
      seqlock: Fix multiple kernel-doc warnings

Sebastian Andrzej Siewior (1):
      locking/seqlock: Tweak DEFINE_SEQLOCK() kernel doc

peterz@infradead.org (1):
      seqlock: Unbreak lockdep


 Documentation/locking/lockdep-design.rst           |  258 +++++
 Documentation/locking/seqlock.rst                  |   18 +
 arch/x86/kernel/tsc.c                              |   10 +-
 include/asm-generic/atomic-instrumented.h          |  330 +++---
 include/asm-generic/bitops/instrumented-atomic.h   |    6 +-
 include/asm-generic/bitops/instrumented-lock.h     |    2 +-
 .../asm-generic/bitops/instrumented-non-atomic.h   |   30 +-
 include/linux/instrumented.h                       |   30 +
 include/linux/kcsan-checks.h                       |   45 +-
 include/linux/lockdep.h                            |   58 +-
 include/linux/lockdep_types.h                      |    8 +-
 include/linux/rbtree_latch.h                       |    6 +-
 include/linux/refcount.h                           |   65 +-
 include/linux/seqlock.h                            |  388 ++++---
 kernel/kcsan/core.c                                |  210 +++-
 kernel/kcsan/debugfs.c                             |  130 +--
 kernel/kcsan/kcsan-test.c                          |  128 ++-
 kernel/kcsan/kcsan.h                               |   12 +-
 kernel/kcsan/report.c                              |   10 +-
 kernel/kcsan/selftest.c                            |    8 +-
 kernel/locking/lockdep.c                           |  977 ++++++++++++------
 kernel/locking/lockdep_internals.h                 |    7 +-
 kernel/time/sched_clock.c                          |    6 +-
 kernel/time/timekeeping.c                          |   10 +-
 lib/Kconfig.kcsan                                  |    5 +
 lib/locking-selftest.c                             |  445 +++++++-
 mm/swap.c                                          |   65 +-
 scripts/Makefile.kcsan                             |    2 +-
 scripts/atomic/check-atomics.sh                    |    1 +
 scripts/atomic/gen-atomic-instrumented.sh          |   21 +-
 scripts/tags.sh                                    |    2 +
 tools/memory-model/Documentation/cheatsheet.txt    |   33 +-
 tools/memory-model/Documentation/litmus-tests.txt  | 1074 ++++++++++++++++++++
 tools/memory-model/Documentation/recipes.txt       |    4 +-
 tools/memory-model/Documentation/references.txt    |    2 +-
 tools/memory-model/Documentation/simple.txt        |  271 +++++
 tools/memory-model/README                          |  160 +--
 tools/objtool/check.c                              |   55 +
 38 files changed, 3900 insertions(+), 992 deletions(-)
 create mode 100644 tools/memory-model/Documentation/litmus-tests.txt
 create mode 100644 tools/memory-model/Documentation/simple.txt
