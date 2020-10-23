Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADCC2979AA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 01:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758721AbgJWX1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 19:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754873AbgJWX1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 19:27:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA38C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 16:27:54 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f83009fb120187eef5b1b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:8300:9fb1:2018:7eef:5b1b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 63D661EC0532;
        Sat, 24 Oct 2020 01:27:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603495671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6MXz16bydkDkUmAuAr1z9JL3nMto19D+xja3GOSFDLk=;
        b=SpgpSyvGnr6R7Zl08kHu9mU7UfVZbdtqeI1/lI6FETxkCqbxA4cbvAV7ev4APh0QDHCj1O
        4ln9F95YXqpDsd6JRfLaPUYEQzQNQTxCJUD+87DC58N5hOytbILekIc2Tno8ojDtdRwSoD
        d3Hys2xir54+C0Hjby6hZdExp6Lyvtg=
Date:   Sat, 24 Oct 2020 01:27:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     x86-ml <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-ID: <20201023232741.GF23324@zn.tnic>
References: <20201021092750.GA4050@zn.tnic>
 <20201021232613.e40c1daef4b567e0e29044a4@kernel.org>
 <20201021164558.GB4050@zn.tnic>
 <20201022163100.1139b28220da4eafb5e70fcc@kernel.org>
 <20201022093044.GA29222@zn.tnic>
 <20201022222140.f46e6db1243e05fdd049b504@kernel.org>
 <CALCETrWhzzZ=EAoKZ4=k3FjffvS_3R4o5N1Rkj9FkHQdiUag6A@mail.gmail.com>
 <20201023182850.c54ac863159fb312c411c029@kernel.org>
 <20201023093254.GC23324@zn.tnic>
 <20201023194704.f723c86e5f8dfc1133dd5930@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201023194704.f723c86e5f8dfc1133dd5930@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 07:47:04PM +0900, Masami Hiramatsu wrote:
> Thanks! I look forward to it.

Ok, here's a first stab, it is a single big diff and totally untested
but it should show what I mean. I've made some notes while converting,
as I went along.

Have a look at insn_decode() and its call sites: they are almost trivial
now because caller needs simply to do:

	if (insn_decode(insn, buffer, ...))

and not care about any helper functions.

For some of the call sites it still makes sense to do a piecemeal insn
decoding and I've left them this way but they can be converted too, if
one wants.

In any case, just have a look please and lemme know if that looks OKish.
I'll do the actual splitting and testing afterwards.

And what Andy wants can't be done with the decoder because it already
gets a fixed size buffer and length - it doesn't do the fetching. The
caller does.

What you wanna do:

> len = min(15, remaining bytes in page);
> fetch len bytes;
> insn_init();
> ret = insn_decode_fully();

<--- you can't always know here whether the insn is valid if you don't
have all the bytes. But you can always fetch *all* bytes and then give
it to the decoder for checking.

Also, this doesn't make any sense: try insn decode on a subset of bytes
and then if it fails, try it on the whole set of bytes. Why even try the
subset - it will almost always fail.

> if (ret == -EAGAIN) {
>   fetch remaining 15 - len bytes;
>   insn_init();
>   ret = insn_decode_fully();

Ok, good night and good luck. :-)

Author: Borislav Petkov <bp@suse.de>
Date:   Fri Oct 23 12:15:59 2020 +0200

    insn: Reorg
    
    - Rename insn_decode() to insn_decode_regs() to denote that it receives
      regs as param and free the name for the generic version.
    
    - intel/ds.c needs only the insn length so it uses the appropriate
      helper instead of a full decode.
    
    - make insn_get_opcode() return an errval, make it more stricter as
      to whether what has seen so far is a valid insn and if not, signal an
      error.
    
    - lbr.c doesn't need to call the full insn_decode() because it doesn't
      need it in all cases thus the separate calls.
    
    - Add enum insn_mode to insn_decode() to call kernel_insn_init() too.
    

diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index 954cb2702e23..8d95f859e439 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -79,16 +79,13 @@ static inline void sev_es_wr_ghcb_msr(u64 val)
 static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 {
 	char buffer[MAX_INSN_SIZE];
-	enum es_result ret;
 
 	memcpy(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
 
-	insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE, 1);
-	insn_get_length(&ctxt->insn);
+	if (insn_decode(&ctxt->insn, buffer, MAX_INSN_SIZE, INSN_MODE_64))
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
index 8961653c5dd2..d23f7d3108a8 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1224,8 +1224,7 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 	is64 = kernel_ip((unsigned long)addr) || !test_thread_flag(TIF_IA32);
 #endif
 	insn_init(&insn, addr, bytes_read, is64);
-	insn_get_opcode(&insn);
-	if (!insn.opcode.got)
+	if (insn_get_opcode(&insn))
 		return X86_BR_ABORT;
 
 	switch (insn.opcode.bytes[0]) {
@@ -1262,8 +1261,7 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 		ret = X86_BR_INT;
 		break;
 	case 0xe8: /* call near rel */
-		insn_get_immediate(&insn);
-		if (insn.immediate1.value == 0) {
+		if (insn_get_immediate(&insn) || insn.immediate1.value == 0) {
 			/* zero length call */
 			ret = X86_BR_ZERO_CALL;
 			break;
@@ -1279,7 +1277,9 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 		ret = X86_BR_JMP;
 		break;
 	case 0xff: /* call near absolute, call far absolute ind */
-		insn_get_modrm(&insn);
+		if (insn_get_modrm(&insn))
+			return X86_BR_ABORT;
+
 		ext = (insn.modrm.bytes[0] >> 3) & 0x7;
 		switch (ext) {
 		case 2: /* near ind call */
diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index a0f839aa144d..3797497a9270 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -23,7 +23,7 @@ unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx);
 int insn_get_code_seg_params(struct pt_regs *regs);
 int insn_fetch_from_user(struct pt_regs *regs,
 			 unsigned char buf[MAX_INSN_SIZE]);
-bool insn_decode(struct insn *insn, struct pt_regs *regs,
-		 unsigned char buf[MAX_INSN_SIZE], int buf_size);
+bool insn_decode_regs(struct insn *insn, struct pt_regs *regs,
+		      unsigned char buf[MAX_INSN_SIZE], int buf_size);
 
 #endif /* _ASM_X86_INSN_EVAL_H */
diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 5c1ae3eff9d4..94c1ef548883 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -88,12 +88,21 @@ struct insn {
 
 extern void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64);
 extern void insn_get_prefixes(struct insn *insn);
-extern void insn_get_opcode(struct insn *insn);
-extern void insn_get_modrm(struct insn *insn);
-extern void insn_get_sib(struct insn *insn);
-extern void insn_get_displacement(struct insn *insn);
-extern void insn_get_immediate(struct insn *insn);
-extern void insn_get_length(struct insn *insn);
+extern int insn_get_opcode(struct insn *insn);
+extern int insn_get_modrm(struct insn *insn);
+extern int insn_get_sib(struct insn *insn);
+extern int insn_get_displacement(struct insn *insn);
+extern int insn_get_immediate(struct insn *insn);
+extern int insn_get_length(struct insn *insn);
+
+enum insn_mode {
+	INSN_MODE_32,
+	INSN_MODE_64,
+	INSN_MODE_KERN,	/* determined by the current kernel build */
+	INSN_NUM_MODES,
+};
+
+extern int insn_decode(struct insn *insn, const void *kaddr, int buf_len, enum insn_mode m);
 
 /* Attribute will be determined after getting ModRM (for opcode groups) */
 static inline void insn_get_attribute(struct insn *insn)
@@ -108,11 +117,7 @@ extern int insn_rip_relative(struct insn *insn);
 static inline void kernel_insn_init(struct insn *insn,
 				    const void *kaddr, int buf_len)
 {
-#ifdef CONFIG_X86_64
-	insn_init(insn, kaddr, buf_len, 1);
-#else /* CONFIG_X86_32 */
-	insn_init(insn, kaddr, buf_len, 0);
-#endif
+	insn_init(insn, kaddr, buf_len, IS_ENABLED(CONFIG_X86_64));
 }
 
 static inline int insn_is_avx(struct insn *insn)
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 83df991314c5..30ba7c9ae27c 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -224,9 +224,7 @@ static bool is_copy_from_user(struct pt_regs *regs)
 	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
 		return false;
 
-	kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
-	insn_get_opcode(&insn);
-	if (!insn.opcode.got)
+	if (insn_decode(&insn, insn_buf, MAX_INSN_SIZE, INSN_MODE_KERN))
 		return false;
 
 	switch (insn.opcode.value) {
@@ -234,10 +232,6 @@ static bool is_copy_from_user(struct pt_regs *regs)
 	case 0x8A: case 0x8B:
 	/* MOVZ mem,reg */
 	case 0xB60F: case 0xB70F:
-		insn_get_modrm(&insn);
-		insn_get_sib(&insn);
-		if (!insn.modrm.got || !insn.sib.got)
-			return false;
 		addr = (unsigned long)insn_get_addr_ref(&insn, regs);
 		break;
 	/* REP MOVS */
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
index 4a96726fbaf8..2f87cd52f12c 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -244,8 +244,7 @@ static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
 static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 {
 	char buffer[MAX_INSN_SIZE];
-	enum es_result ret;
-	int res;
+	int res, ret;
 
 	if (user_mode(ctxt->regs)) {
 		res = insn_fetch_from_user(ctxt->regs, buffer);
@@ -256,7 +255,7 @@ static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 			return ES_EXCEPTION;
 		}
 
-		if (!insn_decode(&ctxt->insn, ctxt->regs, buffer, res))
+		if (!insn_decode_regs(&ctxt->insn, ctxt->regs, buffer, res))
 			return ES_DECODE_FAILED;
 	} else {
 		res = vc_fetch_insn_kernel(ctxt, buffer);
@@ -267,13 +266,13 @@ static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 			return ES_EXCEPTION;
 		}
 
-		insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE - res, 1);
-		insn_get_length(&ctxt->insn);
+		ret = insn_decode(&ctxt->insn, buffer, MAX_INSN_SIZE - res, INSN_MODE_64);
 	}
 
-	ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
-
-	return ret;
+	if (ret)
+		return ES_DECODE_FAILED;
+	else
+		return ES_OK;
 }
 
 static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 3c70fb34028b..40211eb584a7 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -498,9 +498,8 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 			MAX_INSN_SIZE))
 		return GP_NO_HINT;
 
