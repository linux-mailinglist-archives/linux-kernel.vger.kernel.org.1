Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA802ED4B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbhAGQpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:45:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:47738 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728210AbhAGQpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:45:49 -0500
IronPort-SDR: EIG6c2EpIiS4srB3fDR/dPzul0ErpcNLM1RldPCFaCdL8UnmuVMhBnWMtvlxgUa+1safFlLYWt
 iuXrYMO/26NQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="164524615"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="164524615"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 08:45:22 -0800
IronPort-SDR: teG6szFSg8FXQwpak2aOHdYrr7/o8Q1/7nR8bW2u+EA+sWVhYwt9WHl82ZJyRpjguSRXRHrr2s
 tUj554Dbco0Q==
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="567818451"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 08:45:21 -0800
Subject: [PATCH v3] x86: fix enqcmds() with missing __iomem annotation
From:   Dave Jiang <dave.jiang@intel.com>
To:     bp@alien8.de, x86@kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dan.j.williams@intel.com, ben.widawsky@intel.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 07 Jan 2021 09:45:21 -0700
Message-ID: <161003789741.4062451.14362269365703761223.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing __iomem annotation to address sparse warning. Caller is expected
to pass an __iomem annotated pointer to this function. The current usages
send a 64bytes command descriptor to an MMIO location (portal) on a
device for consumption.

Also, from the comment in movdir64b(), which also applies to enqcmds(),
@__dst must be supplied as an lvalue because this tells the compiler what
the object is (its size) the instruction accesses. I.e., not the pointers
but what they point to, thus the deref'ing '*'."

"sparse warnings: (new ones prefixed by >>)"
   drivers/dma/idxd/submit.c: note: in included file (through include/linux/io.h, include/linux/pci.h):
   arch/x86/include/asm/io.h:422:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *dst @@     got void [noderef] __iomem *dst @@
   arch/x86/include/asm/io.h:422:27: sparse:     expected void *dst
   arch/x86/include/asm/io.h:422:27: sparse:     got void [noderef] __iomem *dst
   drivers/dma/idxd/submit.c: note: in included file (through arch/x86/include/asm/processor.h, arch/x86/include/asm/timex.h, include/linux/timex.h, ...):
>> arch/x86/include/asm/special_insns.h:289:41: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct <noident> *__dst @@     got void [noderef] __iomem *dst @@
   arch/x86/include/asm/special_insns.h:289:41: sparse:     expected struct <noident> *__dst
   arch/x86/include/asm/special_insns.h:289:41: sparse:     got void [noderef] __iomem *dst

Fixes: 7f5933f81bd8 ("x86/asm: Add an enqcmds() wrapper for the ENQCMDS instruction")
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v3:
- Update subject with comments from Boris.
v2:
- Update commit log with comments from Dan.

 arch/x86/include/asm/special_insns.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 4e234645f0c6..1d3cbaef4bb7 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -286,7 +286,7 @@ static inline void movdir64b(void __iomem *dst, const void *src)
 static inline int enqcmds(void __iomem *dst, const void *src)
 {
 	const struct { char _[64]; } *__src = src;
-	struct { char _[64]; } *__dst = dst;
+	struct { char _[64]; } __iomem *__dst = dst;
 	int zf;
 
 	/*


