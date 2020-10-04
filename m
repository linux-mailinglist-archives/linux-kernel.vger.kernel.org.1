Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC03282862
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 05:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgJDD0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 23:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgJDD0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 23:26:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1288EC0613D0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 20:26:22 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id C98F529B038
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     hch@lst.de, hpa@zytor.com, bp@alien8.de, rric@kernel.org,
        peterz@infradead.org, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        sean.j.christopherson@intel.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 10/10] x86: Reclaim TIF_IA32 and TIF_X32
Date:   Sat,  3 Oct 2020 23:25:36 -0400
Message-Id: <20201004032536.1229030-11-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004032536.1229030-1-krisman@collabora.com>
References: <20201004032536.1229030-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that these flags are no longer used, reclaim those TI bits.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/x86/include/asm/thread_info.h | 4 ----
 arch/x86/kernel/process_64.c       | 6 ------
 2 files changed, 10 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 267701ae3d86..6888aa39c4d6 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -91,7 +91,6 @@ struct thread_info {
 #define TIF_NEED_FPU_LOAD	14	/* load FPU on return to userspace */
 #define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
-#define TIF_IA32		17	/* IA32 compatibility process */
 #define TIF_SLD			18	/* Restore split lock detection on context switch */
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
@@ -101,7 +100,6 @@ struct thread_info {
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
 #define TIF_SYSCALL_TRACEPOINT	28	/* syscall tracepoint instrumentation */
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
-#define TIF_X32			30	/* 32-bit native x86-64 binary */
 #define TIF_FSCHECK		31	/* Check FS is USER_DS on return */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
@@ -121,7 +119,6 @@ struct thread_info {
 #define _TIF_NEED_FPU_LOAD	(1 << TIF_NEED_FPU_LOAD)
 #define _TIF_NOCPUID		(1 << TIF_NOCPUID)
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
-#define _TIF_IA32		(1 << TIF_IA32)
 #define _TIF_SLD		(1 << TIF_SLD)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
@@ -130,7 +127,6 @@ struct thread_info {
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
-#define _TIF_X32		(1 << TIF_X32)
 #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
 
 /* flags to check in __switch_to() */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 40fa7973e4f0..9e71101e9d61 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -640,9 +640,7 @@ void set_personality_64bit(void)
 	/* inherit personality from parent */
 
 	/* Make sure to be in 64bit mode */
-	clear_thread_flag(TIF_IA32);
 	clear_thread_flag(TIF_ADDR32);
-	clear_thread_flag(TIF_X32);
 	/* Pretend that this comes from a 64bit execve */
 	task_pt_regs(current)->orig_ax = __NR_execve;
 	current_thread_info()->status &= ~TS_COMPAT;
@@ -659,8 +657,6 @@ void set_personality_64bit(void)
 static void __set_personality_x32(void)
 {
 #ifdef CONFIG_X86_X32
-	clear_thread_flag(TIF_IA32);
-	set_thread_flag(TIF_X32);
 	if (current->mm)
 		current->mm->context.flags = 0;
 
@@ -681,8 +677,6 @@ static void __set_personality_x32(void)
 static void __set_personality_ia32(void)
 {
 #ifdef CONFIG_IA32_EMULATION
-	set_thread_flag(TIF_IA32);
-	clear_thread_flag(TIF_X32);
 	if (current->mm) {
 		/*
 		 * uprobes applied to this MM need to know this and
-- 
2.28.0

