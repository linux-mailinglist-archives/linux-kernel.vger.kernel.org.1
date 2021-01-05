Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000DE2EA2A1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 02:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbhAEBEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 20:04:33 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:51365 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727940AbhAEBE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 20:04:29 -0500
X-Greylist: delayed 948 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jan 2021 20:04:29 EST
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 4 Jan 2021 16:47:53 -0800
Received: from amakhalov-virtual-machine.eng.vmware.com (unknown [10.118.101.187])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 0859A20355;
        Mon,  4 Jan 2021 16:47:55 -0800 (PST)
From:   Alexey Makhalov <amakhalov@vmware.com>
To:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>, <hpa@zytor.com>,
        <bp@alien8.de>, <mingo@redhat.com>, <tglx@linutronix.de>,
        <pv-drivers@vmware.com>, <sdeep@vmware.com>
CC:     Alexey Makhalov <amakhalov@vmware.com>
Subject: [PATCH] x86/vmware: avoid TSC recalibration
Date:   Mon, 4 Jan 2021 16:47:52 -0800
Message-ID: <20210105004752.131069-1-amakhalov@vmware.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: amakhalov@vmware.com does not
 designate permitted sender hosts)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When TSC frequency is known (retrieved from hypervisor), we should skip
TSC refined calibration by setting X86_FEATURE_TSC_KNOWN_FREQ.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
---
 arch/x86/kernel/cpu/vmware.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index c6ede3b3d302..83164110ccc5 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -378,6 +378,8 @@ static void __init vmware_set_capabilities(void)
 {
 	setup_force_cpu_cap(X86_FEATURE_CONSTANT_TSC);
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+	if (vmware_tsc_khz)
+		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMCALL)
 		setup_force_cpu_cap(X86_FEATURE_VMCALL);
 	else if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMMCALL)
-- 
2.11.0

