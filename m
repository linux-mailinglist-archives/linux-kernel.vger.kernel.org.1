Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF1529D70E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbgJ1WUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731745AbgJ1WRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41940246CC;
        Wed, 28 Oct 2020 11:56:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kXk3o-005ZFy-Dp; Wed, 28 Oct 2020 07:56:12 -0400
Message-ID: <20201028115244.995788961@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 28 Oct 2020 07:52:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/9] ftrace: Have callbacks handle their own recursion
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found that having the ftrace infrastructure use its own trampoline to
handle recursion and RCU by defaulte unless the ftrace_ops set the
appropriate flags, was an issue that nobody set those flags. But then their
callbacks would suffer from an unnecessary overhead instead of simply
handling the recursion itself.

This series makes it mandatory that ftrace callbacks handle recursion or set
a flag asking ftrace to do it for it. It also creates helper functions to
help these callbacks to have recursion protection.

Steven Rostedt (VMware) (9):
      ftrace: Move the recursion testing into global headers
      ftrace: Add ftrace_test_recursion_trylock() helper function
      ftrace: Optimize testing what context current is in
      pstore/ftrace: Add recursion protection to the ftrace callback
      kprobes/ftrace: Add recursion protection to the ftrace callback
      livepatch/ftrace: Add recursion protection to the ftrace callback
      perf/ftrace: Add recursion protection to the ftrace callback
      perf/ftrace: Check for rcu_is_watching() in callback function
      ftrace: Reverse what the RECURSION flag means in the ftrace_ops

----
 Documentation/trace/ftrace-uses.rst  |  82 +++++++++++----
 arch/csky/kernel/probes/ftrace.c     |  12 ++-
 arch/parisc/kernel/ftrace.c          |  13 ++-
 arch/powerpc/kernel/kprobes-ftrace.c |  11 +-
 arch/s390/kernel/ftrace.c            |  13 ++-
 arch/x86/kernel/kprobes/ftrace.c     |  12 ++-
 fs/pstore/ftrace.c                   |   6 ++
 include/linux/ftrace.h               |  13 +--
 include/linux/trace_recursion.h      | 199 +++++++++++++++++++++++++++++++++++
 kernel/livepatch/patch.c             |   5 +
 kernel/trace/fgraph.c                |   3 +-
 kernel/trace/ftrace.c                |  20 ++--
 kernel/trace/trace.h                 | 156 ---------------------------
 kernel/trace/trace_event_perf.c      |  13 ++-
 kernel/trace/trace_events.c          |   1 -
 kernel/trace/trace_functions.c       |  14 ++-
 kernel/trace/trace_selftest.c        |   7 +-
 kernel/trace/trace_stack.c           |   1 -
 18 files changed, 358 insertions(+), 223 deletions(-)
 create mode 100644 include/linux/trace_recursion.h
