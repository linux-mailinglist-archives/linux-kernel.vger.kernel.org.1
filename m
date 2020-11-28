Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596BC2C6EA6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 04:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbgK1Deb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 22:34:31 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8056 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731107AbgK1D2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 22:28:50 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CjcQc5RX2zhYSx;
        Sat, 28 Nov 2020 11:28:24 +0800 (CST)
Received: from linux-suse12sp4.huawei.com (10.67.133.50) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Sat, 28 Nov 2020 11:28:39 +0800
From:   laiyuanyuan <laiyuanyuan.lai@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
CC:     <wangle6@huawei.com>, <laiyuanyuan.lai@huawei.com>
Subject: [PATCH] x86: fix some spelling mistakes in the comments
Date:   Sat, 28 Nov 2020 11:28:39 +0800
Message-ID: <20201128032839.60293-1-laiyuanyuan.lai@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.133.50]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some spelling mistakes in the comments:
	reqeust ==> request
	Runing ==> Running
	interupts ==> interrupts
	requsted ==> requested

Signed-off-by: laiyuanyuan <laiyuanyuan.lai@huawei.com>
---
 arch/x86/kernel/e820.c  | 2 +-
 arch/x86/kernel/hpet.c  | 2 +-
 arch/x86/kernel/smp.c   | 2 +-
 arch/x86/kernel/traps.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 22aad412f965..f74cb7da9557 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -793,7 +793,7 @@ core_initcall(e820__register_nvs_regions);
 #endif
 
 /*
- * Allocate the requested number of bytes with the requsted alignment
+ * Allocate the requested number of bytes with the requested alignment
  * and return (the physical address) to the caller. Also register this
  * range in the 'kexec' E820 table as a reserved range.
  *
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 7a50f0b62a70..71cb347ddd24 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -596,7 +596,7 @@ static void __init hpet_select_clockevents(void)
 
 	hpet_base.nr_clockevents = 0;
 
-	/* No point if MSI is disabled or CPU has an Always Runing APIC Timer */
+	/* No point if MSI is disabled or CPU has an Always Running APIC Timer */
 	if (hpet_msi_disable || boot_cpu_has(X86_FEATURE_ARAT))
 		return;
 
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index eff4ce3b10da..ec640fec787c 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -204,7 +204,7 @@ static void native_stop_other_cpus(int wait)
 		}
 		/*
 		 * Don't wait longer than 10 ms if the caller didn't
-		 * reqeust it. If wait is true, the machine hangs here if
+		 * request it. If wait is true, the machine hangs here if
 		 * one or more CPUs do not reach shutdown state.
 		 */
 		timeout = USEC_PER_MSEC * 10;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index e19df6cde35d..5f999b4154e0 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -390,7 +390,7 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 		/*
 		 * Adjust our frame so that we return straight to the #GP
 		 * vector with the expected RSP value.  This is safe because
-		 * we won't enable interupts or schedule before we invoke
+		 * we won't enable interrupts or schedule before we invoke
 		 * general_protection, so nothing will clobber the stack
 		 * frame we just set up.
 		 *
-- 
2.12.3

