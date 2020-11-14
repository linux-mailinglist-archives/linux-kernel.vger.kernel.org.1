Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD22D2B2E05
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 16:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgKNPfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 10:35:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:48520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgKNPfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 10:35:00 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F020922263;
        Sat, 14 Nov 2020 15:34:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kdxZq-000Hjg-ON; Sat, 14 Nov 2020 10:34:58 -0500
Message-ID: <20201114153221.050150744@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 14 Nov 2020 10:32:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/4] ftrace/tracing/livepatch: More updates for 5.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kaixu Xia <kaixuxia@tencent.com>, Steven Rostedt (VMware) <rostedt@goodmis.org>
  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: b111545d26c0d66dd9aae668d9373669e752b075


Kaixu Xia (1):
      tracing: Remove the useless value assignment in test_create_synth_event()

Steven Rostedt (VMware) (3):
      ftrace: Have the callbacks receive a struct ftrace_regs instead of pt_regs
      ftrace/x86: Allow for arguments to be passed in to ftrace_regs by default
      livepatch: Use the default ftrace_ops instead of REGS when ARGS is available

----
 arch/csky/kernel/probes/ftrace.c     |  4 +++-
 arch/nds32/kernel/ftrace.c           |  4 ++--
 arch/parisc/kernel/ftrace.c          |  8 +++++---
 arch/powerpc/include/asm/livepatch.h |  4 +++-
 arch/powerpc/kernel/kprobes-ftrace.c |  4 +++-
 arch/s390/include/asm/livepatch.h    |  5 ++++-
 arch/s390/kernel/ftrace.c            |  4 +++-
 arch/x86/Kconfig                     |  1 +
 arch/x86/include/asm/ftrace.h        | 18 ++++++++++++++++++
 arch/x86/include/asm/livepatch.h     |  4 ++--
 arch/x86/kernel/ftrace_64.S          | 15 +++++++++++++--
 arch/x86/kernel/kprobes/ftrace.c     |  3 ++-
 fs/pstore/ftrace.c                   |  2 +-
 include/linux/ftrace.h               | 28 ++++++++++++++++++++++++++--
 include/linux/kprobes.h              |  2 +-
 kernel/livepatch/Kconfig             |  2 +-
 kernel/livepatch/patch.c             | 10 ++++++----
 kernel/trace/Kconfig                 |  9 +++++++++
 kernel/trace/ftrace.c                | 27 +++++++++++++++------------
 kernel/trace/synth_event_gen_test.c  |  2 +-
 kernel/trace/trace_event_perf.c      |  2 +-
 kernel/trace/trace_events.c          |  2 +-
 kernel/trace/trace_functions.c       |  9 ++++-----
 kernel/trace/trace_irqsoff.c         |  2 +-
 kernel/trace/trace_sched_wakeup.c    |  2 +-
 kernel/trace/trace_selftest.c        | 20 +++++++++++---------
 kernel/trace/trace_stack.c           |  2 +-
 27 files changed, 139 insertions(+), 56 deletions(-)
