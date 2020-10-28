Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E68729DEE2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403802AbgJ2A5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:57:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731610AbgJ1WRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7060224742;
        Wed, 28 Oct 2020 13:19:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kXlM5-005a6P-Mv; Wed, 28 Oct 2020 09:19:09 -0400
Message-ID: <20201028131542.963014814@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 28 Oct 2020 09:15:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RFC][PATCH 0/2] ftrace: Add access to function arguments for all callbacks
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is something I wanted to implement a long time ago, but held off until
there was a good reason to do so. Now it appears that having access to the
arguments of the function by default is very useful. As a bonus, because
arguments must be saved regardless before calling a callback, because they
need to be restored before returning back to the start of the traced
function, there's not much work to do to have them always be there for
normal function callbacks.

The basic idea is that if CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS is set, then
all callbacks registered to ftrace can use the regs parameter for the stack
and arguments (kernel_stack_pointer(regs), regs_get_kernel_argument(regs, n)),
without the need to set REGS that causes overhead by saving all registers as
REGS simulates a breakpoint.

Only the first patch is to be applied. The second patch is just to show how
this could work.

Steven Rostedt (VMware) (2):
      ftrace/x86: Allow for arguments to be passed in to REGS by default
      ftrace: Test arguments by adding trace_printk in function tracer

----
 arch/x86/Kconfig               |  1 +
 arch/x86/kernel/ftrace_64.S    | 12 +++++++-----
 kernel/trace/Kconfig           |  9 +++++++++
 kernel/trace/trace_functions.c | 13 ++++++++++++-
 4 files changed, 29 insertions(+), 6 deletions(-)
