Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DCE28B276
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387686AbgJLKnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:43:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:54190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387596AbgJLKnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:43:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4838AB1FF;
        Mon, 12 Oct 2020 10:43:40 +0000 (UTC)
Date:   Mon, 12 Oct 2020 12:43:27 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/fsgsbase updates for v5.10
Message-ID: <20201012104327.GG25311@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some small x86/fsgsbase updates.

Thx.

---
The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fsgsbase_for_v5.10

for you to fetch changes up to 1b9abd1755ad947d7c9913e92e7837b533124c90:

  selftests/x86/fsgsbase: Test PTRACE_PEEKUSER for GSBASE with invalid LDT GS (2020-08-26 20:54:18 +0200)

----------------------------------------------------------------
* Misc minor cleanups and corrections to the fsgsbase code and
respective selftests.

----------------------------------------------------------------
Andy Lutomirski (2):
      selftests/x86/fsgsbase: Reap a forgotten child
      selftests/x86/fsgsbase: Test PTRACE_PEEKUSER for GSBASE with invalid LDT GS

Borislav Petkov (2):
      x86/entry/64: Correct the comment over SAVE_AND_SET_GSBASE
      x86/fsgsbase: Replace static_cpu_has() with boot_cpu_has()

 arch/x86/entry/entry_64.S              |  5 ++-
 arch/x86/include/asm/fsgsbase.h        |  4 +-
 arch/x86/kernel/process_64.c           |  8 ++--
 tools/testing/selftests/x86/fsgsbase.c | 68 ++++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 8 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
