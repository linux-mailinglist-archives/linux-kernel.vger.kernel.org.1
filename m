Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A3B2D973D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 12:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407556AbgLNLQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 06:16:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:34480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbgLNLQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 06:16:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE03AAC10;
        Mon, 14 Dec 2020 11:15:54 +0000 (UTC)
Date:   Mon, 14 Dec 2020 12:15:50 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/RAS updates for v5.11
Message-ID: <20201214111550.GB26358@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Pls pull the x86/RAS lineup for 5.11,

thx.

---

The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_updates_for_v5.11

for you to fetch changes up to e1c06d2366e743475b91045ef0c2ce1bbd028cb6:

  x86/mce: Rename kill_it to kill_current_task (2020-12-01 18:58:50 +0100)

----------------------------------------------------------------
- Enable additional logging mode on older Xeons (Tony Luck)

- Pass error records logged by firmware through the MCE decoding chain
  to provide human-readable error descriptions instead of raw values
  (Smita Koralahalli)

- Some #MC handler fixes (Gabriele Paoloni)

- The usual small fixes and cleanups all over.

----------------------------------------------------------------
Borislav Petkov (1):
      Merge tag 'v5.10-rc6' into ras/core

Gabriele Paoloni (4):
      x86/mce: Move the mce_panic() call and 'kill_it' assignments to the right places
      x86/mce: Panic for LMCE only if mca_cfg.tolerant < 3
      x86/mce: Remove redundant call to irq_work_queue()
      x86/mce: Rename kill_it to kill_current_task

Kaixu Xia (1):
      x86/mce: Assign boolean values to a bool variable

Smita Koralahalli (1):
      x86/mce, cper: Pass x86 CPER through the MCA handling chain

Tom Rix (1):
      x86/mce: Remove unneeded break

Tony Luck (2):
      x86/mce: Enable additional error logging on certain Intel CPUs
      x86/mce: Use "safe" MSR functions when enabling additional error logging

Zhen Lei (1):
      x86/mce: Correct the detection of invalid notifier priorities

 arch/x86/include/asm/acpi.h      | 11 ++++++++
 arch/x86/include/asm/mce.h       |  9 +++++-
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/kernel/acpi/apei.c      |  5 ++++
 arch/x86/kernel/cpu/mce/apei.c   | 61 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c   | 43 +++++++++++-----------------
 arch/x86/kernel/cpu/mce/intel.c  | 21 ++++++++++++++
 drivers/firmware/efi/cper-x86.c  | 11 ++++++--
 8 files changed, 131 insertions(+), 31 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
