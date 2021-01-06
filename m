Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADC22EB866
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 04:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbhAFDVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 22:21:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbhAFDVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 22:21:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B3E422D01;
        Wed,  6 Jan 2021 03:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609903243;
        bh=5d5qUEyCc2AGrp6ZcUYBmbmTN9GQRSG6k9HOKJrjqUQ=;
        h=From:To:Cc:Subject:Date:From;
        b=OcwATME0AodyAX8uJNQGgPZdaQ7aovS4ULW4QPBAzxJS8n3E9UYnYPCOZTXGrApW+
         eutihtP+23XQtTYXySGi6NjfnJUeFMbVWmApPerUMpyhcs8KYeWkLFPxsTjtAoC9Fr
         yKaTw1QBQMdHq0twjypbIPn75djOR/aaRGDlmU3sE1mn6U/ZOFoDA/yeTd69k1mEon
         uVt5mSZyYeARMgPN2L2E60bQ5k3ekNTd+OUGoJuWxrSJL0plsmFerNCDz1ZJTEIQff
         FCcRrGAyMUjYVeT6JVJZuJmb+LkIWz+eYcbnuDI3rtjAQCbiGFlF+XfIos0S/rjhLg
         kAXSLjszit/bQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: [PATCH] tracing/kprobes: Do the notrace functions check without kprobes on ftrace
Date:   Wed,  6 Jan 2021 12:20:40 +0900
Message-Id: <160990323982.16047.9136060149082849917.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the notrace function check on the architecture which doesn't
support kprobes on ftrace. This notrace function check is not only
for the kprobes on ftrace but also sw-breakpoint based kprobes.
Thus there is no reason to limit this check for the arch which
supports kprobes on ftrace.

This also changes the dependency of Kconfig. Because kprobe event
uses the function tracer's address list for identifying notrace
function, if the CONFIG_FUNCTION_TRACER=n, it can not check whether
the target function is notrace or not.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 kernel/trace/Kconfig        |    2 +-
 kernel/trace/trace_kprobe.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index fe60f9d7a0e6..d19cf2070033 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -540,7 +540,7 @@ config KPROBE_EVENTS
 config KPROBE_EVENTS_ON_NOTRACE
 	bool "Do NOT protect notrace function from kprobe events"
 	depends on KPROBE_EVENTS
-	depends on KPROBES_ON_FTRACE
+	depends on FUNCTION_TRACER
 	default n
 	help
 	  This is only for the developers who want to debug ftrace itself
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index b29f92c51b1a..280b7e318f18 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -434,7 +434,7 @@ static int disable_trace_kprobe(struct trace_event_call *call,
 	return 0;
 }
 
-#if defined(CONFIG_KPROBES_ON_FTRACE) && \
+#if defined(CONFIG_FUNCTION_TRACER) && \
 	!defined(CONFIG_KPROBE_EVENTS_ON_NOTRACE)
 static bool __within_notrace_func(unsigned long addr)
 {

