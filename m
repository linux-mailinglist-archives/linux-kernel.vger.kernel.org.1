Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62A12FA2A1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392665AbhARONb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:13:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392605AbhARONO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:13:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4DDB22B39;
        Mon, 18 Jan 2021 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610979149;
        bh=t1B1q/VJWade+4dpTf+GU6cznZzV1+nHf2BiPOHUkBo=;
        h=From:To:Cc:Subject:Date:From;
        b=XO4Lx/ao4z8CVKE9hMZAwrURVuSw1QgYJDvsB6z4faBicLGrF1gu53EFaRA617+rV
         dScnF+Jb5x7mSlcvoTc6WlNkd+kLjG8eNGqtTmzPK+5xWYIQ28C/ujrmpBP7xl2WXW
         wtO0be9lxtrBaONkSy/YAGeDZqluCGC7Mv+Czeny27ox5e/mP1nMsBESaxOMJZaIN7
         eDyC7/Q8ELNb5JnGNUFguK/uhyHqIjUElIHIg7O+OnenUNL2PbRao9YmuogCo0Sw8a
         nnDGj5ExAjlB1lyr5/HF8lXNHTMIMzG2sMKQ7BlNyniTmpPr4WYiJVhxs3id8hlV2g
         KlAscKZl4a8LA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 0/7] preempt: Tune preemption flavour on boot v4
Date:   Mon, 18 Jan 2021 15:12:15 +0100
Message-Id: <20210118141223.123667-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a new version of the feature that can select the preempt flavour
on boot time. Note that it doesn't entirely mimic the actual real
config-based preemption flavours, because at least preempt-RCU
implementation is there in any case.

Also there is still some work to do against subsystems that may play
their own games with CONFIG_PREEMPT.

In this version:

* Restore the initial simple __static_call_return0() implementation.

* Uninline __static_call_return0 on all flavours since its address is
always needed on DEFINE_STATIC_CALL()

* Introduce DEFINE_STATIC_CALL_RET0()

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	preempt/dynamic-v4

HEAD: b5f3b1da9df4197d0b0ffe0f55f0f6a8c838d75f

Thanks,
	Frederic
---

Peter Zijlstra (Intel) (4):
      preempt/dynamic: Provide cond_resched() and might_resched() static calls
      preempt/dynamic: Provide preempt_schedule[_notrace]() static calls
      preempt/dynamic: Provide irqentry_exit_cond_resched() static call
      preempt/dynamic: Support dynamic preempt with preempt= boot option

Peter Zijlstra (2):
      static_call/x86: Add __static_call_return0()
      static_call: Pull some static_call declarations to the type headers

Frederic Weisbecker (1):
      static_call: Provide DEFINE_STATIC_CALL_RET0()

Michal Hocko (1):
      preempt: Introduce CONFIG_PREEMPT_DYNAMIC


 Documentation/admin-guide/kernel-parameters.txt |  7 ++
 arch/Kconfig                                    |  9 +++
 arch/x86/Kconfig                                |  1 +
 arch/x86/include/asm/preempt.h                  | 34 ++++++---
 arch/x86/kernel/static_call.c                   | 17 ++++-
 include/linux/entry-common.h                    |  4 ++
 include/linux/kernel.h                          | 23 ++++--
 include/linux/sched.h                           | 27 ++++++-
 include/linux/static_call.h                     | 43 ++++--------
 include/linux/static_call_types.h               | 29 ++++++++
 kernel/Kconfig.preempt                          | 19 +++++
 kernel/entry/common.c                           | 10 ++-
 kernel/sched/core.c                             | 93 ++++++++++++++++++++++++-
 kernel/static_call.c                            |  5 ++
 14 files changed, 271 insertions(+), 50 deletions(-)
