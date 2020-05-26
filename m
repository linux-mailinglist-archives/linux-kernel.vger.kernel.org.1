Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E951BA97A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgD0QA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 12:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728489AbgD0QA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:00:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38D5C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:00:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 186so2367731ybq.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/4Lv0RwdLpBbP8q3ppNzsCXSA3vQogZDo2gd5muLx+Y=;
        b=n9KrHF2mldk7Mz7gH6enPSHcDsT3axVnmACTGqW8hqjoSyGJf+Ov/N1gypzGaPzF5b
         tjH1UqrbHPM3ppck2oAqDpadYWQK3plpcdFVFDR2U7VBiBiYil/ykWh6Ak6uRtLrKKYp
         Mab8sDBlBmubI8WnEoRN6wGVrDVwHOhApQhkyBVirqIeIqMJBIY9RPdpocfTt36V5r4C
         C6Rt+Zh4w+sHpKAq2ucxcfW9XAsYE/j9N86A16uogA56kw9mR5Sk/Q1ayZ++6YnoWz/u
         oD5d2Pu3c9gIg+DD9Dv0P9k5Gm4SdC4VEOYZZFDCeFL2xLNDvg+Rv8NfKypnyO9S54CT
         K+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/4Lv0RwdLpBbP8q3ppNzsCXSA3vQogZDo2gd5muLx+Y=;
        b=hXxlAGTLDKXVbVv7ckJxQ6mXwBnaYadw27b140OMBEjt89xqfLf2ek3ZDN3TmRxTcC
         i4QX9qxo35W+CTHCqjnJEiNJ7VxVyI9j4WLxwEDWS7WAKAPDqDZdgoMFA9KGzIV09DSf
         IuabFqnusC5Jkji5+A6JxyqoJlxSO1y5KJW2UGoe+vUZT6bFATxWfU/xMvIymLK5QfBz
         b0+A17Cerp1dEcylctEh8vdPQ4R4esDN/eLkJ/JX+RMGNi8T4b7FeSBfUQ42voN+WMCu
         9k67PcQPcAngnacXaGbCGnVwYuz5R76razPAWD/2PqDpAwyyNgvCDCp7v7+gfSKtgStx
         5Kew==
X-Gm-Message-State: AGi0PuZjHyT6HkeC8A9QitLxzhoUCtCelTw4b8vL4Zt2We90wCEihI1P
        uOrHVKheIeW/VGsXHWBpE3DNmGjYFPxEfI3Kt4c=
X-Google-Smtp-Source: APiQypJnnD9EI6KF+/UDyiS/9DnXsuJlM33wVB2skvTGfCVt0jnZVDF2xIHtf5pKsXizHZdOKBi+N7X6MZrXt/R9nRU=
X-Received: by 2002:a5b:345:: with SMTP id q5mr35788916ybp.494.1588003222670;
 Mon, 27 Apr 2020 09:00:22 -0700 (PDT)
Date:   Mon, 27 Apr 2020 09:00:06 -0700
In-Reply-To: <20191018161033.261971-1-samitolvanen@google.com>
Message-Id: <20200427160018.243569-1-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v13 00/12] add support for Clang's Shadow Call Stack
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Clang's Shadow Call Stack
(SCS) mitigation, which uses a separately allocated shadow stack
to protect against return address overwrites. More information
can be found here:

  https://clang.llvm.org/docs/ShadowCallStack.html

SCS provides better protection against traditional buffer
overflows than CONFIG_STACKPROTECTOR_*, but it should be noted
that SCS security guarantees in the kernel differ from the ones
documented for user space. The kernel must store addresses of
shadow stacks in memory, which means an attacker capable of
reading and writing arbitrary memory may be able to locate them
and hijack control flow by modifying the shadow stacks.

SCS is currently supported only on arm64, where the compiler
requires the x18 register to be reserved for holding the current
task's shadow stack pointer.

With -fsanitize=shadow-call-stack, the compiler injects
instructions to all non-leaf C functions to store the return
address to the shadow stack, and unconditionally load it again
before returning. As a result, SCS is incompatible with features
that rely on modifying function return addresses in the kernel
stack to alter control flow. A copy of the return address is
still kept in the kernel stack for compatibility with stack
unwinding, for example.

