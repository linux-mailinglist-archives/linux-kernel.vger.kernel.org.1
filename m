Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26CC2E902D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 06:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbhADFg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 00:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbhADFg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 00:36:26 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CB7C061574
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 21:35:46 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b5so10110093pjl.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 21:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QaRVNSuYB7tYJ+gMxxTcDf08bRsBIt7K93REpdt1gfg=;
        b=CAq6M1dxD6ZUxNuBH/0J5BzRysMtJItXfXCYon451y/008iCFh/H7O0GU0SN61OiOr
         SZwifag2sAKtzUJC5r3wSbZB9DYO6Z+IT+bgZx6uTC8vyQo1DXQ8N4MIlF1ZkO3lKNo6
         +dIg6+tgqf/m5pvt5sD1Xc8PdiJHQv0uKNStl09OhVTvroXQhReg32CUJvF1B9+ERG/o
         OPm7TZdJxaKZNIUds0qiagBWMAsFN1J9ISa8Admcw7/JN0Xr4QjjhQ2luJqlLKDiFb+4
         /aHEpSv336dWyaqDNqJR7D9ZZaCd1JcfxvxwojtyRmhnTqLlLHc6fOrK/we9ogGE2JN+
         5hDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QaRVNSuYB7tYJ+gMxxTcDf08bRsBIt7K93REpdt1gfg=;
        b=Z5qFvLam8xjJn5CFtAS9NA/M/sYbhQpOSRi/P8MYv05DF9opFUz8Gk21UJa36xTRxf
         AxXhfdCUcfAbOWWb9BGfmpsMUCsPmaMPa36ydF13doUqTwbGVl68ZqMUEn0qkrAJR23Y
         FAMGJgzozCeMExEYgF2bVudfS1uFGGjfjNsyD36eJmHuPty+532X9k5CMTa5aRBnR9Bl
         YLi1W6YSaYqBj0ImkS464rAEVxt97GZyAMV/cpiBRfpMk56VsIO3iZm/wfF84x21vuCG
         wKmeNLxZMXqtF9/sVqMnLegw4YHZNqfI5wB51LVGZs+XAa8cl7hQDHpac2C9/F0Uubct
         oIsQ==
X-Gm-Message-State: AOAM5315Ob8qEfQ6CYFc3v+GJbakexFEHXW4Nglc+KB52MCPGNqL0aqm
        7SosmiF0mUUObGebxJERKu0=
X-Google-Smtp-Source: ABdhPJysaUy/Jzg9I9Tj77EVl0sByMcrQGxJMJWtaKb7HRcXmjWJyS/qSQ0Kc76uL6t+WtSEHlHajw==
X-Received: by 2002:a17:90b:691:: with SMTP id m17mr28754895pjz.73.1609738545697;
        Sun, 03 Jan 2021 21:35:45 -0800 (PST)
Received: from tj10607pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id k18sm19102575pjz.26.2021.01.03.21.35.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2021 21:35:45 -0800 (PST)
From:   Louis Wang <liang26812@gmail.com>
To:     linux@armlinux.org.uk
Cc:     akpm@linux-foundation.org, rppt@kernel.org, geert@linux-m68k.org,
        penberg@kernel.org, liang26812@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: ftrace: pause/unpause function graph tracer in cpu_suspend()
Date:   Mon,  4 Jan 2021 13:35:34 +0800
Message-Id: <1609738534-14369-1-git-send-email-liang26812@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "louis.wang1" <louis.wang1@unisoc.com>

Enabling function_graph tracer on ARM causes kernel panic, because the
function graph tracer updates the "return address" of a function in order
to insert a trace callback on function exit, it saves the function's
original return address in a return trace stack, but cpu_suspend() may not
return through the normal return path.

cpu_suspend() will resume directly via the cpu_resume path, but the return
trace stack has been set-up by the subfunctions of cpu_suspend(), which
makes the "return address" inconsistent with cpu_suspend().

This patch refers to Commit de818bd4522c40ea02a81b387d2fa86f989c9623
("arm64: kernel: pause/unpause function graph tracer in cpu_suspend()"),
fixes the issue by pausing/resuming the function graph tracer on the thread
executing cpu_suspend(), so that the function graph tracer state is kept
consistent across functions that enter power down states and never return
by effectively disabling graph tracer while they are executing.

Signed-off-by: louis.wang1 <louis.wang1@unisoc.com>
---
 arch/arm/kernel/suspend.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index 24bd205..43f0a3e 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/mm_types.h>
@@ -26,12 +27,22 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 		return -EINVAL;
 
 	/*
+	 * Function graph tracer state gets incosistent when the kernel
+	 * calls functions that never return (aka suspend finishers) hence
+	 * disable graph tracing during their execution.
+	 */
+	pause_graph_tracing();
+
+	/*
 	 * Provide a temporary page table with an identity mapping for
 	 * the MMU-enable code, required for resuming.  On successful
 	 * resume (indicated by a zero return code), we need to switch
 	 * back to the correct page tables.
 	 */
 	ret = __cpu_suspend(arg, fn, __mpidr);
+
+	unpause_graph_tracing();
+
 	if (ret == 0) {
 		cpu_switch_mm(mm->pgd, mm);
 		local_flush_bp_all();
@@ -45,7 +56,13 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 {
 	u32 __mpidr = cpu_logical_map(smp_processor_id());
-	return __cpu_suspend(arg, fn, __mpidr);
+	int ret;
+
+	pause_graph_tracing();
+	ret = __cpu_suspend(arg, fn, __mpidr);
+	unpause_graph_tracing();
+
+	return ret;
 }
 #define	idmap_pgd	NULL
 #endif
-- 
2.7.4

