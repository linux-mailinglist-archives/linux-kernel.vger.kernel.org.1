Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F82274129
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgIVLrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:47:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:59836 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgIVLoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:44:06 -0400
IronPort-SDR: n/l8ZvKoVtco7qQYWF3We65FKZJX7U3GkbvIzYFc5hOVv/Y96Xi45KOfMpMQZZkCFaUc/QLj2d
 XntgFXVcGb7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="222176902"
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="222176902"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 04:43:53 -0700
IronPort-SDR: HiReXYV5kpDCsW9cyE/Q8RfbgHBo/aXLM8vbdJhjK1FKFJQtEpMKlFRT0qU2fzaGBuju4BFk10
 DLWCm4xqHazQ==
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="309469820"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 04:43:49 -0700
From:   shuo.a.liu@intel.com
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Yakui Zhao <yakui.zhao@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH v4 04/17] x86/acrn: Introduce hypercall interfaces
Date:   Tue, 22 Sep 2020 19:42:58 +0800
Message-Id: <20200922114311.38804-5-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922114311.38804-1-shuo.a.liu@intel.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

The Service VM communicates with the hypervisor via conventional
hypercalls. VMCALL instruction is used to make the hypercalls.

ACRN hypercall ABI:
  * Hypercall number is in R8 register.
  * Up to 2 parameters are in RDI and RSI registers.
  * Return value is in RAX register.

Introduce the ACRN hypercall interfaces. Because GCC doesn't support R8
register as direct register constraints, here are two ways to use R8 in
extended asm:
  1) use explicit register variable as input
  2) use supported constraint as input with a explicit MOV to R8 in
     beginning of asm

The number of instructions of above two ways are same.
Asm code from 1)
  38:   41 b8 00 00 00 80       mov    $0x80000000,%r8d
  3e:   48 89 c7                mov    %rax,%rdi
  41:   0f 01 c1                vmcall
Here, writes to the lower dword (%r8d) clear the upper dword of %r8 when
the CPU is in 64-bit mode.

Asm code from 2)
  38:   48 89 c7                mov    %rax,%rdi
  3b:   49 b8 00 00 00 80 00    movabs $0x80000000,%r8
  42:   00 00 00
  45:   0f 01 c1                vmcall

Choose 1) for code simplicity and a little bit of code size
optimization.

Originally-by: Yakui Zhao <yakui.zhao@intel.com>
Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Fengwei Yin <fengwei.yin@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/acrn.h | 57 +++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
index a2d4aea3a80d..23a93b87edeb 100644
--- a/arch/x86/include/asm/acrn.h
+++ b/arch/x86/include/asm/acrn.h
@@ -14,4 +14,61 @@ void acrn_setup_intr_handler(void (*handler)(void));
 void acrn_remove_intr_handler(void);
 bool acrn_is_privileged_vm(void);
 
+/*
+ * Hypercalls for ACRN
+ *
+ * - VMCALL instruction is used to implement ACRN hypercalls.
+ * - ACRN hypercall ABI:
+ *   - Hypercall number is passed in R8 register.
+ *   - Up to 2 arguments are passed in RDI, RSI.
+ *   - Return value will be placed in RAX.
+ */
+static inline long acrn_hypercall0(unsigned long hcall_id)
+{
+	register long r8 asm("r8");
+	long result;
+
+	/* Nothing can come between the r8 assignment and the asm: */
+	r8 = hcall_id;
+	asm volatile("vmcall\n\t"
+		     : "=a" (result)
+		     : "r" (r8)
+		     : );
+
+	return result;
+}
+
+static inline long acrn_hypercall1(unsigned long hcall_id,
+				   unsigned long param1)
+{
+	register long r8 asm("r8");
+	long result;
+
+	/* Nothing can come between the r8 assignment and the asm: */
+	r8 = hcall_id;
+	asm volatile("vmcall\n\t"
+		     : "=a" (result)
+		     : "r" (r8), "D" (param1)
+		     : );
+
+	return result;
+}
+
+static inline long acrn_hypercall2(unsigned long hcall_id,
+				   unsigned long param1,
+				   unsigned long param2)
+{
+	register long r8 asm("r8");
+	long result;
+
+	/* Nothing can come between the r8 assignment and the asm: */
+	r8 = hcall_id;
+	asm volatile("vmcall\n\t"
+		     : "=a" (result)
+		     : "r" (r8), "D" (param1), "S" (param2)
+		     : );
+
+	return result;
+}
+
 #endif /* _ASM_X86_ACRN_H */
-- 
2.28.0

