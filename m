Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0934293B17
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394335AbgJTMTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394309AbgJTMTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:19:10 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3CEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 05:19:10 -0700 (PDT)
Received: from cap.home.8bytes.org (p549add56.dip0.t-ipconnect.de [84.154.221.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 919502AA;
        Tue, 20 Oct 2020 14:19:07 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Martin Radev <martin.b.radev@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] x86/sev-es: Do not support MMIO to/from encrypted memory
Date:   Tue, 20 Oct 2020 14:18:56 +0200
Message-Id: <20201020121856.19427-6-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020121856.19427-1-joro@8bytes.org>
References: <20201020121856.19427-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

MMIO memory is usually not mapped encrypted, so there is no reason to
support emulated MMIO when it is mapped encrypted.

This prevents a possible hypervisor attack where it maps a RAM page as
an MMIO page in the nested page-table, so that any guest access to it
will trigger a #VC exception and leak the data on that page to the
hypervisor or allows the hypervisor to inject data into the guest.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev-es.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 4a96726fbaf8..421fe0203c68 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -374,8 +374,8 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 	return ES_EXCEPTION;
 }
 
-static bool vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
-				 unsigned long vaddr, phys_addr_t *paddr)
+static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+					   unsigned long vaddr, phys_addr_t *paddr)
 {
 	unsigned long va = (unsigned long)vaddr;
 	unsigned int level;
@@ -394,15 +394,19 @@ static bool vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 		if (user_mode(ctxt->regs))
 			ctxt->fi.error_code |= X86_PF_USER;
 
-		return false;
+		return ES_EXCEPTION;
 	}
 
+	if (unlikely(WARN_ON_ONCE(pte_val(*pte) & _PAGE_ENC)))
+		/* Emulated MMIO to/from encrypted memory not supported */
+		return ES_UNSUPPORTED;
+
 	pa = (phys_addr_t)pte_pfn(*pte) << PAGE_SHIFT;
 	pa |= va & ~page_level_mask(level);
 
 	*paddr = pa;
 
-	return true;
+	return ES_OK;
 }
 
 /* Include code shared with pre-decompression boot stage */
@@ -731,6 +735,7 @@ static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 {
 	u64 exit_code, exit_info_1, exit_info_2;
 	unsigned long ghcb_pa = __pa(ghcb);
+	enum es_result res;
 	phys_addr_t paddr;
 	void __user *ref;
 
@@ -740,11 +745,12 @@ static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 
 	exit_code = read ? SVM_VMGEXIT_MMIO_READ : SVM_VMGEXIT_MMIO_WRITE;
 
-	if (!vc_slow_virt_to_phys(ghcb, ctxt, (unsigned long)ref, &paddr)) {
-		if (!read)
+	res = vc_slow_virt_to_phys(ghcb, ctxt, (unsigned long)ref, &paddr);
+	if (res != ES_OK) {
+		if (res == ES_EXCEPTION && !read)
 			ctxt->fi.error_code |= X86_PF_WRITE;
 
-		return ES_EXCEPTION;
+		return res;
 	}
 
 	exit_info_1 = paddr;
-- 
2.28.0

