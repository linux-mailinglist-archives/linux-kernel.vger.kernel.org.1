Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE49B2F39E3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436494AbhALTSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436478AbhALTSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:18:46 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5A2C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:18:05 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id i7so2068290pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=tRocDBL479oJ1SnnG9CByWUGNSwm/pLAX9mBthCnHbI=;
        b=fE9M0/8RdbrERI9Tyx1kCXzw7GD2RsD6vzkGLiDSF8TjDtURHAB0Z8Ad9F4EHxgkZx
         47FwaFDvb4b8u3or9x6FDrvjhsWWXsR9kvvLsw6uunP3W9clKa+UJsCJd+IkfpE9CUZS
         OLcKjwIUpJhJR3ZuR72DP1KX4OdgVQwCJqnRxsxhYTgCJ42qOtnygXUrgzoDuJsXnJhl
         wIea+xi/EgxQ8bIcJiv1go0GpmU58xM53tqAqRASM1EzsgJrhkdTVV6v6JfLdP7AG/js
         7T/wdJ5KORX+Aj0EHe39Qd+4sUMBrJwgeY9WPjoIap9o0xWSXdcOJb/atE6JdtfbFnCE
         mqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=tRocDBL479oJ1SnnG9CByWUGNSwm/pLAX9mBthCnHbI=;
        b=mzWh6vJ0LovFPRFrDMKuxL79rKo+lzS2uZD8R3xr7vrODr+DAoNM3L7xDjhNt/KO0w
         ACgjLtub9VGMUBTsk/R+ZPfnWcukVZy7rQdiNeaEB6ynvhahaf/nCrXM02Qpcfo5Mjl/
         jc9FJOSMyv1lUPhpbAq8vZ0RTeMbybhuJkse3xJw2Kl9r/OCQG8qe76YKYF8k2HsfPfX
         b2q+ogyRp8n83KFAB1JL6yp4UR5ptcC2IYZFdkB9bhBk6eOIEmx3FVM+FpUsJtbZJ0TB
         OSpb4r1dVDLL4CQvbtnsGNTaxHkCuTV0g2sxhDF4gPrER6kpCVIZBzLJHb3DmYl3z9wh
         UKpw==
X-Gm-Message-State: AOAM532MZtbKsdED/F5P20gR6cx4bqRYUcNLESYd+VW4cuvFcQIsmifc
        6LKbgUJ55hcRJYVxFNloQqlcgg==
X-Google-Smtp-Source: ABdhPJxS1euzXl+eV5Ano8ylVae3RrZE87WJAhTmunwTBG2zDilovLe9H80oYB0km8Dk7Yoke0PSaQ==
X-Received: by 2002:a63:1f21:: with SMTP id f33mr532046pgf.31.1610479085005;
        Tue, 12 Jan 2021 11:18:05 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id m26sm3920831pfo.123.2021.01.12.11.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 11:18:04 -0800 (PST)
Date:   Tue, 12 Jan 2021 11:18:04 -0800 (PST)
X-Google-Original-Date: Tue, 12 Jan 2021 11:18:02 PST (-0800)
Subject:     Re: [PATCH v5 0/9] Add k/uprobe & fentry & error_injection supported
In-Reply-To: <1608220905-1962-1-git-send-email-guoren@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, mhiramat@kernel.org,
        alankao@andestech.com, rostedt@goodmis.org, bjorn.topel@intel.com,
        pdp7pdp7@gmail.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, anup@brainfault.org,
        linux-csky@vger.kernel.org, greentime.hu@sifive.com,
        zong.li@sifive.com, guoren@kernel.org, me@packi.ch,
        guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     guoren@kernel.org
