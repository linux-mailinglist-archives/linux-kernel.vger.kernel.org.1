Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502022AFA02
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 21:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgKKUrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 15:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKKUrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 15:47:33 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34F5C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 12:47:32 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id o24so3604135ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 12:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kqXzWPcn/O/4CLOVfdqt2sWTguSFm5QeKMfYExO6Es0=;
        b=GECEhQ1mi8lg9CRGuy+xJpcNXzJmDeYnBwiiuNZcN/mWFilVjdYlB4F6LhtZH6pmJH
         1HnZyC2Z38vrnyUbjp3jPnWI0nniDsCjZdFRR9ifF2M56scO9VW29NOZhvo6lecArxYI
         /80OM61hLATiEA267w/X7ja34tNhn/NKroYZw2b8SzT9MEsMUzWWQb/YmlnbHGIh+VSZ
         eyebZ+6STGqx4mNKzix1cFBKfMaTZEga7XIVgGCI4mhU6XirWI8lupsdgD1ZmAnHAdPW
         my9XLIlpspU+61ocMhnKv/s9TD4vRUqbWeYTG0gqqe+1rIgTP0u6qQGUTo2LD73oOE3i
         MozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kqXzWPcn/O/4CLOVfdqt2sWTguSFm5QeKMfYExO6Es0=;
        b=kFLL7x5m7ZUbhbRp013qpE/VDFhxOLjHjGHZAI104dtm+yMl1xdDHBK28Xhf0yY924
         ankfS86Aqlm9vhE6sdQxxjMNcfAuGrwy9UTH4VZT8NxeAKT979Ml3W/ivjcSO+fsKi86
         Qlu7V4YCspU5FUQXIp2AAbKA+a/UXJiAAxpQf/xGA+6RgQAARF8HVUPpIz1foXMEfskp
         cfTure08OV+nZwyMbV94Hh00DtAMHJeZghnR6BsBuw4pps/B0nKjnCuuEEo5oGk9+AlJ
         ITYMWP7euGaur1tEjctd7LT6syyfXekKf6uKzVNHJ0fLDHqV1bGxfzRwQyhBY9/pv4Wf
         ztng==
X-Gm-Message-State: AOAM532uXa7cGP6toIz3Jaq9gS4mLqTbXMel4dLbnxn6VB3yF4KkGZ/o
        euzsDEB9AyTJpL7rtK9uWDDyRmy5Hdl6KQ==
X-Google-Smtp-Source: ABdhPJwqT2b3RDMdIpLUc62Fp4ganTpJzm6XRy/RIgwv2RAwlcc7NslxV3tIBd3qngHgRaGEn9nR2g==
X-Received: by 2002:a2e:8845:: with SMTP id z5mr10793727ljj.281.1605127651376;
        Wed, 11 Nov 2020 12:47:31 -0800 (PST)
Received: from octofox.metropolis ([5.19.183.212])
        by smtp.gmail.com with ESMTPSA id f1sm330971ljp.65.2020.11.11.12.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:47:30 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] xtensa: fix broken TIF_NOTIFY_SIGNAL assembly
Date:   Wed, 11 Nov 2020 12:47:23 -0800
Message-Id: <20201111204723.21634-1-jcmvbkbc@gmail.com>
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
index 7f733f40fef0..a367c464217d 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -500,9 +500,8 @@ common_exception_return:
 	 */
 
 	_bbsi.l	a4, TIF_NEED_RESCHED, 3f
-	_bbsi.l	a4, TIF_NOTIFY_RESUME, 2f
-	_bbci.l	a4, TIF_SIGPENDING, 5f
-	_bbci.l	a4, TIF_NOTIFY_SIGNAL, 5f
+	movi	a2, _TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NOTIFY_SIGNAL
+	bnone	a2, a4, 5f
 
 2:	l32i	a4, a1, PT_DEPC
 	bgeui	a4, VALID_DOUBLE_EXCEPTION_ADDRESS, 4f
-- 
2.20.1

