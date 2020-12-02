Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4075D2CC34E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388504AbgLBRSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:18:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgLBRSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:18:37 -0500
Date:   Wed, 2 Dec 2020 17:17:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606929476;
        bh=j+prTbBP5N18p2oaYarI9+lmn4VBukxoQRMVo540nMo=;
        h=From:To:Cc:Subject:From;
        b=u8QuLvkH4SB/FsRMXY6Zg2JT0IiiUpW+FCfaiWeuQxKmpUDAEMsjFFBeLwf+iL/Un
         WMULI7KGT4nPu3QKpwrEh3qVR0ciPLZGbGeJypEyGADMdb24V7y9m2U/zr16VEa7hl
         lyiNkNhnY2duR2f2LmfhgMr2MOF/upBo4ZIAF/Zg=
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        peterz@infradead.org, mark.rutland@arm.com
Subject: [GIT PULL] arm64 fixes for -rc7
Message-ID: <20201202171750.GA29813@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I'm sad to say that we've got an unusually large arm64 fixes pull for
-rc7 which addresses numerous significant instrumentation issues with
our entry code. Without these patches, lockdep is hopelessly unreliable
in some configurations [1,2] and syzkaller is therefore not a lot of use
because it's so noisy. Although much of this has always been broken, it
appears to have been exposed more readily by other changes such as
044d0d6de9f5 ("lockdep: Only trace IRQ edges") and general lockdep
improvements around IRQ tracing and NMIs.

Fixing this properly required moving much of the instrumentation hooks
from our entry assembly into C, which Mark has been working on for the
last few weeks. We're not quite ready to move to the recently added
generic functions yet, but the code here has been deliberately written
to mimic that closely so we can look at cleaning things up once we have
a bit more breathing room.

Having said all that, the second version of these patches was posted
last week and I pushed it into our CI (kernelci and cki) along with a
commit which forced on PROVE_LOCKING, NOHZ_FULL and
CONTEXT_TRACKING_FORCE. The result? We found a real bug in the md/raid10
code [3].

Oh, and there's also a really silly typo patch that's unrelated.

In other words, none of this warrants an -rc8 if you end up considering
it.

Please pull. Cheers,

Will

[1] https://lore.kernel.org/r/CACT4Y+aAzoJ48Mh1wNYD17pJqyEcDnrxGfApir=-j171TnQXhw@mail.gmail.com
[2] https://lore.kernel.org/r/20201119193819.GA2601289@elver.google.com
[3] https://lore.kernel.org/r/94c76d5e-466a-bc5f-e6c2-a11b65c39f83@redhat.com

--->8

The following changes since commit ff1712f953e27f0b0718762ec17d0adb15c9fd0b:

  arm64: pgtable: Ensure dirty bit is preserved across pte_wrprotect() (2020-11-23 16:13:18 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 9e5344e0ffc33f4fee899f98b6939a0682b1d9c3:

  arm64: mte: Fix typo in macro definition (2020-11-30 17:36:52 +0000)

----------------------------------------------------------------
arm64 fixes for -rc7

- Fix numerous issues with instrumentation and exception entry

- Fix hideous typo in unused register field definition

----------------------------------------------------------------
Mark Rutland (11):
      arm64: syscall: exit userspace before unmasking exceptions
      arm64: mark idle code as noinstr
      arm64: entry: mark entry code as noinstr
      arm64: entry: move enter_from_user_mode to entry-common.c
      arm64: entry: prepare ret_to_user for function call
      arm64: entry: move el1 irq/nmi logic to C
      arm64: entry: fix non-NMI user<->kernel transitions
      arm64: ptrace: prepare for EL1 irq/rcu tracking
      arm64: entry: fix non-NMI kernel<->kernel transitions
      arm64: entry: fix NMI {user, kernel}->kernel transitions
      arm64: entry: fix EL1 debug transitions

Vincenzo Frascino (1):
      arm64: mte: Fix typo in macro definition

 arch/arm64/include/asm/daifflags.h |   3 +
 arch/arm64/include/asm/exception.h |   5 +
 arch/arm64/include/asm/ptrace.h    |   4 +
 arch/arm64/include/asm/sysreg.h    |   2 +-
 arch/arm64/kernel/entry-common.c   | 254 +++++++++++++++++++++++++++----------
 arch/arm64/kernel/entry.S          |  78 ++++--------
 arch/arm64/kernel/irq.c            |  15 ---
 arch/arm64/kernel/process.c        |   8 +-
 arch/arm64/kernel/sdei.c           |   7 +-
 arch/arm64/kernel/syscall.c        |   1 -
 arch/arm64/kernel/traps.c          |  22 ++--
 arch/arm64/mm/fault.c              |  25 ----
 12 files changed, 243 insertions(+), 181 deletions(-)