-	kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
-	insn_get_modrm(&insn);
-	insn_get_sib(&insn);
+	if (insn_decode(&insn, insn_buf, MAX_INSN_SIZE, INSN_MODE_KERN))
+		return GP_NO_HINT;
 
 	*addr = (unsigned long)insn_get_addr_ref(&insn, regs);
 	if (*addr == -1UL)
diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index f6225bf22c02..e3584894b074 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -356,7 +356,7 @@ bool fixup_umip_exception(struct pt_regs *regs)
 	if (!nr_copied)
 		return false;
 
-	if (!insn_decode(&insn, regs, buf, nr_copied))
+	if (!insn_decode_regs(&insn, regs, buf, nr_copied))
 		return false;
 
 	umip_inst = identify_insn(&insn);
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 3fdaa042823d..b1451242c097 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -275,12 +275,10 @@ static bool is_prefix_bad(struct insn *insn)
 
 static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool x86_64)
 {
+	enum insn_mode m = x86_64 ? INSN_MODE_64 : INSN_MODE_32;
 	u32 volatile *good_insns;
 
-	insn_init(insn, auprobe->insn, sizeof(auprobe->insn), x86_64);
-	/* has the side-effect of processing the entire instruction */
-	insn_get_length(insn);
-	if (!insn_complete(insn))
+	if (insn_decode(insn, auprobe->insn, sizeof(auprobe->insn), m))
 		return -ENOEXEC;
 
 	if (is_prefix_bad(insn))
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 58f7fb95c7f4..5825b4cf4386 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1117,7 +1117,8 @@ static int get_eff_addr_sib(struct insn *insn, struct pt_regs *regs,
 	if (insn->addr_bytes != 8 && insn->addr_bytes != 4)
 		return -EINVAL;
 
-	insn_get_modrm(insn);
+	if (insn_get_modrm(insn))
+		return -EINVAL;
 
 	if (!insn->modrm.nbytes)
 		return -EINVAL;
@@ -1125,7 +1126,8 @@ static int get_eff_addr_sib(struct insn *insn, struct pt_regs *regs,
 	if (X86_MODRM_MOD(insn->modrm.value) > 2)
 		return -EINVAL;
 
-	insn_get_sib(insn);
+	if (insn_get_sib(insn))
+		return -EINVAL;
 
 	if (!insn->sib.nbytes)
 		return -EINVAL;
@@ -1194,8 +1196,8 @@ static void __user *get_addr_ref_16(struct insn *insn, struct pt_regs *regs)
 	short eff_addr;
 	long tmp;
 
-	insn_get_modrm(insn);
-	insn_get_displacement(insn);
+	if (insn_get_modrm(insn) || insn_get_displacement(insn))
+		goto out;
 
 	if (insn->addr_bytes != 2)
 		goto out;
@@ -1454,7 +1456,7 @@ int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
 }
 
 /**
- * insn_decode() - Decode an instruction
+ * insn_decode_regs() - Decode an instruction
  * @insn:	Structure to store decoded instruction
  * @regs:	Structure with register values as seen when entering kernel mode
  * @buf:	Buffer containing the instruction bytes
@@ -1467,8 +1469,8 @@ int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
  *
  * True if instruction was decoded, False otherwise.
  */
-bool insn_decode(struct insn *insn, struct pt_regs *regs,
-		 unsigned char buf[MAX_INSN_SIZE], int buf_size)
+bool insn_decode_regs(struct insn *insn, struct pt_regs *regs,
+		      unsigned char buf[MAX_INSN_SIZE], int buf_size)
 {
 	int seg_defs;
 
@@ -1491,7 +1493,9 @@ bool insn_decode(struct insn *insn, struct pt_regs *regs,
 	insn->addr_bytes = INSN_CODE_SEG_ADDR_SZ(seg_defs);
 	insn->opnd_bytes = INSN_CODE_SEG_OPND_SZ(seg_defs);
 
-	insn_get_length(insn);
+	if (insn_get_length(insn))
+		return false;
+
 	if (buf_size < insn->length)
 		return false;
 
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 404279563891..6031b774a9cb 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -37,6 +37,7 @@
  * insn_init() - initialize struct insn
  * @insn:	&struct insn to be initialized
  * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
+ * @buf_len:	length of the insn buffer at @kaddr
  * @x86_64:	!0 for 64-bit kernel or 64-bit app
  */
 void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
@@ -230,14 +231,20 @@ void insn_get_prefixes(struct insn *insn)
  * If necessary, first collects any preceding (prefix) bytes.
  * Sets @insn->opcode.value = opcode1.  No effect if @insn->opcode.got
  * is already 1.
+ *
+ * Returns:
+ * 0:  on success
+ * !0: on error
  */
-void insn_get_opcode(struct insn *insn)
+int insn_get_opcode(struct insn *insn)
 {
 	struct insn_field *opcode = &insn->opcode;
 	insn_byte_t op;
 	int pfx_id;
+
 	if (opcode->got)
-		return;
+		return 0;
+
 	if (!insn->prefixes.got)
 		insn_get_prefixes(insn);
 
@@ -254,9 +261,13 @@ void insn_get_opcode(struct insn *insn)
 		insn->attr = inat_get_avx_attribute(op, m, p);
 		if ((inat_must_evex(insn->attr) && !insn_is_evex(insn)) ||
 		    (!inat_accept_vex(insn->attr) &&
-		     !inat_is_group(insn->attr)))
-			insn->attr = 0;	/* This instruction is bad */
-		goto end;	/* VEX has only 1 byte for opcode */
+		     !inat_is_group(insn->attr))) {
+			/* This instruction is bad */
+			insn->attr = 0;
+			return 1;
+		}
+		/* VEX has only 1 byte for opcode */
+		goto end;
 	}
 
 	insn->attr = inat_get_opcode_attribute(op);
@@ -267,13 +278,18 @@ void insn_get_opcode(struct insn *insn)
 		pfx_id = insn_last_prefix_id(insn);
 		insn->attr = inat_get_escape_attribute(op, pfx_id, insn->attr);
 	}
-	if (inat_must_vex(insn->attr))
-		insn->attr = 0;	/* This instruction is bad */
+
+	if (inat_must_vex(insn->attr)) {
+		/* This instruction is bad */
+		insn->attr = 0;
+		return 1;
+	}
 end:
 	opcode->got = 1;
+	return 0;
 
 err_out:
-	return;
+	return 1;
 }
 
 /**
@@ -283,15 +299,22 @@ void insn_get_opcode(struct insn *insn)
  * Populates @insn->modrm and updates @insn->next_byte to point past the
  * ModRM byte, if any.  If necessary, first collects the preceding bytes
  * (prefixes and opcode(s)).  No effect if @insn->modrm.got is already 1.
+ *
+ * Returns:
+ * 0:  on success
+ * !0: on error
  */
