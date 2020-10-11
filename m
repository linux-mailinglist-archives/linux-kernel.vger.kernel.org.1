Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8277028A63B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 10:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgJKIAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 04:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgJKIAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 04:00:20 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B238EC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 01:00:19 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u21so18998324eja.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 01:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=kbuC7ekcH2sE0v2mfTiLeLX4xW0n9HdQ2x9bjk8D20s=;
        b=Fl/8gAYT+n/4czsi0djmP61vHLsmkrq85x77day8s0HKf1GMWsnbootrynLMEfd43m
         5Vh78gZDWjap1OOE3zRkKWDC8k1zjxkJ6X08fqXRKW59Wc0yTHyRP/OKHHybsWx4PgH1
         hstvT0oKP61TFfVIqcPY28pDMkUI8l4LtX8h75Zc+Kny92xFTZQnTgn5GidxYFbFxn6f
         Hrnmfe/lXmveri2qHByaXkbyplAhD7Ny31Uau9HmznLt+4EyQ8yK48lAf6or375+58BS
         xsvPBut10pJb5ibZGomLosK5opVp3OkFjdYR+estAJxPLU5nET+verRazY2vRjt1G7H0
         2pZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=kbuC7ekcH2sE0v2mfTiLeLX4xW0n9HdQ2x9bjk8D20s=;
        b=UZ0mlK0q/BEUXgcjBW/VByY4WNjHNvonBWU3ALlcvrnNVxa4c6EB6YDu+bStdAhNdk
         qYULBis9cn9TJ7d1lmP+dkiDpXSaNUFDtG5uVZ8ONcRYTWHIf8EeizY/aKo2gaLEehYX
         0osK9UB7Yxr8hbkx5z/YqMMjj76hlfvtPWoTn75UP3il+Eq6/OF09o7qCil78fIJzbA5
         36l5MeTxR56K6gwemKvDpYcIWAQk/X7qDQigUfEp0pXGGCcODNGg22VzIuALkfimLkH4
         ywkWNoxosuQ7NyM/TUIpkiAMGBnRCELCGQjIQ2BnonjdvVY7zZ83Upr9LxDDMXHH/DXY
         P4hA==
X-Gm-Message-State: AOAM531hBO8yPhwHYV4KDS8UNntCOOaRDFBcuZC4TyjE3uwpQq7OvY2h
        6ARSW2cEqTZVKETKQruaWcI=
X-Google-Smtp-Source: ABdhPJwnV5yyheuV+yhBvtic1VyRko29Zzd/ux4+7rDTBdGMdMJ3QzLei0LrMImzeJbpYCNuElWfrA==
X-Received: by 2002:a17:906:8297:: with SMTP id h23mr21859961ejx.383.1602403218128;
        Sun, 11 Oct 2020 01:00:18 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id q26sm8893485ejr.97.2020.10.11.01.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 01:00:16 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 11 Oct 2020 10:00:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>
Subject: [GIT PULL] perf fix
Message-ID: <20201011080015.GA3530982@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-10-11

   # HEAD: 6d6b8b9f4fceab7266ca03d194f60ec72bd4b654 perf: Fix task_function_call() error handling

Fix an error handling bug that can cause a lockup if a CPU is offline. (doh ...)

 Thanks,

	Ingo

------------------>
Kajol Jain (1):
      perf: Fix task_function_call() error handling


 kernel/events/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7ed5248f0445..e8bf92202542 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -99,7 +99,7 @@ static void remote_function(void *data)
  * retry due to any failures in smp_call_function_single(), such as if the
  * task_cpu() goes offline concurrently.
  *
- * returns @func return value or -ESRCH when the process isn't running
+ * returns @func return value or -ESRCH or -ENXIO when the process isn't running
  */
 static int
 task_function_call(struct task_struct *p, remote_function_f func, void *info)
@@ -115,7 +115,8 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
 	for (;;) {
 		ret = smp_call_function_single(task_cpu(p), remote_function,
 					       &data, 1);
-		ret = !ret ? data.ret : -EAGAIN;
+		if (!ret)
+			ret = data.ret;
 
 		if (ret != -EAGAIN)
 			break;
