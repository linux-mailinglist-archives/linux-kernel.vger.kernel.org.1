Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8694029104F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 09:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437342AbgJQHGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 03:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407996AbgJQHGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 03:06:35 -0400
Received: from localhost.localdomain (89.208.247.74.16clouds.com [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB8402074A;
        Sat, 17 Oct 2020 07:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602918394;
        bh=/LtuFC32HdpunjUXAspDamUzMaTXFVgzmWAwg+mV4qc=;
        h=From:To:Cc:Subject:Date:From;
        b=QgLpgFwmKr6GB/h20QF9rlZdqE7gS2ns2m62hU0OxICugdG28eV0a+JUz443gdw84
         Eyly/eow/LUvL3s7GWqbkxZIamrzBvkTf4Qpo3tMyt8+rANLEhvZWpMqThAMQJQ5fG
         sEIGWFa05k8wpu0TTNxOroqrTuZtUVoQI70NoBrU=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        mhiramat@kernel.org, alankao@andestech.com, rostedt@goodmis.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org, linux-csky@vger.kernel.org,
        greentime.hu@sifive.com, zong.li@sifive.com, guoren@kernel.org,
        me@packi.ch, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH v4 0/9] Add k/uprobe & fentry & error_injection supported
Date:   Sat, 17 Oct 2020 07:06:08 +0000
Message-Id: <1602918377-23573-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

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

 echo 'p:myprobe _do_fork dfd=%a0 filename=%a1 flags=%a2 mode=+4($stack)' > /sys/kernel/debug/tracing/kprobe_events
 echo 'r:myretprobe _do_fork $retval' >> /sys/kernel/debug/tracing/kprobe_event

 echo 1 >/sys/kernel/debug/tracing/events/kprobes/enable
 cat /sys/kernel/debug/tracing/trace
 tracer: nop

 entries-in-buffer/entries-written: 2/2   #P:1

                              _-----=> irqs-off
                             / _----=> need-resched
                            | / _---=> hardirq/softirq
                            || / _--=> preempt-depth
                            ||| /     delay
           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
              | |       |   ||||       |         |
             sh-92    [000] .n..   131.804230: myprobe: (_do_fork+0x0/0x2e6) dfd=0xffffffe03929fdf8 filename=0x0 flags=0x101000 mode=0x1200000ffffffe0
             sh-92    [000] d...   131.806607: myretprobe: (__do_sys_clone+0x70/0x82 <- _do_fork) arg1=0x5f
 cat /sys/kernel/debug/tracing/trace

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
  riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT
  riscv: Add kprobes supported
  riscv: Add KPROBES_ON_FTRACE supported
  riscv: Add uprobes supported
  riscv: Add support for function error injection
  riscv: Fixup lockdep_assert_held(&text_mutex) in patch_insn_write

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
 arch/riscv/kernel/Makefile                    |   5 +-
 arch/riscv/kernel/ftrace.c                    |  94 +++---
 arch/riscv/kernel/mcount-dyn.S                | 211 ++++++--------
 arch/riscv/kernel/patch.c                     |  15 +-
 arch/riscv/kernel/probes/Makefile             |   6 +
 arch/riscv/kernel/probes/decode-insn.c        |  48 ++++
 arch/riscv/kernel/probes/decode-insn.h        |  18 ++
 arch/riscv/kernel/probes/ftrace.c             |  52 ++++
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
 arch/riscv/mm/Makefile                        |   2 +-
 arch/riscv/mm/fault.c                         |  11 +
 28 files changed, 1369 insertions(+), 189 deletions(-)
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

