Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893DF301B4E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 12:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbhAXLDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 06:03:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:41358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbhAXLDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 06:03:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E18CAAF82;
        Sun, 24 Jan 2021 11:02:52 +0000 (UTC)
Date:   Sun, 24 Jan 2021 12:02:47 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.11-rc5
Message-ID: <20210124110247.GA2493@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the collection of x86 urgent fixes for 5.11 accumulated so
far.

Thx.

---

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.11_rc5

for you to fetch changes up to 6e1239c13953f3c2a76e70031f74ddca9ae57cd3:

  x86/cpu: Add another Alder Lake CPU to the Intel family (2021-01-21 23:01:51 +0100)

----------------------------------------------------------------
 - Add a new Intel model number for Alder Lake

 - Differentiate which aspects of the FPU state get saved/restored when the FPU
   is used in-kernel and fix a boot crash on K7 due to early MXCSR access before
   CR4.OSFXSR is even set.

 - A couple of noinstr annotation fixes

 - Correct die ID setting on AMD for users of topology information which need
   the correct die ID

 - A SEV-ES fix to handle string port IO to/from kernel memory properly

----------------------------------------------------------------
Andy Lutomirski (2):
      x86/fpu: Add kernel_fpu_begin_mask() to selectively initialize state
      x86/mmx: Use KFPU_387 for MMX string operations

Borislav Petkov (1):
      x86/topology: Make __max_die_per_package available unconditionally

Gayatri Kammela (1):
      x86/cpu: Add another Alder Lake CPU to the Intel family

Hyunwook (Wooky) Baek (1):
      x86/sev-es: Handle string port IO to kernel memory properly

Peter Zijlstra (6):
      x86/entry: Fix noinstr fail
      x86/sev: Fix nonistr violation
      locking/lockdep: Cure noinstr fail
      locking/lockdep: Avoid noinstr warning for DEBUG_LOCKDEP
      x86/mce: Remove explicit/superfluous tracing
      x86: __always_inline __{rd,wr}msr()

Yazen Ghannam (1):
      x86/cpu/amd: Set __max_die_per_package on AMD

 arch/x86/entry/common.c             | 10 +++++++---
 arch/x86/include/asm/fpu/api.h      | 15 +++++++++++++--
 arch/x86/include/asm/intel-family.h |  1 +
 arch/x86/include/asm/msr.h          |  4 ++--
 arch/x86/include/asm/topology.h     |  4 ++--
 arch/x86/kernel/cpu/amd.c           |  4 ++--
 arch/x86/kernel/cpu/mce/core.c      |  7 ++++---
 arch/x86/kernel/cpu/topology.c      |  2 +-
 arch/x86/kernel/fpu/core.c          |  9 +++++----
 arch/x86/kernel/sev-es.c            | 14 +++++++++++++-
 arch/x86/lib/mmx_32.c               | 20 +++++++++++++++-----
 kernel/locking/lockdep.c            |  9 +++++++--
 12 files changed, 72 insertions(+), 27 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
