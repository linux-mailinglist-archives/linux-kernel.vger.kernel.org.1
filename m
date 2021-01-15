Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A24B2F70C6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 04:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732344AbhAOC6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 21:58:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:55384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732180AbhAOC6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 21:58:46 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E96E923AC6;
        Fri, 15 Jan 2021 02:58:04 +0000 (UTC)
Date:   Thu, 14 Jan 2021 21:58:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] tools/bootconfig: Add tracing_on support to helper
 scripts
Message-ID: <20210114215803.4f1eb972@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Update bootconf scripts for tracing_on option

The tracing_on option is supported by bootconfig entries, but the scripts to
convert from ftrace to a bootconfig and back were not updated.


Please pull the latest trace-v5.11-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.11-rc3

Tag SHA1: 8c1cb73311e09b57d1ff02116c56667ea7fca09a
Head SHA1: 55ed4560774d81d7343223b8fd2784c530a9c6c1


Masami Hiramatsu (1):
      tools/bootconfig: Add tracing_on support to helper scripts

----
 tools/bootconfig/scripts/bconf2ftrace.sh | 1 +
 tools/bootconfig/scripts/ftrace2bconf.sh | 4 ++++
 2 files changed, 5 insertions(+)
---------------------------
commit 55ed4560774d81d7343223b8fd2784c530a9c6c1
Author: Masami Hiramatsu <mhiramat@kernel.org>
Date:   Wed Dec 9 14:27:44 2020 +0900

    tools/bootconfig: Add tracing_on support to helper scripts
    
    Add ftrace.instance.INSTANCE.tracing_on support to ftrace2bconf.sh
    and bconf2ftrace.sh.
    
    commit 8490db06f914 ("tracing/boot: Add per-instance tracing_on
    option support") added the per-instance tracing_on option,
    but forgot to update the helper scripts.
    
    Link: https://lkml.kernel.org/r/160749166410.3497930.14204335886811029800.stgit@devnote2
    
    Cc: stable@vger.kernel.org
    Fixes: 8490db06f914 ("tracing/boot: Add per-instance tracing_on option support")
    Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

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