-void insn_get_modrm(struct insn *insn)
+int insn_get_modrm(struct insn *insn)
 {
 	struct insn_field *modrm = &insn->modrm;
 	insn_byte_t pfx_id, mod;
+
 	if (modrm->got)
-		return;
+		return 0;
+
 	if (!insn->opcode.got)
-		insn_get_opcode(insn);
+		if (insn_get_opcode(insn))
+			return 1;
 
 	if (inat_has_modrm(insn->attr)) {
 		mod = get_next(insn_byte_t, insn);
@@ -301,17 +324,22 @@ void insn_get_modrm(struct insn *insn)
 			pfx_id = insn_last_prefix_id(insn);
 			insn->attr = inat_get_group_attribute(mod, pfx_id,
 							      insn->attr);
-			if (insn_is_avx(insn) && !inat_accept_vex(insn->attr))
-				insn->attr = 0;	/* This is bad */
+			if (insn_is_avx(insn) && !inat_accept_vex(insn->attr)) {
+				/* Bad insn */
+				insn->attr = 0;
+				return 1;
+			}
 		}
 	}
 
 	if (insn->x86_64 && inat_is_force64(insn->attr))
 		insn->opnd_bytes = 8;
+
 	modrm->got = 1;
+	return 0;
 
 err_out:
