Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC52C26B8CA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgIPAug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgIOLlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:41:03 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA370C06178A;
        Tue, 15 Sep 2020 04:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Z0z7VU0ZJOglP2ZP2H14DlOIQchhVanxR/WdYj/tOzs=; b=Q9C+Lkg+d140PJwHzmMxB3GPoh
        cAqivlF5xy8N9eJuKa75TfKd5gXUqSVh1o0mzOLiuAMtJRBfILXQwoON5WhkE05Dcr6eeeQ7GRUos
        fHZbCv9kQT4c9t/ZUpUEzerB7LrLItAEkXMo/aDq+x68HL1WEojZdLFc7u8rxNHYxEM7T5PL6+pPJ
        GXnvTffyMXXo0NDsKPEkUpgsX3wuAxJCSJsiUXFU4ucCgGO6DRfVRPpnMrlXNPmYpVAYHo0UDB0Zr
        hc6eiZghb1FNneaA7XgowKM5+89r/JFX7cgDNWSdpDDow3FqvnaZJzFwyaKHnenH6oFqCqMIj2fUr
        nDieUA/g==;
Received: from 83-245-197-237.elisa-laajakaista.fi ([83.245.197.237] helo=localhost)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jarkko.sakkinen@linux.intel.com>)
        id 1kI8m8-0005t9-MM; Tue, 15 Sep 2020 14:05:28 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, linux-sgx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, bp@alien8.de, cedric.xing@intel.com,
        chenalexchen@google.com, conradparker@google.com,
        cyhanish@google.com, dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, tglx@linutronix.de, yaozhangx@google.com
Subject: [PATCH v38 03/24] x86/mm: x86/sgx: Signal SIGSEGV with PF_SGX
Date:   Tue, 15 Sep 2020 14:05:01 +0300
Message-Id: <20200915110522.893152-4-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200915110522.893152-1-jarkko.sakkinen@linux.intel.com>
References: <20200915110522.893152-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 83.245.197.237
X-SA-Exim-Mail-From: jarkko.sakkinen@linux.intel.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Include SGX bit to the PF error codes and throw SIGSEGV with PF_SGX when
a #PF with SGX set happens.

CPU throws a #PF with the SGX set in the event of Enclave Page Cache Map
(EPCM) conflict. The EPCM is a CPU-internal table, which describes the
properties for a enclave page. Enclaves are measured and signed software
entities, which SGX hosts. [1]

Although the primary purpose of the EPCM conflict checks  is to prevent
malicious accesses to an enclave, an illegit access can happen also for
legit reasons.

All SGX reserved memory, including EPCM is encrypted with a transient key
that does not survive from the power transition. Throwing a SIGSEGV allows
user space software to react when this happens (e.g. recreate the enclave,
which was invalidated).

[1] Intel SDM: 36.5.1 Enclave Page Cache Map (EPCM)

Acked-by: Jethro Beekman <jethro@fortanix.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/include/asm/traps.h | 14 ++++++++------
 arch/x86/mm/fault.c          | 13 +++++++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 714b1a30e7b0..4446f95ad997 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -44,12 +44,13 @@ void __noreturn handle_stack_overflow(const char *message,
 /*
  * Page fault error code bits:
  *
- *   bit 0 ==	 0: no page found	1: protection fault
- *   bit 1 ==	 0: read access		1: write access
- *   bit 2 ==	 0: kernel-mode access	1: user-mode access
- *   bit 3 ==				1: use of reserved bit detected
- *   bit 4 ==				1: fault was an instruction fetch
- *   bit 5 ==				1: protection keys block access
+ *   bit 0  ==	 0: no page found	1: protection fault
+ *   bit 1  ==	 0: read access		1: write access
+ *   bit 2  ==	 0: kernel-mode access	1: user-mode access
+ *   bit 3  ==				1: use of reserved bit detected
+ *   bit 4  ==				1: fault was an instruction fetch
+ *   bit 5  ==				1: protection keys block access
+ *   bit 15 ==				1: inside SGX enclave
  */
 enum x86_pf_error_code {
 	X86_PF_PROT	=		1 << 0,
@@ -58,5 +59,6 @@ enum x86_pf_error_code {
 	X86_PF_RSVD	=		1 << 3,
 	X86_PF_INSTR	=		1 << 4,
 	X86_PF_PK	=		1 << 5,
+	X86_PF_SGX	=		1 << 15,
 };
 #endif /* _ASM_X86_TRAPS_H */
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 35f1498e9832..1a7cc6d3281a 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1054,6 +1054,19 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
 	if (error_code & X86_PF_PK)
 		return 1;
 
+	/*
+	 * Access is blocked by the Enclave Page Cache Map (EPCM), i.e. the
+	 * access is allowed by the PTE but not the EPCM. This usually happens
+	 * when the EPCM is yanked out from under us, e.g. by hardware after a
+	 * suspend/resume cycle. In any case, software, i.e. the kernel, can't
+	 * fix the source of the fault as the EPCM can't be directly modified by
+	 * software. Handle the fault as an access error in order to signal
+	 * userspace so that userspace can rebuild their enclave(s), even though
+	 * userspace may not have actually violated access permissions.
+	 */
+	if (unlikely(error_code & X86_PF_SGX))
+		return 1;
+
 	/*
 	 * Make sure to check the VMA so that we do not perform
 	 * faults just to hit a X86_PF_PK as soon as we fill in a
-- 
2.25.1

