Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C66A27375D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgIVA1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbgIVA1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:27:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C31C623A79;
        Tue, 22 Sep 2020 00:27:00 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKW95-001rYa-ID; Mon, 21 Sep 2020 20:26:59 -0400
Message-ID: <20200922002620.231334654@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 20:26:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/8] tracing: Fixes for 5.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: a27026e95b57acbb8df7182e020b099e7f3b5ac3


Adrian Hunter (1):
      ftrace: Fix missing synchronize_rcu() removing trampoline from kallsyms

Jason Yan (1):
      bootconfig: init: make xbc_namebuf static

Masami Hiramatsu (2):
      kprobes: Fix to check probe enabled before disarm_kprobe_ftrace()
      kprobes: tracing/kprobes: Fix to kill kprobes on initmem after boot

Miroslav Benes (1):
      ftrace: Free the trampoline when ftrace_startup() fails

Sebastian Andrzej Siewior (1):
      tracing: Make the space reserved for the pid wider

Tobias Klauser (1):
      ftrace: Let ftrace_enable_sysctl take a kernel pointer buffer

Tom Rix (1):
      tracing: fix double free

----
 include/linux/ftrace.h           |  3 +--
 include/linux/kprobes.h          |  5 +++++
 init/main.c                      |  4 +++-
 kernel/kprobes.c                 | 27 +++++++++++++++++++++++++--
 kernel/trace/ftrace.c            |  6 ++++--
 kernel/trace/trace.c             | 38 +++++++++++++++++++-------------------
 kernel/trace/trace_events_hist.c |  1 -
 kernel/trace/trace_output.c      | 12 ++++++------
 8 files changed, 63 insertions(+), 33 deletions(-)
