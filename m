Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5258428215C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 06:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgJCEvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 00:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgJCEvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 00:51:16 -0400
Received: from localhost (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CABA920874;
        Sat,  3 Oct 2020 04:51:14 +0000 (UTC)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, linux-sgx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, bp@alien8.de, cedric.xing@intel.com,
        chenalexchen@google.com, conradparker@google.com,
        cyhanish@google.com, dave.hansen@intel.com, haitao.huang@intel.com,
        kai.huang@intel.com, kai.svahn@intel.com, kmoy@google.com,
        ludloff@google.com, luto@kernel.org, nhorman@redhat.com,
        npmccallum@redhat.com, puiterwijk@redhat.com, rientjes@google.com,
        tglx@linutronix.de, yaozhangx@google.com, mikko.ylinen@intel.com
Subject: [PATCH v39 05/24] x86/sgx: Add wrappers for ENCLS leaf functions
Date:   Sat,  3 Oct 2020 07:50:40 +0300
Message-Id: <20201003045059.665934-6-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201003045059.665934-1-jarkko.sakkinen@linux.intel.com>
References: <20201003045059.665934-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ENCLS is a ring 0 instruction, which contains a set of leaf functions for
managing an enclave. Enclaves are measured and signed software entities,
which are protected by asserting the outside memory accesses and memory
encryption.

Add a two-layer macro system along with an encoding scheme to allow
wrappers to return trap numbers along ENCLS-specific error codes. The
bottom layer of the macro system splits between the leafs that return an
error code and those that do not. The second layer generates the correct
input/output annotations based on the number of operands for each leaf
function.

ENCLS leaf functions are documented in

  Intel SDM: 36.6 ENCLAVE INSTRUCTIONS AND INTEL®

Acked-by: Jethro Beekman <jethro@fortanix.com>
Tested-by: Darren Kenny <darren.kenny@oracle.com>
Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/kernel/cpu/sgx/encls.h | 238 ++++++++++++++++++++++++++++++++
 1 file changed, 238 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/sgx/encls.h

diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
new file mode 100644
index 000000000000..a87f15ea5cca
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -0,0 +1,238 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+#ifndef _X86_ENCLS_H
+#define _X86_ENCLS_H
+
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/rwsem.h>
+#include <linux/types.h>
+#include <asm/asm.h>
+#include <asm/traps.h>
+#include "sgx.h"
+
+enum sgx_encls_leaf {
+	ECREATE	= 0x00,
+	EADD	= 0x01,
+	EINIT	= 0x02,
+	EREMOVE	= 0x03,
+	EDGBRD	= 0x04,
+	EDGBWR	= 0x05,
+	EEXTEND	= 0x06,
+	ELDU	= 0x08,
+	EBLOCK	= 0x09,
+	EPA	= 0x0A,
+	EWB	= 0x0B,
+	ETRACK	= 0x0C,
+};
+
+/**
+ * ENCLS_FAULT_FLAG - flag signifying an ENCLS return code is a trapnr
+ *
+ * ENCLS has its own (positive value) error codes and also generates
+ * ENCLS specific #GP and #PF faults.  And the ENCLS values get munged
+ * with system error codes as everything percolates back up the stack.
+ * Unfortunately (for us), we need to precisely identify each unique
+ * error code, e.g. the action taken if EWB fails varies based on the
+ * type of fault and on the exact SGX error code, i.e. we can't simply
+ * convert all faults to -EFAULT.
+ *
+ * To make all three error types coexist, we set bit 30 to identify an
+ * ENCLS fault.  Bit 31 (technically bits N:31) is used to differentiate
+ * between positive (faults and SGX error codes) and negative (system
+ * error codes) values.
+ */
+#define ENCLS_FAULT_FLAG 0x40000000
+
+/* Retrieve the encoded trapnr from the specified return code. */
+#define ENCLS_TRAPNR(r) ((r) & ~ENCLS_FAULT_FLAG)
+
+/* Issue a WARN() about an ENCLS leaf. */
+#define ENCLS_WARN(r, name) {						  \
+	do {								  \
+		int _r = (r);						  \
+		WARN_ONCE(_r, "%s returned %d (0x%x)\n", (name), _r, _r); \
+	} while (0);							  \
+}
+
+/**
+ * encls_failed() - Check if an ENCLS leaf function failed
+ * @ret:	the return value of an ENCLS leaf function call
+ *
+ * Check if an ENCLS leaf function failed. This happens when the leaf function
+ * causes a fault that is not caused by an EPCM conflict or when the leaf
+ * function returns a non-zero value.
+ */
+static inline bool encls_failed(int ret)
+{
+	int epcm_trapnr;
+
+	if (boot_cpu_has(X86_FEATURE_SGX2))
+		epcm_trapnr = X86_TRAP_PF;
+	else
+		epcm_trapnr = X86_TRAP_GP;
+
+	if (ret & ENCLS_FAULT_FLAG)
+		return ENCLS_TRAPNR(ret) != epcm_trapnr;
+
+	return !!ret;
+}
+
+/**
+ * __encls_ret_N - encode an ENCLS leaf that returns an error code in EAX
+ * @rax:	leaf number
+ * @inputs:	asm inputs for the leaf
+ *
+ * Emit assembly for an ENCLS leaf that returns an error code, e.g. EREMOVE.
+ * And because SGX isn't complex enough as it is, leafs that return an error
+ * code also modify flags.
+ *
+ * Return:
+ *	0 on success,
+ *	SGX error code on failure
+ */
+#define __encls_ret_N(rax, inputs...)				\
+	({							\
+	int ret;						\
+	asm volatile(						\
+	"1: .byte 0x0f, 0x01, 0xcf;\n\t"			\
+	"2:\n"							\
+	".section .fixup,\"ax\"\n"				\
+	"3: orl $"__stringify(ENCLS_FAULT_FLAG)",%%eax\n"	\
+	"   jmp 2b\n"						\
+	".previous\n"						\
+	_ASM_EXTABLE_FAULT(1b, 3b)				\
+	: "=a"(ret)						\
+	: "a"(rax), inputs					\
+	: "memory", "cc");					\
+	ret;							\
+	})
+
+#define __encls_ret_1(rax, rcx)		\
+	({				\
+	__encls_ret_N(rax, "c"(rcx));	\
+	})
+
+#define __encls_ret_2(rax, rbx, rcx)		\
+	({					\
+	__encls_ret_N(rax, "b"(rbx), "c"(rcx));	\
+	})
+
+#define __encls_ret_3(rax, rbx, rcx, rdx)			\
+	({							\
+	__encls_ret_N(rax, "b"(rbx), "c"(rcx), "d"(rdx));	\
+	})
+
+/**
+ * __encls_N - encode an ENCLS leaf that doesn't return an error code
+ * @rax:	leaf number
+ * @rbx_out:	optional output variable
+ * @inputs:	asm inputs for the leaf
+ *
+ * Emit assembly for an ENCLS leaf that does not return an error code,
+ * e.g. ECREATE.  Leaves without error codes either succeed or fault.
+ * @rbx_out is an optional parameter for use by EDGBRD, which returns
+ * the requested value in RBX.
+ *
+ * Return:
+ *   0 on success,
+ *   trapnr with ENCLS_FAULT_FLAG set on fault
+ */
+#define __encls_N(rax, rbx_out, inputs...)			\
+	({							\
+	int ret;						\
+	asm volatile(						\
+	"1: .byte 0x0f, 0x01, 0xcf;\n\t"			\
+	"   xor %%eax,%%eax;\n"					\
+	"2:\n"							\
+	".section .fixup,\"ax\"\n"				\
+	"3: orl $"__stringify(ENCLS_FAULT_FLAG)",%%eax\n"	\
+	"   jmp 2b\n"						\
+	".previous\n"						\
+	_ASM_EXTABLE_FAULT(1b, 3b)				\
+	: "=a"(ret), "=b"(rbx_out)				\
+	: "a"(rax), inputs					\
+	: "memory");						\
+	ret;							\
+	})
+
+#define __encls_2(rax, rbx, rcx)				\
+	({							\
+	unsigned long ign_rbx_out;				\
+	__encls_N(rax, ign_rbx_out, "b"(rbx), "c"(rcx));	\
+	})
+
+#define __encls_1_1(rax, data, rcx)			\
+	({						\
+	unsigned long rbx_out;				\
+	int ret = __encls_N(rax, rbx_out, "c"(rcx));	\
+	if (!ret)					\
+		data = rbx_out;				\
+	ret;						\
+	})
+
+static inline int __ecreate(struct sgx_pageinfo *pginfo, void *secs)
+{
+	return __encls_2(ECREATE, pginfo, secs);
+}
+
+static inline int __eextend(void *secs, void *addr)
+{
+	return __encls_2(EEXTEND, secs, addr);
+}
+
+static inline int __eadd(struct sgx_pageinfo *pginfo, void *addr)
+{
+	return __encls_2(EADD, pginfo, addr);
+}
+
+static inline int __einit(void *sigstruct, void *token, void *secs)
+{
+	return __encls_ret_3(EINIT, sigstruct, secs, token);
+}
+
+static inline int __eremove(void *addr)
+{
+	return __encls_ret_1(EREMOVE, addr);
+}
+
+static inline int __edbgwr(void *addr, unsigned long *data)
+{
+	return __encls_2(EDGBWR, *data, addr);
+}
+
+static inline int __edbgrd(void *addr, unsigned long *data)
+{
+	return __encls_1_1(EDGBRD, *data, addr);
+}
+
+static inline int __etrack(void *addr)
+{
+	return __encls_ret_1(ETRACK, addr);
+}
+
+static inline int __eldu(struct sgx_pageinfo *pginfo, void *addr,
+			 void *va)
+{
+	return __encls_ret_3(ELDU, pginfo, addr, va);
+}
+
+static inline int __eblock(void *addr)
+{
+	return __encls_ret_1(EBLOCK, addr);
+}
+
+static inline int __epa(void *addr)
+{
+	unsigned long rbx = SGX_PAGE_TYPE_VA;
+
+	return __encls_2(EPA, rbx, addr);
+}
+
+static inline int __ewb(struct sgx_pageinfo *pginfo, void *addr,
+			void *va)
+{
+	return __encls_ret_3(EWB, pginfo, addr, va);
+}
+
+#endif /* _X86_ENCLS_H */
-- 
2.25.1

