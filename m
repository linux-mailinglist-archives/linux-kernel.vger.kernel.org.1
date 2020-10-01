Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CCE28092E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733183AbgJAVIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgJAVHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:07:51 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13CC9206FA;
        Thu,  1 Oct 2020 21:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601586471;
        bh=BZONBnd/4ese8mXDBV53ByIXM4qMsw4C54W8+/dcXH0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=xqV0FycbtARRwDtBt1l3lUD6yTL32SvX0BvWqonRPf2/5S3tphE0WOmDwQytl1TzQ
         xoGGlcbZJIMpm+D0jVTz7AOg/07Wx3UeCKj6qZezCi7TvbEkKReZiYpX81p0ARemKk
         qt8totCMc7WtzVjiZfp8FhWNtGGXFWydJF8SxLYM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D88873522B33; Thu,  1 Oct 2020 14:07:50 -0700 (PDT)
Date:   Thu, 1 Oct 2020 14:07:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, urezki@gmail.com,
        lkp@intel.com, julia.lawall@inria.fr, mhocko@kernel.org,
        mgorman@techsingularity.net, vbabka@suse.cz, peterz@infradead.org,
        torvalds@linux-foundation.org
Subject: [GIT PULL tip/core/rcu+preempt] Fix RT raw/non-raw lock ordering
Message-ID: <20201001210750.GA25287@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This pull request contains Thomas Gleixner's "Make preempt count
unconditional" series [1], but with the addition of a kvfree_rcu() bug-fix
commit making use of this PREEMPT_COUNT addition.  This series reduces
the size of the kernel by almost 100 lines of code and is intended for
the upcoming v5.10 merge window.

Please note that these commits must go in via the -tip tree [2].

The additional bug-fix commit addresses a bug reported by Sebastian
Andrzej Siewior [3].  Please note that with the advent of the new
lockdep Kconfig option CONFIG_PROVE_RAW_LOCK_NESTING, this is now also
a mainline bug.  In happy contrast to the surprisingly large number of
earlier versions of this fix, this version uses only pre-existing kernel
interfaces, and furthermore uses them in conventional ways.

This series has been posted to LKML:

https://lore.kernel.org/lkml/20200928233041.GA23230@paulmck-ThinkPad-P72

It has also been exposed to the kernel test robot and to -next testing.

Changes since the LKML posting are limited to the addition of a comment
block and commit-log changes, the latter including the addition of
a Reviewed-by.  Additional discussion led to an additional two commits
containing small updates, but these two additional commits are deferred
to a later pull request, almost certainly for a later merge window.

							Thanx, Paul

[1]	https://lore.kernel.org/linux-mm/20200914204209.256266093@linutronix.de/
[2]	https://lore.kernel.org/lkml/871riigxp9.fsf@nanos.tec.linutronix.de/
[3]	https://lore.kernel.org/lkml/20200630164543.4mdcf6zb4zfclhln@linutronix.de/

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/fix-rt

for you to fetch changes up to 849b9c5446ccb0c98c7b11c69f169d22777ab31b:

  kvfree_rcu(): Fix ifnullfree.cocci warnings (2020-10-01 09:07:24 -0700)

----------------------------------------------------------------
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

Uladzislau Rezki (Sony) (1):
      rcu/tree: Allocate a page when caller is preemptible

kernel test robot (1):
      kvfree_rcu(): Fix ifnullfree.cocci warnings

 arch/arm/include/asm/assembler.h                   | 11 ---
 arch/arm/kernel/iwmmxt.S                           |  2 -
 arch/arm/mach-ep93xx/crunch-bits.S                 |  2 -
 arch/xtensa/kernel/entry.S                         |  2 +-
 drivers/gpu/drm/i915/Kconfig.debug                 |  1 -
 drivers/gpu/drm/i915/i915_utils.h                  |  3 +-
 include/linux/bit_spinlock.h                       |  4 +-
 include/linux/lockdep.h                            |  6 +-
 include/linux/pagemap.h                            |  4 +-
 include/linux/preempt.h                            | 37 ++--------
 include/linux/uaccess.h                            |  6 +-
 kernel/Kconfig.preempt                             |  4 --
 kernel/rcu/tree.c                                  | 79 ++++++++--------------
 kernel/sched/core.c                                |  6 +-
 lib/Kconfig.debug                                  |  3 -
 .../selftests/rcutorture/configs/rcu/SRCU-t        |  1 -
 .../selftests/rcutorture/configs/rcu/SRCU-u        |  1 -
 .../selftests/rcutorture/configs/rcu/TINY01        |  1 -
 .../testing/selftests/rcutorture/doc/TINY_RCU.txt  |  5 +-
 .../selftests/rcutorture/doc/TREE_RCU-kconfig.txt  |  1 -
 .../rcutorture/formal/srcu-cbmc/src/config.h       |  1 -
 21 files changed, 44 insertions(+), 136 deletions(-)
