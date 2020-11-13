Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377692B23D6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 19:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgKMSeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 13:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgKMSeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 13:34:22 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9E1C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 10:34:22 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o5so10153968ybe.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 10:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Ma/FLyxIvjreplT9fQ5iFnXJWoe0yO6ftI36C/AX86M=;
        b=AR2UmXa5MKCZByQKOF+LFv5YwI8iw7GGUcZK6izCCZoIgTXopt3HELQ0jO3d7WrXHr
         yZMZm8Bt/SzEh8+Aiw78Os/Q4jEcNqPdgfbnKPhgaSd0jOvUx/1BB20pJoprZ7S+z3t4
         R/lUjMyKN/WavE9w/XUPxNePRzPKBjchg0M/xvaWxwyw9eZNfMepGlKuvPksIafcaEux
         KkspWZz2p0tKCe373FQYnYJHuREB0genjQ32q2xT9VzflJKSGDjLVvUKNQzCDyNvDEgR
         N0IhE6b8xr5EgU95sFGWIVv2DJqVzmGs6/45By/2XZ3xWzAkvEk1yuHdZIxlQX8sj63T
         qpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Ma/FLyxIvjreplT9fQ5iFnXJWoe0yO6ftI36C/AX86M=;
        b=U1Srnrx21HGzvllnv3wg6HPzKK0Gbb2yenxNPqmgqbz9JUGZqWIkzDeLM4+k292mhp
         tp3lWvjunxhScygaUOe9qB8XjRfaRBoG9xVYdaIUaPQlHGtV3DwswzgFznXLk+jRTILH
         kQ34PETu0rxr+olAeqawrKbRYkHWERoO99AD5HDBqIZiA6MJYzml2724Nr42IkUfj9xV
         gU8BAgOCx01X/vMGn2Z8Sh9q/uP1H50UId+tUeIBHGuGNLQfkRNnbLEorfTemf5bpqAJ
         fRpE5SYHUdiLc12DzJcl0jhjU14ez7wuBChpvmaqmf2QFig8UwEwEO7yQ1OUuHd6xSwU
         tRmg==
X-Gm-Message-State: AOAM530Qi2GEAjnRIgOiyEQOHJnK8HyDp6ogZKFLpcIDhtyzAzki7dse
        F6gjBLA5RCFYVCHk6m4oAMYzJfoL0RJQw25wrow=
X-Google-Smtp-Source: ABdhPJwNK43V60um0tTTOX2SQAil+3ZXbinEBgQeJym4D6IT8+IRZ4dYSaBHbxvfHIFA4FmsyvqfTe3hA9CUjPfDmg4=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:b987:: with SMTP id
 r7mr5148706ybg.166.1605292461220; Fri, 13 Nov 2020 10:34:21 -0800 (PST)
Date:   Fri, 13 Nov 2020 10:34:14 -0800
Message-Id: <20201113183414.1446671-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH] samples/ftrace: mark my_tramp[12]? global
From:   Sami Tolvanen <samitolvanen@google.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

my_tramp[12]? are declared as global functions in C, but they are not
marked global in the inline assembly definition. This mismatch confuses
Clang's Control-Flow Integrity checking. Fix the definitions by adding
.globl.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
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

base-commit: 585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba
-- 
2.29.2.299.gdc1121823c-goog

