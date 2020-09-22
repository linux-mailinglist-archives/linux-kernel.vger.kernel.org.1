Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257932737EB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgIVBZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729603AbgIVBYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB37123B16;
        Tue, 22 Sep 2020 01:24:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX37-001sSy-Ua; Mon, 21 Sep 2020 21:24:53 -0400
Message-ID: <20200922012453.807317415@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 26/26] Documentation: tracing: Add the startup timing of boot-time tracing
References: <20200922012414.115238201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add the note about when to start the boot-time tracing.
This will be needed for the people who wants to trace
earlier boot sequence.

Link: https://lkml.kernel.org/r/159974156678.478751.10215894815285734481.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/boottime-trace.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
index ab3bfd67197c..89b64334929b 100644
--- a/Documentation/trace/boottime-trace.rst
+++ b/Documentation/trace/boottime-trace.rst
@@ -120,6 +120,20 @@ instance node, but those are also visible from other instances. So please
 take care for event name conflict.
 
 
+When to Start
+=============
+
+All boot-time tracing options starting with ``ftrace`` will be enabled at the
+end of core_initcall. This means you can trace the events from postcore_initcall.
+Most of the subsystems and architecture dependent drivers will be initialized
+after that (arch_initcall or subsys_initcall). Thus, you can trace those with
+boot-time tracing.
+If you want to trace events before core_initcall, you can use the options
+starting with ``kernel``. Some of them will be enabled eariler than the initcall
+processing (for example,. ``kernel.ftrace=function`` and ``kernel.trace_event``
+will start before the initcall.)
+
+
 Examples
 ========
 
-- 
2.28.0


