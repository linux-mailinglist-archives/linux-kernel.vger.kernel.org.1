Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B491D57AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 19:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgEORYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 13:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgEORYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:24:04 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C922D20727;
        Fri, 15 May 2020 17:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589563443;
        bh=zWhOLyH9TNGBBaNKqL1KsajY5TGVx0wn+S/jS978Jqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u58EeNvoas8dp6AcVakZPDrN6DVn18NlyNjlI3Pdyhnc7mjVPOcn8MbktD+o5Rsq7
         xcLTIOfxTo116Bo1iK9tGCYZsdxOJ/oLJ7Z+pF5IT90Nnk54qTVuGu5BtrDdGIq1xl
         sKj3OzlhgENCEF/BhlrMtyX6jMLy7xzMY0UmSyHg=
Date:   Fri, 15 May 2020 18:23:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 00/12] add support for Clang's Shadow Call Stack
Message-ID: <20200515172355.GD23334@willie-the-truck>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200427160018.243569-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427160018.243569-1-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

On Mon, Apr 27, 2020 at 09:00:06AM -0700, Sami Tolvanen wrote:
> This patch series adds support for Clang's Shadow Call Stack
> (SCS) mitigation, which uses a separately allocated shadow stack
> to protect against return address overwrites. More information
> can be found here:
> 
>   https://clang.llvm.org/docs/ShadowCallStack.html

I'm planning to queue this with the (mostly cosmetic) diff below folded in.
I also have some extra patches on top which I'll send out shortly for
review.

However, I really think we need to get to the bottom of the size issue
since I'm highly sceptical about not being able to afford a full page
for the shadow stack allocation. We can change this later so it needn't
hold up the patchset, but given that Android is the only user, I'd like
to make sure that if we change to use a full page upstream then that is
also acceptable in AOSP.

Thanks,

Will

--->8

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 18fc4d29ef27..790c0c6b8552 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -45,6 +45,4 @@
 
 #if __has_feature(shadow_call_stack)
 # define __noscs	__attribute__((__no_sanitize__("shadow-call-stack")))
-#else
-# define __noscs
 #endif
diff --git a/include/linux/scs.h b/include/linux/scs.h
index 060eeb3d1390..3f3662621a27 100644
--- a/include/linux/scs.h
+++ b/include/linux/scs.h
@@ -11,7 +11,7 @@
 #include <linux/gfp.h>
 #include <linux/poison.h>
 #include <linux/sched.h>
-#include <asm/page.h>
+#include <linux/sizes.h>
 
 #ifdef CONFIG_SHADOW_CALL_STACK
 
@@ -20,7 +20,7 @@
  * architecture) provided ~40% safety margin on stack usage while keeping
  * memory allocation overhead reasonable.
  */
-#define SCS_SIZE		1024UL
+#define SCS_SIZE		SZ_1K
 #define GFP_SCS			(GFP_KERNEL | __GFP_ZERO)
 
 /* An illegal pointer value to mark the end of the shadow stack. */
@@ -29,7 +29,9 @@
 #define task_scs(tsk)		(task_thread_info(tsk)->scs_base)
 #define task_scs_offset(tsk)	(task_thread_info(tsk)->scs_offset)
 
-extern void scs_init(void);
+void scs_init(void);
+int scs_prepare(struct task_struct *tsk, int node);
+void scs_release(struct task_struct *tsk);
 
 static inline void scs_task_reset(struct task_struct *tsk)
 {
@@ -40,8 +42,6 @@ static inline void scs_task_reset(struct task_struct *tsk)
	task_scs_offset(tsk) = 0;
 }
 
-extern int scs_prepare(struct task_struct *tsk, int node);
-
 static inline unsigned long *__scs_magic(void *s)
 {
	return (unsigned long *)(s + SCS_SIZE) - 1;
@@ -55,12 +55,8 @@ static inline bool scs_corrupted(struct task_struct *tsk)
		READ_ONCE_NOCHECK(*magic) != SCS_END_MAGIC);
 }
 
-extern void scs_release(struct task_struct *tsk);
-
 #else /* CONFIG_SHADOW_CALL_STACK */
 
-#define task_scs(tsk)	NULL
-
 static inline void scs_init(void) {}
 static inline void scs_task_reset(struct task_struct *tsk) {}
 static inline int scs_prepare(struct task_struct *tsk, int node) { return 0; }
diff --git a/kernel/scs.c b/kernel/scs.c
index 2a96573f2b1b..9389c28f0853 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -55,45 +55,37 @@ static void scs_account(struct task_struct *tsk, int account)
 
 int scs_prepare(struct task_struct *tsk, int node)
 {
-	void *s;
+	void *s = scs_alloc(node);
 
-	s = scs_alloc(node);
	if (!s)
		return -ENOMEM;
 
	task_scs(tsk) = s;
	task_scs_offset(tsk) = 0;
	scs_account(tsk, 1);
-
	return 0;
 }
 
-#ifdef CONFIG_DEBUG_STACK_USAGE
-static unsigned long __scs_used(struct task_struct *tsk)
+static void scs_check_usage(struct task_struct *tsk)
 {
-	unsigned long *p = task_scs(tsk);
-	unsigned long *end = __scs_magic(p);
-	unsigned long s = (unsigned long)p;
+	static unsigned long highest;
 
-	while (p < end && READ_ONCE_NOCHECK(*p))
-		p++;
+	unsigned long *p, prev, curr = highest, used = 0;
 
-	return (unsigned long)p - s;
-}
+	if (!IS_ENABLED(CONFIG_DEBUG_STACK_USAGE))
+		return;
 
-static void scs_check_usage(struct task_struct *tsk)
-{
-	static unsigned long highest;
-	unsigned long used = __scs_used(tsk);
-	unsigned long prev;
-	unsigned long curr = highest;
+	for (p = task_scs(tsk); p < __scs_magic(tsk); ++p) {
+		if (!READ_ONCE_NOCHECK(*p))
+			break;
+		used++;
+	}
 
	while (used > curr) {
		prev = cmpxchg_relaxed(&highest, curr, used);
 
		if (prev == curr) {
-			pr_info("%s (%d): highest shadow stack usage: "
-				"%lu bytes\n",
+			pr_info("%s (%d): highest shadow stack usage: %lu bytes\n",
				tsk->comm, task_pid_nr(tsk), used);
			break;
		}
@@ -101,21 +93,16 @@ static void scs_check_usage(struct task_struct *tsk)
		curr = prev;
	}
 }
-#else
-static inline void scs_check_usage(struct task_struct *tsk) {}
-#endif
 
 void scs_release(struct task_struct *tsk)
 {
-	void *s;
+	void *s = task_scs(tsk);
 
-	s = task_scs(tsk);
	if (!s)
		return;
 
-	WARN_ON(scs_corrupted(tsk));
+	WARN(scs_corrupted(tsk), "corrupted shadow stack detected when freeing task\n");
	scs_check_usage(tsk);
-
	scs_account(tsk, -1);
	scs_free(s);
 }

