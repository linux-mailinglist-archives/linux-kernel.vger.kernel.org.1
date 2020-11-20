Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B532BA98A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 12:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgKTLq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 06:46:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:56204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgKTLqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:46:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605872797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sS1EJKt51h291wm5JVNdsHCnbqIXSSiBfe36LpIoCrA=;
        b=WVjP1cXrvEv6BcOuYYRRPDo3jLHXRzTbMmG8iz26tq7H/AD6XGaCaEuWLh1HYP0KzOQojC
        TL5gEUnwW2xZHsOxw7AUv5t25FlWOGVjL7woGx7jIIthaq+3F+CLPtjKswaNYB80qYpmvG
        3n9/6uZzIwC91SbNbyTtK8/S+fhiOK4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73BF2ADD9;
        Fri, 20 Nov 2020 11:46:37 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, luto@kernel.org,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 10/12] x86/paravirt: add new macros PVOP_ALT* supporting pvops in ALTERNATIVEs
Date:   Fri, 20 Nov 2020 12:46:28 +0100
Message-Id: <20201120114630.13552-11-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201120114630.13552-1-jgross@suse.com>
References: <20201120114630.13552-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using paravirt patching for custom code sequences add
support for using ALTERNATIVE handling combined with paravirt call
patching.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt_types.h | 62 +++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index b66650dc869e..1f8e1b76e78b 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -482,14 +482,39 @@ int paravirt_disable_iospace(void);
 		(rettype)(__eax & PVOP_RETMASK(rettype));		\
 	})
 
