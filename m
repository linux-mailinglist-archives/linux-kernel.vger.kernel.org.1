Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92376273753
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgIVA1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729220AbgIVA1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:27:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE17523A9A;
        Tue, 22 Sep 2020 00:27:00 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKW95-001raD-W8; Mon, 21 Sep 2020 20:27:00 -0400
Message-ID: <20200922002659.875259952@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 20:26:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [for-linus][PATCH 3/8] ftrace: Fix missing synchronize_rcu() removing trampoline from
 kallsyms
References: <20200922002620.231334654@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add synchronize_rcu() after list_del_rcu() in
ftrace_remove_trampoline_from_kallsyms() to protect readers of
ftrace_ops_trampoline_list (in ftrace_get_trampoline_kallsym)
which is used when kallsyms is read.

Link: https://lkml.kernel.org/r/20200901091617.31837-1-adrian.hunter@intel.com

Fixes: fc0ea795f53c8d ("ftrace: Add symbols for ftrace trampolines")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 656d7cb5a78c..e9f893388245 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2782,6 +2782,7 @@ static void ftrace_remove_trampoline_from_kallsyms(struct ftrace_ops *ops)
 {
 	lockdep_assert_held(&ftrace_lock);
 	list_del_rcu(&ops->list);
+	synchronize_rcu();
 }
 
 /*
-- 
2.28.0


