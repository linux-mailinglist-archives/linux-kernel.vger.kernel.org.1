Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544F628F7DE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 19:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbgJORxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 13:53:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgJORxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 13:53:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82AA12225E;
        Thu, 15 Oct 2020 17:53:47 +0000 (UTC)
Date:   Thu, 15 Oct 2020 13:53:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [GIT PULL] tracing: Updates for 5.10
Message-ID: <20201015135345.6b29e8c0@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Updates for tracing and bootconfig:

- Add support for "bool" type in synthetic events

- Add per instance tracing for bootconfig

- Support perf-style return probe ("SYMBOL%return") in kprobes and uprobes

- Allow for kprobes to be enabled earlier in boot up

- Added tracepoint helper function to allow testing if tracepoints are
  enabled in headers

- Synthetic events can now have dynamic strings (variable length)

- Various fixes and cleanups


Please pull the latest trace-v5.10 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.10

Tag SHA1: 26ab68b2a2fa3a0e3724d4b025ca3a15dd7ec1f3
Head SHA1: 6107742d15832011cd0396d821f3225b52551f1f


Axel Rasmussen (1):
      tracing: support "bool" type in synthetic trace events

Dan Carpenter (1):
      tracing: remove a pointless assignment

Davidlohr Bueso (1):
      fgraph: Convert ret_stack tasklist scanning to rcu

Gaurav Kohli (1):
      tracing: Fix race in trace_open and buffer resize call

Jarkko Sakkinen (1):
      kprobes: Use module_name() macro

Masami Hiramatsu (21):
      tools/bootconfig: Show bootconfig compact tree from bootconfig file
      tools/bootconfig: Add list option
      tools/bootconfig: Make all functions static
      tools/bootconfig: Add a script to generate ftrace shell-command from bootconfig
      tools/bootconfig: Add a script to generates bootconfig from ftrace
      tools/bootconfig: Add --init option for bconf2ftrace.sh
      tracing/boot: Add per-instance tracing_on option support
      Documentation: tracing: Add tracing_on option to boot-time tracer
      tracing/kprobes: Support perf-style return probe
      tracing/uprobes: Support perf-style return probe
      Documentation: tracing: Add %return suffix description
      Documentation: tracing: boot: Add an example of tracing function-calls
      selftests/ftrace: Add %return suffix tests
      kprobes: Init kprobes in early_initcall
      tracing: Define event fields early stage
      tracing: Enable adding dynamic events early stage
      tracing: Enable creating new instance early boot
      tracing/boot, kprobe, synth: Initialize boot-time tracing earlier
      Documentation: tracing: Add the startup timing of boot-time tracing
      tracing/boot: Initialize per-instance event list in early boot
      tracing/boot: Add ftrace.instance.*.alloc_snapshot option

Qiujun Huang (2):
      ftrace: Fix some typos in comment
      tracing: Fix some typos in comments

Randy Dunlap (1):
      tracing: Delete repeated words in comments

Steven Rostedt (VMware) (8):
      tracepoints: Add helper to test if tracepoint is enabled in a header
      mm/page_ref: Convert the open coded tracepoint enabled to the new helper
      x86: Use tracepoint_enabled() for msr tracepoints instead of open coding it
      tracing: Change synthetic event string format to limit printed length
      ftrace: Simplify the hash calculation
      ftrace: Format variable declarations of ftrace_allocate_records
      tracing: Fix synthetic print fmt check for use of __get_str()
      tracing: Check return value of __create_val_fields() before using its result

Sudip Mukherjee (1):
      tracing: Remove a pointless assignment

Tom Zanussi (13):
      tracing: Change STR_VAR_MAX_LEN
      tracing: Fix parse_synth_field() error handling
      tracing: Save normal string variables
      tracing: Add support for dynamic strings to synthetic events
      tracing: Add README information for synthetic_events file
      selftests/ftrace: Add test case for synthetic event dynamic strings
      tracing: Don't show dynamic string internals in synthetic event description
      tracing: Move is_good_name() from trace_probe.h to trace.h
      tracing: Check that the synthetic event and field names are legal
      tracing: Add synthetic event error logging
      selftests/ftrace: Change synthetic event name for inter-event-combined test
      tracing: Handle synthetic event array field type checking correctly
      selftests/ftrace: Add test case for synthetic event syntax errors

