Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8230D262B56
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 11:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgIIJJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 05:09:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:59860 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgIIJJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:09:15 -0400
IronPort-SDR: 4RgY6XKWC6/fXPJeWwJAIeW8oXjEu9X7+N33tu/yCGfCJwyHnuXvSNx/2ma4yCrPEhAWp2zygs
 JhqW/ANgHFuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="155697284"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="155697284"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 02:09:14 -0700
IronPort-SDR: ZNwBjmKKhQZ6o9j1588awhk5k3t5zv9oKsARtJeASSrOBZYnQSL1VokTahc2WOdWmlJ94Qc0n3
 Xg2rIEV3WMbw==
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="304428022"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 02:09:10 -0700
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
Subject: [PATCH v3 03/17] x86/acrn: Introduce an API to check if a VM is privileged
Date:   Wed,  9 Sep 2020 17:08:22 +0800
Message-Id: <20200909090836.46762-4-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200909090836.46762-1-shuo.a.liu@intel.com>
References: <20200909090836.46762-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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
index bd1d7e759a0f..6f0a00cbbf7e 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -21,9 +21,26 @@
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

