Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932D7285A4B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgJGITM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:19:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:45694 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgJGITL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:19:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 28615AD7C;
        Wed,  7 Oct 2020 08:19:10 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH] x86/unwind/orc: fix inactive tasks with sp in sp
Date:   Wed,  7 Oct 2020 10:19:09 +0200
Message-Id: <20201007081909.29226-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-10 optimizes the scheduler code differently than its predecessors,
depending on DEBUG_SECTION_MISMATCH=y config -- the config sets
-fno-inline-functions-called-once. Until now, __schedule contained the
usual prologue (push bp; mov sp,bp). ORC unwinder simply picked sp from
bp and unwound from __schedule just perfectly:
$ cat /proc/1/stack
[<0>] ep_poll+0x3e9/0x450
[<0>] do_epoll_wait+0xaa/0xc0
[<0>] __x64_sys_epoll_wait+0x1a/0x20
[<0>] do_syscall_64+0x33/0x40
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

But now, w/o bp prologue:
$ cat /proc/1/stack
<nothing>

The orc entry of the point in __schedule is:
sp:sp+88 bp:last_sp-48 type:call end:0

In this case, nobody subtracts sizeof "struct inactive_task_frame". The
struct is put on the stack by __switch_to_asm. Only then __switch_to_asm
stores sp to task->thread.sp. But we start unwinding from a point in
__schedule (stored in frame->ret_addr by 'call') and not in
__switch_to_asm.

So for these example values in __unwind_start:
sp=ffff94b50001fdc8 bp=ffff8e1f41d29340 ip=__schedule+0x1f0

The stack is:
 ffff94b50001fdc8: ffff8e1f41578000 # struct inactive_task_frame
 ffff94b50001fdd0: 0000000000000000
 ffff94b50001fdd8: ffff8e1f41d29340
 ffff94b50001fde0: ffff8e1f41611d40 # ...
 ffff94b50001fde8: ffffffff93c41920 # bx
 ffff94b50001fdf0: ffff8e1f41d29340 # bp
 ffff94b50001fdf8: ffffffff9376cad0 # end of the struct (ret_addr)

0xffffffff9376cad0 is __schedule+0x1f0 (after the call to
__switch_to_asm).  Now follow those 88 bytes from the ORC entry (sp+88).
The entry is correct, __schedule really pushes 48 bytes (8*7) + 32 bytes
via subq to store some local values (like 4U below). So to unwind, look
at the offset 88-sizeof(long) = 0x50 from here:

 ffff94b50001fe00: ffff8e1f41578618
 ffff94b50001fe08: 00000cc000000255
 ffff94b50001fe10: 0000000500000004
 ffff94b50001fe18: 7793fab6956b2d00 # NOTE (see below)
 ffff94b50001fe20: ffff8e1f41578000
 ffff94b50001fe28: ffff8e1f41578000
 ffff94b50001fe30: ffff8e1f41578000
 ffff94b50001fe38: ffff8e1f41578000
 ffff94b50001fe40: ffff94b50001fed8
 ffff94b50001fe48: ffff8e1f41577ff0
 ffff94b50001fe50: ffffffff9376cf12

Here               ^^^^^^^^^^^^^^^^ is the correct ret addr from
__schedule. It translates to schedule+0x42 (insn after a call to
__schedule).

BUT, unwind_next_frame tries to take the address starting from
0xffff94b50001fdc8. That is exactly from thread.sp+88-sizeof(long) =
0xffff94b50001fdc8+88-8 = 0xffff94b50001fe18, which is garbage marked as
NOTE above. So this quits the unwinding as 7793fab6956b2d00 is obviously
not a kernel address.

There was a fix to skip 'struct inactive_task_frame' in
unwind_get_return_address_ptr in commit 187b96db5ca7 ("x86/unwind/orc:
Fix unwind_get_return_address_ptr() for inactive tasks").

But we need to skip the struct already in the unwinder proper. So
subtract the size (increase the stack pointer) of the structure in
__unwind_start directly. This allows for removal of the code added by
commit 187b96db5ca7 completely, as the address is now at
'(unsigned long *)state->sp - 1', the same as in the generic case.

Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Bug: https://bugzilla.suse.com/show_bug.cgi?id=1176907
---
 arch/x86/kernel/unwind_orc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 6a339ce328e0..4492465fd77b 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -321,19 +321,12 @@ EXPORT_SYMBOL_GPL(unwind_get_return_address);
 
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
 
@@ -663,7 +656,13 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 	} else {
 		struct inactive_task_frame *frame = (void *)task->thread.sp;
 
-		state->sp = task->thread.sp;
+		/*
+		 * @ret_addr is in __schedule _before_ the @frame is pushed to
+		 * the stack, but @thread.sp is saved in __switch_to_asm only
+		 * _after_ saving the @frame, so subtract the @frame size, i.e.
+		 * add it to @thread.sp.
+		 */
+		state->sp = task->thread.sp + sizeof(*frame);
 		state->bp = READ_ONCE_NOCHECK(frame->bp);
 		state->ip = READ_ONCE_NOCHECK(frame->ret_addr);
 		state->signal = (void *)state->ip == ret_from_fork;
-- 
2.28.0

