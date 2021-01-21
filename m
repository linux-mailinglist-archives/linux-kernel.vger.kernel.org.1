Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90982FE38B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbhAUHLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:11:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbhAUG7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:59:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 360B8239EB;
        Thu, 21 Jan 2021 06:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212242;
        bh=i5kKqcXAdEK3w9PHX/J6KsHZxpv6rGSQrEueu+WNiqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lPEOoG4rihFBamS1moBuhei56tAdQvL0ziuwsQ0DrTXj4mEOfTPQ408csy2CS+k6m
         xkI9QaitDaew/JnOABPFY2twXtjEkagfIbTgoNPphO6AYiZkakSDyyZ/s+QXcGoEEP
         yI5o6ccJR8xavzcBmZj3iWthZ97AZzyJ0ezpvDaIm186aZ0Tp8gsgUgwblMMKgGETy
         29do8+Z+sdApv+W80Gp1Ozn5sC54wJ7f6MyuzPq9jHxSAwX3oLeLQCbR8T0Tn6Seo8
         BvluHMaIDn4r2H1iBbegNte0CETJ90ruX3nTiEllPorQjzHWiuCYZyEHLasW2Xh7Xf
         5TmA/xk/cpVaQ==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH 20/29] csky: Reconstruct VDSO framework
Date:   Thu, 21 Jan 2021 14:53:40 +0800
Message-Id: <20210121065349.3188251-20-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Reconstruct vdso framework to support future vsyscall,
vgettimeofday features. These are very important features to reduce
system calls into the kernel for performance improvement.

The patch is reference RISC-V's

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/csky/abiv1/inc/abi/vdso.h       |  18 ++--
 arch/csky/abiv2/inc/abi/vdso.h       |  20 +----
 arch/csky/include/asm/vdso.h         |  19 ++++-
 arch/csky/kernel/Makefile            |   2 +-
 arch/csky/kernel/signal.c            |   4 +-
 arch/csky/kernel/vdso.c              | 123 +++++++++++++++------------
 arch/csky/kernel/vdso/.gitignore     |   4 +
 arch/csky/kernel/vdso/Makefile       |  67 +++++++++++++++
 arch/csky/kernel/vdso/note.S         |  12 +++
 arch/csky/kernel/vdso/rt_sigreturn.S |  14 +++
 arch/csky/kernel/vdso/so2s.sh        |   5 ++
 arch/csky/kernel/vdso/vdso.S         |  16 ++++
 arch/csky/kernel/vdso/vdso.lds.S     |  54 ++++++++++++
 13 files changed, 269 insertions(+), 89 deletions(-)
 create mode 100644 arch/csky/kernel/vdso/.gitignore
 create mode 100644 arch/csky/kernel/vdso/Makefile
 create mode 100644 arch/csky/kernel/vdso/note.S
 create mode 100644 arch/csky/kernel/vdso/rt_sigreturn.S
 create mode 100755 arch/csky/kernel/vdso/so2s.sh
 create mode 100644 arch/csky/kernel/vdso/vdso.S
 create mode 100644 arch/csky/kernel/vdso/vdso.lds.S

diff --git a/arch/csky/abiv1/inc/abi/vdso.h b/arch/csky/abiv1/inc/abi/vdso.h
index 14352f524f1d..9e6d0a2fdd2b 100644
--- a/arch/csky/abiv1/inc/abi/vdso.h
+++ b/arch/csky/abiv1/inc/abi/vdso.h
@@ -1,17 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-#include <linux/uaccess.h>
+#ifndef __ABI_CSKY_VDSO_H
+#define __ABI_CSKY_VDSO_H
 
-static inline int setup_vdso_page(unsigned short *ptr)
-{
-	int err = 0;
+/* movi r1, 127; addi r1, (139 - 127) */
+#define SET_SYSCALL_ID	.long 0x20b167f1
 
-	/* movi r1, 127 */
-	err |= __put_user(0x67f1, ptr + 0);
-	/* addi r1, (139 - 127) */
-	err |= __put_user(0x20b1, ptr + 1);
-	/* trap 0 */
-	err |= __put_user(0x0008, ptr + 2);
-
-	return err;
-}
+#endif /* __ABI_CSKY_VDSO_H */
diff --git a/arch/csky/abiv2/inc/abi/vdso.h b/arch/csky/abiv2/inc/abi/vdso.h
index b60d4a070326..40fd10d893ff 100644
--- a/arch/csky/abiv2/inc/abi/vdso.h
+++ b/arch/csky/abiv2/inc/abi/vdso.h
@@ -3,21 +3,7 @@
 #ifndef __ABI_CSKY_VDSO_H
 #define __ABI_CSKY_VDSO_H
 
