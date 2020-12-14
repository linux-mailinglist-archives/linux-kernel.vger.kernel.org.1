Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89262D97E1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 13:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbgLNMIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 07:08:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:50194 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438938AbgLNMIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 07:08:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9656B733;
        Mon, 14 Dec 2020 12:07:38 +0000 (UTC)
Date:   Mon, 14 Dec 2020 13:07:33 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/misc updates for v5.11
Message-ID: <20201214120733.GF26358@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the accumulated misc pile for v5.11.

Thx.

---

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.11

for you to fetch changes up to f77f420d34754b8d08ac6ebf094ff7193023196a:

  x86/msr: Add a pointer to an URL which contains further details (2020-12-08 10:17:08 +0100)

----------------------------------------------------------------
The main part of this branch is the ongoing fight against windmills in
an attempt to have userspace tools not poke at naked MSRs. This round
deals with MSR_IA32_ENERGY_PERF_BIAS and removes direct poking into it
by our in-tree tools in favor of the proper "energy_perf_bias" sysfs
interface which we already have.

In addition, the msr.ko write filtering's error message points to a new
summary page which contains the info we collected from helpful reporters
about which userspace tools write MSRs:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/about

along with the current status of their conversion.

Rest is the usual small fixes and improvements.

----------------------------------------------------------------
Andy Lutomirski (2):
      selftests/x86/fsgsbase: Fix GS == 1, 2, and 3 tests
      selftests/x86: Add missing .note.GNU-stack sections

Borislav Petkov (6):
      tools/power/cpupower: Read energy_perf_bias from sysfs
      tools/power/turbostat: Read energy_perf_bias from sysfs
      tools/power/x86_energy_perf_policy: Read energy_perf_bias from sysfs
      x86/msr: Do not allow writes to MSR_IA32_ENERGY_PERF_BIAS
      x86/msr: Downgrade unrecognized MSR message
      x86/msr: Add a pointer to an URL which contains further details

Sami Tolvanen (1):
      x86/pci: Fix the function type for check_reserved_t

Steve Wahl (1):
      MAINTAINERS: Cleanup SGI-related entries

 MAINTAINERS                                        |   6 +-
 arch/x86/kernel/msr.c                              |   8 +-
 arch/x86/pci/mmconfig-shared.c                     |   4 +-
 tools/power/cpupower/lib/cpupower.c                |  23 ++++-
 tools/power/cpupower/lib/cpupower_intern.h         |   5 +
 tools/power/cpupower/utils/cpupower-info.c         |   2 +-
 tools/power/cpupower/utils/cpupower-set.c          |   2 +-
 tools/power/cpupower/utils/helpers/helpers.h       |   8 +-
 tools/power/cpupower/utils/helpers/misc.c          |  48 +++++++++
 tools/power/cpupower/utils/helpers/msr.c           |  28 ------
 tools/power/x86/turbostat/turbostat.c              |  29 +++++-
 .../x86_energy_perf_policy.c                       | 109 +++++++++++++++++++--
 tools/testing/selftests/x86/fsgsbase.c             |  12 ++-
 .../testing/selftests/x86/raw_syscall_helper_32.S  |   2 +
 tools/testing/selftests/x86/thunks.S               |   2 +
 15 files changed, 227 insertions(+), 61 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
