Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6973F27F5FA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732311AbgI3X0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:26:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:44542 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730415AbgI3X0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:26:21 -0400
IronPort-SDR: EaTekYYicQe7FDm2h+DG/ibSlKUNepXwfIwik4eBWijabUklkQUCpfVeKBtFiRyb1tGBIyo3ja
 Z4gkqeTcuirw==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="162627729"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="162627729"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 16:26:19 -0700
IronPort-SDR: M+oX0d1JPgpJe6DQYLFW79vV/nsRjD4xsIMz5M5myRMAl+su8FXIws46lA49/CH03DtAsNj3RM
 2TqhXrxvBU/g==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="457857988"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 16:26:18 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] Add machine check recovery when copying from user space
Date:   Wed, 30 Sep 2020 16:26:04 -0700
Message-Id: <20200930232611.15355-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200921113144.GD5901@zn.tnic>
References: <20200921113144.GD5901@zn.tnic>
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

Original part 0001 has already been applied to tip ras/core branch:
13c877f4b48b ("x86/mce: Stop mce_reign() from re-computing severity for every CPU")
so new part 0001 below used to be part 0002 in original series.

0001:	First piece of infrastructure update. Severity calculations need
	access to the saved registers. So pass pointer down the call
	chain.

0002:	Later we need to know what type of exception handler is present
	for a given kernel instruction. Rather than proliferate more
	functions like ex_has_fault_handler() for each type, replace
	with a function that looks up the handler and returns an enum
	describing the type.
Change since v1:
	rename enum members s/HANDLER_NONE/EX_HANDLER_NONE/ etc.
	drop __visible attribute

0003:	Need slightly different handling for *copy_user*() faults from
	get_user() faults. Create a new exception table tag and apply
	to the copy functions.
Change since v1:
	Add comments for kflags bits MCE_IN_KERNEL_RECOV and MCE_IN_KERNEL_COPYIN

0004:	In fixup path of copy functions avoid dealing with the tail
	when the copy took a machine check by returning that there
	are no bytes left to be copied.
Change since v1:
	Better comments in both commit and in code to explain the
	reason for returning 0 == success, and why that is OK (process
	will be sent a SIGBUS).

0005:	For the REP MOVS copy case we need to check if %rsi is a user
	or kernel address. There's already a static function to do this.
	Make it global so x86/mce code can share the goodness.

0006:	Changes to do_machine_check() to support the new recovery flow.
	Some re-factoring to avoid code duplication (since the flows
	for "error in user mode" and "error while copying from user
	mode" are almost identical). Couple of new fields added to the
	task structure.
Change since v1:
	This patch used to have the code to decode the kernel
	instruction and figure out what address was being accessed.
	But doing that here was too late ... the severity code
	needs to do that to distiguish copy to/from user in the
	unrolled copy functions.

0007:	Finally the keystone patch that pulls all the parts together.
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
Change since v1:
	Moved the code to discover user address here in the
	severity/context flow.

Tony Luck (3):
  x86/mce: Provide method to find out the type of exception handle
  x86/mce: Avoid tail copy when machine check terminated a copy from
    user
  x86/mce: Decode a kernel instruction to determine if it is copying
    from user

Youquan Song (4):
  x86/mce: Pass pointer to saved pt_regs to severity calculation
    routines
  x86/mce: Add _ASM_EXTABLE_CPY for copy user access
  x86/mce: Change fault_in_kernel_space() from static to global
  x86/mce: Recover from poison found while copying from user space

 arch/x86/include/asm/asm.h         |   6 ++
 arch/x86/include/asm/extable.h     |   9 ++-
 arch/x86/include/asm/mce.h         |  15 ++++
 arch/x86/include/asm/traps.h       |   2 +
 arch/x86/kernel/cpu/mce/core.c     |  58 +++++++++------
 arch/x86/kernel/cpu/mce/internal.h |   3 +-
 arch/x86/kernel/cpu/mce/severity.c |  68 ++++++++++++++++--
 arch/x86/lib/copy_user_64.S        | 111 ++++++++++++++++-------------
 arch/x86/mm/extable.c              |  24 +++++--
 arch/x86/mm/fault.c                |   2 +-
 include/linux/sched.h              |   2 +
 11 files changed, 216 insertions(+), 84 deletions(-)


base-commit: dc0592b73715c8e84ad8ebbc50c6057d5e203aac
-- 
2.21.1

