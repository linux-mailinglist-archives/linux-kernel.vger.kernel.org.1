Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329E23011F4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 02:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbhAWBST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 20:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbhAWBRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 20:17:48 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E73DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 17:17:08 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id a7so227240qkb.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 17:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IaMkqmTttjbetPQ20RK5ozAGqawwXlCoh0MYCZptj3I=;
        b=MAAgQ3G7gFHcbWuKbJpWrlFG1wwE40EZ9ukhl9w3UFqYj7/Xxi1/K6gnpAHxXuH+5G
         PX9hsugMj/aJCd2he8LzClFHYQd6PfrZYyO9zVEl8vhqgY+WFjHM+OEHtAXIshE1NcxP
         HHHmGmCq5OuCJwumNAhhNM9cr7VYZwimowf3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IaMkqmTttjbetPQ20RK5ozAGqawwXlCoh0MYCZptj3I=;
        b=bAlkFTdfnhUnwSZA3H5XVvYbfT7ZKPZ8QNYdd5Yra2H6lteSlcEe2RNEbeNdW/IADm
         qeCcIMYHMCLXmXc5nWdpr1/cjVN7ypqTuWG0uIKSLiitZ5sC0lr51GxzhTVnv93qGMTk
         yGHauXvfjbgChPAuLYI5u5Kmol5fXuNv5K9Tahi6rwO7AII5y9s8ckCHcfyMozNGPHHH
         fU9NfLRi3VcEnuh6YdmDKnsGjZ09aV6z82dWpWRuys4MRkV9aMK+rq8WXBLkmhsFU412
         CEZY74IPB9iHpaqfc7FQrAbT0B6ocgpGoKHY0c3gNllcxv3YLKA0Iej9v2ZMAtwoTDRd
         vVVQ==
X-Gm-Message-State: AOAM5337KvVVb8A078hT8lNjgul8ushb8e/vTMxIA2tBDxLTcpUdrNpT
        zr/qkcLPCuUdMBARXWuXmgNYpw==
X-Google-Smtp-Source: ABdhPJwzoFS7nwSIZWLmlRK27FPK8hvGtFhurDr54DbA+rH+7AiAeyOZiXv20gIxTlnVhCvbN4Kliw==
X-Received: by 2002:a37:49d6:: with SMTP id w205mr3340840qka.322.1611364627638;
        Fri, 22 Jan 2021 17:17:07 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x15sm2516840qtr.72.2021.01.22.17.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 17:17:07 -0800 (PST)
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
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v10 0/5] Core scheduling remaining patches
Date:   Fri, 22 Jan 2021 20:16:59 -0500
Message-Id: <20210123011704.1901835-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Core-Scheduling
===============
Enclosed is series v10 of core scheduling.
Many of the core patches in v9 were picked up in Peter's queue tree. This
series contains the remaining patches (interface, docs).

v9 series is here: https://lwn.net/Articles/837595/

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

Vineeth tested sysbench on v9 series and does not see any regressions.
Hong and Aubrey tested v9 and see results similar to v8. There is a known issue
with uperf that does regress. This appears to be because of ksoftirq heavily
contending with other tasks on the core. The consensus is this can be improved
in the future.

Changes in v10
==============
- migration code changes from Aubrey.
- interface changes from Josh and Chris.
- dropped kernel protection changes for now (have to rework them for mainline).

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

Joel Fernandes (Google) (3):
kselftest: Add tests for core-sched interface
Documentation: Add core scheduling documentation
sched: Debug bits...

Peter Zijlstra (1):
sched: CGroup tagging interface for core scheduling

.../admin-guide/hw-vuln/core-scheduling.rst   | 263 +++++++
Documentation/admin-guide/hw-vuln/index.rst   |   1 +
include/linux/sched.h                         |  10 +
include/uapi/linux/prctl.h                    |   6 +
kernel/fork.c                                 |   1 +
kernel/sched/Makefile                         |   1 +
kernel/sched/core.c                           | 171 ++++-
kernel/sched/coretag.c                        | 669 ++++++++++++++++
kernel/sched/debug.c                          |   4 +
kernel/sched/fair.c                           |  42 +-
kernel/sched/sched.h                          | 130 +++-
kernel/sys.c                                  |   7 +
tools/include/uapi/linux/prctl.h              |   6 +
tools/testing/selftests/sched/.gitignore      |   1 +
tools/testing/selftests/sched/Makefile        |  14 +
tools/testing/selftests/sched/config          |   1 +
.../testing/selftests/sched/test_coresched.c  | 716 ++++++++++++++++++
17 files changed, 2018 insertions(+), 25 deletions(-)
create mode 100644 Documentation/admin-guide/hw-vuln/core-scheduling.rst
create mode 100644 kernel/sched/coretag.c
create mode 100644 tools/testing/selftests/sched/.gitignore
create mode 100644 tools/testing/selftests/sched/Makefile
create mode 100644 tools/testing/selftests/sched/config
create mode 100644 tools/testing/selftests/sched/test_coresched.c

--
2.30.0.280.ga3ce27912f-goog

