Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A604D27414A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgIVLsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:48:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:39044 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbgIVLnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:43:47 -0400
IronPort-SDR: SowYU8QK1fCeQGFWPSgPhvKL1BClLIDC0YafGaj1kwXNKMWpJXDzjp0KZTqk3Ha7eZUUFIXPmK
 uIQZ89yXV8fA==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="224732826"
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="224732826"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 04:43:41 -0700
IronPort-SDR: yQZeYdwBfrsXzSoTdmRXDez7SNEDT9LS8+112XtFtZ1rLNV9XbXNjK50CtMyhCU8dg8813uLaa
 5EC9rc3o0Paw==
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="511172150"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.135])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 04:43:37 -0700
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
        Zhi Wang <zhi.a.wang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH v4 02/17] x86/acrn: Introduce acrn_{setup, remove}_intr_handler()
Date:   Tue, 22 Sep 2020 19:42:56 +0800
Message-Id: <20200922114311.38804-3-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922114311.38804-1-shuo.a.liu@intel.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

The ACRN Hypervisor builds an I/O request when a trapped I/O access
happens in User VM. Then, ACRN Hypervisor issues an upcall by sending
a notification interrupt to the Service VM. HSM in the Service VM needs
to hook the notification interrupt to handle I/O requests.

Notification interrupts from ACRN Hypervisor are already supported and
a, currently uninitialized, callback called.

Export two APIs for HSM to setup/remove its callback.

Originally-by: Yakui Zhao <yakui.zhao@intel.com>
Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
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
 arch/x86/include/asm/acrn.h |  8 ++++++++
 arch/x86/kernel/cpu/acrn.c  | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 arch/x86/include/asm/acrn.h

diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
new file mode 100644
index 000000000000..ff259b69cde7
--- /dev/null
+++ b/arch/x86/include/asm/acrn.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_ACRN_H
+#define _ASM_X86_ACRN_H
+
+void acrn_setup_intr_handler(void (*handler)(void));
+void acrn_remove_intr_handler(void);
+
+#endif /* _ASM_X86_ACRN_H */
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 0b2c03943ac6..42e88d01ccf9 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -9,7 +9,11 @@
  *
  */
 
+#define pr_fmt(fmt) "acrn: " fmt
+
 #include <linux/interrupt.h>
+
+#include <asm/acrn.h>
 #include <asm/apic.h>
 #include <asm/cpufeatures.h>
 #include <asm/desc.h>
@@ -55,6 +59,18 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_acrn_hv_callback)
 	set_irq_regs(old_regs);
 }
 
+void acrn_setup_intr_handler(void (*handler)(void))
+{
+	acrn_intr_handler = handler;
+}
+EXPORT_SYMBOL_GPL(acrn_setup_intr_handler);
+
+void acrn_remove_intr_handler(void)
+{
+	acrn_intr_handler = NULL;
+}
+EXPORT_SYMBOL_GPL(acrn_remove_intr_handler);
+
 const __initconst struct hypervisor_x86 x86_hyper_acrn = {
 	.name                   = "ACRN",
 	.detect                 = acrn_detect,
-- 
2.28.0

