Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7968528E578
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389520AbgJNRhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:37:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389506AbgJNRha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:37:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 814B52222A;
        Wed, 14 Oct 2020 17:37:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kSkiO-002yEX-4f; Wed, 14 Oct 2020 13:37:28 -0400
Message-ID: <20201014173647.955053902@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 14 Oct 2020 13:36:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 00/12] tracing: Last minute updates before sending to Linus
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: d3c07fac565261101337b9535df072361297ea2d


Axel Rasmussen (1):
      tracing: support "bool" type in synthetic trace events

Gaurav Kohli (1):
      tracing: Fix race in trace_open and buffer resize call

Masami Hiramatsu (1):
      tracing/boot: Add ftrace.instance.*.alloc_snapshot option

Qiujun Huang (1):
      tracing: Fix some typos in comments

Steven Rostedt (VMware) (1):
      tracing: Check return value of __create_val_fields() before using its result

Tom Zanussi (7):
      tracing: Don't show dynamic string internals in synthetic event description
      tracing: Move is_good_name() from trace_probe.h to trace.h
      tracing: Check that the synthetic event and field names are legal
      tracing: Add synthetic event error logging
      selftests/ftrace: Change synthetic event name for inter-event-combined test
      tracing: Handle synthetic event array field type checking correctly
      selftests/ftrace: Add test case for synthetic event syntax errors

----
 kernel/trace/ring_buffer.c                         |  10 ++
 kernel/trace/trace.c                               |   4 +-
 kernel/trace/trace.h                               |  21 +++-
 kernel/trace/trace_boot.c                          |   6 +
 kernel/trace/trace_events_hist.c                   |   2 +-
 kernel/trace/trace_events_synth.c                  | 127 ++++++++++++++++++++-
 kernel/trace/trace_probe.h                         |  13 ---
 .../trigger-inter-event-combined-hist.tc           |   8 +-
 .../trigger-synthetic_event_syntax_errors.tc       |  19 +++
 9 files changed, 180 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
