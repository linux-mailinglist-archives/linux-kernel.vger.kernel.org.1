Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D4A282863
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 05:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgJDD0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 23:26:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35164 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgJDD0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 23:26:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 873FD29B018
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     hch@lst.de, hpa@zytor.com, bp@alien8.de, rric@kernel.org,
        peterz@infradead.org, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        sean.j.christopherson@intel.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 09/10] x86: Convert mmu context ia32_compat into a proper flags field
Date:   Sat,  3 Oct 2020 23:25:35 -0400
Message-Id: <20201004032536.1229030-10-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004032536.1229030-1-krisman@collabora.com>
References: <20201004032536.1229030-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ia32_compat attribute is a weird thing.  It mirrors TIF_IA32 and
TIF_X32 and is used only in two very unrelated places: (1) to decide if
the vsyscall page is accessible (2) for uprobes to find whether the
patched instruction is 32 or 64 bit.  In preparation to remove the TI
flags, we want new values for ia32_compat, but given its odd semantics,
I'd rather make it a real flags field that configures these specific
behaviours.  So, set_personality_x64 can ask for the vsyscall page,
which is not available in x32/ia32 and set_personality_ia32 can
configure the uprobe code as needed.

uprobe cannot rely on other methods like user_64bit_mode() to decide how
to patch, so it needs some specific flag like this.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Rename MM_CONTEXT_GATE_PAGE -> MM_CONTEXT_HAS_VSYSCALL (andy)
---
 arch/x86/entry/vsyscall/vsyscall_64.c |  2 +-
 arch/x86/include/asm/mmu.h            |  6 ++++--
 arch/x86/include/asm/mmu_context.h    |  2 +-
 arch/x86/kernel/process_64.c          | 17 +++++++++++------
 4 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 44c33103a955..1b40b9297083 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -316,7 +316,7 @@ static struct vm_area_struct gate_vma __ro_after_init = {
 struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
 {
 #ifdef CONFIG_COMPAT
-	if (!mm || mm->context.ia32_compat)
+	if (!mm || !(mm->context.flags & MM_CONTEXT_HAS_VSYSCALL))
 		return NULL;
 #endif
 	if (vsyscall_mode == NONE)
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 9257667d13c5..6a00665574ea 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -7,6 +7,9 @@
 #include <linux/mutex.h>
 #include <linux/atomic.h>
 
+#define MM_CONTEXT_UPROBE_IA32	1 /* Uprobes on this MM assume 32-bit code */
+#define MM_CONTEXT_HAS_VSYSCALL	2 /* Whether vsyscall page is accessible on this MM */
+
 /*
  * x86 has arch-specific MMU state beyond what lives in mm_struct.
  */
@@ -33,8 +36,7 @@ typedef struct {
 #endif
 
 #ifdef CONFIG_X86_64
-	/* True if mm supports a task running in 32 bit compatibility mode. */
-	unsigned short ia32_compat;
+	unsigned short flags;
 #endif
 
 	struct mutex lock;
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index d98016b83755..054a79157323 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -177,7 +177,7 @@ static inline void arch_exit_mmap(struct mm_struct *mm)
 static inline bool is_64bit_mm(struct mm_struct *mm)
 {
 	return	!IS_ENABLED(CONFIG_IA32_EMULATION) ||
-		!(mm->context.ia32_compat == TIF_IA32);
+		!(mm->context.flags & MM_CONTEXT_UPROBE_IA32);
 }
 #else
 static inline bool is_64bit_mm(struct mm_struct *mm)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index a4935d134e9d..40fa7973e4f0 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -646,10 +646,8 @@ void set_personality_64bit(void)
 	/* Pretend that this comes from a 64bit execve */
 	task_pt_regs(current)->orig_ax = __NR_execve;
 	current_thread_info()->status &= ~TS_COMPAT;
-
-	/* Ensure the corresponding mm is not marked. */
 	if (current->mm)
-		current->mm->context.ia32_compat = 0;
+		current->mm->context.flags = MM_CONTEXT_HAS_VSYSCALL;
 
 	/* TBD: overwrites user setup. Should have two bits.
 	   But 64bit processes have always behaved this way,
@@ -664,7 +662,8 @@ static void __set_personality_x32(void)
 	clear_thread_flag(TIF_IA32);
 	set_thread_flag(TIF_X32);
 	if (current->mm)
-		current->mm->context.ia32_compat = TIF_X32;
+		current->mm->context.flags = 0;
+
 	current->personality &= ~READ_IMPLIES_EXEC;
 	/*
 	 * in_32bit_syscall() uses the presence of the x32 syscall bit
@@ -684,8 +683,14 @@ static void __set_personality_ia32(void)
 #ifdef CONFIG_IA32_EMULATION
 	set_thread_flag(TIF_IA32);
 	clear_thread_flag(TIF_X32);
-	if (current->mm)
-		current->mm->context.ia32_compat = TIF_IA32;
+	if (current->mm) {
+		/*
+		 * uprobes applied to this MM need to know this and
+		 * cannot use user_64bit_mode() at that time.
+		 */
+		current->mm->context.flags = MM_CONTEXT_UPROBE_IA32;
+	}
+
 	current->personality |= force_personality32;
 	/* Prepare the first "return" to user space */
 	task_pt_regs(current)->orig_ax = __NR_ia32_execve;
-- 
2.28.0

