Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4308628B6C7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbgJLNha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730994AbgJLNhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:37:14 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C25C0613DE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:37:05 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dt13so23213514ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tCUpQoSulnQei1dT4ghNdiCKyO8fOYZZP8+ViGtmQQc=;
        b=OcF/8hAefoDzydagDszym4HaHQhFksCnztgDdXaaOwJIOw/SUubpEh24slj+VtK6rt
         OrYPejsdZ9xZ/R9Ma8EegPOZ+iZopKEyJVxdz+8n2xvdAjdRKFrHmTaGdhHmOCAH7GgV
         At7mMwq6cQHUbbTMZhuYotDxot4HagxUkyX3LGhKpUigD0MdN7pb/raVx13+SoaOJkTZ
         vAKdagrpD+iwnoO4pGdo0PXYW6KKPD4VaiK8ijh9UL7RkUSJxlY3RdomIG1ZdOP3vuhy
         YNkyEl1KOC8n/h5F76LP+43aJnCcPKkg1QA27e4YKbKswDrhvch+yPpS0TgN6FDCLkzv
         Qipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=tCUpQoSulnQei1dT4ghNdiCKyO8fOYZZP8+ViGtmQQc=;
        b=PaTpL2FzuiClvALNkaZxVQotNmydcQiXGagB8zUsVrmd+6DOZn+uslrzCb1a+B8JgK
         ve605Dt8G4Ed3uH0RAL3KsVn9xpjcXvjMxOkXe7LturK3i/w2cXx2S96AeBTcHXLHn0w
         niRG4MuwoGL6WR7feocwHMsQl1rs5ciLBjZb6ULlyYRo2yc5LyD0bJdQ7OBMD+CYWzVA
         5mZtbW51qM/+h/aVRZJoOk2UUfK70l8YzaFpm2HnA983hiz1ROAFQ3vG6MPmKkG0doKc
         J5NlbI3PbU/aaogi3UbheAhueRBME1wxiD2ONgmZqKxamoCbVlYOVI6zA540lPVqU3rw
         S6ow==
X-Gm-Message-State: AOAM533VMJfiU+s96SZb5cdS9gnjuIa5TWeWMe4riwsDUF/Ld9Rm1ivh
        a4ZK5Abc+xaCj0jG+9U2z48=
X-Google-Smtp-Source: ABdhPJyClTZhFg3sHiRkIoMm4qqDjOUdMlb5/yTlq3yvJThvEJfNcEQp7bTGx9jj4aOy1TF4C8Z/LQ==
X-Received: by 2002:a17:906:54d8:: with SMTP id c24mr10110818ejp.499.1602509823947;
        Mon, 12 Oct 2020 06:37:03 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id e5sm10792343ejb.26.2020.10.12.06.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:37:03 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 12 Oct 2020 15:37:01 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [GIT PULL] scheduler changes for v5.10
Message-ID: <20201012133701.GA3206705@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2020-10-12

   # HEAD: feff2e65efd8d84cf831668e182b2ce73c604bbb sched/deadline: Unthrottle PI boosted threads while enqueuing

Scheduler changes for v5.10:

 - Reorganize & clean up the SD* flags definitions and add a bunch
   of sanity checks. These new checks caught quite a few bugs or at
   least inconsistencies, resulting in another set of patches.

 - Rseq updates, add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ

 - Add a new tracepoint to improve CPU capacity tracking

 - Improve overloaded SMP system load-balancing behavior

 - Tweak SMT balancing

 - Energy-aware scheduling updates

 - NUMA balancing improvements

 - Deadline scheduler fixes and improvements

 - CPU isolation fixes

 - Misc cleanups, simplifications and smaller optimizations.

 Thanks,

	Ingo

------------------>
Barry Song (1):
      sched/fair: Use dst group while checking imbalance for NUMA balancer

Daniel Bristot de Oliveira (3):
      MAINTAINERS: Add myself as SCHED_DEADLINE reviewer
      sched/rt: Disable RT_RUNTIME_SHARE by default
      sched/deadline: Unthrottle PI boosted threads while enqueuing

Jiang Biao (1):
      sched/fair: Simplify the work when reweighting entity

