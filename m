Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5001B83DE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 07:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgDYFt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 01:49:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgDYFt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 01:49:29 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 180662098B;
        Sat, 25 Apr 2020 05:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587793769;
        bh=4r5CSvU+s72cUPpWeXl5tlXq2K72b9pI6RZJPtKhiJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wubMSlqOmZJ1zR4Fjf97ANO7mHgyEXb6StmI+RD9Ty2bzUUfQaoGlX0E+pEQKsnTr
         h1XymzVnRlnNWC2mMeVprnk+VD4V079OP8Culycn4LF9erqMLMqkwH5xktPUCw20tQ
         L/owFpRol6HoyzmgxbWAtdKzr1VMnVV+p6zuudo8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 3/3] tracing/kprobes: Reject new event if loc is NULL
Date:   Sat, 25 Apr 2020 14:49:26 +0900
Message-Id: <158779376597.6082.1411212055469099461.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158779373972.6082.16695832932765258919.stgit@devnote2>
References: <158779373972.6082.16695832932765258919.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reject the new event which has NULL location for kprobes.
For kprobes, user must specify at least the location.

Fixes: 2a588dd1d5d6 ("tracing: Add kprobe event command generation functions")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/trace/trace_kprobe.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 0d9300c3b084..35989383ae11 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -940,6 +940,9 @@ EXPORT_SYMBOL_GPL(kprobe_event_cmd_init);
  * complete command or only the first part of it; in the latter case,
  * kprobe_event_add_fields() can be used to add more fields following this.
  *
+ * Unlikely the synth_event_gen_cmd_start(), @loc must be specified. This
+ * returns -EINVAL if @loc == NULL.
+ *
  * Return: 0 if successful, error otherwise.
  */
 int __kprobe_event_gen_cmd_start(struct dynevent_cmd *cmd, bool kretprobe,
@@ -953,6 +956,9 @@ int __kprobe_event_gen_cmd_start(struct dynevent_cmd *cmd, bool kretprobe,
 	if (cmd->type != DYNEVENT_TYPE_KPROBE)
 		return -EINVAL;
 
+	if (!loc)
+		return -EINVAL;
+
 	if (kretprobe)
 		snprintf(buf, MAX_EVENT_NAME_LEN, "r:kprobes/%s", name);
 	else

