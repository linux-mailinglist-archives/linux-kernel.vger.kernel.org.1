Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD732AC9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 01:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbgKJA4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 19:56:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:53890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKJA4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 19:56:16 -0500
Received: from localhost.localdomain (i15-lef02-th2-89-83-252-17.ft.lns.abo.bbox.fr [89.83.252.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 694F7206D8;
        Tue, 10 Nov 2020 00:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604969775;
        bh=SfL6aYaM02zGlq5BN0lgvBPDGAtSYXrZoCAswFB55k0=;
        h=From:To:Cc:Subject:Date:From;
        b=Cathi0tfliVsD3t2aIAww5ZcKBelMBdtrZkUw8L8oXcBg4n2S2WxuClri2RbyIMFb
         TWGTe224hygOd+zY9AtpQRNO428xQ61j23RkMKQbmVMkb5DUjaZNw/4d8/WrqX4e9/
         Uv0BtVrVxkEuXguVeCiL0aJ5V8aGhm4PAxVvFsxc=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 0/7] preempt: Tune preemption flavour on boot v3
Date:   Tue, 10 Nov 2020 01:56:02 +0100
Message-Id: <20201110005609.40989-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a reworked version of what came out of the debate between Michal
Hocko and Peter Zijlstra in order to tune the preemption mode from
kernel parameters, see v2 in:

https://lore.kernel.org/lkml/20201009122926.29962-1-mhocko@kernel.org/

I mostly fetched the raw diff from Peter's proof of concept using
static calls + a few cherry picking here and there + some rework from my
end. The result is still not complete, I still need to handle
__cond_resched_lock() and other CONFIG_PREEMPT specifics. And also
some others cleanup patches that were in Michal's series.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	preempt/dynamic

HEAD: 764be94f20534c96e6f5a16922ad81c0a3bcd868

Thanks,
	Frederic
---

Peter Zijlstra (Intel) (4):
      preempt/dynamic: Provide cond_resched() and might_resched() static calls
      preempt/dynamic: Provide preempt_schedule[_notrace]() static calls
      preempt/dynamic: Provide irqentry_exit_cond_resched() static call
      preempt/dynamic: Support dynamic preempt with preempt= boot option

Peter Zijlstra (2):
      static_call/x86: Add __static_call_returnl0()
      static_call: Pull some static_call declarations to the type headers

Michal Hocko (1):
      preempt: Introduce CONFIG_PREEMPT_DYNAMIC


 Documentation/admin-guide/kernel-parameters.txt |  7 ++
 arch/Kconfig                                    |  9 +++
 arch/x86/Kconfig                                |  1 +
 arch/x86/include/asm/preempt.h                  | 34 ++++++---
 arch/x86/include/asm/text-patching.h            | 26 ++++++-
 arch/x86/kernel/alternative.c                   |  5 ++
 arch/x86/kernel/static_call.c                   | 10 ++-
 include/linux/entry-common.h                    |  4 ++
 include/linux/kernel.h                          | 22 +++++-
 include/linux/sched.h                           | 27 ++++++-
 include/linux/static_call.h                     | 21 ------
 include/linux/static_call_types.h               | 33 +++++++++
 kernel/Kconfig.preempt                          | 19 +++++
 kernel/entry/common.c                           | 10 ++-
 kernel/sched/core.c                             | 93 ++++++++++++++++++++++++-
 kernel/static_call.c                            | 10 +++
 16 files changed, 289 insertions(+), 42 deletions(-)
