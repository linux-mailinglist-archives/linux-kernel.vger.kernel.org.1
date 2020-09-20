Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AEC271784
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 21:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgITTX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 15:23:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:41054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgITTX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 15:23:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 43FAEAF1A;
        Sun, 20 Sep 2020 19:23:59 +0000 (UTC)
Date:   Sun, 20 Sep 2020 21:23:15 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.9-rc6
Message-ID: <20200920192315.GC13044@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the x86/urgent pile accumulated so far.

Thx.

---
The following changes since commit f4d51dffc6c01a9e94650d95ce0104964f8ae822:

  Linux 5.9-rc4 (2020-09-06 17:11:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.9_rc6

for you to fetch changes up to 6f9885a36c006d798319661fa849f9c2922223b9:

  x86/unwind/fp: Fix FP unwinding in ret_from_fork (2020-09-18 09:59:40 +0200)

----------------------------------------------------------------
* A defconfig fix, from Daniel Díaz.

* Disable relocation relaxation for the compressed kernel when not built
  as -pie as in that case kernels built with clang and linked with LLD
  fail to boot due to the linker optimizing some instructions in non-PIE
  form; the gory details in the commit message, from Arvind Sankar.

* A fix for the "bad bp value" warning issued by the frame-pointer
  unwinder, from Josh Poimboeuf.

----------------------------------------------------------------
Arvind Sankar (1):
      x86/boot/compressed: Disable relocation relaxation

Daniel Díaz (1):
      x86/defconfigs: Explicitly unset CONFIG_64BIT in i386_defconfig

Josh Poimboeuf (1):
      x86/unwind/fp: Fix FP unwinding in ret_from_fork

 arch/x86/boot/compressed/Makefile |  2 ++
 arch/x86/configs/i386_defconfig   |  1 +
 arch/x86/include/asm/frame.h      | 19 +++++++++++++++++++
 arch/x86/kernel/process.c         |  3 ++-
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 3962f592633d..ff7894f39e0e 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -43,6 +43,8 @@ KBUILD_CFLAGS += -Wno-pointer-sign
 KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS += -D__DISABLE_EXPORTS
+# Disable relocation relaxation in case the link is not PIE.
+KBUILD_CFLAGS += $(call as-option,-Wa$(comma)-mrelax-relocations=no)
 
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n
diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index d7577fece9eb..4cfdf5755ab5 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -19,6 +19,7 @@ CONFIG_CGROUP_CPUACCT=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
+# CONFIG_64BIT is not set
 CONFIG_SMP=y
 CONFIG_X86_GENERIC=y
 CONFIG_HPET_TIMER=y
diff --git a/arch/x86/include/asm/frame.h b/arch/x86/include/asm/frame.h
index 296b346184b2..fb42659f6e98 100644
--- a/arch/x86/include/asm/frame.h
+++ b/arch/x86/include/asm/frame.h
@@ -60,12 +60,26 @@
 #define FRAME_END "pop %" _ASM_BP "\n"
 
 #ifdef CONFIG_X86_64
+
 #define ENCODE_FRAME_POINTER			\
 	"lea 1(%rsp), %rbp\n\t"
+
+static inline unsigned long encode_frame_pointer(struct pt_regs *regs)
+{
+	return (unsigned long)regs + 1;
+}
+
 #else /* !CONFIG_X86_64 */
+
 #define ENCODE_FRAME_POINTER			\
 	"movl %esp, %ebp\n\t"			\
 	"andl $0x7fffffff, %ebp\n\t"
+
+static inline unsigned long encode_frame_pointer(struct pt_regs *regs)
+{
+	return (unsigned long)regs & 0x7fffffff;
+}
+
 #endif /* CONFIG_X86_64 */
 
 #endif /* __ASSEMBLY__ */
@@ -83,6 +97,11 @@
 
 #define ENCODE_FRAME_POINTER
 
+static inline unsigned long encode_frame_pointer(struct pt_regs *regs)
+{
+	return 0;
+}
+
 #endif
 
 #define FRAME_BEGIN
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 13ce616cc7af..ba4593a913fa 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -42,6 +42,7 @@
 #include <asm/spec-ctrl.h>
 #include <asm/io_bitmap.h>
 #include <asm/proto.h>
+#include <asm/frame.h>
 
 #include "process.h"
 
@@ -133,7 +134,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	fork_frame = container_of(childregs, struct fork_frame, regs);
 	frame = &fork_frame->frame;
 
-	frame->bp = 0;
+	frame->bp = encode_frame_pointer(childregs);
 	frame->ret_addr = (unsigned long) ret_from_fork;
 	p->thread.sp = (unsigned long) fork_frame;
 	p->thread.io_bitmap = NULL;

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
