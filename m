Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3542273754
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbgIVA1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729217AbgIVA1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:27:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3EBB23A7B;
        Tue, 22 Sep 2020 00:27:00 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKW95-001rZj-Rb; Mon, 21 Sep 2020 20:26:59 -0400
Message-ID: <20200922002659.731360699@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 20:26:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [for-linus][PATCH 2/8] ftrace: Free the trampoline when ftrace_startup() fails
References: <20200922002620.231334654@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miroslav Benes <mbenes@suse.cz>

Commit fc0ea795f53c ("ftrace: Add symbols for ftrace trampolines")
missed to remove ops from new ftrace_ops_trampoline_list in
ftrace_startup() if ftrace_hash_ipmodify_enable() fails there. It may
lead to BUG if such ops come from a module which may be removed.

Moreover, the trampoline itself is not freed in this case.

Fix it by calling ftrace_trampoline_free() during the rollback.

Link: https://lkml.kernel.org/r/20200831122631.28057-1-mbenes@suse.cz

Fixes: fc0ea795f53c ("ftrace: Add symbols for ftrace trampolines")
Fixes: f8b8be8a310a ("ftrace, kprobes: Support IPMODIFY flag to find IP modify conflict")
Signed-off-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 275441254bb5..656d7cb5a78c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2862,6 +2862,8 @@ int ftrace_startup(struct ftrace_ops *ops, int command)
 		__unregister_ftrace_function(ops);
 		ftrace_start_up--;
 		ops->flags &= ~FTRACE_OPS_FL_ENABLED;
+		if (ops->flags & FTRACE_OPS_FL_DYNAMIC)
+			ftrace_trampoline_free(ops);
 		return ret;
 	}
 
-- 
2.28.0


