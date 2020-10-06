Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6642853A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 23:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgJFVJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 17:09:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:44603 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbgJFVJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 17:09:20 -0400
IronPort-SDR: s8S1DFo6AWVDgeVryre1ZS4OYUwH/1YdbxH1KtGGC7Ro46cf1eG1O58xu0J4GWYd5yBratgbfZ
 Q2SXTq9Y+edA==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="161302104"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="161302104"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 14:09:18 -0700
IronPort-SDR: t3z6pK2g2s2+tfI7Ch0wFyomltUGOQBNkUnFhBmlpDHyWAVVrG97apkDM5RQw+kFjo84pS8HPo
 8qNQrZ7eozAg==
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="527590579"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 14:09:18 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] Add machine check recovery when copying from user space
Date:   Tue,  6 Oct 2020 14:09:04 -0700
Message-Id: <20201006210910.21062-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20201005163130.GD21151@zn.tnic>
References: <20201005163130.GD21151@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Machine check recovery from uncorrected memory errors currently focusses
primarily on errors that are detected while running in user mode. There
is a mechanism for recovering from errors in kernel code, but it is
currently only used for memcpy_mcsafe().

The existing recover actions for errors found in user mode (unmap the
page and send SIGBUS to the task) can also be applied when the error is
found while copying data from user space to the kernel.

Roadmap to this series:

Series is based on top of tip ras/core branch because original part 0001
has already been applied to tip ras/core branch:
13c877f4b48b ("x86/mce: Stop mce_reign() from re-computing severity for every CPU")
so new part 0001 below used to be part 0002 in v1 series.


In v3 part 0005 has been merged with the final part, so now just 6 parts.

0001:   First piece of infrastructure update. Severity calculations need
        access to the saved registers. So pass pointer down the call
        chain.

0002:   Need to know what type of exception handler is present
        for a given kernel instruction. Rather than proliferate more
        functions like ex_has_fault_handler() for each type, replace
        with a function that looks up the handler and returns an enum
        describing the type.

0003:   Need slightly different handling for *copy_user*() faults from
        get_user() faults. Create a new exception table tag and apply
        to the copy functions.

Change since v2: Reword commit message to avoid use of "we".

0004:   In fixup path of copy functions avoid dealing with the tail
        when the copy took a machine check by returning that there
        are no bytes left to be copied.

0005:   Changes to do_machine_check() to support the new recovery flow.
        Some re-factoring to avoid code duplication (since the flows
        for "error in user mode" and "error while copying from user
        mode" are almost identical). Couple of new fields added to the
        task structure.

Change since v2: Boris supplied a helper function to make the re-factor
	much simpler. Use it instead of the spaghetti code in v2.

0006:	Finally the keystone patch that pulls all the parts together.
	An instruction decoder figures out whether an instruction
	tagged as accessing user space is reading from or writing
	to user space. The instructions in the switch were found
	experimentally by looking at what instructions in the base
	kernel are tagged in the exception table. I didn't add the
	atomic operations (0x87 = XCHG etc.) that both read and write
	user addresses. I think they should be safe, but I need a test
	case where a futex has been poisoned to check. Probably this
	switch should be expanded with all the instructions that the
	compiler could possibly generate that read from user space.

Change since v2: Merged old part 0005 into this piece since this is
	where function fault_in_kernel_space() is used.
	Check modrm.got and sib.got fields in "insn" were set before
	calling insn_get_addr()
	Change type of constant from ~0ul to -1l when checking whether
	address returned by insn_get_addr() is valid.


Tony Luck (4):
  x86/mce: Provide method to find out the type of exception handle
  x86/mce: Avoid tail copy when machine check terminated a copy from
    user
  x86/mce: Recover from poison found while copying from user space
  x86/mce: Decode a kernel instruction to determine if it is copying
    from user

Youquan Song (2):
  x86/mce: Pass pointer to saved pt_regs to severity calculation
    routines
  x86/mce: Add _ASM_EXTABLE_CPY for copy user access

 arch/x86/include/asm/asm.h         |   6 ++
 arch/x86/include/asm/extable.h     |   9 ++-
 arch/x86/include/asm/mce.h         |  15 ++++
 arch/x86/include/asm/traps.h       |   2 +
 arch/x86/kernel/cpu/mce/core.c     |  52 +++++++++-----
 arch/x86/kernel/cpu/mce/internal.h |   3 +-
 arch/x86/kernel/cpu/mce/severity.c |  70 ++++++++++++++++--
 arch/x86/lib/copy_user_64.S        | 111 ++++++++++++++++-------------
 arch/x86/mm/extable.c              |  24 +++++--
 arch/x86/mm/fault.c                |   2 +-
 include/linux/sched.h              |   2 +
 11 files changed, 217 insertions(+), 79 deletions(-)


base-commit: 5da8e4a658109e3b7e1f45ae672b7c06ac3e7158
-- 
2.21.1

