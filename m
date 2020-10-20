Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FA728CDA2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgJMMBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbgJMLym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:42 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ED7F2227F;
        Tue, 13 Oct 2020 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590080;
        bh=ANwSfHlYycUaZxzUwSyDQzW5wFbqluFd7ZfalvckhQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dAvaiRBoscStIgvpVMBHjV95O1w2/By3kPHHQXi/YIEYOJiwsh7mKexOSt7yPCiGJ
         FaHKvSAje0cvnzowi7EODboldDn91A7aaap8zFCG1qODh3Qe2atbD6pXE7VSvEv2Dv
         aAZL0yEBpwdGq0rXdsWD5Z4Q7EWFd9rrgIXQ10rE=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt4-006CUG-AA; Tue, 13 Oct 2020 13:54:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 24/80] docs: trace-uses.rst: remove bogus c-domain tags
Date:   Tue, 13 Oct 2020 13:53:39 +0200
Message-Id: <e1d48df962ef794f274b921c0c912176a01d533d.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some c-domain tags that are wrong. While this won't
cause problems with Sphinx < 3.0, this cause troubles with
newer versions, as the C parser won't recognize the contents
of the tag, and will drop it from the output.

Let's just place them at literal blocks.

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/trace/ftrace-uses.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/trace/ftrace-uses.rst b/Documentation/trace/ftrace-uses.rst
index 2a05e770618a..a4955f7e3d19 100644
--- a/Documentation/trace/ftrace-uses.rst
+++ b/Documentation/trace/ftrace-uses.rst
@@ -55,17 +55,17 @@ an ftrace_ops with ftrace:
 
 Both .flags and .private are optional. Only .func is required.
 
-To enable tracing call:
+To enable tracing call::
 
-.. c:function::  register_ftrace_function(&ops);
+    register_ftrace_function(&ops);
 
-To disable tracing call:
+To disable tracing call::
 
-.. c:function::  unregister_ftrace_function(&ops);
+    unregister_ftrace_function(&ops);
 
-The above is defined by including the header:
+The above is defined by including the header::
 
-.. c:function:: #include <linux/ftrace.h>
+    #include <linux/ftrace.h>
 
 The registered callback will start being called some time after the
 register_ftrace_function() is called and before it returns. The exact time
-- 
2.26.2

