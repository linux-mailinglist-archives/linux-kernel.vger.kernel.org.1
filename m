Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B00282859
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 05:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgJDDZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 23:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgJDDZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 23:25:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FE2C0613D0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 20:25:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id B9B1027ED16
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     hch@lst.de, hpa@zytor.com, bp@alien8.de, rric@kernel.org,
        peterz@infradead.org, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        sean.j.christopherson@intel.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 00/10] Reclaim TIF_IA32 and TIF_X32
Date:   Sat,  3 Oct 2020 23:25:26 -0400
Message-Id: <20201004032536.1229030-1-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third version of the patch to reclaim those TI flags.  The
main difference from v2 is that it exports the elf32 headers in the
macros in a proper way, instead of doing some magic to use them.

Andy, I didn't follow (my understanding of) your suggestion to expose
the elf32 headers because by doing that in compat_start_thread would
mean also doing it in start_thread, but the later is not ELF specific.
The mechanism I used, which solves the issue and I hope is not
over-complex is the same that SET_PERSONALITY does, so there is
precedent.  It also has the benefit that we don't need to touch other
architecture functions.  Do you think in this patch series is fine?

This also drops the vmx patch, since that is being reworked by Sean and
Andy, and my patch doesn't change its behavior.

* original cover letter:

We are running out of TI flags for x86.  This patchset removes several
usages of TIF_IA32 and TIF_x32 in preparation to reclaim these flags.
After these cleanups, there is still one more user for both of them,
which I need to take a better look before removing.

Many of the ideas for this patchset came from Andy Lutomirski (Thank
you!)

These were tested by exercising these paths with x32 and ia32 binaries.

Gabriel Krisman Bertazi (10):
  x86: events: Avoid TIF_IA32 when checking 64bit mode
  x86: Simplify compat syscall userspace allocation
  x86: oprofile: Avoid TIF_IA32 when checking 64bit mode
  x86: elf: Use e_machine to choose DLINFO in compat
  elf: Expose ELF header in compat_start_thread
  x86: elf: Use e_machine to select start_thread for x32
  elf: Expose ELF header on arch_setup_additional_pages
  x86: elf: Use e_machine to select additional_pages between x32
  x86: Convert mmu context ia32_compat into a proper flags field
  x86: Reclaim TIF_IA32 and TIF_X32

 arch/x86/entry/vdso/vma.c             |  4 ++--
 arch/x86/entry/vsyscall/vsyscall_64.c |  2 +-
 arch/x86/events/core.c                |  2 +-
 arch/x86/events/intel/ds.c            |  2 +-
 arch/x86/events/intel/lbr.c           |  2 +-
 arch/x86/include/asm/compat.h         | 15 +++++++-------
 arch/x86/include/asm/elf.h            | 13 ++++++++-----
 arch/x86/include/asm/mmu.h            |  6 ++++--
 arch/x86/include/asm/mmu_context.h    |  2 +-
 arch/x86/include/asm/thread_info.h    |  4 ----
 arch/x86/kernel/perf_regs.c           |  2 +-
 arch/x86/kernel/process_64.c          | 28 +++++++++++++--------------
 arch/x86/oprofile/backtrace.c         |  2 +-
 fs/binfmt_elf.c                       |  4 ++--
 fs/compat_binfmt_elf.c                | 20 ++++++++++++++-----
 include/linux/elf.h                   | 10 ++++++++++
 16 files changed, 68 insertions(+), 50 deletions(-)

-- 
2.28.0

