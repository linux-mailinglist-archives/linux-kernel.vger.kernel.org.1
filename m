Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CC528285F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 05:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgJDD0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 23:26:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35104 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgJDD0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 23:26:07 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 128E129B008
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     hch@lst.de, hpa@zytor.com, bp@alien8.de, rric@kernel.org,
        peterz@infradead.org, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        sean.j.christopherson@intel.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 06/10] x86: elf: Use e_machine to select start_thread for x32
Date:   Sat,  3 Oct 2020 23:25:32 -0400
Message-Id: <20201004032536.1229030-7-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004032536.1229030-1-krisman@collabora.com>
References: <20201004032536.1229030-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since TIF_X32 is going away, avoid using it to find the ELF type in
compat_start_thread.

According to SysV AMD64 ABI Draft, an AMD64 ELF object using ILP32 must
have ELFCLASS32 with (E_MACHINE == EM_X86_64), so use that ELF field to
differentiate a x32 object from a IA32 object when executing
start_thread in compat mode.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Avoid a function-like macro in compat_start_thread (Andy)
---
 arch/x86/include/asm/elf.h   | 5 +++--
 arch/x86/kernel/process_64.c | 5 ++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 9220efc65d78..109697a19eb1 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -186,8 +186,9 @@ static inline void elf_common_init(struct thread_struct *t,
 #define	COMPAT_ELF_PLAT_INIT(regs, load_addr)		\
 	elf_common_init(&current->thread, regs, __USER_DS)
 
-void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp);
-#define compat_start_thread compat_start_thread
+void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp, bool x32);
+#define COMPAT_START_THREAD(ex, regs, new_ip, new_sp)	\
+	compat_start_thread(regs, new_ip, new_sp, ex->e_machine == EM_X86_64)
 
 void set_personality_ia32(bool);
 #define COMPAT_SET_PERSONALITY(ex)			\
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 9afefe325acb..a4935d134e9d 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -511,11 +511,10 @@ start_thread(struct pt_regs *regs, unsigned long new_ip, unsigned long new_sp)
 EXPORT_SYMBOL_GPL(start_thread);
 
 #ifdef CONFIG_COMPAT
-void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp)
+void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp, bool x32)
 {
 	start_thread_common(regs, new_ip, new_sp,
-			    test_thread_flag(TIF_X32)
-			    ? __USER_CS : __USER32_CS,
+			    x32 ? __USER_CS : __USER32_CS,
 			    __USER_DS, __USER_DS);
 }
 #endif
-- 
2.28.0

