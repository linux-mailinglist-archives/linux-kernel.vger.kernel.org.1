Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A882EEC5A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 05:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbhAHEUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 23:20:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbhAHEUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 23:20:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57FAD207A8;
        Fri,  8 Jan 2021 04:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610079582;
        bh=Eqg0B6FysIAYFiLN2zSH3ZM3MPe4wwlksK7heO64dro=;
        h=From:To:Cc:Subject:Date:From;
        b=YyDQVNjuFODVcNsSrwURVY1QiqLQSJyVYmzAWK0jFGH40IAO/hJJ3wHUPDeQapWB0
         dXKBhTrj7P26c0+PhIQEzlTQoe36i+25/N5+fEB7S5pRYDvtmZdBzQiCPbgKMgBcft
         Br4fm0fm9rrUH1tKPxT99uWiPmDR4jLeibKWr5MymlVD6vL9sxCX3C1zIOwe5c7g/M
         BJX3f6QkD3Mn1Iu2VnbXMkL1Ud9vVx6D8Wd3JH/+mvTHG7sVAfZjz15K3egz+MsDRO
         /NrQYh3+EUVD1yrIgrO55x16y8xaSYEbQl6iZgVZ9EbrLS52Re5Tf7J5LVlznTe1D8
         ULwQ0TTVo24oA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: [PATCH v2] tracing/kprobes: Do the notrace functions check without kprobes on ftrace
Date:   Fri,  8 Jan 2021 13:19:38 +0900
Message-Id: <161007957862.114704.4512260007555399463.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 Changes in v2:
  - Depends on CONFIG_DYNAMIC_FTRACE instead of CONFIG_FUNCTION_TRACER
---
 kernel/trace/Kconfig        |    2 +-
 kernel/trace/trace_kprobe.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index fe60f9d7a0e6..18da5e8e28fb 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -540,7 +540,7 @@ config KPROBE_EVENTS
 config KPROBE_EVENTS_ON_NOTRACE
 	bool "Do NOT protect notrace function from kprobe events"
 	depends on KPROBE_EVENTS
-	depends on KPROBES_ON_FTRACE
+	depends on DYNAMIC_FTRACE
 	default n
 	help
 	  This is only for the developers who want to debug ftrace itself
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index b29f92c51b1a..5fff39541b8a 100644
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

