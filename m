Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8802F21B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbhAKVVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:21:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:44986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbhAKVVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:21:42 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59BC022CB2;
        Mon, 11 Jan 2021 21:21:01 +0000 (UTC)
Date:   Mon, 11 Jan 2021 16:20:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: [GIT PULL] tracing/kprobes: Do the notrace functions check without
 kprobes on ftrace
Message-ID: <20210111162059.28d4c91a@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu <mhiramat@kernel.org>

Linus,

Blacklist properly on all archs

The way to blacklist notrace functions for kprobes was not using
the proper kconfig which caused some archs (powerpc) from blacklisting
them.


Please pull the latest trace-v5.11-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.11-rc2

Tag SHA1: 9d83e1055c7a49abf656a3fe6ee390315a8f29da
Head SHA1: 7bb83f6fc4ee84e95d0ac0d14452c2619fb3fe70


Masami Hiramatsu (1):
      tracing/kprobes: Do the notrace functions check without kprobes on ftrace

----
 kernel/trace/Kconfig        | 2 +-
 kernel/trace/trace_kprobe.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---------------------------
commit 7bb83f6fc4ee84e95d0ac0d14452c2619fb3fe70
Author: Masami Hiramatsu <mhiramat@kernel.org>
Date:   Fri Jan 8 13:19:38 2021 +0900

    tracing/kprobes: Do the notrace functions check without kprobes on ftrace
    
    Enable the notrace function check on the architecture which doesn't
    support kprobes on ftrace but support dynamic ftrace. This notrace
    function check is not only for the kprobes on ftrace but also
    sw-breakpoint based kprobes.
    Thus there is no reason to limit this check for the arch which
    supports kprobes on ftrace.
    
    This also changes the dependency of Kconfig. Because kprobe event
    uses the function tracer's address list for identifying notrace
    function, if the CONFIG_DYNAMIC_FTRACE=n, it can not check whether
    the target function is notrace or not.
    
    Link: https://lkml.kernel.org/r/20210105065730.2634785-1-naveen.n.rao@linux.vnet.ibm.com
    Link: https://lkml.kernel.org/r/161007957862.114704.4512260007555399463.stgit@devnote2
    
    Cc: stable@vger.kernel.org
    Fixes: 45408c4f92506 ("tracing: kprobes: Prohibit probing on notrace function")
    Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
    Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index d5a19413d4f8..c1a62ae7e812 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -538,7 +538,7 @@ config KPROBE_EVENTS
 config KPROBE_EVENTS_ON_NOTRACE
 	bool "Do NOT protect notrace function from kprobe events"
 	depends on KPROBE_EVENTS
-	depends on KPROBES_ON_FTRACE
+	depends on DYNAMIC_FTRACE
 	default n
 	help
 	  This is only for the developers who want to debug ftrace itself
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 9c31f42245e9..e6fba1798771 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -434,7 +434,7 @@ static int disable_trace_kprobe(struct trace_event_call *call,
 	return 0;
 }
 
-#if defined(CONFIG_KPROBES_ON_FTRACE) && \
+#if defined(CONFIG_DYNAMIC_FTRACE) && \
 	!defined(CONFIG_KPROBE_EVENTS_ON_NOTRACE)
 static bool __within_notrace_func(unsigned long addr)
 {
