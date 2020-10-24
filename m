Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A5C297B9F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 11:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756802AbgJXJXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 05:23:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:48426 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S463679AbgJXJXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 05:23:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1961DAC23;
        Sat, 24 Oct 2020 09:23:33 +0000 (UTC)
Date:   Sat, 24 Oct 2020 11:23:23 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/seves fixes for v5.10-rc1
Message-ID: <20201024092323.GA15609@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull three SEV-ES fixes for 5.10. They got ready around the same
time the merge window opened so I gave them some additional testing and
soaking time before sending them your way.

Please pull,
thx.

---
The following changes since commit da9803dfd3955bd2f9909d55e23f188ad76dbe58:

  Merge tag 'x86_seves_for_v5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2020-10-14 10:21:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_seves_fixes_for_v5.10_rc1

for you to fetch changes up to b17a45b6e53f6613118b2e5cfc4a992cc50deb2c:

  x86/boot/64: Explicitly map boot_params and command line (2020-10-19 19:39:50 +0200)

----------------------------------------------------------------
Three fixes to SEV-ES to correct setting up the new early pagetable
on 5-level paging machines, to always map boot_params and the kernel
cmdline, and disable stack protector for ../compressed/head{32,64}.c.
(Arvind Sankar)

----------------------------------------------------------------
Arvind Sankar (3):
      x86/boot/64: Initialize 5-level paging variables earlier
      x86/head/64: Disable stack protection for head$(BITS).o
      x86/boot/64: Explicitly map boot_params and command line

 arch/x86/boot/compressed/head_64.S      |  3 +++
 arch/x86/boot/compressed/ident_map_64.c | 27 +++++++++++++++++++--------
 arch/x86/boot/compressed/kaslr.c        |  8 --------
 arch/x86/boot/compressed/pgtable_64.c   | 16 ++++++++++++++++
 arch/x86/kernel/Makefile                |  2 ++
 5 files changed, 40 insertions(+), 16 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
