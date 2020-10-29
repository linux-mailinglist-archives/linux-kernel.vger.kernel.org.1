Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470BB29F104
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgJ2QQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgJ2QQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:16:23 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FF7C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:16:21 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z5so4144317iob.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1V5GLCZNybwNg87uu0YriGFVSE0ZjD9L+JX6iLbpcdI=;
        b=kZwkBKS6f2ZBSE1fGpGmhvgSiftzOvn4kEvPznxoDJxc9gtztrZ6V8UoXE4dgipppd
         /hLAmfJgw9tAq+4v8Nk93BcoPpkuN9jFpHpYhe8uI+vBPrEo+Xomcx7ULZD2cmPRdASz
         6c9YAwpv2+fTGNjgyslfQzs3ryikCosV910k0UeHmvCoTdDuXo+4RmIeTy1QcYcJySfv
         TrCqt7EmCQCvH9X9B5G3V0LGPlBMko+/HplUtCoXGZWb7TLuiMdsjGVdycgTET0xmfSA
         67/HxifNW9fUAnFXHmnjo4W+dfDuHW7bVnU7Zy4Sg4MhCKTYlSPo0/3t9NldXTl6CQpU
         UF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1V5GLCZNybwNg87uu0YriGFVSE0ZjD9L+JX6iLbpcdI=;
        b=f5FUUF/HODrMW3hHFun9eWPHKpvULAkuiszpESkEPeISMZoT+4eHxbQn5tqFIBykIK
         MKEIFlX17MXkGPOeS3i/pSomBE0aCJnV+ivaxJoFtcfYoJX/aN1WqtW9kBPuqqZWqGWO
         jY9nTL0g6aw2JG9+Z559JkB/n6DWRjPbowrfc16CZPFDlBmQxoiz3o2l0GG7iYCn9iuk
         A7J/5UKNAmPvbJ6Er+HPj01K4B5wD3QLlMW/2KpZWU5wVds+U6+7cSfrX0QBbxklmWqV
         HGMLqwocHQdOU8OxqaWQEhLbAdSZsROCHQEVm2owCH+gwkul3npSmMYkTGBzJbvCdlbf
         e4ug==
X-Gm-Message-State: AOAM530RWb/gO2G24BVBC1wyKFlBzxzLBKcmGzolwj9njhkKYdPtnHFO
        NXEc1rMTs2fmgek7TjeP23YL+ZzPm/5iWA==
X-Google-Smtp-Source: ABdhPJylfHRg9Ct9W9BLj6ON9i6pE9QxxjpmL0adeP1lJ0IcKDporQcYl8yG/YJQnvl5DQEkZDZNHg==
X-Received: by 2002:a5e:8f4c:: with SMTP id x12mr519830iop.140.1603988180660;
        Thu, 29 Oct 2020 09:16:20 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p15sm2301963ioh.27.2020.10.29.09.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 09:16:20 -0700 (PDT)
To:     Michal Simek <monstr@monstr.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] microblaze: add support for TIF_NOTIFY_SIGNAL
Message-ID: <a2b78afc-5f60-8590-9df5-17302e356552@kernel.dk>
Date:   Thu, 29 Oct 2020 10:16:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up TIF_NOTIFY_SIGNAL handling for microblaze.

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---

5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
for details:

https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.dk/

As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
as that will enable a set of cleanups once all of them support it. I'm
happy carrying this patch if need be, or it can be funelled through the
arch tree. Let me know.

 arch/microblaze/include/asm/thread_info.h | 2 ++
 arch/microblaze/kernel/signal.c           | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/include/asm/thread_info.h b/arch/microblaze/include/asm/thread_info.h
index ad8e8fcb90d3..44f5ca331862 100644
--- a/arch/microblaze/include/asm/thread_info.h
+++ b/arch/microblaze/include/asm/thread_info.h
@@ -107,6 +107,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_NEED_RESCHED	3 /* rescheduling necessary */
 /* restore singlestep on return to user mode */
 #define TIF_SINGLESTEP		4
+#define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
 #define TIF_MEMDIE		6	/* is terminating due to OOM killer */
 #define TIF_SYSCALL_AUDIT	9       /* syscall auditing active */
 #define TIF_SECCOMP		10      /* secure computing */
@@ -119,6 +120,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
+#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
index f11a0ccccabc..5a8d173d7b75 100644
--- a/arch/microblaze/kernel/signal.c
+++ b/arch/microblaze/kernel/signal.c
@@ -313,7 +313,8 @@ static void do_signal(struct pt_regs *regs, int in_syscall)
 
 asmlinkage void do_notify_resume(struct pt_regs *regs, int in_syscall)
 {
-	if (test_thread_flag(TIF_SIGPENDING))
+	if (test_thread_flag(TIF_SIGPENDING) ||
+	    test_thread_flag(TIF_NOTIFY_SIGNAL))
 		do_signal(regs, in_syscall);
 
 	if (test_thread_flag(TIF_NOTIFY_RESUME))
-- 
2.29.0

-- 
Jens Axboe

