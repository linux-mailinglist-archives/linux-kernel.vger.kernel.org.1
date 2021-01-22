Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AEF2FFFDA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbhAVKMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:12:06 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:57774 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbhAVKGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:06:30 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DMZdG4THgz9vBmm;
        Fri, 22 Jan 2021 11:05:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id HmvJJTgS_C-x; Fri, 22 Jan 2021 11:05:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DMZdG3RDHz9vBml;
        Fri, 22 Jan 2021 11:05:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A889B8B818;
        Fri, 22 Jan 2021 11:05:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3nCgHEcowuoo; Fri, 22 Jan 2021 11:05:23 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5FBD38B773;
        Fri, 22 Jan 2021 11:05:23 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3015F66AAE; Fri, 22 Jan 2021 10:05:23 +0000 (UTC)
Message-Id: <cover.1611309841.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 00/14] powerpc/32: Reduce head complexity and re-activate MMU earlier
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 22 Jan 2021 10:05:23 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a first step on the way to C syscall/exception entry/exit.

This series aims at reducing exception/syscall prologs complexity.
It also brings earlier MMU re-activation.

This series is based on Nick's v6 series "powerpc: interrupt wrappers".
It takes benefit of the removal of traps arguments (patches 2-7 of that series).
I have squashed those patches as second patch of my series in order to
please test robots. My series cleanly applies on top of entire Nick's series.

v2 has been reworked in order to apply to all PPC32, including BOOKE and 40x.

At the time being, we have two pathes in the prologs: one for
when we have VMAP stack and one when we don't.

When VMAP stack is supported, there is special prolog code to
allow accessing stack with MMU on.

That code that accesses VM stack with MMU on is also able to access
linear memory, so it can also access non VM stack with MMU on.

CONFIG_VMAP_STACK as been on by default on 6xx and 8xx for several
kernel releases now, so it is known to work.

On the 8xx, null_syscall runs in 292 cycles with VMAP_STACK and in
296 cycles without VMAP stack.
On the 832x, null_syscall runs in 224 cycles with VMAP_STACK and in
213 cycles without VMAP stack.

By removing the old non VMAP stack code, and using the same prolog
regardless of the activation of VMAP stacks, we make the code a lot
simplier and reduce the number of test cases.

BOOKE has MMU always on, so there is no change needed for that.
To allow removal of the old non VMAP stack code, only 40x need
to get adapted to support earlier MMU activation. That's what
patches 3-8 are for.

Once this is done, we easily go one step further and re-activate
Instruction translation at the same time as data translation.

At the end, null_syscall runs in 286 cycles on the 8xx and in 216
cycles on the 832x

Changes in v2:
- Implemented early MMU activation also on 40x
- Added BOOKE in the loop
- Removed the patches that replace r11 by r1 all over the place (too
much churn for very small benefit for now)

Christophe Leroy (14):
  powerpc/32s: Only build hash code when CONFIG_PPC_BOOK3S_604 is
    selected
  NOT TO BE MERGED - Squash of patches 2-7 of v6 series "powerpc:
    interrupt wrappers"
  powerpc/40x: Don't use SPRN_SPRG_SCRATCH0/1 in TLB miss handlers
  powerpc/40x: Change CRITICAL_EXCEPTION_PROLOG macro to a gas macro
  powerpc/40x: Save SRR0/SRR1 and r10/r11 earlier in critical exception
  powerpc/40x: Reorder a few instructions in critical exception prolog
  powerpc/40x: Prepare for enabling MMU in critical exception prolog
  powerpc/40x: Prepare normal exception handler for enabling MMU early
  powerpc/32: Preserve cr1 in exception prolog stack check
  powerpc/32: Use LOAD_REG_IMMEDIATE() to load MSR values
  powerpc/32: Always enable data translation in exception prolog
  powerpc/32: Enable instruction translation at the same time as data
    translation
  powerpc/32: Remove msr argument in EXC_XFER_TEMPLATE()
  powerpc/32: Use fast instructions to change MSR EE/RI when available

 arch/powerpc/include/asm/asm-prototypes.h     |   4 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |   1 +
 arch/powerpc/include/asm/bug.h                |   7 +-
 arch/powerpc/include/asm/debug.h              |   3 +-
 arch/powerpc/include/asm/hw_irq.h             |  46 +++++
 arch/powerpc/include/asm/processor.h          |   4 +-
 arch/powerpc/kernel/asm-offsets.c             |   2 -
 arch/powerpc/kernel/entry_32.S                | 128 ++++----------
 arch/powerpc/kernel/exceptions-64e.S          |   5 +-
 arch/powerpc/kernel/exceptions-64s.S          | 164 +++++------------
 arch/powerpc/kernel/fpu.S                     |   2 -
 arch/powerpc/kernel/head_32.h                 | 167 ++++--------------
 arch/powerpc/kernel/head_40x.S                | 161 +++++++++--------
 arch/powerpc/kernel/head_8xx.S                |  26 +--
 arch/powerpc/kernel/head_book3s_32.S          |  52 ++----
 arch/powerpc/kernel/head_booke.h              |  20 +--
 arch/powerpc/kernel/idle_6xx.S                |  12 +-
 arch/powerpc/kernel/idle_e500.S               |   4 +-
 arch/powerpc/kernel/process.c                 |   7 +-
 arch/powerpc/kernel/traps.c                   |   2 +-
 arch/powerpc/kernel/vector.S                  |   2 -
 arch/powerpc/mm/book3s32/Makefile             |   4 +-
 arch/powerpc/mm/book3s32/hash_low.S           |  14 --
 arch/powerpc/mm/book3s64/hash_utils.c         |  79 ++++++---
 arch/powerpc/mm/book3s64/slb.c                |  11 +-
 arch/powerpc/mm/fault.c                       |  18 +-
 arch/powerpc/platforms/8xx/machine_check.c    |   2 +-
 27 files changed, 354 insertions(+), 593 deletions(-)

-- 
2.25.0

