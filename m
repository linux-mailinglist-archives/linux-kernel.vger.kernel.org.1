Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E40C2E2B80
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 13:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgLYMeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 07:34:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43758 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgLYMeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 07:34:23 -0500
Received: from zn.tnic (p200300ec2f0e8e00cc073e8cb60495d6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:8e00:cc07:3e8c:b604:95d6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17B771EC0281;
        Fri, 25 Dec 2020 13:33:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608899621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kt3O8fCSxoh8e8LkX86l4Sz4giqKMVue7oZdRRyeuQs=;
        b=dc69mcyAoLcK4amagAMlrTWuxO6WacLyxrxaB70rc1vmlZb87l/uWUWUN2f7Ge/8rUU3xl
        NDPjGiqztIOyYocAFCE659QeAcJJcqam3inupkRVLIEK2YTtMhq3RQR7i1QvHRrliIQTDM
        MpVTRs6y4auVwWbZgE6CexxWXDcWYN0=
Date:   Fri, 25 Dec 2020 13:33:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 11/19] x86/sev-es: Convert to insn_decode()
Message-ID: <20201225123334.GA5874@zn.tnic>
References: <20201223174233.28638-12-bp@alien8.de>
 <202012251838.G6eufP3Q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202012251838.G6eufP3Q-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25, 2020 at 06:50:33PM +0800, kernel test robot wrote:
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/x86/kernel/sev-es.c:258:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>                    if (!insn_decode_regs(&ctxt->insn, ctxt->regs, buffer, res))
>                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Yeah, good catch, thanks for reporting.

Frankly, the readability and "extensiblity" of that function can be
improved by splitting the two cases (diff ontop):

---
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 564cc9fc693d..ea47037f1624 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -241,40 +241,53 @@ static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
 	return copy_from_kernel_nofault(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
 }
 
-static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
+static enum es_result __vc_decode_user_insn(struct es_em_ctxt *ctxt)
 {
 	char buffer[MAX_INSN_SIZE];
-	int res, ret;
-
-	if (user_mode(ctxt->regs)) {
-		res = insn_fetch_from_user(ctxt->regs, buffer);
-		if (!res) {
-			ctxt->fi.vector     = X86_TRAP_PF;
-			ctxt->fi.error_code = X86_PF_INSTR | X86_PF_USER;
-			ctxt->fi.cr2        = ctxt->regs->ip;
-			return ES_EXCEPTION;
-		}
+	int res;
 
-		if (!insn_decode_regs(&ctxt->insn, ctxt->regs, buffer, res))
-			return ES_DECODE_FAILED;
-	} else {
-		res = vc_fetch_insn_kernel(ctxt, buffer);
-		if (res) {
-			ctxt->fi.vector     = X86_TRAP_PF;
-			ctxt->fi.error_code = X86_PF_INSTR;
-			ctxt->fi.cr2        = ctxt->regs->ip;
-			return ES_EXCEPTION;
-		}
+	res = insn_fetch_from_user(ctxt->regs, buffer);
+	if (!res) {
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.error_code = X86_PF_INSTR | X86_PF_USER;
+		ctxt->fi.cr2        = ctxt->regs->ip;
+		return ES_EXCEPTION;
+	}
+
+	if (!insn_decode_regs(&ctxt->insn, ctxt->regs, buffer, res))
+		return ES_DECODE_FAILED;
+	else
+		return ES_OK;
+}
+
+static enum es_result __vc_decode_kern_insn(struct es_em_ctxt *ctxt)
+{
+	char buffer[MAX_INSN_SIZE];
+	int res;
 
-		ret = insn_decode(&ctxt->insn, buffer, MAX_INSN_SIZE - res, INSN_MODE_64);
+	res = vc_fetch_insn_kernel(ctxt, buffer);
+	if (res) {
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.error_code = X86_PF_INSTR;
+		ctxt->fi.cr2        = ctxt->regs->ip;
+		return ES_EXCEPTION;
 	}
 
-	if (ret < 0)
+	res = insn_decode(&ctxt->insn, buffer, MAX_INSN_SIZE - res, INSN_MODE_64);
+	if (res < 0)
 		return ES_DECODE_FAILED;
 	else
 		return ES_OK;
 }
 
+static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
+{
+	if (user_mode(ctxt->regs))
+		return __vc_decode_user_insn(ctxt);
+	else
+		return __vc_decode_kern_insn(ctxt);
+}
+
 static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
 				   char *dst, char *buf, size_t size)
 {

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
