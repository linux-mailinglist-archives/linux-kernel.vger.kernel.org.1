Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A432CA7AC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392008AbgLAQBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:01:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389229AbgLAQB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:01:28 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B2F02224C;
        Tue,  1 Dec 2020 16:00:07 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kk84U-002R7S-5t; Tue, 01 Dec 2020 11:00:06 -0500
Message-ID: <20201201160006.071790742@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 01 Dec 2020 10:58:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [for-linus][PATCH 07/12] samples/ftrace: Mark my_tramp[12]? global
References: <20201201155835.647858317@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sami Tolvanen <samitolvanen@google.com>

my_tramp[12]? are declared as global functions in C, but they are not
marked global in the inline assembly definition. This mismatch confuses
Clang's Control-Flow Integrity checking. Fix the definitions by adding
.globl.

Link: https://lkml.kernel.org/r/20201113183414.1446671-1-samitolvanen@google.com

Fixes: 9d907f1ae80b8 ("ftrace/samples: Add a sample module that implements modify_ftrace_direct()")
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 samples/ftrace/ftrace-direct-modify.c | 2 ++
 samples/ftrace/ftrace-direct-too.c    | 1 +
 samples/ftrace/ftrace-direct.c        | 1 +
 3 files changed, 4 insertions(+)

diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index c13a5bc5095b..5b9a09957c6e 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -21,6 +21,7 @@ static unsigned long my_ip = (unsigned long)schedule;
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
 "   my_tramp1:"
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
@@ -29,6 +30,7 @@ asm (
 "	.size		my_tramp1, .-my_tramp1\n"
 "	ret\n"
 "	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
 "   my_tramp2:"
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index d5c5022be664..3f0079c9bd6f 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -16,6 +16,7 @@ extern void my_tramp(void *);
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
 "   my_tramp:"
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 63ca06d42c80..a2729d1ef17f 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -14,6 +14,7 @@ extern void my_tramp(void *);
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
 "   my_tramp:"
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
-- 
2.28.0


