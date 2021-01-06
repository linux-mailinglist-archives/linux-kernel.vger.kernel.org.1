Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD67B2EBACC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbhAFHwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 02:52:18 -0500
Received: from mga17.intel.com ([192.55.52.151]:3827 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbhAFHwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:52:15 -0500
IronPort-SDR: Ma3453biWJfYSj2DcsJAUmnctd9U14VWRftT+Sb5oJq8wttksLgwdJlMMg242+SIQBmYkyZDz5
 l6LsOxwOyamQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="157028126"
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="157028126"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 23:51:33 -0800
IronPort-SDR: HXk5cShn1NSR7rlZgG9FgRwmCWhR+6tAfNlpfb7pZlx2LZB4SDW9RSBFNDtEmICdtI9QOYAxjA
 F8xA7EwQqSHQ==
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="346565497"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 23:51:28 -0800
From:   shuo.a.liu@intel.com
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Yakui Zhao <yakui.zhao@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH v7 04/18] x86/acrn: Introduce hypercall interfaces
Date:   Wed,  6 Jan 2021 15:50:41 +0800
Message-Id: <20210106075055.47226-5-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210106075055.47226-1-shuo.a.liu@intel.com>
References: <20210106075055.47226-1-shuo.a.liu@intel.com>
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
register as direct register constraints, use supported constraint as
input with a explicit MOV to R8 in beginning of asm.

Originally-by: Yakui Zhao <yakui.zhao@intel.com>
Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Borislav Petkov <bp@suse.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Fengwei Yin <fengwei.yin@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
---
 arch/x86/include/asm/acrn.h | 54 +++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
index 127f20672c5d..e003a01b7c67 100644
--- a/arch/x86/include/asm/acrn.h
+++ b/arch/x86/include/asm/acrn.h
@@ -21,4 +21,58 @@ static inline u32 acrn_cpuid_base(void)
 	return 0;
 }
 
+/*
+ * Hypercalls for ACRN
+ *
+ * - VMCALL instruction is used to implement ACRN hypercalls.
+ * - ACRN hypercall ABI:
+ *   - Hypercall number is passed in R8 register.
+ *   - Up to 2 arguments are passed in RDI, RSI.
+ *   - Return value will be placed in RAX.
+ *
+ * Because GCC doesn't support R8 register as direct register constraints, use
+ * supported constraint as input with a explicit MOV to R8 in beginning of asm.
+ */
+static inline long acrn_hypercall0(unsigned long hcall_id)
+{
+	long result;
+
+	asm volatile("movl %1, %%r8d\n\t"
+		     "vmcall\n\t"
+		     : "=a" (result)
+		     : "g" (hcall_id)
+		     : "r8", "memory");
+
+	return result;
+}
+
+static inline long acrn_hypercall1(unsigned long hcall_id,
+				   unsigned long param1)
+{
+	long result;
+
+	asm volatile("movl %1, %%r8d\n\t"
+		     "vmcall\n\t"
+		     : "=a" (result)
+		     : "g" (hcall_id), "D" (param1)
+		     : "r8", "memory");
+
+	return result;
+}
+
+static inline long acrn_hypercall2(unsigned long hcall_id,
+				   unsigned long param1,
+				   unsigned long param2)
+{
+	long result;
+
+	asm volatile("movl %1, %%r8d\n\t"
+		     "vmcall\n\t"
+		     : "=a" (result)
+		     : "g" (hcall_id), "D" (param1), "S" (param2)
+		     : "r8", "memory");
+
+	return result;
+}
+
 #endif /* _ASM_X86_ACRN_H */
-- 
2.28.0