+#define ____PVOP_ALT_CALL(rettype, op, alt, cond, clbr, call_clbr,	\
+			  extra_clbr, ...)				\
+	({								\
+		PVOP_CALL_ARGS;						\
+		PVOP_TEST_NULL(op);					\
+		BUILD_BUG_ON(sizeof(rettype) > sizeof(unsigned long));	\
+		asm volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CALL),	\
+					 alt, cond)			\
+			     : call_clbr, ASM_CALL_CONSTRAINT		\
+			     : paravirt_type(op),			\
+			       paravirt_clobber(clbr),			\
+			       ##__VA_ARGS__				\
+			     : "memory", "cc" extra_clbr);		\
+		(rettype)(__eax & PVOP_RETMASK(rettype));		\
+	})
+
 #define __PVOP_CALL(rettype, op, ...)					\
 	____PVOP_CALL(rettype, op, CLBR_ANY, PVOP_CALL_CLOBBERS,	\
 		      EXTRA_CLOBBERS, ##__VA_ARGS__)
 
+#define __PVOP_ALT_CALL(rettype, op, alt, cond, ...)			\
+	____PVOP_ALT_CALL(rettype, op, alt, cond, CLBR_ANY,		\
+			  PVOP_CALL_CLOBBERS, EXTRA_CLOBBERS,		\
+			  ##__VA_ARGS__)
+
 #define __PVOP_CALLEESAVE(rettype, op, ...)				\
 	____PVOP_CALL(rettype, op.func, CLBR_RET_REG,			\
 		      PVOP_CALLEE_CLOBBERS, , ##__VA_ARGS__)
 
+#define __PVOP_ALT_CALLEESAVE(rettype, op, alt, cond, ...)		\
+	____PVOP_ALT_CALL(rettype, op.func, alt, cond, CLBR_RET_REG,	\
+			  PVOP_CALLEE_CLOBBERS, , ##__VA_ARGS__)
+
 
 #define ____PVOP_VCALL(op, clbr, call_clbr, extra_clbr, ...)		\
 	({								\
@@ -503,36 +528,73 @@ int paravirt_disable_iospace(void);
 			     : "memory", "cc" extra_clbr);		\
 	})
 
+#define ____PVOP_ALT_VCALL(op, alt, cond, clbr, call_clbr,		\
+			   extra_clbr, ...)				\
+	({								\
+		PVOP_VCALL_ARGS;					\
+		PVOP_TEST_NULL(op);					\
+		asm volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CALL),	\
+					 alt, cond)			\
+			     : call_clbr, ASM_CALL_CONSTRAINT		\
+			     : paravirt_type(op),			\
+			       paravirt_clobber(clbr),			\
+			       ##__VA_ARGS__				\
+			     : "memory", "cc" extra_clbr);		\
+	})
+
 #define __PVOP_VCALL(op, ...)						\
 	____PVOP_VCALL(op, CLBR_ANY, PVOP_VCALL_CLOBBERS,		\
 		       VEXTRA_CLOBBERS, ##__VA_ARGS__)
 
+#define __PVOP_ALT_VCALL(op, alt, cond, ...)				\
+	____PVOP_ALT_VCALL(op, alt, cond, CLBR_ANY,			\
+			   PVOP_VCALL_CLOBBERS, VEXTRA_CLOBBERS,	\
+			   ##__VA_ARGS__)
+
 #define __PVOP_VCALLEESAVE(op, ...)					\
 	____PVOP_VCALL(op.func, CLBR_RET_REG,				\
 		      PVOP_VCALLEE_CLOBBERS, , ##__VA_ARGS__)
 
+#define __PVOP_ALT_VCALLEESAVE(op, alt, cond, ...)			\
+	____PVOP_ALT_VCALL(op.func, alt, cond, CLBR_RET_REG,		\
+			   PVOP_VCALLEE_CLOBBERS, , ##__VA_ARGS__)
+
 
 
 #define PVOP_CALL0(rettype, op)						\
 	__PVOP_CALL(rettype, op)
 #define PVOP_VCALL0(op)							\
 	__PVOP_VCALL(op)
+#define PVOP_ALT_CALL0(rettype, op, alt, cond)				\
+	__PVOP_ALT_CALL(rettype, op, alt, cond)
+#define PVOP_ALT_VCALL0(op, alt, cond)					\
+	__PVOP_ALT_VCALL(op, alt, cond)
 
 #define PVOP_CALLEE0(rettype, op)					\
 	__PVOP_CALLEESAVE(rettype, op)
 #define PVOP_VCALLEE0(op)						\
 	__PVOP_VCALLEESAVE(op)
+#define PVOP_ALT_CALLEE0(rettype, op, alt, cond)			\
+	__PVOP_ALT_CALLEESAVE(rettype, op, alt, cond)
+#define PVOP_ALT_VCALLEE0(op, alt, cond)				\
+	__PVOP_ALT_VCALLEESAVE(op, alt, cond)
 
 
 #define PVOP_CALL1(rettype, op, arg1)					\
 	__PVOP_CALL(rettype, op, PVOP_CALL_ARG1(arg1))
 #define PVOP_VCALL1(op, arg1)						\
 	__PVOP_VCALL(op, PVOP_CALL_ARG1(arg1))
+#define PVOP_ALT_VCALL1(op, arg1, alt, cond)				\
+	__PVOP_ALT_VCALL(op, alt, cond, PVOP_CALL_ARG1(arg1))
 
 #define PVOP_CALLEE1(rettype, op, arg1)					\
 	__PVOP_CALLEESAVE(rettype, op, PVOP_CALL_ARG1(arg1))
 #define PVOP_VCALLEE1(op, arg1)						\
 	__PVOP_VCALLEESAVE(op, PVOP_CALL_ARG1(arg1))
+#define PVOP_ALT_CALLEE1(rettype, op, arg1, alt, cond)			\
+	__PVOP_ALT_CALLEESAVE(rettype, op, alt, cond, PVOP_CALL_ARG1(arg1))
+#define PVOP_ALT_VCALLEE1(op, arg1, alt, cond)				\
+	__PVOP_ALT_VCALLEESAVE(op, alt, cond, PVOP_CALL_ARG1(arg1))
 
 
 #define PVOP_CALL2(rettype, op, arg1, arg2)				\
-- 
2.26.2

