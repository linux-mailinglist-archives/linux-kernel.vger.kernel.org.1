Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34BB28C1E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgJLUBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:01:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:29714 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgJLUBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:01:52 -0400
IronPort-SDR: k2BQiTpQmhLIwjHNxlMhPOGo5P7C7f9ZK/AK+IQgKwo4B3OYxeppzm6i6/B8psz4kT8Pos0t3n
 oS6rCBitz8eQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165908610"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="165908610"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 13:01:51 -0700
IronPort-SDR: DfaqXpru17xN4Wk78RJgHoHaaMFtaCbUEhj5skvBw18cimf6XkbrZsaJahYyZ2vFWVFQBC10ZN
 8jU9zZ+0H12A==
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="463224391"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 13:01:51 -0700
Date:   Mon, 12 Oct 2020 13:01:49 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: [PLEASE PULL] ia64 for v5.10
Message-ID: <20201012200149.GA27228@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f4d51dffc6c01a9e94650d95ce0104964f8ae822:

  Linux 5.9-rc4 (2020-09-06 17:11:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git tags/ia64_for_5.10

for you to fetch changes up to c331649e637152788b0ca1c857d0c2eaf34fcbc3:

  ia64: Use libata instead of the legacy ide driver in defconfigs (2020-09-11 09:38:00 -0700)

----------------------------------------------------------------
Cleanups by Christoph
1) Switch to libata instead of legacy ide driver
2) Drop ia64 perfmon (it's been broken for a while)

----------------------------------------------------------------
Christoph Hellwig (2):
      ia64: Remove perfmon
      ia64: Use libata instead of the legacy ide driver in defconfigs

 arch/ia64/Kconfig                     |    9 -
 arch/ia64/configs/bigsur_defconfig    |    8 +-
 arch/ia64/configs/generic_defconfig   |   10 +-
 arch/ia64/configs/gensparse_defconfig |   10 +-
 arch/ia64/configs/tiger_defconfig     |   10 +-
 arch/ia64/configs/zx1_defconfig       |    8 +-
 arch/ia64/include/asm/processor.h     |   10 -
 arch/ia64/include/asm/switch_to.h     |   10 +-
 arch/ia64/kernel/Makefile             |    3 +-
 arch/ia64/kernel/irq_ia64.c           |    7 -
 arch/ia64/kernel/perfmon.c            | 6703 ---------------------------------
 arch/ia64/kernel/process.c            |   53 -
 arch/ia64/kernel/ptrace.c             |   24 -
 arch/ia64/kernel/smpboot.c            |    8 -
 arch/ia64/kernel/syscalls/syscall.tbl |    2 +-
 arch/ia64/lib/Makefile                |    1 -
 arch/ia64/lib/carta_random.S          |   55 -
 arch/ia64/oprofile/Makefile           |    1 -
 arch/ia64/oprofile/init.c             |   12 +-
 arch/ia64/oprofile/perfmon.c          |   99 -
 20 files changed, 22 insertions(+), 7021 deletions(-)
 delete mode 100644 arch/ia64/kernel/perfmon.c
 delete mode 100644 arch/ia64/lib/carta_random.S
 delete mode 100644 arch/ia64/oprofile/perfmon.c
