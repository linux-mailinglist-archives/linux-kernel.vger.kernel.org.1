Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBF829F10E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgJ2QRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgJ2QRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:17:43 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F81C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:17:43 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k21so4090620ioa.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=SKr9MH9Bstlx9LkJz9i8rsRThHUJA55SREyc/qzxyy0=;
        b=sMAfBbdzxrXiWDThLEEdmcvolx8Jb/8oFyJyK8kMpPRwXDfeFWii7xVOS77FrfTDGW
         ZQRnz2yBWIYkTcZRdifGzWzNHp9tInxdJnsTVu5KOgUUZIxqK04I5Ex5gEQHV3kooHXs
         DAVXWwXCmNS6+S0S3ZBWYy/jiYODcQ7iCn6SJ8x+RvaQlwc7XUxwAbzHCEQ5QrCqi5rq
         e1gxob4XAHbCbk8tbbwW4G0bbAhs+IQumED2uMIocFGG3FZg4sKOU5piZALsf7TTeXwM
         KvrCeBSQ98DSnPYgjEgAw+cXiq4oaZwFv1Ryunhzk7SUVRBSl1whnwnzsoCXMDiD6E9P
         iPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=SKr9MH9Bstlx9LkJz9i8rsRThHUJA55SREyc/qzxyy0=;
        b=W3jLARMRNUd/MbpCnT2ZkxWbPMTCFlPqxYdTLG4e9nyyL29LrbO4xwQXuBXfk+kjEz
         Se+fjupTQ1Ei5HKlqnB7qKo5kmeAXfft4DOgTncVkFZ5QqEFWZijkihWq7KJC1uqk5NT
         neb/O/JTy9/TJUbxu458Cqd5ZJ4u6NL5GUP3+OZ3ymEFGmgQeF9APfi13c0CEcWaSvyZ
         pQgz61joATGspZMzQUAZpLEuG1C26spMhDlIcrsoerE5geFnuJUUZeE9MtXn07JUW/1x
         m2fpN9piMKY28T2cGC42XntQtWWMh8gpTRuJduKY9CXeq+ZnYMjFbsK81qWXe1trTsjE
         ne7w==
X-Gm-Message-State: AOAM533claY3/UH6dTApLtQKMJsz1JA0zuYcvQu49laQ7mOt26Higs2k
        4LcR38Bd2poZqaf20FyWsBDwu8vkoBrVeA==
X-Google-Smtp-Source: ABdhPJyQK1+WWeuTnVKKw25HkRY2vD9hDczZ4LWFahRDan5+BWAjH3Uj3aaykZMTAzLTPJwm3SheEg==
X-Received: by 2002:a6b:e613:: with SMTP id g19mr3160758ioh.17.1603988262344;
        Thu, 29 Oct 2020 09:17:42 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p6sm3083181ilc.26.2020.10.29.09.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 09:17:41 -0700 (PDT)
To:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] nds32: add support for TIF_NOTIFY_SIGNAL
Message-ID: <4b195c6d-405d-cad8-f036-1bfc5876d528@kernel.dk>
Date:   Thu, 29 Oct 2020 10:17:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up TIF_NOTIFY_SIGNAL handling for nds32.

Cc: Nick Hu <nickhu@andestech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---

5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
for details:

https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.dk/

As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
as that will enable a set of cleanups once all of them support it. I'm
happy carrying this patch if need be, or it can be funelled through the
arch tree. Let me know.

 arch/nds32/include/asm/thread_info.h | 2 ++
 arch/nds32/kernel/ex-exit.S          | 2 +-
 arch/nds32/kernel/signal.c           | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/nds32/include/asm/thread_info.h b/arch/nds32/include/asm/thread_info.h
index c135111ec44e..d3967ad184f0 100644
--- a/arch/nds32/include/asm/thread_info.h
+++ b/arch/nds32/include/asm/thread_info.h
@@ -48,6 +48,7 @@ struct thread_info {
 #define TIF_NEED_RESCHED	2
 #define TIF_SINGLESTEP		3
 #define TIF_NOTIFY_RESUME	4	/* callback before returning to user */
+#define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
 #define TIF_SYSCALL_TRACE	8
 #define TIF_POLLING_NRFLAG	17
 #define TIF_MEMDIE		18
@@ -57,6 +58,7 @@ struct thread_info {
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
+#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
diff --git a/arch/nds32/kernel/ex-exit.S b/arch/nds32/kernel/ex-exit.S
index 6a2966c2d8c8..b30699911b81 100644
--- a/arch/nds32/kernel/ex-exit.S
+++ b/arch/nds32/kernel/ex-exit.S
@@ -120,7 +120,7 @@ work_pending:
 	andi	$p1, $r1, #_TIF_NEED_RESCHED
 	bnez	$p1, work_resched
 
-	andi	$p1, $r1, #_TIF_SIGPENDING|#_TIF_NOTIFY_RESUME
+	andi	$p1, $r1, #_TIF_SIGPENDING|#_TIF_NOTIFY_RESUME|#_TIF_NOTIFY_SIGNAL
 	beqz	$p1, no_work_pending
 
 	move	$r0, $sp			! 'regs'
diff --git a/arch/nds32/kernel/signal.c b/arch/nds32/kernel/signal.c
index 2acb94812af9..7e3ca430a223 100644
--- a/arch/nds32/kernel/signal.c
+++ b/arch/nds32/kernel/signal.c
@@ -376,7 +376,7 @@ static void do_signal(struct pt_regs *regs)
 asmlinkage void
 do_notify_resume(struct pt_regs *regs, unsigned int thread_flags)
 {
-	if (thread_flags & _TIF_SIGPENDING)
+	if (thread_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
 		do_signal(regs);
 
 	if (thread_flags & _TIF_NOTIFY_RESUME)
-- 
2.29.0

-- 
Jens Axboe