Message-ID: <mhng-e2d0b1bb-151d-437f-8952-8d73fb231bd0@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Dec 2020 08:01:36 PST (-0800), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> This the 5th round of riscv k/uprobe support patchset, it's based on
> linux-5.10 and you can test it with the repo:
>
>  https://github.com/c-sky/csky-linux/tree/linux-5.10-probe-dev
>
> The important fixup is about the trampoline call site, we change the
> prologue of the function call site from:
>
>     <funca>:
>         nop -> addi sp, sp, -SZREG
>         nop -> REG_S ra, (sp)
>         nop -> auipc ra, 0x?
>         nop -> jalr ?(ra)
>         nop -> REG_L ra, (sp)
>         nop -> addi sp, sp, -SZREG
>         ...
>
> to:
>
>     <funca>:
>         nop -> REG_S ra, -SZREG(sp)
>         nop -> auipc ra, 0x?
>         nop -> jalr ?(ra)
>         nop -> REG_L ra, -SZREG(sp)
>         ...
>
> It's wrong to change the sp in callsite, because when you change the value of
> ra then the sp is broken and the same with HAVE_OPTPROBES.
>
> The patchset includes kprobe/uprobe support and some related fixups.
> Patrick provides HAVE_REGS_AND_STACK_ACCESS_API support and some
> kprobe's code. The framework of k/uprobe is from csky but also refers
> to other arches'. kprobes on ftrace is also supported in the patchset.
> Modify dynamic ftrace mechanism from mcount to fentry.
>
> There is no single step exception in riscv ISA, only single-step
> facility for jtag. See riscv-Privileged spec:
>
> Interrupt Exception Code-Description
> 1 0 Reserved
> 1 1 Supervisor software interrupt
> 1 2–4 Reserved
> 1 5 Supervisor timer interrupt
> 1 6–8 Reserved
> 1 9 Supervisor external interrupt
> 1 10–15 Reserved
> 1 ≥16 Available for platform use
> 0 0 Instruction address misaligned
> 0 1 Instruction access fault
> 0 2 Illegal instruction
> 0 3 Breakpoint
> 0 4 Load address misaligned
> 0 5 Load access fault
> 0 6 Store/AMO address misaligned
> 0 7 Store/AMO access fault
> 0 8 Environment call from U-mode
> 0 9 Environment call from S-mode
> 0 10–11 Reserved
> 0 12 Instruction page fault
> 0 13 Load page fault
> 0 14 Reserved
> 0 15 Store/AMO page fault
> 0 16–23 Reserved
> 0 24–31 Available for custom use
> 0 32–47 Reserved
> 0 48–63 Available for custom use
> 0 ≥64 Reserved
>
> No single step!
>
> Other arches use hardware single-step exception for k/uprobe,  eg:
>  - powerpc: regs->msr |= MSR_SINGLESTEP
>  - arm/arm64: PSTATE.D for enabling software step exceptions
>  - s390: Set PER control regs, turns on single step for the given address
>  - x86: regs->flags |= X86_EFLAGS_TF
>  - csky: of course use hw single step :)
>
> All the above arches use a hardware single-step exception
> mechanism to execute the instruction that was replaced with a probe
> breakpoint. So utilize ebreak to simulate.
>
> Some pc related instructions couldn't be executed out of line and some
> system/fence instructions couldn't be a trace site at all. So we give
> out a reject list and simulate list in decode-insn.c.
>
> You could use uprobe to test simulate code like this:
>
>  echo 'p:enter_current_state_one /hello:0x6e4 a0=%a0 a1=%a1' >> /sys/kernel/debug/tracing/uprobe_events
>  echo 1 > /sys/kernel/debug/tracing/events/uprobes/enable
>  /hello
>  ^C
>  cat /sys/kernel/debug/tracing/trace
>  tracer: nop
>
>  entries-in-buffer/entries-written: 1/1   #P:1
>
>                               _-----=> irqs-off
>                              / _----=> need-resched
>                             | / _---=> hardirq/softirq
>                             || / _--=> preempt-depth
>                             ||| /     delay
>            TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
>               | |       |   ||||       |         |
>           hello-94    [000] d...    55.404242: enter_current_state_one: (0x106e4) a0=0x1 a1=0x3fffa8ada8
>
> Be care /hello:0x6e4 is the file offset in elf and it relate to 0x106e4
> in memory and hello is your target elf program.
>
> Try kprobe like this:
>
>  echo 'p:myprobe sys_clone a0=%a0 a1=%a1 a2=%a2 a3=%a3 stach_val=+4($stack)' > /sys/kernel/debug/tracing/kprobe_events
>  echo 'r:myretprobe sys_clone $retval' >> /sys/kernel/debug/tracing/kprobe_events
>  echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
>  cat /sys/kernel/debug/tracing/trace
>  tracer: nop
>
>  entries-in-buffer/entries-written: 2/2   #P:1
>
>                                 _-----=> irqs-off
>                                / _----=> need-resched
>                               | / _---=> hardirq/softirq
>                               || / _--=> preempt-depth
>                               ||| /     delay
>            TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
>               | |         |   ||||      |         |
>               sh-92      [000] .n..  8506.435857: myprobe: (sys_clone+0x0/0x28) a0=0x1200011 a1=0x0 a2=0x0 a3=0x0 stach_val=0x2044ecffffffe0
>               sh-92      [000] d...  8506.445620: myretprobe: (ret_from_syscall+0x0/0x2 <- sys_clone) arg1=0x64
>
> Changlog v5:
>  - Fixup fentry modified sp cause fail_inject error
>  - Fixup function_graph broken
>  - Update to linux-5.10
>  - Fixup checkpatch.pl issues
>
> Changlog v4:
>  - Revert fixup kprobes handler couldn't change pc
>  - Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT
>  - rebase on linux-tree:
> commit 071a0578b0ce0b0e543d1e38ee6926b9cc21c198
> Merge: fad7011 be4df0c
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Fri Oct 16 15:29:46 2020 -0700
>
>     Merge tag 'ovl-update-5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs
>
> Changlog v3:
>  - Add upport for function error injection
>  - Fixup kprobes handler couldn't change pc
>
> Changlog v2:
>  - Add Reviewed-by, Tested-by, Acked-by, thx for all of you
>  - Add kprobes on ftrace feature
>  - Use __always_inline as same as fix_to_virt for fixup
>    BUILD_BUG_ON
>  - Use const "const unsigned int" for 2th param for fixup
>    BUILD_BUG_ON
>
>
> Guo Ren (8):
>   riscv: Fixup compile error BUILD_BUG_ON failed
>   riscv: Fixup wrong ftrace remove cflag
>   riscv: Fixup patch_text panic in ftrace
>   riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT
>   riscv: Add kprobes supported
>   riscv: Add KPROBES_ON_FTRACE supported
>   riscv: Add uprobes supported
>   riscv: Add support for function error injection
>
> Patrick Stählin (1):
>   RISC-V: Implement ptrace regs and stack API
>
>  arch/riscv/Kconfig                            |   8 +
>  arch/riscv/Makefile                           |   2 +
>  arch/riscv/include/asm/kprobes.h              |  40 +++
>  arch/riscv/include/asm/probes.h               |  24 ++
>  arch/riscv/include/asm/processor.h            |   1 +
>  arch/riscv/include/asm/ptrace.h               |  35 +++
>  arch/riscv/include/asm/thread_info.h          |   4 +-
>  arch/riscv/include/asm/uprobes.h              |  40 +++
>  arch/riscv/kernel/Makefile                    |   6 +-
>  arch/riscv/kernel/ftrace.c                    |  95 +++---
>  arch/riscv/kernel/mcount-dyn.S                | 342 ++++++++++------------
>  arch/riscv/kernel/patch.c                     |   8 +-
>  arch/riscv/kernel/probes/Makefile             |   6 +
>  arch/riscv/kernel/probes/decode-insn.c        |  48 ++++
>  arch/riscv/kernel/probes/decode-insn.h        |  18 ++
>  arch/riscv/kernel/probes/ftrace.c             |  53 ++++
>  arch/riscv/kernel/probes/kprobes.c            | 398 ++++++++++++++++++++++++++
>  arch/riscv/kernel/probes/kprobes_trampoline.S |  93 ++++++
>  arch/riscv/kernel/probes/simulate-insn.c      |  85 ++++++
>  arch/riscv/kernel/probes/simulate-insn.h      |  47 +++
>  arch/riscv/kernel/probes/uprobes.c            | 186 ++++++++++++
>  arch/riscv/kernel/ptrace.c                    |  99 +++++++
>  arch/riscv/kernel/signal.c                    |   3 +
>  arch/riscv/kernel/traps.c                     |  19 ++
>  arch/riscv/lib/Makefile                       |   2 +
>  arch/riscv/lib/error-inject.c                 |  10 +
>  arch/riscv/mm/Makefile                        |   3 +-
>  arch/riscv/mm/fault.c                         |  10 +
>  28 files changed, 1444 insertions(+), 241 deletions(-)
>  create mode 100644 arch/riscv/include/asm/probes.h
>  create mode 100644 arch/riscv/include/asm/uprobes.h
>  create mode 100644 arch/riscv/kernel/probes/Makefile
>  create mode 100644 arch/riscv/kernel/probes/decode-insn.c
>  create mode 100644 arch/riscv/kernel/probes/decode-insn.h
>  create mode 100644 arch/riscv/kernel/probes/ftrace.c
>  create mode 100644 arch/riscv/kernel/probes/kprobes.c
>  create mode 100644 arch/riscv/kernel/probes/kprobes_trampoline.S
>  create mode 100644 arch/riscv/kernel/probes/simulate-insn.c
>  create mode 100644 arch/riscv/kernel/probes/simulate-insn.h
>  create mode 100644 arch/riscv/kernel/probes/uprobes.c
>  create mode 100644 arch/riscv/lib/error-inject.c

Thanks, these are on for-next.  I've fixed up a few things, LMK if there were
any issues.
