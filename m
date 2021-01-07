Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1CD2ED4A3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbhAGQpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:45:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:57335 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728284AbhAGQpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:45:33 -0500
IronPort-SDR: 51edUx96bFXD1UYpg0Wli/P1CgxMdtlLrtpD9JBblLNYMBZw4FRUJTFzwGyNBMjJ1fkk9WDbRV
 H62HHB9N7s9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="157235188"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="157235188"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 08:44:52 -0800
IronPort-SDR: JAajxnCuspdWJfSeWdeb0AZsdwH5B5VYb3x1J+b5PQBb+AuB5sQgC/2ekaKG65hZ40X0ucApnI
 maIMOLzq3qNg==
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="343952780"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 08:44:51 -0800
Subject: [PATCH v3] x86: fix movdir64b() with missing __iomem annotation
From:   Dave Jiang <dave.jiang@intel.com>
To:     bp@alien8.de, x86@kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dan.j.williams@intel.com, ben.widawsky@intel.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 07 Jan 2021 09:44:51 -0700
Message-ID: <161003787823.4062451.6564503265464317197.stgit@djiang5-desk3.ch.intel.com>
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
device for consumption. When future usages for MOVDIR64B instruction show
up in kernel for memory to memory operation is needed, the code can be
revisited.

Also, from the comment in movdir64b() @__dst must be supplied as an
lvalue because this tells the compiler what the object is (its size)
the instruction accesses. I.e., not the pointers but what they point
to, thus the deref'ing '*'."

"sparse warnings: (new ones prefixed by >>)"
   drivers/dma/idxd/submit.c: note: in included file (through include/linux/io.h, include/linux/pci.h):
>> arch/x86/include/asm/io.h:422:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *dst @@     got void [noderef] __iomem *dst @@
   arch/x86/include/asm/io.h:422:27: sparse:     expected void *dst
   arch/x86/include/asm/io.h:422:27: sparse:     got void [noderef] __iomem *dst

Fixes: 0888e1030d3e ("x86/asm: Carve out a generic movdir64b() helper for general usage")
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v3:
- Update subject and commit log with comments from Boris.
v2:
- Update commit log with comments from Dan.

 arch/x86/include/asm/special_insns.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index cc177b4431ae..4e234645f0c6 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -243,10 +243,10 @@ static inline void serialize(void)
 }
 
 /* The dst parameter must be 64-bytes aligned */
-static inline void movdir64b(void *dst, const void *src)
+static inline void movdir64b(void __iomem *dst, const void *src)
 {
 	const struct { char _[64]; } *__src = src;
-	struct { char _[64]; } *__dst = dst;
+	struct { char _[64]; } __iomem *__dst = dst;
 
 	/*
 	 * MOVDIR64B %(rdx), rax.


