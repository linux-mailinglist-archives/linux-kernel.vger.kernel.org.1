Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910502DD4C9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 17:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgLQQDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 11:03:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:52640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgLQQDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 11:03:35 -0500
From:   guoren@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        mhiramat@kernel.org, alankao@andestech.com, rostedt@goodmis.org,
        bjorn.topel@intel.com, pdp7pdp7@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org, linux-csky@vger.kernel.org,
        greentime.hu@sifive.com, zong.li@sifive.com, guoren@kernel.org,
        me@packi.ch, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH v5 0/9] Add k/uprobe & fentry & error_injection supported
Date:   Thu, 17 Dec 2020 16:01:36 +0000
Message-Id: <1608220905-1962-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This the 5th round of riscv k/uprobe support patchset, it's based on
linux-5.10 and you can test it with the repo: 

 https://github.com/c-sky/csky-linux/tree/linux-5.10-probe-dev

The important fixup is about the trampoline call site, we change the
prologue of the function call site from:

    <funca>:
        nop -> addi sp, sp, -SZREG
        nop -> REG_S ra, (sp)
        nop -> auipc ra, 0x?
        nop -> jalr ?(ra)
        nop -> REG_L ra, (sp)
        nop -> addi sp, sp, -SZREG
        ...

to:

    <funca>:
        nop -> REG_S ra, -SZREG(sp)
        nop -> auipc ra, 0x?
        nop -> jalr ?(ra)
        nop -> REG_L ra, -SZREG(sp)
        ...

It's wrong to change the sp in callsite, because when you change the value of
ra then the sp is broken and the same with HAVE_OPTPROBES.

The patchset includes kprobe/uprobe support and some related fixups.
Patrick provides HAVE_REGS_AND_STACK_ACCESS_API support and some
kprobe's code. The framework of k/uprobe is from csky but also refers
to other arches'. kprobes on ftrace is also supported in the patchset.
Modify dynamic ftrace mechanism from mcount to fentry.

There is no single step exception in riscv ISA, only single-step
facility for jtag. See riscv-Privileged spec:

Interrupt Exception Code-Description
1 0 Reserved
1 1 Supervisor software interrupt
1 2–4 Reserved
1 5 Supervisor timer interrupt
1 6–8 Reserved
1 9 Supervisor external interrupt
1 10–15 Reserved
1 ≥16 Available for platform use
0 0 Instruction address misaligned
0 1 Instruction access fault
0 2 Illegal instruction
0 3 Breakpoint
0 4 Load address misaligned
0 5 Load access fault
0 6 Store/AMO address misaligned
0 7 Store/AMO access fault
0 8 Environment call from U-mode
0 9 Environment call from S-mode
0 10–11 Reserved
0 12 Instruction page fault
0 13 Load page fault
0 14 Reserved
0 15 Store/AMO page fault
0 16–23 Reserved
0 24–31 Available for custom use
0 32–47 Reserved
0 48–63 Available for custom use
0 ≥64 Reserved

No single step!

Other arches use hardware single-step exception for k/uprobe,  eg:
 - powerpc: regs->msr |= MSR_SINGLESTEP
 - arm/arm64: PSTATE.D for enabling software step exceptions
 - s390: Set PER control regs, turns on single step for the given address
 - x86: regs->flags |= X86_EFLAGS_TF
 - csky: of course use hw single step :)

All the above arches use a hardware single-step exception
mechanism to execute the instruction that was replaced with a probe
breakpoint. So utilize ebreak to simulate.

Some pc related instructions couldn't be executed out of line and some
system/fence instructions couldn't be a trace site at all. So we give
out a reject list and simulate list in decode-insn.c.

You could use uprobe to test simulate code like this:

 echo 'p:enter_current_state_one /hello:0x6e4 a0=%a0 a1=%a1' >> /sys/kernel/debug/tracing/uprobe_events
 echo 1 > /sys/kernel/debug/tracing/events/uprobes/enable
 /hello
 ^C
 cat /sys/kernel/debug/tracing/trace
 tracer: nop

 entries-in-buffer/entries-written: 1/1   #P:1

                              _-----=> irqs-off
                             / _----=> need-resched
                            | / _---=> hardirq/softirq
                            || / _--=> preempt-depth
                            ||| /     delay
           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
              | |       |   ||||       |         |
          hello-94    [000] d...    55.404242: enter_current_state_one: (0x106e4) a0=0x1 a1=0x3fffa8ada8

Be care /hello:0x6e4 is the file offset in elf and it relate to 0x106e4
in memory and hello is your target elf program.

