Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EF4284E14
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgJFOfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgJFOfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:35:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8052120782;
        Tue,  6 Oct 2020 14:35:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kPo3c-002zF8-FO; Tue, 06 Oct 2020 10:35:12 -0400
Message-ID: <20201006143512.349327871@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 06 Oct 2020 10:34:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [for-linus][PATCH 11/15] ftrace: Simplify the dyn_ftrace->flags macro
References: <20201006143446.182666356@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yang <richard.weiyang@linux.alibaba.com>

All the three macro are defined to be used for ftrace_rec_count(). This
can be achieved by (flags & FTRACE_REF_MAX) directly.

Since no other places would use those macros, remove them for clarity.

Also it fixes a typo in the comment.

Link: https://lkml.kernel.org/r/20200831031104.23322-4-richard.weiyang@linux.alibaba.com

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index e5c2d5cc6e6a..b1f56e3410dc 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -432,7 +432,7 @@ bool is_ftrace_trampoline(unsigned long addr);
  *  DIRECT   - there is a direct function to call
  *
  * When a new ftrace_ops is registered and wants a function to save
- * pt_regs, the rec->flag REGS is set. When the function has been
+ * pt_regs, the rec->flags REGS is set. When the function has been
  * set up to save regs, the REG_EN flag is set. Once a function
  * starts saving regs it will do so until all ftrace_ops are removed
  * from tracing that function.
@@ -450,12 +450,9 @@ enum {
 };
 
 #define FTRACE_REF_MAX_SHIFT	23
-#define FTRACE_FL_BITS		9
-#define FTRACE_FL_MASKED_BITS	((1UL << FTRACE_FL_BITS) - 1)
-#define FTRACE_FL_MASK		(FTRACE_FL_MASKED_BITS << FTRACE_REF_MAX_SHIFT)
 #define FTRACE_REF_MAX		((1UL << FTRACE_REF_MAX_SHIFT) - 1)
 
-#define ftrace_rec_count(rec)	((rec)->flags & ~FTRACE_FL_MASK)
+#define ftrace_rec_count(rec)	((rec)->flags & FTRACE_REF_MAX)
 
 struct dyn_ftrace {
 	unsigned long		ip; /* address of mcount call-site */
-- 
2.28.0


