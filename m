Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E800B2F0677
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 11:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbhAJKfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 05:35:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:43022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbhAJKfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 05:35:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CFA32AC5B;
        Sun, 10 Jan 2021 10:34:40 +0000 (UTC)
Date:   Sun, 10 Jan 2021 11:34:36 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.11-rc3
Message-ID: <20210110103436.GB10664@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

as expected, fixes started trickling in after the holidays so please
pull the accumulated pile of x86 urgent fixes for 5.11.

Thx.

---

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.11_rc3

for you to fetch changes up to a0195f314a25582b38993bf30db11c300f4f4611:

  x86/resctrl: Don't move a task to the same resource group (2021-01-08 09:08:03 +0100)

----------------------------------------------------------------
- A fix for fanotify_mark() missing the conversion of x86_32 native
syscalls which take 64-bit arguments to the compat handlers due to
former having a general compat handler. (Brian Gerst)

- Add a forgotten pmd page destructor call to pud_free_pmd_page() where
a pmd page is freed. (Dan Williams)

- Make IN/OUT insns with an u8 immediate port operand handling for
SEV-ES guests more precise by using only the single port byte and not
the whole s32 value of the insn decoder. (Peter Gonda)

- Correct a straddling end range check before returning the proper MTRR
type, when the end address is the same as top of memory. (Ying-Tsun
Huang)

- Change PQR_ASSOC MSR update scheme when moving a task to a resctrl
resource group to avoid significant performance overhead with some
resctrl workloads. (Fenghua Yu)

- Avoid the actual task move overhead when the task is already in the
resource group. (Fenghua Yu)

----------------------------------------------------------------
Brian Gerst (1):
      fanotify: Fix sys_fanotify_mark() on native x86-32

Dan Williams (1):
      x86/mm: Fix leak of pmd ptlock

Fenghua Yu (2):
      x86/resctrl: Use an IPI instead of task_work_add() to update PQR_ASSOC MSR
      x86/resctrl: Don't move a task to the same resource group

Peter Gonda (1):
      x86/sev-es: Fix SEV-ES OUT/IN immediate opcode vc handling

Ying-Tsun Huang (1):
      x86/mtrr: Correct the range check before performing MTRR type lookups

 arch/Kconfig                           |   6 ++
 arch/x86/Kconfig                       |   1 +
 arch/x86/kernel/cpu/mtrr/generic.c     |   6 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 117 ++++++++++++++-------------------
 arch/x86/kernel/sev-es-shared.c        |   4 +-
 arch/x86/mm/pgtable.c                  |   2 +
 fs/notify/fanotify/fanotify_user.c     |  17 ++---
 include/linux/syscalls.h               |  24 +++++++
 8 files changed, 94 insertions(+), 83 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
