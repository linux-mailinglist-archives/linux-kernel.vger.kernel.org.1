Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DA329C9FB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 21:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1831108AbgJ0UPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 16:15:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48974 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505285AbgJ0UPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:15:33 -0400
Date:   Tue, 27 Oct 2020 20:14:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603829730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lMGyUmeI6bymP1yo7e/SbKcx/v0csOVfQWAzUe9zyLI=;
        b=F2lBIEitTahPZr5cR8AU7xy/UZPmCJRzVEsoRtvt0ynI7WuE5dBvIAHEL5APHUfiLbWDYp
        N0WaWpa600jTy6rwRfLnqm2zyG87bVKREmIpcvzNnWYN+HTYIuXesvvvOj2cUMi7T09fAB
        CQo1RiABzpn5pH+5UGiRMj6I/gQlBOUHdZMTjlv7vd69I+rdm3iynOG3Hci0lJzAUPXPKG
        Gki/ZPcWbLJs+j0faD7Uz3RGNTxGcPAuIEIVI2D2PgFDpOiiSW4YskqSuXNSsyZBW3ykYg
        U4CkHGqXlHasQSnLpBxYRemi4gLUA2eJzfgoRuz98DnyvJMcOJGtewyPL9b+bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603829730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lMGyUmeI6bymP1yo7e/SbKcx/v0csOVfQWAzUe9zyLI=;
        b=7amHByd5kpPiSflDQhDY4lZXov0GTTGX0Cel9Swm/eWMOGY9rXEa10mTiYf3hHMkNydWTy
        CE84LeqmUUm2d3DA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for 5.10-rc2
Message-ID: <160382969970.21153.12631210500316115410.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-10-27

up to:  abee7c494d8c: x86/alternative: Don't call text_poke() in lazy TLB mode

A couple of x86 fixes which missed rc1 due to my stupidity:

  - Drop lazy TLB mode before switching to the temporary address space for
    text patching. text_poke() switches to the temporary mm which clears
    the lazy mode and restores the original mm afterwards. Due to clearing
    lazy mode this might restore a already dead mm if exit_mmap() runs in
    parallel on another CPU.

  - Document the x32 syscall design fail vs. syscall numbers 512-547
    properly.

  - Fix the ORC unwinder to handle the inactive task frame correctly. This
    was unearthed due to the slightly different code generation of GCC10.

  - Use an up to date screen_info for the boot params of kexec instead of
    the possibly stale and invalid version which happened to be valid when
    the kexec kernel was loaded.

Thanks,

	tglx

------------------>
Andy Lutomirski (1):
      x86/syscalls: Document the fact that syscalls 512-547 are a legacy mistake

Jiri Slaby (1):
      x86/unwind/orc: Fix inactive tasks with stack pointer in %sp on GCC 10 compiled kernels

Juergen Gross (1):
      x86/alternative: Don't call text_poke() in lazy TLB mode

Kairui Song (2):
      x86/kexec: Use up-to-dated screen_info copy to fill boot params
      hyperv_fb: Update screen_info after removing old framebuffer


 arch/x86/entry/syscalls/syscall_64.tbl | 10 ++++++----
 arch/x86/kernel/alternative.c          |  9 +++++++++
 arch/x86/kernel/kexec-bzimage64.c      |  3 +--
 arch/x86/kernel/unwind_orc.c           |  9 +--------
 drivers/video/fbdev/hyperv_fb.c        |  9 ++++++++-
 5 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f30d6ae9a688..4adb5d2a3319 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -363,10 +363,10 @@
 439	common	faccessat2		sys_faccessat2
 
 #
-# x32-specific system call numbers start at 512 to avoid cache impact
-# for native 64-bit operation. The __x32_compat_sys stubs are created
-# on-the-fly for compat_sys_*() compatibility system calls if X86_X32
-# is defined.
+# Due to a historical design error, certain syscalls are numbered differently
+# in x32 as compared to native x86_64.  These syscalls have numbers 512-547.
+# Do not add new syscalls to this range.  Numbers 548 and above are available
+# for non-x32 use.
 #
 512	x32	rt_sigaction		compat_sys_rt_sigaction
 513	x32	rt_sigreturn		compat_sys_x32_rt_sigreturn
@@ -404,3 +404,5 @@
 545	x32	execveat		compat_sys_execveat
 546	x32	preadv2			compat_sys_preadv64v2
 547	x32	pwritev2		compat_sys_pwritev64v2
+# This is the end of the legacy x32 range.  Numbers 548 and above are
+# not special and are not to be used for x32-specific syscalls.
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index cdaab30880b9..cd6be6f143e8 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -807,6 +807,15 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
 	temp_mm_state_t temp_state;
 
 	lockdep_assert_irqs_disabled();
+
+	/*
+	 * Make sure not to be in TLB lazy mode, as otherwise we'll end up
+	 * with a stale address space WITHOUT being in lazy mode after
+	 * restoring the previous mm.
+	 */
+	if (this_cpu_read(cpu_tlbstate.is_lazy))
+		leave_mm(smp_processor_id());
+
 	temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	switch_mm_irqs_off(NULL, mm, current);
 
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 57c2ecf43134..ce831f9448e7 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -200,8 +200,7 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	params->hdr.hardware_subarch = boot_params.hdr.hardware_subarch;
 
 	/* Copying screen_info will do? */
-	memcpy(&params->screen_info, &boot_params.screen_info,
-				sizeof(struct screen_info));
+	memcpy(&params->screen_info, &screen_info, sizeof(struct screen_info));
 
 	/* Fill in memsize later */
 	params->screen_info.ext_mem_k = 0;
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index ec88bbe08a32..4a96aa3de7d8 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -320,19 +320,12 @@ EXPORT_SYMBOL_GPL(unwind_get_return_address);
 
 unsigned long *unwind_get_return_address_ptr(struct unwind_state *state)
 {
-	struct task_struct *task = state->task;
-
 	if (unwind_done(state))
 		return NULL;
 
 	if (state->regs)
 		return &state->regs->ip;
 
-	if (task != current && state->sp == task->thread.sp) {
-		struct inactive_task_frame *frame = (void *)task->thread.sp;
-		return &frame->ret_addr;
-	}
-
 	if (state->sp)
 		return (unsigned long *)state->sp - 1;
 
@@ -662,7 +655,7 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 	} else {
 		struct inactive_task_frame *frame = (void *)task->thread.sp;
 
-		state->sp = task->thread.sp;
+		state->sp = task->thread.sp + sizeof(*frame);
 		state->bp = READ_ONCE_NOCHECK(frame->bp);
 		state->ip = READ_ONCE_NOCHECK(frame->ret_addr);
 		state->signal = (void *)state->ip == ret_from_fork;
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 02411d89cb46..e36fb1a0ecdb 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1114,8 +1114,15 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 getmem_done:
 	remove_conflicting_framebuffers(info->apertures,
 					KBUILD_MODNAME, false);
-	if (!gen2vm)
+
+	if (gen2vm) {
+		/* framebuffer is reallocated, clear screen_info to avoid misuse from kexec */
+		screen_info.lfb_size = 0;
+		screen_info.lfb_base = 0;
+		screen_info.orig_video_isVGA = 0;
+	} else {
 		pci_dev_put(pdev);
+	}
 	kfree(info->apertures);
 
 	return 0;

