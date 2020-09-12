Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC682676FC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 02:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgILA6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 20:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgILA6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 20:58:36 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB27C061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 17:58:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o20so8504566pfp.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 17:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BQEBitiGkWGlZM4yqpZopSRzm6HS+moeiC97y9ea1YU=;
        b=Ihn4Rqwl3X1/PBt7G/kTyamrsinQUF3TxCWPjg6e8OQN476ND9CVfuKHuqlxU1qDUm
         a/hBBnKCIBRIYQEhRLK9iu9C2/iMSUK0EXz/GagWIL9phdjvZZo4JX+iH1rW1Y6FFfJb
         Dai1I/MiwXHFQCRxKKJF0jTk7f16ia64TZ8gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BQEBitiGkWGlZM4yqpZopSRzm6HS+moeiC97y9ea1YU=;
        b=bWQp1bcA4YyTbp0bzk3mrLLNKz3tgiF0zqYEcM3UCvJDWdS26tKjRJH3KGRhKYU559
         3ROoT3e5N1BHqoELKPGshceOdEWiK6QctGmrMbaZL+lsU38guNYTztpZBnYt+onZtGyA
         RhAJVbcLyVIPoAzaX8QZfeqRcdqYt7/8HIaqbQYrssWvHlD/pf+g7K4iEbc1rtszCokt
         7rY4CNDR9LDIdyW3kFoBhZaxOCFwa+vC5lonFsiKeII3EwKdoyORXdy6gcSkiUXsgmHI
         VDDpwqDhVs+IjEZbAk0Py8PVWMQvQI1Lhoq81q7G3l+6Xi+dBkoACCXkOD4b1nDo8aYr
         QOlA==
X-Gm-Message-State: AOAM530EVS6ihztRPK/yHnysoGFOD8qztJr8G9wTQs5k5QgsmpCoXG7L
        cTQhMdv99ZWgmZzjfPgwiV/m8g==
X-Google-Smtp-Source: ABdhPJy3+8gD4qTnMB/dc12Fcc9iJI2FPBjz7f+Cbs5qUkcTc1/Dc6JOH6fHskMCyzeP5MnAqaG96A==
X-Received: by 2002:a63:5966:: with SMTP id j38mr3469299pgm.187.1599872314545;
        Fri, 11 Sep 2020 17:58:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k2sm3357001pfi.169.2020.09.11.17.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 17:58:33 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kyle Huey <me@kylehuey.com>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] core/entry: Report syscall correctly for trace and audit
Date:   Fri, 11 Sep 2020 17:58:26 -0700
Message-Id: <20200912005826.586171-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On v5.8 when doing seccomp syscall rewrites (e.g. getpid into getppid
as seen in the seccomp selftests), trace (and audit) correctly see the
rewritten syscall on entry and exit:

	seccomp_bpf-1307  [000] .... 22974.874393: sys_enter: NR 110 (...
	seccomp_bpf-1307  [000] .N.. 22974.874401: sys_exit: NR 110 = 1304

With mainline we see a mismatched enter and exit (the original syscall
is incorrectly visible on entry):

	seccomp_bpf-1030  [000] ....    21.806766: sys_enter: NR 39 (...
	seccomp_bpf-1030  [000] ....    21.806767: sys_exit: NR 110 = 1027

When ptrace or seccomp change the syscall, this needs to be visible to
trace and audit at that time as well. Update the syscall earlier so they
see the correct value.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Fixes: d88d59b64ca3 ("core/entry: Respect syscall number rewrites")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kyle Huey <me@kylehuey.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/entry/common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 18683598edbc..6fdb6105e6d6 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -60,13 +60,15 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 			return ret;
 	}
 
+	/* Either of the above might have changed the syscall number */
+	syscall = syscall_get_nr(current, regs);
+
 	if (unlikely(ti_work & _TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, syscall);
 
 	syscall_enter_audit(regs, syscall);
 
-	/* The above might have changed the syscall number */
-	return ret ? : syscall_get_nr(current, regs);
+	return ret ? : syscall;
 }
 
 static __always_inline long
-- 
2.25.1

