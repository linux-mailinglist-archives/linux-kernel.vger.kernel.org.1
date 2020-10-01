Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97DA2808E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgJAU7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgJAU7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:59:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EC7C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 13:59:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 53F2D29D101
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     hch@lst.de, hpa@zytor.com, bp@alien8.de, rric@kernel.org,
        peterz@infradead.org, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 0/9] Reclaim TIF_IA32 and TIF_X32
Date:   Thu,  1 Oct 2020 16:58:10 -0400
Message-Id: <20201001205819.27879-1-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI_IA32 and TIF_X32 are not strictly necessary and they are only set at
task creation time, which doesn't fit with processes that transition
between 64/32 bits.  In addition, other reasons to drop these flags are
that we are running out of TI flags for x86 and it is generally a good
idea to reduce architecture specific TI flags, before move the generic
ones to common code.

Many of the ideas for this patchset came from Andy Lutomirski (Thank
you!)

The only difference of v2 from v1 is the addition of the final 3 patches
that solve the last 3 cases of TIF_IA32 and TIF_X32 usage, and actually
remove the TI flags.

Finally, the testing for this patchset was done exercising the code
paths of each case where the flags were used with x32, ia32 and x64
applications. Finally, x86 selftests showed no regressions.


Gabriel Krisman Bertazi (9):
  x86: events: Avoid TIF_IA32 when checking 64bit mode
  x86: Simplify compat syscall userspace allocation
  x86: oprofile: Avoid TIF_IA32 when checking 64bit mode
  x86: elf: Use e_machine to choose DLINFO in compat
  x86: elf: Use e_machine to select start_thread for x32
  x86: elf: Use e_machine to select setup_additional_pages for x32
  x86: Use current USER_CS to setup correct context on vmx entry
  x86: Convert mmu context ia32_compat into a proper flags field
  x86: Reclaim TIF_IA32 and TIF_X32

 arch/x86/entry/vdso/vma.c             | 21 ++++++++++-------
 arch/x86/entry/vsyscall/vsyscall_64.c |  2 +-
 arch/x86/events/core.c                |  2 +-
 arch/x86/events/intel/ds.c            |  2 +-
 arch/x86/events/intel/lbr.c           |  2 +-
 arch/x86/include/asm/compat.h         | 15 ++++++------
 arch/x86/include/asm/elf.h            | 24 ++++++++++++++-----
 arch/x86/include/asm/mmu.h            |  6 +++--
 arch/x86/include/asm/mmu_context.h    |  2 +-
 arch/x86/include/asm/thread_info.h    |  4 ----
 arch/x86/kernel/perf_regs.c           |  2 +-
 arch/x86/kernel/process_64.c          | 34 ++++++++++++++-------------
 arch/x86/kvm/vmx/vmx.c                |  2 +-
 arch/x86/oprofile/backtrace.c         |  2 +-
 14 files changed, 67 insertions(+), 53 deletions(-)

-- 
2.28.0