SCS has a minimal performance overhead, but allocating
shadow stacks increases kernel memory usage. The feature is
therefore mostly useful on hardware that lacks support for PAC
instructions.

Changes in v13:
 - Changed thread_info::shadow_call_stack to a base address and
   an offset instead, and removed the now unneeded __scs_base()
   and scs_save().
 - Removed alignment from the kmem_cache and static allocations.
 - Removed the task_set_scs() helper function.
 - Moved the assembly code for loading and storing the offset in
   thread_info to scs_load/save macros.
 - Added offset checking to scs_corrupted().
 - Switched to cmpxchg_relaxed() in scs_check_usage().

Changes in v12:
 - Removed CONFIG_SHADOW_CALL_STACK_VMAP.
 - Added CC_IS_CLANG as a dependency to CONFIG_SHADOW_CALL_STACK.
 - Changed SCS_END_MAGIC to use POISON_POINTER_DELTA.
 - Removed the unnecessary scs_set_magic() helper function.
 - Moved scs_task_reset() and scs_corrupted() to scs.h, along with
   __scs_magic() and __scs_base().
 - Removed a redundant warning from memory allocation.
 - Removed an unnecessary task_set_scs() call from scs_release().
 - Changed the accounting code to calculate KiB instead of bytes.
 - Replaced the lock in scs_check_usage() with a cmpxchg() loop.

Changes in v11:
 - Rebased, added maintainers for kernel/ changes.

Changes in v10:
 - Removed an unnecessary <asm/scs.h> include from head.S.

Changes in v9:
 - Fixed grammar in the Kconfig help text.
 - Changed Kconfig to allow SCS to be selected with the patchable-
   function-entry graph tracer.
 - Changed the EFI stub patch to not filter out -ffixed-x18, only
   SCS flags.

Changes in v8:
 - Added __noscs to __hyp_text instead of filtering SCS flags from
   the entire arch/arm64/kvm/hyp directory.
 - Added a patch to filter out -ffixed-x18 and SCS flags from the
   EFI stub.

Changes in v7:
 - Changed irq_stack_entry/exit to store the shadow stack pointer
   in x24 instead of x20 as kernel_entry uses x20-x23 to store
   data that can be used later. Updated the comment as well.
 - Changed the Makefile in arch/arm64/kvm/hyp to also filter out
   -ffixed-x18.
 - Changed SHADOW_CALL_STACK to depend on !FUNCTION_GRAPH_TRACER
   instead of not selecting HAVE_FUNCTION_GRAPH_TRACER with SCS.
 - Removed ifdefs from the EFI wrapper and updated the comment to
   explain why we are restoring x18.
 - Rebased as Ard's x18 patches that were part of this series have
   already been merged.

Changes in v6:
 - Updated comment in the EFI RT wrapper to include the
   explanation from the commit message.
 - Fixed the SHADOW_CALL_STACK_VMAP config option and the
   compilation errors in scs_init_irq()
 - Updated the comment in entry.S to Mark's suggestion
 - Fixed the WARN_ON in scs_init() to trip only when the return
   value for cpuhp_setup_state() is < 0.
 - Removed ifdefs from the code in arch/arm64/kernel/scs.c and
   added separate shadow stacks for the SDEI handler

Changes in v5:
 - Updated the comment in __scs_base() to Mark's suggestion
 - Changed all instances of uintptr_t to unsigned long
 - Added allocation poisoning for KASAN to catch unintentional
   shadow stack accesses; moved set_set_magic before poisoning
   and switched scs_used() and scs_corrupted() to access the
   buffer using READ_ONCE_NOCHECK() instead
 - Changed scs_free() to check for NULL instead of zero
 - Renamed SCS_CACHE_SIZE to NR_CACHED_SCS
 - Added a warning if cpuhp_setup_state fails in scs_init()
 - Dropped patches disabling kretprobes after confirming there's
   no functional conflict with SCS instrumentation
 - Added an explanation to the commit message why function graph
   tracing and SCS are incompatible
 - Removed the ifdefs from arch/arm64/mm/proc.S and added
   comments explaining why we are saving and restoring x18
 - Updated scs_check_usage format to include process information

