Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C0D28B35F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387812AbgJLLGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:06:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:38958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387594AbgJLLGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:06:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B279DAC24;
        Mon, 12 Oct 2020 11:06:01 +0000 (UTC)
Date:   Mon, 12 Oct 2020 13:05:57 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/asm updates for v5.10
Message-ID: <20201012110557.GK25311@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two asm wrapper fixes.

Thx.

---

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_asm_for_v5.10

for you to fetch changes up to aa5cacdc29d76a005cbbee018a47faa6e724dd2d:

  x86/asm: Replace __force_order with a memory clobber (2020-10-01 10:31:48 +0200)

----------------------------------------------------------------
* Use XORL instead of XORQ to avoid a REX prefix and save some bytes in
the .fixup section, by Uros Bizjak.

* Replace __force_order dummy variable with a memory clobber to fix LLVM
requiring a definition for former and to prevent memory accesses from
still being cached/reordered, by Arvind Sankar.

----------------------------------------------------------------
Arvind Sankar (1):
      x86/asm: Replace __force_order with a memory clobber

Uros Bizjak (1):
      x86/uaccess: Use XORL %0,%0 in __get_user_asm()

 arch/x86/boot/compressed/pgtable_64.c |  9 ---------
 arch/x86/include/asm/special_insns.h  | 28 +++++++++++++++-------------
 arch/x86/include/asm/uaccess.h        |  2 +-
 arch/x86/kernel/cpu/common.c          |  4 ++--
 4 files changed, 18 insertions(+), 25 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
