Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CDE2DD925
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 20:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbgLQTJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 14:09:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:45992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgLQTJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 14:09:35 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1708239EB;
        Thu, 17 Dec 2020 19:08:53 +0000 (UTC)
Date:   Thu, 17 Dec 2020 14:08:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kaixu Xia <kaixuxia@tencent.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [GIT PULL] tracing: Updates for 5.11
Message-ID: <20201217140852.45d70612@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing updates for 5.11

** Note there's a minor conflict with mainline, see second paragraph **

The major update to this release is that there's a new arch config option called:
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS. Currently, only x86_64 enables it.
All the ftrace callbacks now take a struct ftrace_regs instead of a struct
pt_regs. If the architecture has HAVE_DYNAMIC_FTRACE_WITH_ARGS enabled, then
the ftrace_regs will have enough information to read the arguments of the
function being traced, as well as access to the stack pointer. This way, if
a user (like live kernel patching) only cares about the arguments, then it
can avoid using the heavier weight "regs" callback, that puts in enough
information in the struct ftrace_regs to simulate a breakpoint exception
(needed for kprobes).

New config option that audits the timestamps of the ftrace ring buffer at
most every event recorded.  The "check_buffer()" calls will conflict with
mainline, because I purposely added the check without including the fix that
it caught, which is in mainline. Running a kernel built from the commit of
the added check will trigger it.

Ftrace recursion protection has been cleaned up to move the protection to
the callback itself (this saves on an extra function call for those
callbacks).

Perf now handles its own RCU protection and does not depend on ftrace to do
it for it (saving on that extra function call).

New debug option to add "recursed_functions" file to tracefs that lists all
the places that triggered the recursion protection of the function tracer.
This will show where things need to be fixed as recursion slows down the
function tracer.

The eval enum mapping updates done at boot up are now offloaded to a work
queue, as it caused a noticeable pause on slow embedded boards.

Various clean ups and last minute fixes.


Please pull the latest trace-v5.11 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.11

Tag SHA1: 5db8571616e109a83cc9164e1c0e7875fe3f92b3
Head SHA1: f6a694665f132cbf6e2222dd2f173dc35330a8aa


Alex Shi (1):
      ftrace: Remove unused varible 'ret'

Arnd Bergmann (1):
      seq_buf: Avoid type mismatch for seq_buf_init

Kaixu Xia (1):
      tracing: Remove the useless value assignment in test_create_synth_event()

Lukas Bulwahn (4):
      MAINTAINERS: assign ./fs/tracefs to TRACING
      tracing: Clean up after filter logic rewriting
      ring-buffer: Remove obsolete rb_event_is_commit()
      tracing: Drop unneeded assignment in ring_buffer_resize()

Masami Hiramatsu (1):
      tracing: Disable ftrace selftests when any tracer is running

Qiujun Huang (4):
      tracing: Fix some typos in comments
      ring-buffer: Fix a typo in function description
      ring-buffer: Fix two typos in comments
      ring-buffer: Add rb_check_bpage in __rb_allocate_pages

Steven Rostedt (VMware) (21):
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
      ftrace: Have the callbacks receive a struct ftrace_regs instead of pt_regs
      ftrace/x86: Allow for arguments to be passed in to ftrace_regs by default
      livepatch: Use the default ftrace_ops instead of REGS when ARGS is available
      ftrace/documentation: Fix RST C code blocks
      ring-buffer: Add test to validate the time stamp deltas
      Revert: "ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS"
      tracing: Offload eval map updates to a work queue

----
 Documentation/trace/ftrace-uses.rst   |  90 +++++++++----
 MAINTAINERS                           |   1 +
 arch/Kconfig                          |  16 +++
 arch/csky/kernel/probes/ftrace.c      |  16 ++-
 arch/nds32/kernel/ftrace.c            |   4 +-
 arch/parisc/kernel/ftrace.c           |  24 +++-
 arch/powerpc/include/asm/livepatch.h  |   4 +-
 arch/powerpc/kernel/kprobes-ftrace.c  |  15 ++-
 arch/s390/include/asm/livepatch.h     |   5 +-
 arch/s390/kernel/ftrace.c             |  20 ++-
 arch/x86/Kconfig                      |   1 +
 arch/x86/include/asm/ftrace.h         |  18 +++
 arch/x86/include/asm/livepatch.h      |   4 +-
 arch/x86/kernel/ftrace_64.S           |  15 ++-
 arch/x86/kernel/kprobes/ftrace.c      |  15 ++-
 fs/pstore/ftrace.c                    |   8 +-
 include/linux/ftrace.h                |  45 +++++--
 include/linux/kprobes.h               |   2 +-
 include/linux/seq_buf.h               |   2 +-
 include/linux/trace_recursion.h       | 232 +++++++++++++++++++++++++++++++++
 include/linux/trace_seq.h             |   4 +-
 kernel/livepatch/Kconfig              |   2 +-
 kernel/livepatch/patch.c              |  15 ++-
 kernel/trace/Kconfig                  |  68 ++++++++++
 kernel/trace/Makefile                 |   1 +
 kernel/trace/blktrace.c               |   4 +-
 kernel/trace/bpf_trace.c              |   2 +-
 kernel/trace/fgraph.c                 |   3 +-
 kernel/trace/ftrace.c                 |  57 ++++----
 kernel/trace/ring_buffer.c            | 223 +++++++++++++++++++++++++++-----
 kernel/trace/synth_event_gen_test.c   |   2 +-
 kernel/trace/trace.c                  |  53 ++++++--
 kernel/trace/trace.h                  | 182 +-------------------------
 kernel/trace/trace_benchmark.c        |   6 +-
 kernel/trace/trace_boot.c             |   2 +
 kernel/trace/trace_dynevent.c         |   2 +-
 kernel/trace/trace_dynevent.h         |   6 +-
 kernel/trace/trace_entries.h          |   6 +-
 kernel/trace/trace_event_perf.c       |  15 ++-
 kernel/trace/trace_events.c           |   9 +-
 kernel/trace/trace_events_filter.c    |  23 +---
 kernel/trace/trace_events_hist.c      |   2 +-
 kernel/trace/trace_events_synth.c     |   4 +-
 kernel/trace/trace_export.c           |   2 +-
 kernel/trace/trace_functions.c        |  23 ++--
 kernel/trace/trace_functions_graph.c  |   2 +-
 kernel/trace/trace_hwlat.c            |   4 +-
 kernel/trace/trace_irqsoff.c          |   2 +-
 kernel/trace/trace_kprobe.c           |   9 +-
 kernel/trace/trace_output.c           |   6 +-
 kernel/trace/trace_output.h           |   1 +
 kernel/trace/trace_recursion_record.c | 236 ++++++++++++++++++++++++++++++++++
 kernel/trace/trace_sched_wakeup.c     |   2 +-
 kernel/trace/trace_selftest.c         |  29 ++---
 kernel/trace/trace_stack.c            |   3 +-
 kernel/trace/tracing_map.c            |   6 +-
 kernel/trace/tracing_map.h            |   2 +-
 57 files changed, 1140 insertions(+), 415 deletions(-)
 create mode 100644 include/linux/trace_recursion.h
 create mode 100644 kernel/trace/trace_recursion_record.c
---------------------------
