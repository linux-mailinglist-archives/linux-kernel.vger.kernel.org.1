Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF96F1A0170
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 01:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgDFXQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 19:16:16 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39955 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgDFXQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 19:16:15 -0400
Received: by mail-pj1-f67.google.com with SMTP id kx8so568734pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 16:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=afO1zKmkq1sj5aqNSAPmo8IRjezuEuKjnM3GlRCWtRE=;
        b=FAUou8gYmt2MCxO2cKyXhzSw4j1IC8KgeC+bXiqTqe5QqSNRmdnqOuVJoHQDJ+UyPU
         RdIafVDCCHUGnepHULs0h0QZtUehhYm52xPc8JIfEafNjj7L97tUHTMzVrIHdX23tu7T
         870tT8w8N8DbhdKYHGf474/jG4q9lS98mHNd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=afO1zKmkq1sj5aqNSAPmo8IRjezuEuKjnM3GlRCWtRE=;
        b=PIoRyBVkTEepOgiQ6ikfqK58I2dA9Amk/lntcVzxzsPO6dkD63gN5A7RRuh/bhd3ha
         Sghinde/aaIYaHFB1Ze1hWXtrRRWYmBBDOjyq37Zy+Sf4/Bnj9XfxfsJp2wrv7mhf90i
         TU8e25fMeRkmmqnHIS5MckXKe27sJZiWB9GWS3AX5LZbWc6K3WIw2qTRuEmBVFysiw8L
         E+e62BWqp1MOsFWf2qJ9d+m7RuQdHiaIepchdbrsF4A5ZCMVNXVFBrC8DFmb41jxsuTk
         +RDB8JA6wTxlxioeOPDe5US8sVveN69Nq5N7+TaWHdrjHzFxEn5r5pAw0oCtnD0QGgCD
         0EpQ==
X-Gm-Message-State: AGi0PuaukNrur2eDQLfw7uMbthwxvwce8J0cC5aRNSYeKjSbtegNATbm
        zl9Dmc3s34FPi5f4JM1z2PzInA==
X-Google-Smtp-Source: APiQypLKqmE7eCIX43I8YR8JbiR94l3ZUUPoGei30hzmH3c+zDO2qS2G3j+Tlv/Caq6mWLyP6sMzhQ==
X-Received: by 2002:a17:902:788e:: with SMTP id q14mr22301315pll.72.1586214974066;
        Mon, 06 Apr 2020 16:16:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f8sm10635773pgc.75.2020.04.06.16.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 16:16:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] x86/entry: Enable random_kstack_offset support
Date:   Mon,  6 Apr 2020 16:16:05 -0700
Message-Id: <20200406231606.37619-5-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200406231606.37619-1-keescook@chromium.org>
References: <20200406231606.37619-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow for a randomized stack offset on a per-syscall basis, with roughly
5 bits of entropy.

In order to avoid unconditional stack canaries on syscall entry, also
downgrade from -fstack-protector-strong to -fstack-protector to avoid
triggering checks due to alloca(). Examining the resulting canary coverage
changes to common.o, this also removes canaries in other functions,
due to a handful of declarations of "__u64 args[6]" (from seccomp) and
"unsigned long args[6]" (from tracepoints), but their accesses are indexed
(instead of via dynamically sized linear reads/writes) so the risk of
removing useful mitigation coverage here is very low.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig        |  1 +
 arch/x86/entry/Makefile |  9 +++++++++
 arch/x86/entry/common.c | 12 +++++++++++-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index beea77046f9b..b9d449581eb6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -150,6 +150,7 @@ config X86
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if X86_64
 	select HAVE_ARCH_VMAP_STACK		if X86_64
+	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_WITHIN_STACK_FRAMES
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CMPXCHG_DOUBLE
diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index 06fc70cf5433..7b40e6ae2618 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -7,6 +7,15 @@ OBJECT_FILES_NON_STANDARD_entry_64_compat.o := y
 
 CFLAGS_syscall_64.o		+= $(call cc-option,-Wno-override-init,)
 CFLAGS_syscall_32.o		+= $(call cc-option,-Wno-override-init,)
+
+# Downgrade to -fstack-protector to avoid triggering unneeded stack canary
+# checks due to randomize_kstack_offset. This also removes canaries in
+# other places as well, due to a handful of declarations of __u64 args[6]
+# (seccomp) and unsigned long args[6] (tracepoints), but their accesses
+# are indexed (instead of via dynamically sized linear reads/writes) so
+# the risk of removing useful mitigation coverage here is very low.
+CFLAGS_common.o			+= $(subst -fstack-protector-strong,-fstack-protector,$(filter -fstack-protector-strong,$(KBUILD_CFLAGS)))
+
 obj-y				:= entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
 
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 9747876980b5..086d7af570af 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -26,6 +26,7 @@
 #include <linux/livepatch.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
+#include <linux/randomize_kstack.h>
 
 #include <asm/desc.h>
 #include <asm/traps.h>
@@ -189,6 +190,13 @@ __visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
 	lockdep_assert_irqs_disabled();
 	lockdep_sys_exit();
 
+	/*
+	 * x86_64 stack alignment means 3 bits are ignored, so keep
+	 * the top 5 bits. x86_32 needs only 2 bits of alignment, so
+	 * the top 6 bits will be used.
+	 */
+	choose_random_kstack_offset(rdtsc() & 0xFF);
+
 	cached_flags = READ_ONCE(ti->flags);
 
 	if (unlikely(cached_flags & EXIT_TO_USERMODE_LOOP_FLAGS))
@@ -283,6 +291,7 @@ __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
 	struct thread_info *ti;
 
+	add_random_kstack_offset();
 	enter_from_user_mode();
 	local_irq_enable();
 	ti = current_thread_info();
@@ -355,6 +364,7 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 /* Handles int $0x80 */
 __visible void do_int80_syscall_32(struct pt_regs *regs)
 {
+	add_random_kstack_offset();
 	enter_from_user_mode();
 	local_irq_enable();
 	do_syscall_32_irqs_on(regs);
@@ -378,8 +388,8 @@ __visible long do_fast_syscall_32(struct pt_regs *regs)
 	 */
 	regs->ip = landing_pad;
 
+	add_random_kstack_offset();
 	enter_from_user_mode();
-
 	local_irq_enable();
 
 	/* Fetch EBP from where the vDSO stashed it. */
-- 
2.20.1

