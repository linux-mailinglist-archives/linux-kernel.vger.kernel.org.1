Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355002808ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733092AbgJAU7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgJAU7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:59:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3552FC0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 13:59:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 9EFDD29D102
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     hch@lst.de, hpa@zytor.com, bp@alien8.de, rric@kernel.org,
        peterz@infradead.org, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 5/9] x86: elf: Use e_machine to select start_thread for x32
Date:   Thu,  1 Oct 2020 16:58:15 -0400
Message-Id: <20201001205819.27879-6-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001205819.27879-1-krisman@collabora.com>
References: <20201001205819.27879-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since TIF_X32 is going away, avoid using it to find the ELF type on
compat_start_thread

According to SysV AMD64 ABI Draft, an AMD64 ELF object using ILP32 must
have ELFCLASS32 with (E_MACHINE == EM_X86_64), so use that ELF field to
differentiate a x32 object from a IA32 object when executing
start_thread in compat mode.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/x86/include/asm/elf.h   | 11 +++++++++--
 arch/x86/kernel/process_64.c | 11 +++++++----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 9220efc65d78..33c1c9be2e07 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -186,8 +186,15 @@ static inline void elf_common_init(struct thread_struct *t,
 #define	COMPAT_ELF_PLAT_INIT(regs, load_addr)		\
 	elf_common_init(&current->thread, regs, __USER_DS)
 
-void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp);
-#define compat_start_thread compat_start_thread
+void compat_start_thread_ia32(struct pt_regs *regs, u32 new_ip, u32 new_sp);
+void compat_start_thread_x32(struct pt_regs *regs, u32 new_ip, u32 new_sp);
+#define compat_start_thread(regs, new_ip, new_sp)			\
+do {									\
+	if (elf_ex->e_machine == EM_X86_64)				\
+		compat_start_thread_x32(regs, new_ip, new_sp);		\
+	else								\
+		compat_start_thread_ia32(regs, new_ip, new_sp);		\
+} while (0)
 
 void set_personality_ia32(bool);
 #define COMPAT_SET_PERSONALITY(ex)			\
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 9afefe325acb..56e882c339e6 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -511,12 +511,15 @@ start_thread(struct pt_regs *regs, unsigned long new_ip, unsigned long new_sp)
 EXPORT_SYMBOL_GPL(start_thread);
 
 #ifdef CONFIG_COMPAT
-void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp)
+void compat_start_thread_ia32(struct pt_regs *regs, u32 new_ip, u32 new_sp)
 {
 	start_thread_common(regs, new_ip, new_sp,
-			    test_thread_flag(TIF_X32)
-			    ? __USER_CS : __USER32_CS,
-			    __USER_DS, __USER_DS);
+			    __USER32_CS, __USER_DS, __USER_DS);
+}
+void compat_start_thread_x32(struct pt_regs *regs, u32 new_ip, u32 new_sp)
+{
+	start_thread_common(regs, new_ip, new_sp,
+			    __USER_CS, __USER_DS, __USER_DS);
 }
 #endif
 
-- 
2.28.0

