Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0172DCE7A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 10:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgLQJde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 04:33:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:43684 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727571AbgLQJdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 04:33:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608197510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ceiDV3ATRY9YnL7SgQrnOIjlDPrG0xckHD/uLnaouJY=;
        b=fkabVt/gQVsQgi+sTbuhe2pPxdQ4U/Mx68jn/Ds9nwTAstwwF2nFVqItyVleqvdwWiVUm2
        LBkYA+3Iwt7AJHNa8uB5tG4CsJSePTrAh1FtlF3w4fgpGNUXmSINUyYY5gD969qbJTGzCV
        xEtn7DCMf0bMmVFBnIN3kPgmGmUiWPk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D72D1B721;
        Thu, 17 Dec 2020 09:31:49 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 13/15] x86/paravirt: add new macros PVOP_ALT* supporting pvops in ALTERNATIVEs
Date:   Thu, 17 Dec 2020 10:31:31 +0100
Message-Id: <20201217093133.1507-14-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201217093133.1507-1-jgross@suse.com>
References: <20201217093133.1507-1-jgross@suse.com>
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
V3:
- drop ____PVOP_ALT_VCALL() macro
---
 arch/x86/include/asm/paravirt_types.h | 49 +++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 5d6de014d2f6..7e0130781b12 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -477,44 +477,93 @@ int paravirt_disable_iospace(void);
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
+
 #define __PVOP_VCALL(op, ...)						\
 	(void)____PVOP_CALL(long, op, CLBR_ANY, PVOP_VCALL_CLOBBERS,	\
 		       VEXTRA_CLOBBERS, ##__VA_ARGS__)
 
+#define __PVOP_ALT_VCALL(op, alt, cond, ...)				\
+	(void)____PVOP_ALT_CALL(long, op, alt, cond, CLBR_ANY,		\
+			   PVOP_VCALL_CLOBBERS, VEXTRA_CLOBBERS,	\
+			   ##__VA_ARGS__)
+
 #define __PVOP_VCALLEESAVE(op, ...)					\
 	(void)____PVOP_CALL(long, op.func, CLBR_RET_REG,		\
 		      PVOP_VCALLEE_CLOBBERS, , ##__VA_ARGS__)
 
+#define __PVOP_ALT_VCALLEESAVE(op, alt, cond, ...)			\
+	(void)____PVOP_ALT_CALL(long, op.func, alt, cond, CLBR_RET_REG,	\
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

