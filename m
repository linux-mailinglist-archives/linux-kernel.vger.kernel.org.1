Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF3D2A66D0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbgKDOzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:55:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:48902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730245AbgKDOzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:55:10 -0500
Received: from suppilovahvero.lan (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87F132240C;
        Wed,  4 Nov 2020 14:55:03 +0000 (UTC)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, linux-sgx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jethro Beekman <jethro@fortanix.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: [PATCH v40 05/24] x86/cpufeatures: x86/msr: Add Intel SGX Launch Control hardware bits
Date:   Wed,  4 Nov 2020 16:54:11 +0200
Message-Id: <20201104145430.300542-6-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104145430.300542-1-jarkko.sakkinen@linux.intel.com>
References: <20201104145430.300542-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

The SGX Launch Control hardware helps restrict which enclaves the
hardware will run.  Launch control is intended to restrict what software
can run with enclave protections, which helps protect the overall system
from bad enclaves.

For the kernel's purposes, there are effectively two modes in which the
launch control hardware can operate: rigid and flexible. In its rigid
mode, an entity other than the kernel has ultimate authority over which
enclaves can be run (firmware, Intel, etc...). In its flexible mode, the
kernel has ultimate authority over which enclaves can run.

Enable X86_FEATURE_SGX_LC to enumerate when the CPU supports SGX Launch
Control in general.

Add MSR_IA32_SGXLEPUBKEYHASH{0, 1, 2, 3}, which when combined contain a
SHA256 hash of a 3072-bit RSA public key. The hardware allows SGX enclaves
signed with this public key to initialize and run [*]. Enclaves not signed
with this key can not initialize and run.

Add FEAT_CTL_SGX_LC_ENABLED, which informs whether the SGXLEPUBKEYHASH MSRs
can be written by the kernel.

If the MSRs do not exist or are read-only, the launch control hardware is
operating in rigid mode. Linux does not and will not support creating
enclaves when hardware is configured in rigid mode because it takes away
the authority for launch decisions from the kernel. Note, this does not
preclude KVM from virtualizing/exposing SGX to a KVM guest when launch
control hardware is operating in rigid mode.

[*] Intel SDM: 38.1.4 Intel SGX Launch Control Configuration

Reviewed-by: Borislav Petkov <bp@alien8.de>
Acked-by: Jethro Beekman <jethro@fortanix.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/include/asm/msr-index.h   | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 1181f5c7bbef..f5ef2d5b9231 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -357,6 +357,7 @@
 #define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
 #define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
 #define X86_FEATURE_ENQCMD		(16*32+29) /* ENQCMD and ENQCMDS instructions */
+#define X86_FEATURE_SGX_LC		(16*32+30) /* Software Guard Extensions Launch Control */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 258d555d22f2..d0c6cfff5b55 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -609,6 +609,7 @@
 #define FEAT_CTL_LOCKED				BIT(0)
 #define FEAT_CTL_VMX_ENABLED_INSIDE_SMX		BIT(1)
 #define FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX	BIT(2)
+#define FEAT_CTL_SGX_LC_ENABLED			BIT(17)
 #define FEAT_CTL_SGX_ENABLED			BIT(18)
 #define FEAT_CTL_LMCE_ENABLED			BIT(20)
 
@@ -629,6 +630,12 @@
 #define MSR_IA32_UCODE_WRITE		0x00000079
 #define MSR_IA32_UCODE_REV		0x0000008b
 
+/* Intel SGX Launch Enclave Public Key Hash MSRs */
+#define MSR_IA32_SGXLEPUBKEYHASH0	0x0000008C
+#define MSR_IA32_SGXLEPUBKEYHASH1	0x0000008D
+#define MSR_IA32_SGXLEPUBKEYHASH2	0x0000008E
+#define MSR_IA32_SGXLEPUBKEYHASH3	0x0000008F
+
 #define MSR_IA32_SMM_MONITOR_CTL	0x0000009b
 #define MSR_IA32_SMBASE			0x0000009e
 
-- 
2.27.0

