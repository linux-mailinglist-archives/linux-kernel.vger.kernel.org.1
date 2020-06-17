Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3504B1FD865
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 00:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgFQWJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 18:09:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:6776 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgFQWJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:09:43 -0400
IronPort-SDR: LzISDdAfkwhv91AI3pOrdTaihqS2++aGQgzh36nb/4j49IdmpqLNrEt3Pk8xO5iOjRrQFqoSIQ
 UD6Kw5DG/1uQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 15:09:42 -0700
IronPort-SDR: OKpSvoY6XScPQyXwVwCy566jnRcZjOxQqudcA3tB2iS7nq6Spa2edilQvkDEg2leDyK93G1Cl5
 bIRYNfjAeCeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="421287854"
Received: from ysharon1-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.49.131])
  by orsmga004.jf.intel.com with ESMTP; 17 Jun 2020 15:09:30 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, linux-sgx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, bp@alien8.de, cedric.xing@intel.com,
        chenalexchen@google.com, conradparker@google.com,
        cyhanish@google.com, dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, tglx@linutronix.de, yaozhangx@google.com
Subject: [PATCH v33 03/21] x86/mm: x86/sgx: Signal SIGSEGV with PF_SGX
Date:   Thu, 18 Jun 2020 01:08:25 +0300
Message-Id: <20200617220844.57423-4-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617220844.57423-1-jarkko.sakkinen@linux.intel.com>
References: <20200617220844.57423-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Include SGX bit to the PF error codes and throw SIGSEGV with PF_SGX when
a #PF with SGX set happens.

CPU throws a #PF with the SGX bit in the event of Enclave Page Cache Map
(EPCM) conflict. The EPCM is a CPU-internal table, which describes the
properties for a enclave page. Enclaves are measured and signed software
entities, which SGX hosts. [1]

Although the primary purpose of the EPCM conflict checks  is to prevent
malicious accesses to an enclave, an illegit access can happen also for
legit reasons.

All SGX reserved memory, including EPCM is encrypted with a transient
key that does not survive from the power transition. Throwing a SIGSEGV
allows user space software react when this happens (e.g. rec-create the
enclave, which was invalidated).

[1] Intel SDM: 36.5.1 Enclave Page Cache Map (EPCM)

Acked-by: Jethro Beekman <jethro@fortanix.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/include/asm/traps.h |  1 +
 arch/x86/mm/fault.c          | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 714b1a30e7b0..ee3617b67bf4 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -58,5 +58,6 @@ enum x86_pf_error_code {
 	X86_PF_RSVD	=		1 << 3,
 	X86_PF_INSTR	=		1 << 4,
 	X86_PF_PK	=		1 << 5,
+	X86_PF_SGX	=		1 << 15,
 };
 #endif /* _ASM_X86_TRAPS_H */
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 66be9bd60307..25d48aae36c1 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1055,6 +1055,19 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
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

