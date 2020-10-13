Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7870A28CB1D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 11:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbgJMJmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 05:42:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:49384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727744AbgJMJmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 05:42:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 614A0AC84;
        Tue, 13 Oct 2020 09:41:59 +0000 (UTC)
Date:   Tue, 13 Oct 2020 11:41:49 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL -v2] x86/asm updates for v5.10
Message-ID: <20201013094149.GA32151@zn.tnic>
References: <20201012110557.GK25311@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201012110557.GK25311@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here's v2 of the x86/asm pull with only the __force_order patch so that
it can go in now. The other one will be sorted out when the matter has
been settled properly.

Please pull,
thx.

---
The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_asm_for_v5.10

for you to fetch changes up to 3e626682046e30282979f7d71e054cd4c00069a7:

  x86/asm: Replace __force_order with a memory clobber (2020-10-13 11:23:15 +0200)

----------------------------------------------------------------
* Replace __force_order dummy variable with a memory clobber to fix LLVM
requiring a definition for former and to prevent memory accesses from
still being cached/reordered. (Arvind Sankar)

----------------------------------------------------------------
Arvind Sankar (1):
      x86/asm: Replace __force_order with a memory clobber

 arch/x86/boot/compressed/pgtable_64.c |  9 ---------
 arch/x86/include/asm/special_insns.h  | 28 +++++++++++++++-------------
 arch/x86/kernel/cpu/common.c          |  4 ++--
 3 files changed, 17 insertions(+), 24 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
