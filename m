Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A89273E70
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 11:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgIVJWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 05:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgIVJWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 05:22:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0889C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 02:22:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f199so5878885yba.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 02:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=yDlpLM05HoR6YqCfSu4qeydWcyJmDE8wcQRWM8VFRp0=;
        b=nawgVnlB6Ro4XbH+hWvRIJahmBDAS1Rw883lJ0J71dtkhEyQrIMHpkigEwmSsrDWS3
         Y2LC3cnztYrD3BrItrtHEkA1fyCCEAhJVcgLAeai4UbE/NqI5Hr5zgOZKBkedBGpg1RP
         6TNX+88vAL4ZH6l8f7YcybDxZ2v5/SzNJ2USL95mIPx8GHwBniZfLMaMRzMfGv3SyvgK
         fdWH1LZ28qgQ2Mj5RbAN+Cu37Wfa+hpBWghbvOkZVrjr7iJQRq2y5yjBlyMD9QEy/VqA
         P9RU1JA6wa5Xndvr8MD214T4yOOjaFkW7LYKv8Qwb3gwb4bLXGqqFI7QkjnY1sS7I4rN
         7WqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yDlpLM05HoR6YqCfSu4qeydWcyJmDE8wcQRWM8VFRp0=;
        b=Q3l5TPgYo0Ssv2SmJxCzdp3KncPO6ElVkWIZTuH+xJuBovyIzKsh9ehFoZUgSgMN5S
         f2uSS7lwNC7Os30thqpvVbl9OeHKHWXh+HHiL4PhI+6MEpDpXGcl6sKJkqg1RmalNHx9
         RAmguL2ZIW8TIRQi0TrZnFG+Pp/fIJ+HxB3iWZSpc6PCTjBykeh8Ny0boR9cvfaY0Mce
         M2j1+2zxl6Bi7Crf3WVL+eh7sdzSyBOg68u/gmFBFSE9F9bBX8XX61rJ0TO5FhIP0wsz
         h5N6xrhZrAssskrTEg6YuEiMRHRPH71Xvs039iG7sakzxMUAhtJsuj0at93PqxDnT8XN
         Xq1Q==
X-Gm-Message-State: AOAM5336lxhXey61/SP7mJkzk3QgRUYcANYEvX4PBiedu/iDAuKL8Zjk
        I0BV2SpuixzKEqcHA01HFYVFohH4IVr+ri62XQ==
X-Google-Smtp-Source: ABdhPJwpwmC9UI2AlBete5lhF/xiU8P1gifkypr3G1ZEdxBC20bvwuUVh1UC46OnIFTu59GUzxzIwhL+G3DQL22zwvY=
Sender: "asteinhauser via sendgmr" 
        <asteinhauser@asteinhauser.svl.corp.google.com>
X-Received: from asteinhauser.svl.corp.google.com ([2620:15c:2ce:200:f693:9fff:fef4:3cd1])
 (user=asteinhauser job=sendgmr) by 2002:a25:d1d4:: with SMTP id
 i203mr5201536ybg.429.1600766532835; Tue, 22 Sep 2020 02:22:12 -0700 (PDT)
Date:   Tue, 22 Sep 2020 02:21:53 -0700
In-Reply-To: <20200921110020.GA2139@willie-the-truck>
Message-Id: <20200922092153.978003-1-asteinhauser@google.com>
Mime-Version: 1.0
References: <20200921110020.GA2139@willie-the-truck>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v2] PR_SPEC_DISABLE_NOEXEC support for arm64.
From:   Anthony Steinhauser <asteinhauser@google.com>
To:     will@kernel.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        maz@kernel.org, Anthony Steinhauser <asteinhauser@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support of Spectre v4 PR_SPEC_DISABLE_NOEXEC mitigation mode for on arm64.

PR_SPEC_DISABLE_NOEXEC turns the mitigation on, but it is automatically
turned off whenever a new program is being execve'ed.

Signed-off-by: Anthony Steinhauser <asteinhauser@google.com>
---

I added the "#include <linux/sched/task_stack.h>" line to the
arch/arm64/kernel/proton-pack.c file just to make the kernel compilable.
It is not a part of the PR_SPEC_DISABLE_NOEXEC implementation.

 arch/arm64/kernel/process.c     |  7 +++++++
 arch/arm64/kernel/proton-pack.c | 35 +++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 9dbd35b95253..5ac43b743696 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -391,6 +391,13 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	ptrauth_thread_init_kernel(p);
 
+	if (task_spec_ssb_noexec(current)) {
+		clear_thread_flag(TIF_SSBD);
+		task_clear_spec_ssb_disable(current);
+		task_clear_spec_ssb_noexec(current);
+		spectre_v4_enable_task_mitigation(current);
+	}
+
 	if (likely(!(p->flags & PF_KTHREAD))) {
 		*childregs = *current_pt_regs();
 		childregs->regs[0] = 0;
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index b1ea935fd948..566c2304bba7 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -22,6 +22,7 @@
 #include <linux/device.h>
 #include <linux/nospec.h>
 #include <linux/prctl.h>
+#include <linux/sched/task_stack.h>
 
 #include <asm/spectre.h>
 #include <asm/traps.h>
@@ -681,6 +682,7 @@ static int ssbd_prctl_set(struct task_struct *task, unsigned long ctrl)
 			return -EPERM;
 
 		task_clear_spec_ssb_disable(task);
+		task_clear_spec_ssb_noexec(task);
 		clear_tsk_thread_flag(task, TIF_SSBD);
 		break;
 	case PR_SPEC_FORCE_DISABLE:
@@ -701,6 +703,36 @@ static int ssbd_prctl_set(struct task_struct *task, unsigned long ctrl)
 			return -EPERM;
 
 		task_set_spec_ssb_disable(task);
+		task_clear_spec_ssb_noexec(task);
+		set_tsk_thread_flag(task, TIF_SSBD);
+		break;
+	case PR_SPEC_DISABLE_NOEXEC:
+		/* Disable speculation (enable mitigation), but don't inherit
+		 * the mitigation when a new program is execve'd.
+		 *
+		 * Force disabled speculation prevents it from being
+		 * re-enabled even after exec.
+		 */
+		if (task_spec_ssb_force_disable(task))
+			return -EPERM;
+
+		/*
+		 * If the mitigation is forced on, then speculation is forced
+		 * of unconditionally and we revent it from being
+		 * re-enabled even after exec.
+		 */
+		if (spectre_v4_mitigations_on())
+			return -EPERM;
+
+		/*
+		 * If the mitigation is forced off, then speculation is forced
+		 * on and we prevent it from being disabled.
+		 */
+		if (spectre_v4_mitigations_off())
+			return -EPERM;
+
+		task_set_spec_ssb_disable(task);
+		task_set_spec_ssb_noexec(task);
 		set_tsk_thread_flag(task, TIF_SSBD);
 		break;
 	default:
@@ -746,6 +778,9 @@ static int ssbd_prctl_get(struct task_struct *task)
 	if (task_spec_ssb_force_disable(task))
 		return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
 
+	if (task_spec_ssb_noexec(task))
+		return PR_SPEC_PRCTL | PR_SPEC_DISABLE_NOEXEC;
+
 	if (task_spec_ssb_disable(task))
 		return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
 
-- 
2.18.4