Josh Don (1):
      sched/fair: Ignore cache hotness for SMT migration

Lucas Stach (1):
      sched/deadline: Fix stale throttling on de-/boosted tasks

Lukasz Luba (1):
      sched/fair: Fix wrong negative conversion in find_energy_efficient_cpu()

Peter Oskolkov (4):
      rseq/membarrier: Add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
      rseq/selftests,x86_64: Add rseq_offset_deref_addv()
      rseq/selftests: Test MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
      sched/fair: Tweak pick_next_entity()

Sebastian Andrzej Siewior (2):
      sched: Bring the PF_IO_WORKER and PF_WQ_WORKER bits closer together
      sched: Cache task_struct::flags in sched_submit_work()

Valentin Schneider (19):
      ARM, sched/topology: Remove SD_SHARE_POWERDOMAIN
      ARM, sched/topology: Revert back to default scheduler topology
      sched/topology: Split out SD_* flags declaration to its own file
      sched/topology: Define and assign sched_domain flag metadata
      sched/topology: Verify SD_* flags setup when sched_debug is on
      sched/debug: Output SD flag names rather than their values
      sched/topology: Introduce SD metaflag for flags needing > 1 groups
      sched/topology: Use prebuilt SD flag degeneration mask
      sched/topology: Remove SD_SERIALIZE degeneration special case
      sched/topology: Propagate SD_ASYM_CPUCAPACITY upwards
      sched/topology: Mark SD_PREFER_SIBLING as SDF_NEEDS_GROUPS
      sched/topology: Mark SD_BALANCE_WAKE as SDF_NEEDS_GROUPS
      sched/topology: Mark SD_SERIALIZE as SDF_NEEDS_GROUPS
      sched/topology: Mark SD_ASYM_PACKING as SDF_NEEDS_GROUPS
      sched/topology: Mark SD_OVERLAP as SDF_NEEDS_GROUPS
      sched/topology: Mark SD_NUMA as SDF_NEEDS_GROUPS
      sched/topology: Move sd_flag_debug out of linux/sched/topology.h
      sched/topology: Move SD_DEGENERATE_GROUPS_MASK out of linux/sched/topology.h
      sched/topology: Move sd_flag_debug out of #ifdef CONFIG_SYSCTL

Vincent Donnefort (1):
      sched/debug: Add new tracepoint to track cpu_capacity

Vincent Guittot (5):
      sched/numa: Use runnable_avg to classify node
      sched/fair: Relax constraint on task's load during load balance
      sched/fair: Reduce minimal imbalance threshold
      sched/fair: Minimize concurrent LBs between domain level
      sched/fair: Reduce busy load balance interval

Xianting Tian (1):
      sched/fair: Remove the force parameter of update_tg_load_avg()

Xunlei Pang (1):
      sched/fair: Fix wrong cpu selecting from isolated domain

YueHaibing (1):
      sched: Remove unused inline function uclamp_bucket_base_value()


 MAINTAINERS                                    |   1 +
 arch/arm/kernel/topology.c                     |  26 ---
 include/linux/sched.h                          |   5 +-
 include/linux/sched/mm.h                       |   3 +
 include/linux/sched/sd_flags.h                 | 156 +++++++++++++++++
 include/linux/sched/topology.h                 |  37 ++--
 include/linux/syscalls.h                       |   2 +-
 include/trace/events/sched.h                   |   4 +
 include/uapi/linux/membarrier.h                |  26 +++
 kernel/sched/core.c                            |  13 +-
 kernel/sched/deadline.c                        |  34 +++-
 kernel/sched/debug.c                           |  56 ++++++-
 kernel/sched/fair.c                            | 103 ++++++++----
 kernel/sched/features.h                        |   2 +-
 kernel/sched/membarrier.c                      | 136 +++++++++++----
 kernel/sched/topology.c                        |  69 ++++----
 tools/testing/selftests/rseq/param_test.c      | 223 ++++++++++++++++++++++++-
 tools/testing/selftests/rseq/rseq-x86.h        |  57 +++++++
 tools/testing/selftests/rseq/run_param_test.sh |   2 +
 19 files changed, 803 insertions(+), 152 deletions(-)
 create mode 100644 include/linux/sched/sd_flags.h