-	return;
+	return 1;
 }
 
 
@@ -343,15 +371,23 @@ int insn_rip_relative(struct insn *insn)
  *
  * If necessary, first collects the instruction up to and including the
  * ModRM byte.
+ *
+ * Returns:
+ * 0: if decoding succeeded
+ * !0: otherwise.
  */
-void insn_get_sib(struct insn *insn)
+int insn_get_sib(struct insn *insn)
 {
 	insn_byte_t modrm;
 
 	if (insn->sib.got)
-		return;
-	if (!insn->modrm.got)
-		insn_get_modrm(insn);
+		return 0;
+
+	if (!insn->modrm.got) {
+		if (insn_get_modrm(insn))
+			return 1;
+	}
+
 	if (insn->modrm.nbytes) {
 		modrm = (insn_byte_t)insn->modrm.value;
 		if (insn->addr_bytes != 2 &&
@@ -362,8 +398,10 @@ void insn_get_sib(struct insn *insn)
 	}
 	insn->sib.got = 1;
 
+	return 0;
+
 err_out:
-	return;
+	return 1;
 }
 
 
@@ -374,15 +412,23 @@ void insn_get_sib(struct insn *insn)
  * If necessary, first collects the instruction up to and including the
  * SIB byte.
  * Displacement value is sign-expanded.
+ *
+ * * Returns:
+ * 0: if decoding succeeded
+ * !0: otherwise.
  */
-void insn_get_displacement(struct insn *insn)
+int insn_get_displacement(struct insn *insn)
 {
 	insn_byte_t mod, rm, base;
 
 	if (insn->displacement.got)
-		return;
-	if (!insn->sib.got)
-		insn_get_sib(insn);
+		return 0;
+
+	if (!insn->sib.got) {
+		if (insn_get_sib(insn))
+			return 1;
+	}
+
 	if (insn->modrm.nbytes) {
 		/*
 		 * Interpreting the modrm byte:
@@ -425,9 +471,10 @@ void insn_get_displacement(struct insn *insn)
 	}
 out:
 	insn->displacement.got = 1;
+	return 0;
 
 err_out:
-	return;
+	return 1;
 }
 
 /* Decode moffset16/32/64. Return 0 if failed */
@@ -538,20 +585,27 @@ static int __get_immptr(struct insn *insn)
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
+ * 0:  on success
+ * !0: on error
  */
-void insn_get_immediate(struct insn *insn)
+int insn_get_immediate(struct insn *insn)
 {
 	if (insn->immediate.got)
-		return;
-	if (!insn->displacement.got)
-		insn_get_displacement(insn);
+		return 0;
+
+	if (!insn->displacement.got) {
+		if (insn_get_displacement(insn))
+			return 1;
+	}
 
 	if (inat_has_moffset(insn->attr)) {
 		if (!__get_moffset(insn))
@@ -604,9 +658,10 @@ void insn_get_immediate(struct insn *insn)
 	}
 done:
 	insn->immediate.got = 1;
+	return 0;
 
 err_out:
-	return;
+	return 1;
 }
 
 /**
@@ -615,13 +670,58 @@ void insn_get_immediate(struct insn *insn)
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
+}
+
+/**
+ * insn_decode() - Decode an x86 instruction
+ * @insn:	&struct insn to be initialized
+ * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
+ * @buf_len:	length of the insn buffer at @kaddr
+ * @m:		insn mode, see enum insn_mode
+ *
+ * Returns:
+ * 0: if decoding succeeded
+ * !0: otherwise.
+ */
+int insn_decode(struct insn *insn, const void *kaddr, int buf_len, enum insn_mode m)
+{
+	if (m == INSN_MODE_KERN)
+		kernel_insn_init(insn, kaddr, buf_len);
+	else
+		insn_init(insn, kaddr, buf_len, m == INSN_MODE_64);
+
+	if (insn_get_opcode(insn))
+		return 1;
+
+	if (insn_get_modrm(insn))
+		return 1;
+
+	if (insn_get_sib(insn))
+		return 1;
+
+	if (insn_get_displacement(insn))
+		return 1;
+
+	if (insn_get_immediate(insn))
+		return 1;
+
+	return !insn_complete(insn);
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
