Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DB3293ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405644AbgJTMCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405557AbgJTMCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:02:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91612C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 05:02:47 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1066009754437955fe5703.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:6600:9754:4379:55fe:5703])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D20A11EC034B;
        Tue, 20 Oct 2020 14:02:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603195366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=EN1K2xTcCEsu5UOj0t7CcVCdieqE6R8Sg+1r++34Sfk=;
        b=UBa6l9TohDqbHjy5RA/GFmjkv//agjoDhzBO9OvUIyaQws2KMdpNdCT/U6mgDotRnAQLWJ
        TdW8kF8EX2EQvisGayxMZFjlVeUfgWwg99GM2Mm5bw+N4W/nmLBbIWvNwf+dXG7/j2m9P+
        yz4oi6bBBj2Z71XFiRo97UbL9U/3eKk=
Date:   Tue, 20 Oct 2020 14:02:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     x86-ml <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Joerg Roedel <jroedel@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: [RFC] Have insn decoder functions return success/failure
Message-ID: <20201020120232.GD11583@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

this has come up a couple of times in the past, how about if those insn
decoder functions returned an error value so that callers can use that
instead of looking at different insn...got fields whether a certain
subset of the insn got decoded properly or not?

Here's a dirty diff to show what I mean. Thoughts?

Thx.

---
diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index 954cb2702e23..53e8ced662ff 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -79,16 +79,14 @@ static inline void sev_es_wr_ghcb_msr(u64 val)
 static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 {
 	char buffer[MAX_INSN_SIZE];
-	enum es_result ret;
 
 	memcpy(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
 
 	insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE, 1);
-	insn_get_length(&ctxt->insn);
+	if (insn_get_length(&ctxt->insn))
+		return ES_DECODE_FAILED;
 
-	ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
-
-	return ret;
+	return ES_OK;
 }
 
 static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 404315df1e16..aa72e8d305dd 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1262,14 +1262,14 @@ static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
 		is_64bit = kernel_ip(to) || !test_thread_flag(TIF_IA32);
 #endif
 		insn_init(&insn, kaddr, size, is_64bit);
-		insn_get_length(&insn);
+
 		/*
 		 * Make sure there was not a problem decoding the
 		 * instruction and getting the length.  This is
 		 * doubly important because we have an infinite
 		 * loop if insn.length=0.
 		 */
-		if (!insn.length)
+		if (insn_get_length(&insn) || !insn.length)
 			break;
 
 		to += insn.length;
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 8961653c5dd2..4ef88831f9b7 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1262,8 +1262,7 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 		ret = X86_BR_INT;
 		break;
 	case 0xe8: /* call near rel */
-		insn_get_immediate(&insn);
-		if (insn.immediate1.value == 0) {
+		if (insn_get_immediate(&insn) || !insn.immediate1.value) {
 			/* zero length call */
 			ret = X86_BR_ZERO_CALL;
 			break;
diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 5c1ae3eff9d4..0c79dad82b89 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -92,8 +92,8 @@ extern void insn_get_opcode(struct insn *insn);
 extern void insn_get_modrm(struct insn *insn);
 extern void insn_get_sib(struct insn *insn);
 extern void insn_get_displacement(struct insn *insn);
-extern void insn_get_immediate(struct insn *insn);
-extern void insn_get_length(struct insn *insn);
+extern int insn_get_immediate(struct insn *insn);
+extern int insn_get_length(struct insn *insn);
 
 /* Attribute will be determined after getting ModRM (for opcode groups) */
 static inline void insn_get_attribute(struct insn *insn)
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 547c7abb39f5..9f1010b30cd0 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -296,8 +296,10 @@ static int can_probe(unsigned long paddr)
 		__addr = recover_probed_instruction(buf, addr);
 		if (!__addr)
 			return 0;
+
 		kernel_insn_init(&insn, (void *)__addr, MAX_INSN_SIZE);
-		insn_get_length(&insn);
+		if (insn_get_length(&insn))
+			return 0;
 
 		/*
 		 * Another debugging subsystem might insert this breakpoint.
@@ -352,7 +354,8 @@ int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 		return 0;
 
 	kernel_insn_init(insn, dest, MAX_INSN_SIZE);
-	insn_get_length(insn);
+	if (insn_get_length(insn))
+		return 0;
 
 	/* We can not probe force emulate prefixed instruction */
 	if (insn_has_emulate_prefix(insn))
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 041f0b50bc27..afe2148c964c 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -309,7 +309,9 @@ static int can_optimize(unsigned long paddr)
 		if (!recovered_insn)
 			return 0;
 		kernel_insn_init(&insn, (void *)recovered_insn, MAX_INSN_SIZE);
-		insn_get_length(&insn);
+		if (insn_get_length(&insn))
+			return 0;
+
 		/* Another subsystem puts a breakpoint */
 		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)
 			return 0;
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 4a96726fbaf8..73c3a4998bc2 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -268,12 +268,13 @@ static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 		}
 
 		insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE - res, 1);
