Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A446E1ED81F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 23:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgFCVfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 17:35:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:53884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgFCVfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 17:35:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 589CBAE92;
        Wed,  3 Jun 2020 21:35:02 +0000 (UTC)
Date:   Wed, 3 Jun 2020 23:34:52 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] core/core updates for v5.8
Message-ID: <20200603213452.GG19667@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the set disabling automatic READ_IMPLIES_EXEC on x86-64 and
arm64.

Thx.

---
The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_core_updates_for_5.8

for you to fetch changes up to 6e0d6ac5f3d9d90271899f6d340872360fe1caee:

  arm64/elf: Disable automatic READ_IMPLIES_EXEC for 64-bit address spaces (2020-04-20 19:44:27 +0200)

----------------------------------------------------------------
Split the old READ_IMPLIES_EXEC workaround from executable PT_GNU_STACK
now that toolchains long support PT_GNU_STACK marking and there's no
need anymore to force modern programs into having all its user mappings
executable instead of only the stack and the PROT_EXEC ones. Disable
that automatic READ_IMPLIES_EXEC forcing on x86-64 and arm64. Add tables
documenting how READ_IMPLIES_EXEC is handled on x86-64, arm and arm64.
By Kees Cook.

----------------------------------------------------------------
Kees Cook (6):
      x86/elf: Add table to document READ_IMPLIES_EXEC
      x86/elf: Split READ_IMPLIES_EXEC from executable PT_GNU_STACK
      x86/elf: Disable automatic READ_IMPLIES_EXEC on 64-bit
      arm32/64/elf: Add tables to document READ_IMPLIES_EXEC
      arm32/64/elf: Split READ_IMPLIES_EXEC from executable PT_GNU_STACK
      arm64/elf: Disable automatic READ_IMPLIES_EXEC for 64-bit address spaces

 arch/arm/kernel/elf.c        | 27 +++++++++++++++++++++++----
 arch/arm64/include/asm/elf.h | 23 ++++++++++++++++++++++-
 arch/x86/include/asm/elf.h   | 22 +++++++++++++++++++++-
 fs/compat_binfmt_elf.c       |  5 +++++
 4 files changed, 71 insertions(+), 6 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
