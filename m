Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270382A44F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgKCMRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:17:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:38388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729071AbgKCMRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:17:37 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FCCD22403;
        Tue,  3 Nov 2020 12:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604405855;
        bh=osSHyWtISVdB1R8HMo/isHU//fDI1y2M0jAn4/4G3zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mh3+xibEbUsQubqsJ15mgonIcFTpMup/WxO+/r1+NlS6DFuqY8BPw6vBRrqzdvMBa
         7yRS3PQFUIpWUpVrJCutLt9ikRpuCzJgDNEVGpRCOAfBDAqCwK5ug0BFdu0TvokeaQ
         nQ2nwLJR8iY1jSdUnli/tgvtHRiZjpyVBj47VNts=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] arm64: lto: Strengthen READ_ONCE() to acquire when CONFIG_LTO=y
Date:   Tue,  3 Nov 2020 12:17:21 +0000
Message-Id: <20201103121721.5166-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201103121721.5166-1-will@kernel.org>
References: <20201103121721.5166-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with LTO, there is an increased risk of the compiler
converting an address dependency headed by a READ_ONCE() invocation
into a control dependency and consequently allowing for harmful
reordering by the CPU.

Ensure that such transformations are harmless by overriding the generic
READ_ONCE() definition with one that provides acquire semantics when
building with LTO.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/rwonce.h   | 63 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/vdso/Makefile   |  2 +-
 arch/arm64/kernel/vdso32/Makefile |  2 +-
 arch/arm64/kernel/vmlinux.lds.S   |  2 +-
 4 files changed, 66 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/rwonce.h

diff --git a/arch/arm64/include/asm/rwonce.h b/arch/arm64/include/asm/rwonce.h
new file mode 100644
index 000000000000..d78eb4cb795b
--- /dev/null
+++ b/arch/arm64/include/asm/rwonce.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Google LLC.
+ */
+#ifndef __ASM_RWONCE_H
+#define __ASM_RWONCE_H
+
+#ifdef CONFIG_LTO
+
+#include <linux/compiler_types.h>
+#include <asm/alternative-macros.h>
+
+#ifndef BUILD_VDSO
+
+#ifdef CONFIG_AS_HAS_LDAPR
+#define __LOAD_RCPC(sfx, regs...)					\
+	ALTERNATIVE(							\
+		"ldar"	#sfx "\t" #regs,				\
+		".arch_extension rcpc\n"				\
+		"ldapr"	#sfx "\t" #regs,				\
+	ARM64_HAS_LDAPR)
+#else
+#define __LOAD_RCPC(sfx, regs...)	"ldar" #sfx "\t" #regs
+#endif /* CONFIG_AS_HAS_LDAPR */
+
+#define __READ_ONCE(x)							\
+({									\
+	typeof(&(x)) __x = &(x);					\
+	int atomic = 1;							\
+	union { __unqual_scalar_typeof(*__x) __val; char __c[1]; } __u;	\
+	switch (sizeof(x)) {						\
+	case 1:								\
+		asm volatile(__LOAD_RCPC(b, %w0, %1)			\
+			: "=r" (*(__u8 *)__u.__c)			\
+			: "Q" (*__x) : "memory");			\
+		break;							\
+	case 2:								\
+		asm volatile(__LOAD_RCPC(h, %w0, %1)			\
+			: "=r" (*(__u16 *)__u.__c)			\
+			: "Q" (*__x) : "memory");			\
+		break;							\
+	case 4:								\
+		asm volatile(__LOAD_RCPC(, %w0, %1)			\
+			: "=r" (*(__u32 *)__u.__c)			\
+			: "Q" (*__x) : "memory");			\
+		break;							\
+	case 8:								\
+		asm volatile(__LOAD_RCPC(, %0, %1)			\
+			: "=r" (*(__u64 *)__u.__c)			\
+			: "Q" (*__x) : "memory");			\
+		break;							\
+	default:							\
+		atomic = 0;						\
+	}								\
+	atomic ? (typeof(*__x))__u.__val : (*(volatile typeof(__x))__x);\
+})
+
+#endif	/* !BUILD_VDSO */
+#endif	/* CONFIG_LTO */
+
+#include <asm-generic/rwonce.h>
+
+#endif	/* __ASM_RWONCE_H */
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index d65f52264aba..a8f8e409e2bf 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -28,7 +28,7 @@ ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv	\
 	     $(btildflags-y) -T
 
 ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
-ccflags-y += -DDISABLE_BRANCH_PROFILING
+ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS)
 KASAN_SANITIZE			:= n
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 79280c53b9a6..a1e0f91e6cea 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -48,7 +48,7 @@ cc32-as-instr = $(call try-run,\
 # As a result we set our own flags here.
 
 # KBUILD_CPPFLAGS and NOSTDINC_FLAGS from top-level Makefile
-VDSO_CPPFLAGS := -D__KERNEL__ -nostdinc -isystem $(shell $(CC_COMPAT) -print-file-name=include)
+VDSO_CPPFLAGS := -DBUILD_VDSO -D__KERNEL__ -nostdinc -isystem $(shell $(CC_COMPAT) -print-file-name=include)
 VDSO_CPPFLAGS += $(LINUXINCLUDE)
 
 # Common C and assembly flags
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 1bda604f4c70..d6cdcf4aa6a5 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -201,7 +201,7 @@ SECTIONS
 		INIT_CALLS
 		CON_INITCALL
 		INIT_RAM_FS
-		*(.init.rodata.* .init.bss)	/* from the EFI stub */
+		*(.init.altinstructions .init.rodata.* .init.bss)	/* from the EFI stub */
 	}
 	.exit.data : {
 		EXIT_DATA
-- 
2.29.1.341.ge80a0c044ae-goog

