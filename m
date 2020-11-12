Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE702AFC7D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgKLBhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:37:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbgKLAdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:33:35 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3EA4205CB;
        Thu, 12 Nov 2020 00:33:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kd0YP-00026J-9t; Wed, 11 Nov 2020 19:33:33 -0500
Message-ID: <20201112003244.764326960@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 11 Nov 2020 19:32:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/17] tracing: Updates for 5.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 58954b3be8b7a8a0ebf1ced6fbbab808e8ccc4b6


Alex Shi (1):
      ftrace: Remove unused varible 'ret'

Lukas Bulwahn (1):
      MAINTAINERS: assign ./fs/tracefs to TRACING

Qiujun Huang (1):
      tracing: Fix some typos in comments

Steven Rostedt (VMware) (14):
      ftrace: Move the recursion testing into global headers
      ftrace: Add ftrace_test_recursion_trylock() helper function
      ftrace: Optimize testing what context current is in
      pstore/ftrace: Add recursion protection to the ftrace callback
      kprobes/ftrace: Add recursion protection to the ftrace callback
      livepatch/ftrace: Add recursion protection to the ftrace callback
      livepatch: Trigger WARNING if livepatch function fails due to recursion
      perf/ftrace: Add recursion protection to the ftrace callback
      perf/ftrace: Check for rcu_is_watching() in callback function
      ftrace: Reverse what the RECURSION flag means in the ftrace_ops
      ftrace: Add recording of functions that caused recursion
      fgraph: Make overruns 4 bytes in graph stack structure
      ftrace: Clean up the recursion code a bit
      ring-buffer: Add recording of ring buffer recursion into recursed_functions

----
 Documentation/trace/ftrace-uses.rst   |  84 ++++++++----
 MAINTAINERS                           |   1 +
 arch/csky/kernel/probes/ftrace.c      |  12 +-
 arch/parisc/kernel/ftrace.c           |  16 ++-
 arch/powerpc/kernel/kprobes-ftrace.c  |  11 +-
 arch/s390/kernel/ftrace.c             |  16 ++-
 arch/x86/kernel/kprobes/ftrace.c      |  12 +-
 fs/pstore/ftrace.c                    |   6 +
 include/linux/ftrace.h                |  17 +--
 include/linux/trace_recursion.h       | 232 +++++++++++++++++++++++++++++++++
 kernel/livepatch/patch.c              |   5 +
 kernel/trace/Kconfig                  |  39 ++++++
 kernel/trace/Makefile                 |   1 +
 kernel/trace/blktrace.c               |   4 +-
 kernel/trace/bpf_trace.c              |   2 +-
 kernel/trace/fgraph.c                 |   3 +-
 kernel/trace/ftrace.c                 |  30 ++---
 kernel/trace/ring_buffer.c            |  12 +-
 kernel/trace/trace.c                  |   2 +-
 kernel/trace/trace.h                  | 177 -------------------------
 kernel/trace/trace_benchmark.c        |   6 +-
 kernel/trace/trace_dynevent.c         |   2 +-
 kernel/trace/trace_dynevent.h         |   6 +-
 kernel/trace/trace_entries.h          |   6 +-
 kernel/trace/trace_event_perf.c       |  13 +-
 kernel/trace/trace_events.c           |   5 +-
 kernel/trace/trace_events_filter.c    |   2 +-
 kernel/trace/trace_events_hist.c      |   2 +-
 kernel/trace/trace_events_synth.c     |   4 +-
 kernel/trace/trace_export.c           |   2 +-
 kernel/trace/trace_functions.c        |  14 +-
 kernel/trace/trace_functions_graph.c  |   2 +-
 kernel/trace/trace_hwlat.c            |   4 +-
 kernel/trace/trace_output.c           |   6 +-
 kernel/trace/trace_output.h           |   1 +
 kernel/trace/trace_recursion_record.c | 236 ++++++++++++++++++++++++++++++++++
 kernel/trace/trace_selftest.c         |   7 +-
 kernel/trace/trace_stack.c            |   1 -
 kernel/trace/tracing_map.c            |   6 +-
 kernel/trace/tracing_map.h            |   2 +-
 40 files changed, 723 insertions(+), 286 deletions(-)
 create mode 100644 include/linux/trace_recursion.h
 create mode 100644 kernel/trace/trace_recursion_record.c