-		insn_get_length(&ctxt->insn);
+		res = insn_get_length(&ctxt->insn);
 	}
 
-	ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
+	if (res)
+		return ES_DECODE_FAILED;
 
-	return ret;
+	return ES_OK;
 }
 
 static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 58f7fb95c7f4..f754470c884d 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1491,7 +1491,9 @@ bool insn_decode(struct insn *insn, struct pt_regs *regs,
 	insn->addr_bytes = INSN_CODE_SEG_ADDR_SZ(seg_defs);
 	insn->opnd_bytes = INSN_CODE_SEG_OPND_SZ(seg_defs);
 
-	insn_get_length(insn);
+	if (insn_get_length(insn))
+		return false;
+
 	if (buf_size < insn->length)
 		return false;
 
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 404279563891..875cd5296c50 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -538,18 +538,23 @@ static int __get_immptr(struct insn *insn)
 }
 
 /**
- * insn_get_immediate() - Get the immediates of instruction
+ * insn_get_immediate() - Get the immediate in an instruction
  * @insn:	&struct insn containing instruction
  *
  * If necessary, first collects the instruction up to and including the
  * displacement bytes.
  * Basically, most of immediates are sign-expanded. Unsigned-value can be
- * get by bit masking with ((1 << (nbytes * 8)) - 1)
+ * computed by bit masking with ((1 << (nbytes * 8)) - 1)
+ *
+ * Returns:
+ *  - 0 on success
+ *  - !0 on error
  */
-void insn_get_immediate(struct insn *insn)
+int insn_get_immediate(struct insn *insn)
 {
 	if (insn->immediate.got)
-		return;
+		return 0;
+
 	if (!insn->displacement.got)
 		insn_get_displacement(insn);
 
@@ -604,9 +609,10 @@ void insn_get_immediate(struct insn *insn)
 	}
 done:
 	insn->immediate.got = 1;
+	return 0;
 
 err_out:
-	return;
+	return 1;
 }
 
 /**
@@ -615,13 +621,22 @@ void insn_get_immediate(struct insn *insn)
  *
  * If necessary, first collects the instruction up to and including the
  * immediates bytes.
- */
-void insn_get_length(struct insn *insn)
+ *
+ * Returns:
+ *  - 0 on success
+ *  - !0 on error
+*/
+int insn_get_length(struct insn *insn)
 {
 	if (insn->length)
-		return;
+		return 0;
+
 	if (!insn->immediate.got)
-		insn_get_immediate(insn);
+		if (insn_get_immediate(insn))
+			return 1;
+
 	insn->length = (unsigned char)((unsigned long)insn->next_byte
 				     - (unsigned long)insn->kaddr);
+
+	return 0;
 }
diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
index 34eda63c124b..5cb0d7b3ebf4 100644
--- a/arch/x86/tools/insn_decoder_test.c
+++ b/arch/x86/tools/insn_decoder_test.c
@@ -150,8 +150,7 @@ int main(int argc, char **argv)
 		}
 		/* Decode an instruction */
 		insn_init(&insn, insn_buff, sizeof(insn_buff), x86_64);
-		insn_get_length(&insn);
-		if (insn.length != nb) {
+		if (insn_get_length(&insn) || insn.length != nb) {
 			warnings++;
 			pr_warn("Found an x86 instruction decoder bug, "
 				"please report this.\n", sym);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
