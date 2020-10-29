Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0488F29F110
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgJ2QST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgJ2QST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:18:19 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80916C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:18:17 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z2so3582779ilh.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ntN5vn0y57nYkQWRakhQFLzyuwW1u93x8+H2aMDTWTE=;
        b=Ff96IwCgJWckTOnkNQdOIxiNGq5wTVWHUPEPtVLvPuTDJ/tJgD+kfNnx5CHEBi9WzA
         8IR29xUzIlC2iQaj0p6cgQffHBnqwMYBCwsKApNDllqVs6UftHHtA3D6KiS6qHgSU1XQ
         OwCkdaE8JVwQeZlNyh7ucyOcQJqd5LqnixdIwwnwxyYZaSSausoWiM/nEuBLfBJBRiwI
         WSQo4sFbY7LA1zwQse9Q4hqMPtUO6CZxGyPYtBQ7CUCPzrRXb6DcFlmV55MJvCYWDeN9
         bpl0uAO8K2vgXUORRf25GcENbMoPAE/2L4LUeEoiN24YBhZ65alEf/3PxnZjvS4QUHdR
         1UJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ntN5vn0y57nYkQWRakhQFLzyuwW1u93x8+H2aMDTWTE=;
        b=NuD9nKMiQEjVy1jNnfTL08CUUewsrZ3siZCd8vrHxRgjmLZ1fSw+Agjog2rvWzlX8j
         8ZvFPuU2L05sFR712QB9d7wXOotEXvf9atmOE6RCuaXUEOhpF93iEyFkNAnMc3JUiCvK
         cFxB3P9cGAUK8EMLnW+xGMmItX2wj+9eBtL23t2ueRkzIDB/lVGM2CxBCfy7FYf2XMdZ
         IXuCv2wnQqdT+Ry+H7msPDv7GQjNGHp7dJTrzWkLQ8ynFiw8U1km4KN2eI8vpvwsdyXu
         JcxBAgXu3bLmmYYEZxpZ7qrQAdwUHLnGP3WN0inLn6abGM2nh2XEeuYIzuCXs6jTy3JU
         J4zw==
X-Gm-Message-State: AOAM532evau+9WP/yiDtMnovxi2ALtTH0XwWOq44m56QrZKA9kfEw/ER
        /jk4vB1ELnHFPSTK+w3Pg6bmvpPl2J4q0g==
X-Google-Smtp-Source: ABdhPJy3EIx/nLWjeLql8lt/3FL9sXy7dAhWiIuMWtwMagNokeHPOJDz0/gkbDZlrHk7SkaC8/saGg==
X-Received: by 2002:a05:6e02:1386:: with SMTP id d6mr3799034ilo.116.1603988296590;
        Thu, 29 Oct 2020 09:18:16 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e11sm2493937ioq.48.2020.10.29.09.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 09:18:16 -0700 (PDT)
To:     Ley Foon Tan <ley.foon.tan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] nios32: add support for TIF_NOTIFY_SIGNAL
Message-ID: <c6e927af-7ffd-d087-8716-729e87d80fb1@kernel.dk>
Date:   Thu, 29 Oct 2020 10:18:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up TIF_NOTIFY_SIGNAL handling for nios32.

Cc: Ley Foon Tan <ley.foon.tan@intel.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---

5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
for details:

https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.dk/

As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
as that will enable a set of cleanups once all of them support it. I'm
happy carrying this patch if need be, or it can be funelled through the
arch tree. Let me know.

 arch/nios2/include/asm/thread_info.h | 2 ++
 arch/nios2/kernel/signal.c           | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/nios2/include/asm/thread_info.h b/arch/nios2/include/asm/thread_info.h
index 7349a4fa635b..272d2c72a727 100644
--- a/arch/nios2/include/asm/thread_info.h
+++ b/arch/nios2/include/asm/thread_info.h
@@ -86,6 +86,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_MEMDIE		4	/* is terminating due to OOM killer */
 #define TIF_SECCOMP		5	/* secure computing */
 #define TIF_SYSCALL_AUDIT	6	/* syscall auditing active */
+#define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
 #define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal() */
 
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling
@@ -97,6 +98,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
+#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 
diff --git a/arch/nios2/kernel/signal.c b/arch/nios2/kernel/signal.c
index cf2dca2ac7c3..2009ae2d3c3b 100644
--- a/arch/nios2/kernel/signal.c
+++ b/arch/nios2/kernel/signal.c
@@ -306,7 +306,8 @@ asmlinkage int do_notify_resume(struct pt_regs *regs)
 	if (!user_mode(regs))
 		return 0;
 
-	if (test_thread_flag(TIF_SIGPENDING)) {
+	if (test_thread_flag(TIF_SIGPENDING) ||
+	    test_thread_flag(TIF_NOTIFY_SIGNAL)) {
 		int restart = do_signal(regs);
 
 		if (unlikely(restart)) {
-- 
2.29.0

-- 
Jens Axboe

