Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00C72EC53D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 21:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbhAFUkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 15:40:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:47800 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbhAFUkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 15:40:51 -0500
IronPort-SDR: Nb4FSlTcK+Hcm1TZz3pqJ+bx5xTmnzuvldO/MfjZVsmHpP17eUAGAtsah6IusgSFawznViWWfA
 ZVoawAK6os4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="241410936"
X-IronPort-AV: E=Sophos;i="5.79,328,1602572400"; 
   d="scan'208";a="241410936"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2021 12:40:09 -0800
IronPort-SDR: ULqD7HGo7WhNapSfgJHyJjBQ4PT9e8F+5ITO1sXJDhZB4Cv1CqH4/FsoN/X+2D64T52uNPsRJ2
 Xy/E+vJ9pMCg==
X-IronPort-AV: E=Sophos;i="5.79,328,1602572400"; 
   d="scan'208";a="567534706"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2021 12:40:08 -0800
Subject: [PATCH] x86: fix enqcmds() sparse warning
From:   Dave Jiang <dave.jiang@intel.com>
To:     bp@alien8.de, x86@kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        dan.j.williams@intel.com, ben.widawsky@intel.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 06 Jan 2021 13:40:08 -0700
Message-ID: <160996560856.3973505.10433205523993096439.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing __iomem anotation to address sparse warning.

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
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
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


