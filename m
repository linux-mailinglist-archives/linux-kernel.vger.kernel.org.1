Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48776301BB5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 13:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbhAXMBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 07:01:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:42368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbhAXL7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 06:59:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DCC54AD0B;
        Sun, 24 Jan 2021 11:58:25 +0000 (UTC)
Date:   Sun, 24 Jan 2021 12:58:19 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v5.11-rc5
Message-ID: <20210124115819.GC2493@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the sched/urgent fixes for v5.11.

Thx.

---

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.11_rc5

for you to fetch changes up to 741ba80f6f9a4702089c122129f22df9774b3e64:

  sched: Relax the set_cpus_allowed_ptr() semantics (2021-01-22 15:09:44 +0100)

----------------------------------------------------------------
 - Correct the marking of kthreads which are supposed to run on a specific,
 single CPU vs such which are affine to only one CPU, mark per-cpu workqueue
 threads as such and make sure that marking "survives" CPU hotplug. Fix CPU
 hotplug issues with such kthreads.

 - A fix to not push away tasks on CPUs coming online.

 - Have workqueue CPU hotplug code use cpu_possible_mask when breaking affinity
   on CPU offlining so that pending workers can finish on newly arrived onlined
   CPUs too.

 - Dump tasks which haven't vacated a CPU which is currently being unplugged.

 - Register a special scale invariance callback which gets called on resume
 from RAM to read out APERF/MPERF after resume and thus make the schedutil
 scaling governor more precise.

----------------------------------------------------------------
Lai Jiangshan (1):
      workqueue: Use cpu_possible_mask instead of cpu_active_mask to break affinity

Peter Zijlstra (7):
      sched: Don't run cpu-online with balance_push() enabled
      kthread: Extract KTHREAD_IS_PER_CPU
      workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
      workqueue: Restrict affinity change to rescuer
      sched: Prepare to use balance_push in ttwu()
      sched: Fix CPU hotplug / tighten is_per_cpu_kthread()
      sched: Relax the set_cpus_allowed_ptr() semantics

Rafael J. Wysocki (1):
      x86: PM: Register syscore_ops for scale invariance

Valentin Schneider (1):
      sched/core: Print out straggler tasks in sched_cpu_dying()

 arch/x86/kernel/smpboot.c |  19 ++++++++
 include/linux/kthread.h   |   3 ++
 kernel/kthread.c          |  27 ++++++++++-
 kernel/sched/core.c       | 111 ++++++++++++++++++++++++++++++++++++----------
 kernel/sched/sched.h      |   1 +
 kernel/smpboot.c          |   1 +
 kernel/workqueue.c        |  22 +++++----
 7 files changed, 151 insertions(+), 33 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
