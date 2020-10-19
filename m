Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54C7292268
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 08:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgJSGSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 02:18:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:21152 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgJSGSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 02:18:39 -0400
IronPort-SDR: VRSbNviPxMHjcDBB2HiwAli1VoKT2gpLNW0mEw+mXsqd8u7PzX/4UMp02VryUK66CLnUJUbwng
 TWkvv0jt/O3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="153912590"
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="153912590"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 23:18:37 -0700
IronPort-SDR: rKeJx9Rc2VNk06k+0YPgBaeNcVgxImdTIQo7XODbg8AAYYWwTBo0JVO7m9gN0Bj/C+6sQtib5O
 qBR1/rFgU3RA==
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="347309932"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 23:18:32 -0700
From:   shuo.a.liu@intel.com
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH v5 03/17] x86/acrn: Introduce an API to check if a VM is privileged
Date:   Mon, 19 Oct 2020 14:17:49 +0800
Message-Id: <20201019061803.13298-4-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019061803.13298-1-shuo.a.liu@intel.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yin Fengwei <fengwei.yin@intel.com>

ACRN Hypervisor reports hypervisor features via CPUID leaf 0x40000001
which is similar to KVM. A VM can check if it's the privileged VM using
the feature bits. The Service VM is the only privileged VM by design.

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
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
 arch/x86/include/asm/acrn.h |  9 +++++++++
 arch/x86/kernel/cpu/acrn.c  | 19 ++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
index ff259b69cde7..a2d4aea3a80d 100644
--- a/arch/x86/include/asm/acrn.h
+++ b/arch/x86/include/asm/acrn.h
@@ -2,7 +2,16 @@
 #ifndef _ASM_X86_ACRN_H
 #define _ASM_X86_ACRN_H
 
+/*
+ * This CPUID returns feature bitmaps in EAX.
+ * Guest VM uses this to detect the appropriate feature bit.
+ */
+#define	ACRN_CPUID_FEATURES		0x40000001
+/* Bit 0 indicates whether guest VM is privileged */
+#define	ACRN_FEATURE_PRIVILEGED_VM	BIT(0)
+
 void acrn_setup_intr_handler(void (*handler)(void));
 void acrn_remove_intr_handler(void);
+bool acrn_is_privileged_vm(void);
 
 #endif /* _ASM_X86_ACRN_H */
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index e0c181781905..5528bfc913ea 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -19,9 +19,26 @@
 #include <asm/idtentry.h>
 #include <asm/irq_regs.h>
 
+static u32 acrn_cpuid_base(void)
+{
+	static u32 acrn_cpuid_base;
+
+	if (!acrn_cpuid_base && boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		acrn_cpuid_base = hypervisor_cpuid_base("ACRNACRNACRN", 0);
+
+	return acrn_cpuid_base;
+}
+
+bool acrn_is_privileged_vm(void)
+{
+	return cpuid_eax(acrn_cpuid_base() | ACRN_CPUID_FEATURES) &
+			 ACRN_FEATURE_PRIVILEGED_VM;
+}
+EXPORT_SYMBOL_GPL(acrn_is_privileged_vm);
+
 static u32 __init acrn_detect(void)
 {
-	return hypervisor_cpuid_base("ACRNACRNACRN", 0);
+	return acrn_cpuid_base();
 }
 
 static void __init acrn_init_platform(void)
-- 
2.28.0

