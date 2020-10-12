Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB6428B202
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgJLKKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:10:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:57994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729547AbgJLKKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:10:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 95688AC6C;
        Mon, 12 Oct 2020 10:10:23 +0000 (UTC)
Date:   Mon, 12 Oct 2020 12:10:12 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/platform updates for v5.10
Message-ID: <20201012101012.GD25311@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the x86/platform queue.

Thx.

---

The following changes since commit a1b8638ba1320e6684aa98233c15255eb803fac7:

  Linux 5.9-rc7 (2020-09-27 14:38:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v5.10

for you to fetch changes up to 7a6d94f0ed957fb667d4d74c5c6c640a26e87c8f:

  x86/platform/uv: Update Copyrights to conform to HPE standards (2020-10-07 09:10:07 +0200)

----------------------------------------------------------------
* Cleanup different aspects of the UV code and start adding support for
the new UV5 class of systems, by Mike Travis.

* Use a flexible array for a dynamically sized struct uv_rtc_timer_head,
by Gustavo A. R. Silva.

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      x86/uv/time: Use a flexible array in struct uv_rtc_timer_head

Mike Travis (13):
      x86/platform/uv: Remove UV BAU TLB Shootdown Handler
      x86/platform/uv: Remove SCIR MMR references for UV systems
      drivers/misc/sgi-xp: Adjust references in UV kernel modules
      x86/platform/uv: Update UV MMRs for UV5
      x86/platform/uv: Add UV5 direct references
      x86/platform/uv: Add and decode Arch Type in UVsystab
      x86/platform/uv: Update MMIOH references based on new UV5 MMRs
      x86/platform/uv: Adjust GAM MMR references affected by UV5 updates
      x86/platform/uv: Update UV5 MMR references in UV GRU
      x86/platform/uv: Update node present counting
      x86/platform/uv: Update UV5 TSC checking
      x86/platform/uv: Update for UV5 NMI MMR changes
      x86/platform/uv: Update Copyrights to conform to HPE standards

 arch/x86/include/asm/idtentry.h     |    4 -
 arch/x86/include/asm/uv/bios.h      |   17 +-
 arch/x86/include/asm/uv/uv.h        |    4 +-
 arch/x86/include/asm/uv/uv_bau.h    |  755 ----
 arch/x86/include/asm/uv/uv_hub.h    |  165 +-
 arch/x86/include/asm/uv/uv_mmrs.h   | 7646 +++++++++++++++++++----------------
 arch/x86/kernel/apic/x2apic_uv_x.c  |  822 ++--
 arch/x86/kernel/idt.c               |    3 -
 arch/x86/mm/tlb.c                   |   24 -
 arch/x86/platform/uv/Makefile       |    2 +-
 arch/x86/platform/uv/bios_uv.c      |   28 +-
 arch/x86/platform/uv/tlb_uv.c       | 2097 ----------
 arch/x86/platform/uv/uv_nmi.c       |   65 +-
 arch/x86/platform/uv/uv_time.c      |   18 +-
 drivers/misc/sgi-gru/grufile.c      |    3 +-
 drivers/misc/sgi-xp/xp.h            |    8 +-
 drivers/misc/sgi-xp/xp_main.c       |    5 +-
 drivers/misc/sgi-xp/xp_uv.c         |    7 +-
 drivers/misc/sgi-xp/xpc_main.c      |    7 +-
 drivers/misc/sgi-xp/xpc_partition.c |    3 +-
 drivers/misc/sgi-xp/xpnet.c         |    3 +-
 21 files changed, 4797 insertions(+), 6889 deletions(-)
 delete mode 100644 arch/x86/include/asm/uv/uv_bau.h
 delete mode 100644 arch/x86/platform/uv/tlb_uv.c

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
