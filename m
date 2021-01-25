Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FDA3036C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389103AbhAZGod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:44:33 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:58163 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729776AbhAYOtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:49:25 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DPXm76ZRTz9v0Gl;
        Mon, 25 Jan 2021 15:48:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zG_eQLxfB_tD; Mon, 25 Jan 2021 15:48:07 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DPXm75L2Vz9v0Gh;
        Mon, 25 Jan 2021 15:48:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4AD6D8B79F;
        Mon, 25 Jan 2021 15:48:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zF5ohHZvB0O4; Mon, 25 Jan 2021 15:48:13 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F3E8A8B79E;
        Mon, 25 Jan 2021 15:48:12 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id CC49566AD8; Mon, 25 Jan 2021 14:48:12 +0000 (UTC)
Message-Id: <cover.1611585031.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 00/23] powerpc/32: Implement C syscall entry/exit
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 25 Jan 2021 14:48:12 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements C syscall entry/exit for PPC32. It reuses
the work already done for PPC64.

This series is based on Nick's v6 series "powerpc: interrupt wrappers".

Patch 1 is a bug fix submitted separately but this series depends on it.
Patches 2-4 are an extract from the series "powerpc/32: Reduce head
complexity and re-activate MMU earlier". The changes here are limited
to system calls. That series will be respined to only contain exception
related changes and the syscall changes will remain in this series.
Patches 5-16 are preparatory changes.
Patch 17 is THE patch that changes to C syscall entry/exit
Patches 18-23 are optimisations.

In terms on performance we have the following number of cycles on an
8xx running null_syscall benchmark:
- mainline: 296 cycles
- after patch 4: 283 cycles
- after patch 16: 304 cycles
- after patch 17: 348 cycles
- at the end of the series: 320 cycles

So in summary, we have a degradation of performance of 8% on null_syscall.

I think it is not a big degradation, it is worth it.

v4 is the first mature version.

Christophe Leroy (23):
  powerpc/32s: Add missing call to kuep_lock on syscall entry
  powerpc/32: Always enable data translation on syscall entry
  powerpc/32: On syscall entry, enable instruction translation at the
    same time as data
  powerpc/32: Reorder instructions to avoid using CTR in syscall entry
  powerpc/64s: Make kuap_check_amr() and kuap_get_and_check_amr()
    generic
  powerpc/32s: Create C version of kuap_user/kernel_restore() and
    friends
  powerpc/8xx: Create C version of kuap_user/kernel_restore() and
    friends
  powerpc/irq: Add helper to set regs->softe
  powerpc/irq: Rework helpers that manipulate MSR[EE/RI]
  powerpc/irq: Add stub irq_soft_mask_return() for PPC32
  powerpc/syscall: Rename syscall_64.c into syscall.c
  powerpc/syscall: Make syscall.c buildable on PPC32
  powerpc/syscall: Use is_compat_task()
  powerpc/syscall: Save r3 in regs->orig_r3
  powerpc/syscall: Change condition to check MSR_RI
  powerpc/32: Always save non volatile GPRs at syscall entry
  powerpc/syscall: implement system call entry/exit logic in C for PPC32
  powerpc/32: Remove verification of MSR_PR on syscall in the ASM entry
  powerpc/syscall: Avoid stack frame in likely part of
    system_call_exception()
  powerpc/syscall: Do not check unsupported scv vector on PPC32
  powerpc/syscall: Remove FULL_REGS verification in
    system_call_exception
  powerpc/syscall: Optimise checks in beginning of
    system_call_exception()
  powerpc/syscall: Avoid storing 'current' in another pointer

 arch/powerpc/include/asm/book3s/32/kup.h      |  33 ++
 arch/powerpc/include/asm/book3s/64/kup.h      |  24 +-
 arch/powerpc/include/asm/hw_irq.h             |  91 ++++--
 arch/powerpc/include/asm/kup.h                |   9 +-
 arch/powerpc/include/asm/nohash/32/kup-8xx.h  |  27 ++
 arch/powerpc/include/asm/reg.h                |   1 +
 arch/powerpc/kernel/Makefile                  |   4 +-
 arch/powerpc/kernel/entry_32.S                | 305 ++----------------
 arch/powerpc/kernel/entry_64.S                |   1 -
 arch/powerpc/kernel/head_32.h                 |  76 +----
 arch/powerpc/kernel/head_booke.h              |  27 +-
 .../kernel/{syscall_64.c => syscall.c}        |  57 ++--
 arch/powerpc/kernel/syscalls/syscall.tbl      |  20 +-
 13 files changed, 225 insertions(+), 450 deletions(-)
 rename arch/powerpc/kernel/{syscall_64.c => syscall.c} (90%)

-- 
2.25.0

