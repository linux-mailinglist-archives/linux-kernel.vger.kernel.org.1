Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC7228A3D4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389809AbgJJWzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731478AbgJJT1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:27:21 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F35F722370;
        Sat, 10 Oct 2020 15:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602343693;
        bh=Z3Ej4a7qHPar4eVGK2pzL8sYBK4axe/bt5/w4LxbGfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SbzevZFtHyNPvYjjDelg7q5HunVbJBMMSEFMRl+X/FC+o9+BTT01dE3lcGS4VrYnt
         epeizqqH9WZ3G/eFeVLkjvtv3ANA8+6Wocv1vgt0s2hq7uS087rv7Pyndt+nGDOSo5
         JE6ZfBxBG3wI4fXm+TOz9sbBXJu34e+hh76pKeGc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] tracing/boot: Add ftrace.instance.*.alloc_snapshot option
Date:   Sun, 11 Oct 2020 00:28:09 +0900
Message-Id: <160234368948.400560.15313384470765915015.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <160234368056.400560.6282640165007466754.stgit@devnote2>
References: <160234368056.400560.6282640165007466754.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ftrace.instance.*.alloc_snapshot option.

This option has been described in Documentation/trace/boottime-trace.rst
but not implemented yet.

ftrace.[instance.INSTANCE.]alloc_snapshot
   Allocate snapshot buffer.

The difference from kernel.alloc_snapshot is that the kernel.alloc_snapshot
will allocate the buffer only for the main instance, but this can allocate
buffer for any new instances.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_boot.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 754e3cf2df3a..c22a152ef0b4 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -284,6 +284,12 @@ trace_boot_enable_tracer(struct trace_array *tr, struct xbc_node *node)
 		if (tracing_set_tracer(tr, p) < 0)
 			pr_err("Failed to set given tracer: %s\n", p);
 	}
+
+	/* Since tracer can free snapshot buffer, allocate snapshot here.*/
+	if (xbc_node_find_value(node, "alloc_snapshot", NULL)) {
+		if (tracing_alloc_snapshot_instance(tr) < 0)
+			pr_err("Failed to allocate snapshot buffer\n");
+	}
 }
 
 static void __init

