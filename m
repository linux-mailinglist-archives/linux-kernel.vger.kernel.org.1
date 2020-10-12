Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D863A28B1D9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 11:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbgJLJ6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 05:58:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:50070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgJLJ6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 05:58:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A3BAADF5;
        Mon, 12 Oct 2020 09:58:07 +0000 (UTC)
Date:   Mon, 12 Oct 2020 11:57:56 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cpu updates for v5.10
Message-ID: <20201012095756.GC25311@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the x86/cpu changes collected this time.

Thx.

---

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.10

for you to fetch changes up to e1ebb2b49048c4767cfa0d8466f9c701e549fa5e:

  KVM: SVM: Don't flush cache if hardware enforces cache coherency across encryption domains (2020-09-19 20:46:59 +0200)

----------------------------------------------------------------
* Add support for hardware-enforced cache coherency on AMD which
obviates the need to flush cachelines before changing the PTE encryption
bit, by Krish Sadhukhan.

* Add Centaur initialization support for families >= 7, by Tony W
Wang-oc.

* Add a feature flag for, and expose TSX suspend load tracking feature
to KVM, by Cathy Zhang.

* Emulate SLDT and STR so that windows programs don't crash on UMIP
machines, by Brendan Shanks and Ricardo Neri.

* Use the new SERIALIZE insn on Intel hardware which supports it, by
Ricardo Neri.

* Misc cleanups and fixes.

----------------------------------------------------------------
Brendan Shanks (1):
      x86/umip: Add emulation/spoofing for SLDT and STR instructions

Cathy Zhang (1):
      x86/kvm: Expose TSX Suspend Load Tracking feature

Ingo Molnar (1):
      x86/cpu: Fix typos and improve the comments in sync_core()

Krish Sadhukhan (3):
      x86/cpu: Add hardware-enforced cache coherency as a CPUID feature
      x86/mm/pat: Don't flush cache if hardware enforces cache coherency across encryption domnains
      KVM: SVM: Don't flush cache if hardware enforces cache coherency across encryption domains

Kyung Min Park (1):
      x86/cpufeatures: Enumerate TSX suspend load address tracking instructions

Ricardo Neri (1):
      x86/cpu: Use SERIALIZE in sync_core() when available

Tony W Wang-oc (2):
      x86/cpu/centaur: Replace two-condition switch-case with an if statement
      x86/cpu/centaur: Add Centaur family >=7 CPUs initialization support

Uros Bizjak (1):
      x86/cpu: Use XGETBV and XSETBV mnemonics in fpu/internal.h

 arch/x86/include/asm/cpufeatures.h   |  3 ++-
 arch/x86/include/asm/fpu/internal.h  |  7 ++-----
 arch/x86/include/asm/special_insns.h |  6 ++++++
 arch/x86/include/asm/sync_core.h     | 34 +++++++++++++++++++-----------
 arch/x86/kernel/cpu/centaur.c        | 27 +++++++++++-------------
 arch/x86/kernel/cpu/scattered.c      |  1 +
 arch/x86/kernel/umip.c               | 40 ++++++++++++++++++++++++------------
 arch/x86/kvm/cpuid.c                 |  2 +-
 arch/x86/kvm/svm/sev.c               |  3 ++-
 arch/x86/mm/pat/set_memory.c         |  2 +-
 10 files changed, 76 insertions(+), 49 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
