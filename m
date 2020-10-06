Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E75D284E18
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgJFOfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgJFOfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:35:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 281512078E;
        Tue,  6 Oct 2020 14:35:12 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kPo3a-002z9e-LZ; Tue, 06 Oct 2020 10:35:10 -0400
Message-ID: <20201006143446.182666356@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 06 Oct 2020 10:34:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 00/15] tracing: Some final updates for 5.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 1a0b112ed1247152685996b4e0edf2af9844ece4


Qiujun Huang (1):
      ftrace: Fix some typos in comment

Steven Rostedt (VMware) (3):
      tracing: Change synthetic event string format to limit printed length
      ftrace: Simplify the hash calculation
      ftrace: Format variable declarations of ftrace_allocate_records

Sudip Mukherjee (1):
      tracing: Remove a pointless assignment

Tom Zanussi (6):
      tracing: Change STR_VAR_MAX_LEN
      tracing: Fix parse_synth_field() error handling
      tracing: Save normal string variables
      tracing: Add support for dynamic strings to synthetic events
      tracing: Add README information for synthetic_events file
      selftests/ftrace: Add test case for synthetic event dynamic strings

Wei Yang (4):
      ftrace: Use fls() to get the bits for dup_hash()
      ftrace: Simplify the dyn_ftrace->flags macro
      ftrace: Simplify the calculation of page number for ftrace_page->records
      ftrace: ftrace_global_list is renamed to ftrace_ops_list

----
 Documentation/trace/events.rst                     |  15 +-
 Documentation/trace/histogram.rst                  |  18 ++
 include/linux/ftrace.h                             |  11 +-
 kernel/trace/ftrace.c                              |  22 +-
 kernel/trace/synth_event_gen_test.c                |  18 +-
 kernel/trace/trace.c                               |   8 +-
 kernel/trace/trace_events_hist.c                   |  45 +++-
 kernel/trace/trace_events_synth.c                  | 256 ++++++++++++++++++---
 kernel/trace/trace_synth.h                         |   6 +-
 .../trigger-synthetic-event-dynstring.tc           |  31 +++
 10 files changed, 366 insertions(+), 64 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