Changes in v4:
 - Fixed authorship for Ard's patches
 - Added missing commit messages
 - Commented code that clears SCS from thread_info
 - Added a comment about SCS_END_MAGIC being non-canonical

Changes in v3:
 - Switched to filter-out for removing SCS flags in Makefiles
 - Changed the __noscs attribute to use __no_sanitize__("...")
   instead of no_sanitize("...")
 - Cleaned up inline function definitions and moved task_scs()
   into a macro
 - Cleaned up scs_free() and scs_magic()
 - Moved SCS initialization into dup_task_struct() and removed
   the now unused scs_task_init()
 - Added comments to __scs_base() and scs_task_reset() to better
   document design choices
 - Changed copy_page to make the offset and bias explicit

Changes in v2:
 - Changed Ard's KVM patch to use x29 instead of x18 for the
   guest context, which makes restore_callee_saved_regs cleaner
 - Updated help text (and commit messages) to point out
   differences in security properties compared to user space SCS
 - Cleaned up config options: removed the ROP protection choice,
   replaced the CC_IS_CLANG dependency with an arch-specific
   cc-option test, and moved disabling of incompatible config
   options to an arch-specific Kconfig
 - Added CC_FLAGS_SCS, which are filtered out where needed
   instead of using DISABLE_SCS
 - Added a __has_feature guard around __noscs for older clang
   versions

Sami Tolvanen (12):
  add support for Clang's Shadow Call Stack (SCS)
  scs: add accounting
  scs: add support for stack usage debugging
  scs: disable when function graph tracing is enabled
  arm64: reserve x18 from general allocation with SCS
  arm64: preserve x18 when CPU is suspended
  arm64: efi: restore x18 if it was corrupted
  arm64: vdso: disable Shadow Call Stack
  arm64: disable SCS for hypervisor code
  arm64: implement Shadow Call Stack
  arm64: scs: add shadow stacks for SDEI
  efi/libstub: disable SCS

 Makefile                              |   6 ++
 arch/Kconfig                          |  25 ++++++
 arch/arm64/Kconfig                    |   5 ++
 arch/arm64/Makefile                   |   4 +
 arch/arm64/include/asm/kvm_hyp.h      |   2 +-
 arch/arm64/include/asm/scs.h          |  46 ++++++++++
 arch/arm64/include/asm/suspend.h      |   2 +-
 arch/arm64/include/asm/thread_info.h  |  13 +++
 arch/arm64/kernel/Makefile            |   1 +
 arch/arm64/kernel/asm-offsets.c       |   4 +
 arch/arm64/kernel/efi-rt-wrapper.S    |  11 ++-
 arch/arm64/kernel/entry.S             |  38 +++++++-
 arch/arm64/kernel/head.S              |   6 ++
 arch/arm64/kernel/process.c           |   2 +
 arch/arm64/kernel/scs.c               |  20 +++++
 arch/arm64/kernel/vdso/Makefile       |   2 +-
 arch/arm64/mm/proc.S                  |  14 +++
 drivers/base/node.c                   |   6 ++
 drivers/firmware/efi/libstub/Makefile |   3 +
 fs/proc/meminfo.c                     |   4 +
 include/linux/compiler-clang.h        |   6 ++
 include/linux/compiler_types.h        |   4 +
 include/linux/mmzone.h                |   3 +
 include/linux/scs.h                   |  72 +++++++++++++++
 init/init_task.c                      |   8 ++
 kernel/Makefile                       |   1 +
 kernel/fork.c                         |   9 ++
 kernel/sched/core.c                   |   2 +
 kernel/scs.c                          | 121 ++++++++++++++++++++++++++
 mm/page_alloc.c                       |   6 ++
 mm/vmstat.c                           |   3 +
 31 files changed, 442 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/include/asm/scs.h
 create mode 100644 arch/arm64/kernel/scs.c
 create mode 100644 include/linux/scs.h
 create mode 100644 kernel/scs.c


base-commit: 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c
-- 
2.26.2.303.gf8c07b1a785-goog

