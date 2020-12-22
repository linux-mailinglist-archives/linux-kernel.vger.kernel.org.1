Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467072E0AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbgLVN3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:29:12 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:1077 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbgLVN3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:29:11 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4D0cbn5l4Jz9v1vm;
        Tue, 22 Dec 2020 14:28:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id IaxKO6DRfFR5; Tue, 22 Dec 2020 14:28:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4D0cbn4rFrz9v1vl;
        Tue, 22 Dec 2020 14:28:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 061FF8B81B;
        Tue, 22 Dec 2020 14:28:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0E_a5BmWXZY0; Tue, 22 Dec 2020 14:28:22 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B14928B812;
        Tue, 22 Dec 2020 14:28:22 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7B05A66969; Tue, 22 Dec 2020 13:28:22 +0000 (UTC)
Message-Id: <cover.1608641532.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 00/15] powerpc/32: Reduce head complexity and re-activate MMU earlier
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 22 Dec 2020 13:28:22 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims at reducing exception/syscall prologs complexity.
It also brings earlier MMU re-activation.

At the time being, we have two pathes in the prologs: one for
when we have CONFIG_VMAP stack and one when we don't.

Among 40x, 6xx and 8xx, only 40x doesn't support VMAP stack.

When VMAP stack is supported, there is special prolog code to
allow accessing stack with MMU on.

That code that access VM stack with MMU on is also able to access
linear memory, so it can also access non VM stack with MMU on.

CONFIG_VMAP_STACK as been on by default on 6xx and 8xx for some
kernel releases now, so it is known to work.

On the 8xx, null_syscall runs in 292 cycles with VMAP_STACK and in
296 cycles without VMAP stack.
On the 832x, null_syscall runs in 224 cycles with VMAP_STACK and in
213 cycles without VMAP stack.

By removing the old non VMAP stack code, and using the same prolog
regardless of the activation of VMAP stacks, we make the code a lot
simplier and open perspective to even more.

Once this is done, we can easily go one step further and re-activate
Instruction translation at the same time as data translation.

At the end, null_syscall runs in 286 cycles on the 8xx and in 216
cycles on the 832x

To do this, I splitted head_32.h in two files, one for 40x which
doesn't have VMAP stack and one for 6xx and 8xx that have VMAP stack.

Now that we have MMU back on earlier on the 6xx and 8xx, once the 40x is
gone it will be possible have more commonalities with book3e/32 which
has MMU always on.

Christophe Leroy (15):
  powerpc/32: Fix vmap stack - Properly set r1 before activating MMU on
    syscall too
  powerpc/32s: Fix RTAS machine check with VMAP stack
  powerpc/32s: Only build hash code when CONFIG_PPC_BOOK3S_604 is
    selected
  powerpc/32s: Do DABR match out of handle_page_fault()
  powerpc: Remove address argument from bad_page_fault()
  powerpc: Remove address and errorcode arguments from do_break()
  powerpc: Remove address and errorcode arguments from do_page_fault()
  powerpc/32: Split head_32.h into head_40x.h and head_6xx_8xx.h
  powerpc/32: Preserve cr1 in exception prolog stack check
  powerpc/32: Make VMAP stack code depend on HAVE_ARCH_VMAP_STACK
  powerpc/32: Use r1 directly instead of r11 in syscall prolog
  powerpc/32: Remove msr argument in EXC_XFER_TEMPLATE() on 6xx/8xx
  powerpc/32: Enable instruction translation at the same time as data
    translation
  powerpc/32: Use r1 directly instead of r11 in exception prologs on
    6xx/8xx
  powerpc/32: Use r11 to store DSISR in prolog

 arch/powerpc/include/asm/bug.h                |   6 +-
 arch/powerpc/include/asm/debug.h              |   3 +-
 arch/powerpc/include/asm/processor.h          |   2 +-
 arch/powerpc/kernel/asm-offsets.c             |   2 +-
 arch/powerpc/kernel/entry_32.S                |  56 ++---
 arch/powerpc/kernel/exceptions-64e.S          |   5 +-
 arch/powerpc/kernel/exceptions-64s.S          |  10 +-
 arch/powerpc/kernel/fpu.S                     |   2 +-
 arch/powerpc/kernel/head_40x.S                |   8 +-
 arch/powerpc/kernel/{head_32.h => head_40x.h} | 186 +--------------
 .../kernel/{head_32.h => head_6xx_8xx.h}      | 222 +++++-------------
 arch/powerpc/kernel/head_8xx.S                |  33 +--
 arch/powerpc/kernel/head_book3s_32.S          |  64 ++---
 arch/powerpc/kernel/head_booke.h              |   4 +-
 arch/powerpc/kernel/idle_6xx.S                |  12 +-
 arch/powerpc/kernel/process.c                 |   8 +-
 arch/powerpc/kernel/traps.c                   |   2 +-
 arch/powerpc/kernel/vector.S                  |   2 +-
 arch/powerpc/mm/book3s32/Makefile             |   4 +-
 arch/powerpc/mm/book3s32/hash_low.S           |  14 --
 arch/powerpc/mm/book3s64/hash_utils.c         |   2 +-
 arch/powerpc/mm/book3s64/slb.c                |   2 +-
 arch/powerpc/mm/fault.c                       |  16 +-
 arch/powerpc/platforms/8xx/machine_check.c    |   2 +-
 24 files changed, 154 insertions(+), 513 deletions(-)
 copy arch/powerpc/kernel/{head_32.h => head_40x.h} (53%)
 rename arch/powerpc/kernel/{head_32.h => head_6xx_8xx.h} (50%)

-- 
2.25.0

