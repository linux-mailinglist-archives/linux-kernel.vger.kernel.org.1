Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2822CDCC2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387718AbgLCRvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:51:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:46700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731330AbgLCRvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:51:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E832206F0;
        Thu,  3 Dec 2020 17:51:07 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kksl0-002qux-4m; Thu, 03 Dec 2020 12:51:06 -0500
Message-ID: <20201203175106.017683389@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Dec 2020 12:50:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [for-next][PATCH 2/3] ftrace/documentation: Fix RST C code blocks
References: <20201203175013.038902435@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Some C code in the ftrace-users.rst document is missing RST C block
annotation, which has to be added.

Link: https://lore.kernel.org/r/20201116173502.392a769c@canb.auug.org.au

Acked-by: Jonathan Corbet <corbet@lwn.net>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace-uses.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/trace/ftrace-uses.rst b/Documentation/trace/ftrace-uses.rst
index 5981d5691745..f7d98ae5b885 100644
--- a/Documentation/trace/ftrace-uses.rst
+++ b/Documentation/trace/ftrace-uses.rst
@@ -116,6 +116,8 @@ called by a callback may also be traced, and call that same callback,
 recursion protection must be used. There are two helper functions that
 can help in this regard. If you start your code with:
 
+.. code-block:: c
+
 	int bit;
 
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
@@ -124,6 +126,8 @@ can help in this regard. If you start your code with:
 
 and end it with:
 
+.. code-block:: c
+
 	ftrace_test_recursion_unlock(bit);
 
 The code in between will be safe to use, even if it ends up calling a
@@ -145,6 +149,8 @@ protection, it is best to make sure that RCU is "watching", otherwise
 that data or critical section will not be protected as expected. In this
 case add:
 
+.. code-block:: c
+
 	if (!rcu_is_watching())
 		return;
 
-- 
2.28.0


