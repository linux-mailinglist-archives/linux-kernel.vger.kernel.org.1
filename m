Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A8625C203
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 15:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgICNyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 09:54:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:7159 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbgICMpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:45:36 -0400
IronPort-SDR: 1cPOsXju1Cesy+T0ylY0tB4sHHK4YQr9RHSHRkUQr+SOxpTQJKzY6XlOvGNgRSzSK/RscIrKG2
 QgEnyfndDGPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="221778316"
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; 
   d="scan'208";a="221778316"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 05:42:38 -0700
IronPort-SDR: DEofIp1Eg9atdh10eiBDxOGLDIYttoMTo+osfN7aOmSUr510EM+6v1gAfj2xD5C4VYIfCrTAp7
 t4tr10ouWyWQ==
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; 
   d="scan'208";a="302194918"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 05:42:33 -0700
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
Subject: [PATCH v2 04/17] x86/acrn: Introduce hypercall interfaces
Date:   Thu,  3 Sep 2020 20:41:48 +0800
Message-Id: <20200903124201.17275-5-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903124201.17275-1-shuo.a.liu@intel.com>
References: <20200903124201.17275-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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

