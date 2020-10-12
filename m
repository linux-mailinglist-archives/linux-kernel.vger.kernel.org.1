Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB17128B33F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387906AbgJLK73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:59:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:35030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387876AbgJLK7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:59:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3ADD3ACA3;
        Mon, 12 Oct 2020 10:59:22 +0000 (UTC)
Date:   Mon, 12 Oct 2020 12:59:18 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cache updates for v5.10
Message-ID: <20201012105918.GJ25311@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the resctrl pile this time around.

Thx.

---
The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v5.10

for you to fetch changes up to 29b6bd41ee24f69a85666b9f68d500b382d408fd:

  x86/resctrl: Enable user to view thread or core throttling mode (2020-08-26 17:53:22 +0200)

----------------------------------------------------------------
* Misc cleanups to the resctrl code in preparation for the ARM side, by
James Morse.

* Add support for controlling per-thread memory bandwidth throttling
delay values on hw which supports it, by Fenghua Yu.

----------------------------------------------------------------
Fenghua Yu (2):
      x86/resctrl: Enumerate per-thread MBA controls
      x86/resctrl: Enable user to view thread or core throttling mode

James Morse (10):
      x86/resctrl: Remove unused struct mbm_state::chunks_bw
      x86/resctrl: Remove struct rdt_membw::max_delay
      x86/resctrl: Fix stale comment
      x86/resctrl: Use container_of() in delayed_work handlers
      x86/resctrl: Include pid.h
      x86/resctrl: Use is_closid_match() in more places
      x86/resctrl: Add struct rdt_membw::arch_needs_linear to explain AMD/Intel MBA difference
      x86/resctrl: Merge AMD/Intel parse_bw() calls
      x86/resctrl: Add struct rdt_cache::arch_has_{sparse, empty}_bitmaps
      cacheinfo: Move resctrl's get_cache_id() to the cacheinfo header file

 Documentation/x86/resctrl_ui.rst          | 18 +++++-
 arch/x86/include/asm/cpufeatures.h        |  1 +
 arch/x86/kernel/cpu/cpuid-deps.c          |  1 +
 arch/x86/kernel/cpu/resctrl/core.c        | 56 ++++++++++---------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 92 +++++--------------------------
 arch/x86/kernel/cpu/resctrl/internal.h    | 49 ++++++++++------
 arch/x86/kernel/cpu/resctrl/monitor.c     | 16 +-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 85 ++++++++++++++++++++++------
 arch/x86/kernel/cpu/scattered.c           |  1 +
 include/linux/cacheinfo.h                 | 21 +++++++
 include/linux/resctrl.h                   |  2 +
 11 files changed, 185 insertions(+), 157 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
