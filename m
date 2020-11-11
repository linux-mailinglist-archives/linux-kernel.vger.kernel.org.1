Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B982AFA0F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 21:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgKKUx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 15:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgKKUx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 15:53:57 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80237C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 12:53:57 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id z21so5062732lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 12:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yNPB2jlKFvbSRV6c6XL32c51PGoINUdAsOUeABtQLYU=;
        b=j36qxogbv4rKYU+qQ7B3RtrEPZmO7bO/cAnuJgeFFGRp0zL/tzacpUKbHUfmOHq5qB
         evZCzvdnBnPAbjNM7xgwttjVSu664a7dPe5TJ5VI1fuSUH2JiPfuqtriIStxpvD1l11T
         /eEA898f1v1YtttWCQmb5Ge79bs+MH3HIUyAnOgUv7/0TpYz3q8GoJXxv+1vfUpxE3OS
         lKQFT4OzukreB12ElUoDTFQlUTSA5KzrlOHJt2XjKoJ7Zg/CxsC8qwqVa/wFdnoiXi6w
         XIzdWuI3dJOOZYRlu9p0KEnZUQRPjPrBjUxz/bwFDc7KJjDwp6eKJ/IWwruIWMY7ctzf
         FL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yNPB2jlKFvbSRV6c6XL32c51PGoINUdAsOUeABtQLYU=;
        b=CKSx8xP0JcufoFxDQs7m0PpLLGYFc0uMnOGyfEwBJ4uxIFGJiFlUbLgziIdA0nAr99
         zdW6Wt7hL8n6LdK2lnEmrV38dEZfa3QxMGYIDiVazJGq+JkQfznjUdRBjm7TBmTTWLdp
         AIl3j4QITbYy8R4wDF7+eN7qB1SQJxUNNEXvHV4vbd3qHReFzFSVi7uA7s6+l8w0vqcU
         bxidzmb2LtAC6SoR3N3fk7aUUU8NLXRl0G9x81uPAAFjWFZTReiUUdx3JD7aqPwV9N2k
         +LmjH0RZKXpScrX3RCXqBOb9O9vNNfkxhTswRwR04syo/lT4X0K2N/40tiXoCRZRqGHC
         d88A==
X-Gm-Message-State: AOAM530tvFWwV1pNev4HV690GcAcdv3mAv6WrFv533GziQIlK9+IsrBM
        9/kBQmk5wLrya0CL2gGSi5c=
X-Google-Smtp-Source: ABdhPJzCo5sUp8St6IlY2ddwi9lEZX/ozXN8Ulor0n283l+kkysMgfoIagpqOQzT9oUsy+auBehyKA==
X-Received: by 2002:a19:615:: with SMTP id 21mr8938864lfg.99.1605128036069;
        Wed, 11 Nov 2020 12:53:56 -0800 (PST)
Received: from octofox.metropolis ([5.19.183.212])
        by smtp.gmail.com with ESMTPSA id x6sm325457lfn.185.2020.11.11.12.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:53:55 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] xtensa: fix broken TIF_NOTIFY_SIGNAL assembly
Date:   Wed, 11 Nov 2020 12:53:49 -0800
Message-Id: <20201111205349.24815-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TIF_NOTIFY_SIGNAL handling in xtensa assembly is implemented
incorrectly: there should be a call to do_notify_resume when either
TIF_SIGPENDING, TIF_NOTIFY_RESUME or TIF_NOTIFY_SIGNAL bit is set in the
thread_info::flags. The straightforward way to do it would be

    _bbsi.l a4, TIF_NEED_RESCHED, 3f
    _bbsi.l a4, TIF_NOTIFY_RESUME, 2f
    _bbsi.l a4, TIF_NOTIFY_SIGNAL, 2f
    _bbci.l a4, TIF_SIGPENDING, 5f

Optimize it a little bit and use bit mask and bnone opcode to skip
do_notify_resume invocation. Shuffle _TIF_* flags a bit so that used bit
mask fits into the immediate field of movi opcode.

Fixes: 4c6a9dcd4d13 ("xtensa: add support for TIF_NOTIFY_SIGNAL")
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- use more canonical order of bnone arguments: tested value first,
  bit mask second.

 arch/xtensa/include/asm/thread_info.h | 7 ++++---
 arch/xtensa/kernel/entry.S            | 5 ++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/xtensa/include/asm/thread_info.h b/arch/xtensa/include/asm/thread_info.h
index 6ea521b8e2ec..a312333a9add 100644
--- a/arch/xtensa/include/asm/thread_info.h
+++ b/arch/xtensa/include/asm/thread_info.h
@@ -111,22 +111,23 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
 #define TIF_SINGLESTEP		3	/* restore singlestep on return to user mode */
 #define TIF_SYSCALL_TRACEPOINT	4	/* syscall tracepoint instrumentation */
-#define TIF_MEMDIE		5	/* is terminating due to OOM killer */
+#define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
 #define TIF_RESTORE_SIGMASK	6	/* restore signal mask in do_signal() */
 #define TIF_NOTIFY_RESUME	7	/* callback before returning to user */
 #define TIF_DB_DISABLED		8	/* debug trap disabled for syscall */
 #define TIF_SYSCALL_AUDIT	9	/* syscall auditing active */
 #define TIF_SECCOMP		10	/* secure computing */
-#define TIF_NOTIFY_SIGNAL	11	/* signal notifications exist */
+#define TIF_MEMDIE		11	/* is terminating due to OOM killer */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
+#define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
+#define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
-#define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
 
 #define _TIF_WORK_MASK		(_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP | \
 				 _TIF_SYSCALL_TRACEPOINT | \
diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 7f733f40fef0..647b162f959b 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -500,9 +500,8 @@ common_exception_return:
 	 */
 
 	_bbsi.l	a4, TIF_NEED_RESCHED, 3f
-	_bbsi.l	a4, TIF_NOTIFY_RESUME, 2f
-	_bbci.l	a4, TIF_SIGPENDING, 5f
-	_bbci.l	a4, TIF_NOTIFY_SIGNAL, 5f
+	movi	a2, _TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NOTIFY_SIGNAL
+	bnone	a4, a2, 5f
 
 2:	l32i	a4, a1, PT_DEPC
 	bgeui	a4, VALID_DOUBLE_EXCEPTION_ADDRESS, 4f
-- 
2.20.1