Wei Yang (6):
      tracing: toplevel d_entry already initialized
      tracing: make tracing_init_dentry() returns an integer instead of a d_entry pointer
      ftrace: Use fls() to get the bits for dup_hash()
      ftrace: Simplify the dyn_ftrace->flags macro
      ftrace: Simplify the calculation of page number for ftrace_page->records
      ftrace: ftrace_global_list is renamed to ftrace_ops_list

Xianting Tian (1):
      tracing: Use __this_cpu_read() in trace_buffered_event_enable()

----
 Documentation/trace/boottime-trace.rst             |  38 ++
 Documentation/trace/events.rst                     |  15 +-
 Documentation/trace/histogram.rst                  |  18 +
 Documentation/trace/kprobetrace.rst                |   2 +
 Documentation/trace/tracepoints.rst                |  27 ++
 Documentation/trace/uprobetracer.rst               |   2 +
 MAINTAINERS                                        |   1 +
 arch/x86/include/asm/msr.h                         |  20 +-
 include/linux/ftrace.h                             |  11 +-
 include/linux/page_ref.h                           |  42 +--
 include/linux/tracepoint-defs.h                    |  34 ++
 kernel/kprobes.c                                   |   2 +-
 kernel/trace/fgraph.c                              |   8 +-
 kernel/trace/ftrace.c                              |  24 +-
 kernel/trace/ring_buffer.c                         |  10 +
 kernel/trace/synth_event_gen_test.c                |  18 +-
 kernel/trace/trace.c                               | 111 ++++--
 kernel/trace/trace.h                               |  31 +-
 kernel/trace/trace_boot.c                          |  23 +-
 kernel/trace/trace_dynevent.c                      |  10 +-
 kernel/trace/trace_events.c                        | 140 ++++---
 kernel/trace/trace_events_hist.c                   |  45 ++-
 kernel/trace/trace_events_synth.c                  | 413 ++++++++++++++++++---
 kernel/trace/trace_functions.c                     |  22 +-
 kernel/trace/trace_functions_graph.c               |   8 +-
 kernel/trace/trace_hwlat.c                         |   8 +-
 kernel/trace/trace_kprobe.c                        |  41 +-
 kernel/trace/trace_printk.c                        |   8 +-
 kernel/trace/trace_probe.h                         |  14 +-
 kernel/trace/trace_stack.c                         |  12 +-
 kernel/trace/trace_stat.c                          |   8 +-
 kernel/trace/trace_synth.h                         |   6 +-
 kernel/trace/trace_uprobe.c                        |  24 +-
 kernel/trace/tracing_map.c                         |   2 +-
 tools/bootconfig/main.c                            | 147 +++++---
 tools/bootconfig/scripts/bconf2ftrace.sh           | 199 ++++++++++
 tools/bootconfig/scripts/ftrace.sh                 | 109 ++++++
 tools/bootconfig/scripts/ftrace2bconf.sh           | 244 ++++++++++++
 tools/bootconfig/scripts/xbc.sh                    |  56 +++
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   6 +
 .../test.d/kprobe/kretprobe_return_suffix.tc       |  21 ++
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |   6 +
 .../trigger-inter-event-combined-hist.tc           |   8 +-
 .../trigger-synthetic-event-dynstring.tc           |  31 ++
 .../trigger-synthetic_event_syntax_errors.tc       |  19 +
 45 files changed, 1709 insertions(+), 335 deletions(-)
 create mode 100755 tools/bootconfig/scripts/bconf2ftrace.sh
 create mode 100644 tools/bootconfig/scripts/ftrace.sh
 create mode 100755 tools/bootconfig/scripts/ftrace2bconf.sh
 create mode 100644 tools/bootconfig/scripts/xbc.sh
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_return_suffix.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
---------------------------
