Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BC627F5F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbgI3X0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:26:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:25937 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732251AbgI3X0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:26:22 -0400
IronPort-SDR: aSEqWX/Gr49YPPghtxupM84qkzxDG/mOhGNAnHZ0pcrZ/UxnEAyeTnBd1BfbS56a/m8Z6I2LY7
 EYNHnAOHLP6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="159975255"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="159975255"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 16:26:19 -0700
IronPort-SDR: V/KTAwdmGlW7tjSxQdQPw4Luqn6IQ+hr+Si2pNSA02MZZNRinNlrb8eMCNMzhfE9836F2RGNFj
 ID47CIjwLeMg==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="457857981"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 16:26:18 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Youquan Song <youquan.song@intel.com>, tony.luck@intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] x86/mce: Change fault_in_kernel_space() from static to global
Date:   Wed, 30 Sep 2020 16:26:09 -0700
Message-Id: <20200930232611.15355-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200930232611.15355-1-tony.luck@intel.com>
References: <20200921113144.GD5901@zn.tnic>
 <20200930232611.15355-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youquan Song <youquan.song@intel.com>

Machine check code needs to be able to determine if a faulting address
is in user or kernel space. There is already a function to do this.

Change from "static int" to "bool" and add declaration to <asm/traps.h>

No functional change.

Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: <tony.luck@intel.com>
---
 arch/x86/include/asm/traps.h | 2 ++
 arch/x86/mm/fault.c          | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 714b1a30e7b0..df0b7bfc1234 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -35,6 +35,8 @@ extern int panic_on_unrecovered_nmi;
 
 void math_emulate(struct math_emu_info *);
 
+bool fault_in_kernel_space(unsigned long address);
+
 #ifdef CONFIG_VMAP_STACK
 void __noreturn handle_stack_overflow(const char *message,
 				      struct pt_regs *regs,
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 35f1498e9832..88ae443e4e5f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1081,7 +1081,7 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
 	return 0;
 }
 
-static int fault_in_kernel_space(unsigned long address)
+bool fault_in_kernel_space(unsigned long address)
 {
 	/*
 	 * On 64-bit systems, the vsyscall page is at an address above
-- 
2.21.1

