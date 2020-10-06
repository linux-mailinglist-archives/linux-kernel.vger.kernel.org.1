Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D98B284E19
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgJFOfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:35:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgJFOfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:35:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09FD52137B;
        Tue,  6 Oct 2020 14:35:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kPo3c-002zGa-Ur; Tue, 06 Oct 2020 10:35:12 -0400
Message-ID: <20201006143512.835269003@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 06 Oct 2020 10:35:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [for-linus][PATCH 14/15] ftrace: ftrace_global_list is renamed to ftrace_ops_list
References: <20201006143446.182666356@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yang <richard.weiyang@linux.alibaba.com>

Fix the comment to comply with the code.

Link: https://lkml.kernel.org/r/20200831031104.23322-7-richard.weiyang@linux.alibaba.com

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index b1f56e3410dc..1bd3a0356ae4 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -217,11 +217,11 @@ extern struct ftrace_ops __rcu *ftrace_ops_list;
 extern struct ftrace_ops ftrace_list_end;
 
 /*
- * Traverse the ftrace_global_list, invoking all entries.  The reason that we
+ * Traverse the ftrace_ops_list, invoking all entries.  The reason that we
  * can use rcu_dereference_raw_check() is that elements removed from this list
  * are simply leaked, so there is no need to interact with a grace-period
  * mechanism.  The rcu_dereference_raw_check() calls are needed to handle
- * concurrent insertions into the ftrace_global_list.
+ * concurrent insertions into the ftrace_ops_list.
  *
  * Silly Alpha and silly pointer-speculation compiler optimizations!
  */
-- 
2.28.0


