Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423A230020A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbhAVLyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:54:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:24040 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbhAVLCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:02:34 -0500
IronPort-SDR: 4t5Qkyc6Zgx+4PlrL5WaAGKibiPzKJzmFeu5NdRH6Z6G+wCpac9B/J23lmtwPTPQTCGPR208kb
 bOIiYRthBj8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="243508166"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="243508166"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 03:01:42 -0800
IronPort-SDR: JtJUwqGuRTMAsecYDBQbuXoSG5AwsKbocU7Sf7BuypxWU4wpfw0RdUYdH9ATZZcJ3SummnVsjn
 8NiCH6J8+/Tg==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="367381466"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 03:01:38 -0800
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
        Zhi Wang <zhi.a.wang@intel.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH v8 02/18] x86/acrn: Introduce acrn_{setup, remove}_intr_handler()
Date:   Fri, 22 Jan 2021 19:01:06 +0800
Message-Id: <20210122110122.45800-3-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210122110122.45800-1-shuo.a.liu@intel.com>
References: <20210122110122.45800-1-shuo.a.liu@intel.com>
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
---
 arch/x86/include/asm/acrn.h |  8 ++++++++
 arch/x86/kernel/cpu/acrn.c  | 14 ++++++++++++++
 2 files changed, 22 insertions(+)
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
index 0b2c03943ac6..e0c181781905 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -10,6 +10,8 @@
  */
 
 #include <linux/interrupt.h>
+
+#include <asm/acrn.h>
 #include <asm/apic.h>
 #include <asm/cpufeatures.h>
 #include <asm/desc.h>
@@ -55,6 +57,18 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_acrn_hv_callback)
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

