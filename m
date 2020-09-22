Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C146D273806
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgIVBYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:24:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729471AbgIVBYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C83923A79;
        Tue, 22 Sep 2020 01:24:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX33-001sGC-UD; Mon, 21 Sep 2020 21:24:49 -0400
Message-ID: <20200922012414.115238201@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/26] tracing: Updates for 5.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: fd264ce96c382bc2e36eb1f49ac45c5980650244


Dan Carpenter (1):
      tracing: remove a pointless assignment

Davidlohr Bueso (1):
      fgraph: Convert ret_stack tasklist scanning to rcu

Jarkko Sakkinen (1):
      kprobes: Use module_name() macro

Masami Hiramatsu (19):
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

Randy Dunlap (1):
      tracing: Delete repeated words in comments

Wei Yang (2):
      tracing: toplevel d_entry already initialized
      tracing: make tracing_init_dentry() returns an integer instead of a d_entry pointer

Xianting Tian (1):
      tracing: Use __this_cpu_read() in trace_buffered_event_enable()

----
 Documentation/trace/boottime-trace.rst             |  38 ++++
 Documentation/trace/kprobetrace.rst                |   2 +
 Documentation/trace/uprobetracer.rst               |   2 +
 MAINTAINERS                                        |   1 +
 kernel/kprobes.c                                   |   2 +-
 kernel/trace/fgraph.c                              |   8 +-
 kernel/trace/ftrace.c                              |   2 +-
 kernel/trace/trace.c                               |  98 ++++++---
 kernel/trace/trace.h                               |   9 +-
 kernel/trace/trace_boot.c                          |  17 +-
 kernel/trace/trace_dynevent.c                      |  10 +-
 kernel/trace/trace_events.c                        | 110 ++++++----
 kernel/trace/trace_events_synth.c                  |  30 ++-
 kernel/trace/trace_functions.c                     |  22 +-
 kernel/trace/trace_functions_graph.c               |   8 +-
 kernel/trace/trace_hwlat.c                         |   8 +-
 kernel/trace/trace_kprobe.c                        |  41 +++-
 kernel/trace/trace_printk.c                        |   8 +-
 kernel/trace/trace_probe.h                         |   1 +
 kernel/trace/trace_stack.c                         |  12 +-
 kernel/trace/trace_stat.c                          |   8 +-
 kernel/trace/trace_uprobe.c                        |  24 +-
 kernel/trace/tracing_map.c                         |   2 +-
 tools/bootconfig/main.c                            | 147 +++++++++----
 tools/bootconfig/scripts/bconf2ftrace.sh           | 199 +++++++++++++++++
 tools/bootconfig/scripts/ftrace.sh                 | 109 +++++++++
 tools/bootconfig/scripts/ftrace2bconf.sh           | 244 +++++++++++++++++++++
 tools/bootconfig/scripts/xbc.sh                    |  56 +++++
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   6 +
 .../test.d/kprobe/kretprobe_return_suffix.tc       |  21 ++
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |   6 +
 31 files changed, 1055 insertions(+), 196 deletions(-)
 create mode 100755 tools/bootconfig/scripts/bconf2ftrace.sh
 create mode 100644 tools/bootconfig/scripts/ftrace.sh
 create mode 100755 tools/bootconfig/scripts/ftrace2bconf.sh
 create mode 100644 tools/bootconfig/scripts/xbc.sh
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_return_suffix.tc
