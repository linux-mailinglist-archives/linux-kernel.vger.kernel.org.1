Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642E82D3A74
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 06:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgLIF22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 00:28:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgLIF22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 00:28:28 -0500
From:   Masami Hiramatsu <mhiramat@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools/bootconfig: Add tracing_on support to helper scripts
Date:   Wed,  9 Dec 2020 14:27:44 +0900
Message-Id: <160749166410.3497930.14204335886811029800.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ftrace.instance.INSTANCE.tracing_on support to ftrace2bconf.sh
and bconf2ftrace.sh.

commit 8490db06f914 ("tracing/boot: Add per-instance tracing_on
option support") added the per-instance tracing_on option,
but forgot to update the helper scripts.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/scripts/bconf2ftrace.sh |    1 +
 tools/bootconfig/scripts/ftrace2bconf.sh |    4 ++++
 2 files changed, 5 insertions(+)

diff --git a/tools/bootconfig/scripts/bconf2ftrace.sh b/tools/bootconfig/scripts/bconf2ftrace.sh
index 595e164dc352..feb30c2c7881 100755
--- a/tools/bootconfig/scripts/bconf2ftrace.sh
+++ b/tools/bootconfig/scripts/bconf2ftrace.sh
@@ -152,6 +152,7 @@ setup_instance() { # [instance]
 	set_array_of ${instance}.options ${instancedir}/trace_options
 	set_value_of ${instance}.trace_clock ${instancedir}/trace_clock
 	set_value_of ${instance}.cpumask ${instancedir}/tracing_cpumask
+	set_value_of ${instance}.tracing_on ${instancedir}/tracing_on
 	set_value_of ${instance}.tracer ${instancedir}/current_tracer
 	set_array_of ${instance}.ftrace.filters \
 		${instancedir}/set_ftrace_filter
diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index 6c0d4b61e0c2..a0c3bcc6da4f 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -221,6 +221,10 @@ instance_options() { # [instance-name]
 	if [ `echo $val | sed -e s/f//g`x != x ]; then
 		emit_kv $PREFIX.cpumask = $val
 	fi
+	val=`cat $INSTANCE/tracing_on`
+	if [ `echo $val | sed -e s/f//g`x != x ]; then
+		emit_kv $PREFIX.tracing_on = $val
+	fi
 
 	val=
 	for i in `cat $INSTANCE/set_event`; do

