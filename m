Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F7827380B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbgIVB0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:26:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729553AbgIVBYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BC2023AA2;
        Tue, 22 Sep 2020 01:24:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX35-001sLh-MK; Mon, 21 Sep 2020 21:24:51 -0400
Message-ID: <20200922012451.579238353@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [for-next][PATCH 11/26] kprobes: Use module_name() macro
References: <20200922012414.115238201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

It is advised to use module_name() macro instead of dereferencing mod->name
directly. This makes sense for consistencys sake and also it prevents a
hard dependency to CONFIG_MODULES.

Link: https://lkml.kernel.org/r/20200818050857.117998-1-jarkko.sakkinen@linux.intel.com

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-mm@kvack.org
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index feca9b19cd74..f8e46929ceba 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -106,9 +106,10 @@ static nokprobe_inline bool trace_kprobe_has_gone(struct trace_kprobe *tk)
 static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
 						 struct module *mod)
 {
-	int len = strlen(mod->name);
+	int len = strlen(module_name(mod));
 	const char *name = trace_kprobe_symbol(tk);
-	return strncmp(mod->name, name, len) == 0 && name[len] == ':';
+
+	return strncmp(module_name(mod), name, len) == 0 && name[len] == ':';
 }
 
 static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
@@ -688,7 +689,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 			if (ret)
 				pr_warn("Failed to re-register probe %s on %s: %d\n",
 					trace_probe_name(&tk->tp),
-					mod->name, ret);
+					module_name(mod), ret);
 		}
 	}
 	mutex_unlock(&event_mutex);
-- 
2.28.0