Try kprobe like this:

 echo 'p:myprobe sys_clone a0=%a0 a1=%a1 a2=%a2 a3=%a3 stach_val=+4($stack)' > /sys/kernel/debug/tracing/kprobe_events
 echo 'r:myretprobe sys_clone $retval' >> /sys/kernel/debug/tracing/kprobe_events
 echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
 cat /sys/kernel/debug/tracing/trace
 tracer: nop

 entries-in-buffer/entries-written: 2/2   #P:1

                                _-----=> irqs-off
                               / _----=> need-resched
                              | / _---=> hardirq/softirq
                              || / _--=> preempt-depth
                              ||| /     delay
           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
              | |         |   ||||      |         |
              sh-92      [000] .n..  8506.435857: myprobe: (sys_clone+0x0/0x28) a0=0x1200011 a1=0x0 a2=0x0 a3=0x0 stach_val=0x2044ecffffffe0
              sh-92      [000] d...  8506.445620: myretprobe: (ret_from_syscall+0x0/0x2 <- sys_clone) arg1=0x64

Changlog v5:
 - Fixup fentry modified sp cause fail_inject error
 - Fixup function_graph broken
 - Update to linux-5.10
 - Fixup checkpatch.pl issues

Changlog v4:
 - Revert fixup kprobes handler couldn't change pc
 - Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT
 - rebase on linux-tree:
commit 071a0578b0ce0b0e543d1e38ee6926b9cc21c198
Merge: fad7011 be4df0c
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Oct 16 15:29:46 2020 -0700

    Merge tag 'ovl-update-5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs

Changlog v3:
 - Add upport for function error injection
 - Fixup kprobes handler couldn't change pc

Changlog v2:
 - Add Reviewed-by, Tested-by, Acked-by, thx for all of you
 - Add kprobes on ftrace feature
 - Use __always_inline as same as fix_to_virt for fixup
   BUILD_BUG_ON
 - Use const "const unsigned int" for 2th param for fixup
   BUILD_BUG_ON


Guo Ren (8):
  riscv: Fixup compile error BUILD_BUG_ON failed
  riscv: Fixup wrong ftrace remove cflag
  riscv: Fixup patch_text panic in ftrace
  riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT
  riscv: Add kprobes supported
  riscv: Add KPROBES_ON_FTRACE supported
  riscv: Add uprobes supported
  riscv: Add support for function error injection

Patrick Stählin (1):
  RISC-V: Implement ptrace regs and stack API

 arch/riscv/Kconfig                            |   8 +
 arch/riscv/Makefile                           |   2 +
 arch/riscv/include/asm/kprobes.h              |  40 +++
 arch/riscv/include/asm/probes.h               |  24 ++
 arch/riscv/include/asm/processor.h            |   1 +
 arch/riscv/include/asm/ptrace.h               |  35 +++
 arch/riscv/include/asm/thread_info.h          |   4 +-
 arch/riscv/include/asm/uprobes.h              |  40 +++
 arch/riscv/kernel/Makefile                    |   6 +-
 arch/riscv/kernel/ftrace.c                    |  95 +++---
 arch/riscv/kernel/mcount-dyn.S                | 342 ++++++++++------------
 arch/riscv/kernel/patch.c                     |   8 +-
 arch/riscv/kernel/probes/Makefile             |   6 +
 arch/riscv/kernel/probes/decode-insn.c        |  48 ++++
 arch/riscv/kernel/probes/decode-insn.h        |  18 ++
 arch/riscv/kernel/probes/ftrace.c             |  53 ++++
 arch/riscv/kernel/probes/kprobes.c            | 398 ++++++++++++++++++++++++++
 arch/riscv/kernel/probes/kprobes_trampoline.S |  93 ++++++
 arch/riscv/kernel/probes/simulate-insn.c      |  85 ++++++
 arch/riscv/kernel/probes/simulate-insn.h      |  47 +++
 arch/riscv/kernel/probes/uprobes.c            | 186 ++++++++++++
 arch/riscv/kernel/ptrace.c                    |  99 +++++++
 arch/riscv/kernel/signal.c                    |   3 +
 arch/riscv/kernel/traps.c                     |  19 ++
 arch/riscv/lib/Makefile                       |   2 +
 arch/riscv/lib/error-inject.c                 |  10 +
 arch/riscv/mm/Makefile                        |   3 +-
 arch/riscv/mm/fault.c                         |  10 +
 28 files changed, 1444 insertions(+), 241 deletions(-)
 create mode 100644 arch/riscv/include/asm/probes.h
 create mode 100644 arch/riscv/include/asm/uprobes.h
 create mode 100644 arch/riscv/kernel/probes/Makefile
 create mode 100644 arch/riscv/kernel/probes/decode-insn.c
 create mode 100644 arch/riscv/kernel/probes/decode-insn.h
 create mode 100644 arch/riscv/kernel/probes/ftrace.c
 create mode 100644 arch/riscv/kernel/probes/kprobes.c
 create mode 100644 arch/riscv/kernel/probes/kprobes_trampoline.S
 create mode 100644 arch/riscv/kernel/probes/simulate-insn.c
 create mode 100644 arch/riscv/kernel/probes/simulate-insn.h
 create mode 100644 arch/riscv/kernel/probes/uprobes.c
 create mode 100644 arch/riscv/lib/error-inject.c

-- 
2.7.4

