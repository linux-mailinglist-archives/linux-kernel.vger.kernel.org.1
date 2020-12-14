Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12F52D97EA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 13:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438964AbgLNMPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 07:15:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:52762 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730740AbgLNMPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 07:15:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E1D6AF17;
        Mon, 14 Dec 2020 12:14:44 +0000 (UTC)
Date:   Mon, 14 Dec 2020 13:14:44 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/CPU for v5.11
Message-ID: <20201214121444.GG26358@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the x86/CPU pile for v5.11. Only AMD-specific changes this time.

Thx.

---

The following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.11

for you to fetch changes up to 262bd5724afdefd4c48a260d6100e78cc43ee06b:

  x86/cpu/amd: Remove dead code for TSEG region remapping (2020-12-08 18:45:21 +0100)

----------------------------------------------------------------
- Save the AMD's physical die ID into cpuinfo_x86.cpu_die_id and convert all
code to use it (Yazen Ghannam)

- Remove a dead and unused TSEG region remapping workaround on AMD (Arvind Sankar)

----------------------------------------------------------------
Arvind Sankar (1):
      x86/cpu/amd: Remove dead code for TSEG region remapping

Yazen Ghannam (4):
      x86/CPU/AMD: Save AMD NodeId as cpu_die_id
      x86/CPU/AMD: Remove amd_get_nb_id()
      EDAC/mce_amd: Use struct cpuinfo_x86.cpu_die_id for AMD NodeId
      x86/topology: Set cpu_die_id only if DIE_TYPE found

 Documentation/x86/topology.rst   |  9 +++++++++
 arch/x86/events/amd/core.c       |  2 +-
 arch/x86/include/asm/cacheinfo.h |  4 ++--
 arch/x86/include/asm/processor.h |  2 --
 arch/x86/kernel/amd_nb.c         |  4 ++--
 arch/x86/kernel/cpu/amd.c        | 38 +++++---------------------------------
 arch/x86/kernel/cpu/cacheinfo.c  |  8 ++++----
 arch/x86/kernel/cpu/hygon.c      | 31 +++++--------------------------
 arch/x86/kernel/cpu/mce/amd.c    |  4 ++--
 arch/x86/kernel/cpu/mce/inject.c |  4 ++--
 arch/x86/kernel/cpu/topology.c   | 10 ++++++++--
 drivers/edac/amd64_edac.c        |  4 ++--
 drivers/edac/mce_amd.c           |  4 ++--
 13 files changed, 44 insertions(+), 80 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