-#include <linux/uaccess.h>
+/* movi r7, 173 */
+#define SET_SYSCALL_ID	.long 0x008bea07
 
-static inline int setup_vdso_page(unsigned short *ptr)
-{
-	int err = 0;
-
-	/* movi r7, 173 */
-	err |= __put_user(0xea07, ptr);
-	err |= __put_user(0x008b,      ptr+1);
-
-	/* trap 0 */
-	err |= __put_user(0xc000,   ptr+2);
-	err |= __put_user(0x2020,   ptr+3);
-
-	return err;
-}
-
-#endif /* __ABI_CSKY_STRING_H */
+#endif /* __ABI_CSKY_VDSO_H */
diff --git a/arch/csky/include/asm/vdso.h b/arch/csky/include/asm/vdso.h
index d963d691f3a1..12c5d638e784 100644
--- a/arch/csky/include/asm/vdso.h
+++ b/arch/csky/include/asm/vdso.h
@@ -3,10 +3,23 @@
 #ifndef __ASM_CSKY_VDSO_H
 #define __ASM_CSKY_VDSO_H
 
-#include <abi/vdso.h>
+#include <linux/types.h>
 
-struct csky_vdso {
-	unsigned short rt_signal_retcode[4];
+struct vdso_data {
 };
 
+/*
+ * The VDSO symbols are mapped into Linux so we can just use regular symbol
+ * addressing to get their offsets in userspace.  The symbols are mapped at an
+ * offset of 0, but since the linker must support setting weak undefined
+ * symbols to the absolute address 0 it also happens to support other low
+ * addresses even when the code model suggests those low addresses would not
+ * otherwise be availiable.
+ */
+#define VDSO_SYMBOL(base, name)							\
+({										\
+	extern const char __vdso_##name[];					\
+	(void __user *)((unsigned long)(base) + __vdso_##name);			\
+})
+
 #endif /* __ASM_CSKY_VDSO_H */
diff --git a/arch/csky/kernel/Makefile b/arch/csky/kernel/Makefile
index 37f37c0e934a..6c0f36010ed0 100644
--- a/arch/csky/kernel/Makefile
+++ b/arch/csky/kernel/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 extra-y := head.o vmlinux.lds
 
-obj-y += entry.o atomic.o signal.o traps.o irq.o time.o vdso.o
+obj-y += entry.o atomic.o signal.o traps.o irq.o time.o vdso.o vdso/
 obj-y += power.o syscall.o syscall_table.o setup.o
 obj-y += process.o cpu-probe.o ptrace.o stacktrace.o
 obj-y += probes/
diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
index 37ea64ed3c12..312f046d452d 100644
--- a/arch/csky/kernel/signal.c
+++ b/arch/csky/kernel/signal.c
@@ -134,7 +134,6 @@ setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 {
 	struct rt_sigframe *frame;
 	int err = 0;
-	struct csky_vdso *vdso = current->mm->context.vdso;
 
 	frame = get_sigframe(ksig, regs, sizeof(*frame));
 	if (!access_ok(frame, sizeof(*frame)))
@@ -152,7 +151,8 @@ setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 		return -EFAULT;
 
 	/* Set up to return from userspace. */
-	regs->lr = (unsigned long)(vdso->rt_signal_retcode);
+	regs->lr = (unsigned long)VDSO_SYMBOL(
+		current->mm->context.vdso, rt_sigreturn);
 
 	/*
 	 * Set up registers for signal handler.
diff --git a/arch/csky/kernel/vdso.c b/arch/csky/kernel/vdso.c
index abc3dbc658d4..839523920843 100644
--- a/arch/csky/kernel/vdso.c
+++ b/arch/csky/kernel/vdso.c
@@ -1,86 +1,103 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
-#include <linux/kernel.h>
-#include <linux/err.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/init.h>
 #include <linux/binfmts.h>
 #include <linux/elf.h>
-#include <linux/vmalloc.h>
-#include <linux/unistd.h>
-#include <linux/uaccess.h>
+#include <linux/err.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
 
+#include <asm/page.h>
 #include <asm/vdso.h>
-#include <asm/cacheflush.h>
 
-static struct page *vdso_page;
+extern char vdso_start[], vdso_end[];
 
-static int __init init_vdso(void)
-{
-	struct csky_vdso *vdso;
-	int err = 0;
-
-	vdso_page = alloc_page(GFP_KERNEL);
-	if (!vdso_page)
-		panic("Cannot allocate vdso");
+static unsigned int vdso_pages;
+static struct page **vdso_pagelist;
 
-	vdso = vmap(&vdso_page, 1, 0, PAGE_KERNEL);
-	if (!vdso)
-		panic("Cannot map vdso");
+/*
+ * The vDSO data page.
+ */
+static union {
+	struct vdso_data	data;
+	u8			page[PAGE_SIZE];
+} vdso_data_store __page_aligned_data;
+struct vdso_data *vdso_data = &vdso_data_store.data;
 
-	clear_page(vdso);
-
-	err = setup_vdso_page(vdso->rt_signal_retcode);
-	if (err)
-		panic("Cannot set signal return code, err: %x.", err);
+static int __init vdso_init(void)
+{
+	unsigned int i;
+
+	vdso_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
+	vdso_pagelist =
+		kcalloc(vdso_pages + 1, sizeof(struct page *), GFP_KERNEL);
+	if (unlikely(vdso_pagelist == NULL)) {
+		pr_err("vdso: pagelist allocation failed\n");
+		return -ENOMEM;
+	}
 
-	dcache_wb_range((unsigned long)vdso, (unsigned long)vdso + 16);
+	for (i = 0; i < vdso_pages; i++) {
+		struct page *pg;
 
-	vunmap(vdso);
+		pg = virt_to_page(vdso_start + (i << PAGE_SHIFT));
+		vdso_pagelist[i] = pg;
+	}
+	vdso_pagelist[i] = virt_to_page(vdso_data);
 
 	return 0;
 }
-subsys_initcall(init_vdso);
+arch_initcall(vdso_init);
 
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+int arch_setup_additional_pages(struct linux_binprm *bprm,
+	int uses_interp)
 {
-	int ret;
-	unsigned long addr;
 	struct mm_struct *mm = current->mm;
+	unsigned long vdso_base, vdso_len;
+	int ret;
 
-	mmap_write_lock(mm);
+	vdso_len = (vdso_pages + 1) << PAGE_SHIFT;
 
-	addr = get_unmapped_area(NULL, STACK_TOP, PAGE_SIZE, 0, 0);
-	if (IS_ERR_VALUE(addr)) {
-		ret = addr;
-		goto up_fail;
+	mmap_write_lock(mm);
+	vdso_base = get_unmapped_area(NULL, 0, vdso_len, 0, 0);
+	if (IS_ERR_VALUE(vdso_base)) {
+		ret = vdso_base;
+		goto end;
 	}
 
-	ret = install_special_mapping(
-			mm,
-			addr,
-			PAGE_SIZE,
-			VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
-			&vdso_page);
-	if (ret)
-		goto up_fail;
+	/*
+	 * Put vDSO base into mm struct. We need to do this before calling
+	 * install_special_mapping or the perf counter mmap tracking code
+	 * will fail to recognise it as a vDSO (since arch_vma_name fails).
+	 */
+	mm->context.vdso = (void *)vdso_base;
+
+	ret =
+	   install_special_mapping(mm, vdso_base, vdso_pages << PAGE_SHIFT,
+		(VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC),
+		vdso_pagelist);
+
+	if (unlikely(ret)) {
+		mm->context.vdso = NULL;
+		goto end;
+	}
 
-	mm->context.vdso = (void *)addr;
+	vdso_base += (vdso_pages << PAGE_SHIFT);
+	ret = install_special_mapping(mm, vdso_base, PAGE_SIZE,
+		(VM_READ | VM_MAYREAD), &vdso_pagelist[vdso_pages]);
 
-up_fail:
+	if (unlikely(ret))
+		mm->context.vdso = NULL;
+end:
 	mmap_write_unlock(mm);
 	return ret;
 }
 
 const char *arch_vma_name(struct vm_area_struct *vma)
 {
-	if (vma->vm_mm == NULL)
-		return NULL;
-
-	if (vma->vm_start == (long)vma->vm_mm->context.vdso)
+	if (vma->vm_mm && (vma->vm_start == (long)vma->vm_mm->context.vdso))
 		return "[vdso]";
-	else
-		return NULL;
+	if (vma->vm_mm && (vma->vm_start ==
+			   (long)vma->vm_mm->context.vdso + PAGE_SIZE))
+		return "[vdso_data]";
+	return NULL;
 }
diff --git a/arch/csky/kernel/vdso/.gitignore b/arch/csky/kernel/vdso/.gitignore
new file mode 100644
index 000000000000..3a19def868ec
--- /dev/null
+++ b/arch/csky/kernel/vdso/.gitignore
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+vdso.lds
+*.tmp
+vdso-syms.S
diff --git a/arch/csky/kernel/vdso/Makefile b/arch/csky/kernel/vdso/Makefile
new file mode 100644
index 000000000000..13ac549c6587
--- /dev/null
+++ b/arch/csky/kernel/vdso/Makefile
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
+# the inclusion of generic Makefile.
+ARCH_REL_TYPE_ABS := R_CKCORE_ADDR32|R_CKCORE_JUMP_SLOT
+include $(srctree)/lib/vdso/Makefile
+
+# Symbols present in the vdso
+vdso-syms  = rt_sigreturn
+
+# Files to link into the vdso
+obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
+
+ccflags-y := -fno-stack-protector
+
+# Build rules
+targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.lds vdso-dummy.o
+obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
+
+obj-y += vdso.o vdso-syms.o
+CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
+
+# Disable gcov profiling for VDSO code
+GCOV_PROFILE := n
+KCOV_INSTRUMENT := n
+
+# Force dependency
+$(obj)/vdso.o: $(obj)/vdso.so
+
+SYSCFLAGS_vdso.so.dbg = $(c_flags)
+$(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) FORCE
+	$(call if_changed,vdsold)
+SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
+	-Wl,--build-id=sha1 -Wl,--hash-style=both
+
+$(obj)/vdso-syms.S: $(obj)/vdso.so FORCE
+	$(call if_changed,so2s)
+
+# strip rule for the .so file
+$(obj)/%.so: OBJCOPYFLAGS := -S
+$(obj)/%.so: $(obj)/%.so.dbg FORCE
+	$(call if_changed,objcopy)
+
+# actual build commands
+# The DSO images are built using a special linker script
+# Make sure only to export the intended __vdso_xxx symbol offsets.
+quiet_cmd_vdsold = VDSOLD  $@
+      cmd_vdsold = $(CC) $(KBUILD_CFLAGS) $(call cc-option, -no-pie) -nostdlib -nostartfiles $(SYSCFLAGS_$(@F)) \
+                           -Wl,-T,$(filter-out FORCE,$^) -o $@.tmp && \
+                   $(CROSS_COMPILE)objcopy \
+                           $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@ && \
+                   rm $@.tmp
+
+# Extracts symbol offsets from the VDSO, converting them into an assembly file
+# that contains the same symbols at the same offsets.
+quiet_cmd_so2s = SO2S    $@
+      cmd_so2s = $(NM) -D $< | $(srctree)/$(src)/so2s.sh > $@
+
+# install commands for the unstripped file
+quiet_cmd_vdso_install = INSTALL $@
+      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
+
+vdso.so: $(obj)/vdso.so.dbg
+	@mkdir -p $(MODLIB)/vdso
+	$(call cmd,vdso_install)
+
+vdso_install: vdso.so
diff --git a/arch/csky/kernel/vdso/note.S b/arch/csky/kernel/vdso/note.S
new file mode 100644
index 000000000000..2a956c942211
--- /dev/null
+++ b/arch/csky/kernel/vdso/note.S
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * This supplies .note.* sections to go into the PT_NOTE inside the vDSO text.
+ * Here we can supply some information useful to userland.
+ */
+
+#include <linux/elfnote.h>
+#include <linux/version.h>
+
+ELFNOTE_START(Linux, 0, "a")
+	.long LINUX_VERSION_CODE
+ELFNOTE_END
diff --git a/arch/csky/kernel/vdso/rt_sigreturn.S b/arch/csky/kernel/vdso/rt_sigreturn.S
new file mode 100644
index 000000000000..0a6bd1216118
--- /dev/null
+++ b/arch/csky/kernel/vdso/rt_sigreturn.S
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <linux/linkage.h>
+#include <asm/unistd.h>
+#include <abi/vdso.h>
+
+	.text
+ENTRY(__vdso_rt_sigreturn)
+	.cfi_startproc
+	.cfi_signal_frame
+	SET_SYSCALL_ID
+	trap	0
+	.cfi_endproc
+ENDPROC(__vdso_rt_sigreturn)
diff --git a/arch/csky/kernel/vdso/so2s.sh b/arch/csky/kernel/vdso/so2s.sh
new file mode 100755
index 000000000000..69da3d529c6d
--- /dev/null
+++ b/arch/csky/kernel/vdso/so2s.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+
+sed 's!\([0-9a-f]*\) T \([a-z0-9_]*\)\(@@LINUX_5.10\)*!.global \2\n.set \2,0x\1!' \
+| grep '^\.'
diff --git a/arch/csky/kernel/vdso/vdso.S b/arch/csky/kernel/vdso/vdso.S
new file mode 100644
index 000000000000..5162ca069494
--- /dev/null
+++ b/arch/csky/kernel/vdso/vdso.S
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <asm/page.h>
+
+	__PAGE_ALIGNED_DATA
+
+	.globl vdso_start, vdso_end
+	.balign PAGE_SIZE
+vdso_start:
+	.incbin "arch/csky/kernel/vdso/vdso.so"
+	.balign PAGE_SIZE
+vdso_end:
+
+	.previous
diff --git a/arch/csky/kernel/vdso/vdso.lds.S b/arch/csky/kernel/vdso/vdso.lds.S
new file mode 100644
index 000000000000..8d226252d439
--- /dev/null
+++ b/arch/csky/kernel/vdso/vdso.lds.S
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <asm/page.h>
+
+OUTPUT_ARCH(csky)
+
+SECTIONS
+{
+	PROVIDE(_vdso_data = . + PAGE_SIZE);
+	. = SIZEOF_HEADERS;
+
+	.hash		: { *(.hash) }			:text
+	.gnu.hash	: { *(.gnu.hash) }
+	.dynsym		: { *(.dynsym) }
+	.dynstr		: { *(.dynstr) }
+	.gnu.version	: { *(.gnu.version) }
+	.gnu.version_d	: { *(.gnu.version_d) }
+	.gnu.version_r	: { *(.gnu.version_r) }
+
+	.note		: { *(.note.*) }		:text	:note
+	.dynamic	: { *(.dynamic) }		:text	:dynamic
+
+	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
+	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
+
+	.rodata		: { *(.rodata .rodata.* .gnu.linkonce.r.*) }
+
+	. = 0x800;
+	.text		: { *(.text .text.*) }		:text
+
+	.data		: {
+		*(.got.plt) *(.got)
+		*(.data .data.* .gnu.linkonce.d.*)
+		*(.dynbss)
+		*(.bss .bss.* .gnu.linkonce.b.*)
+	}
+}
+
+PHDRS
+{
+	text		PT_LOAD		FLAGS(5) FILEHDR PHDRS; /* PF_R|PF_X */
+	dynamic		PT_DYNAMIC	FLAGS(4);		/* PF_R */
+	note		PT_NOTE		FLAGS(4);		/* PF_R */
+	eh_frame_hdr	PT_GNU_EH_FRAME;
+}
+
+VERSION
+{
+	LINUX_5.10 {
+	global:
+		__vdso_rt_sigreturn;
+	local: *;
+	};
+}
-- 
2.17.1

