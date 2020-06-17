Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7792E1FC792
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 09:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgFQHiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 03:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgFQHiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:38:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71CFC061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 00:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UKlq6Qc43uh+OEpd24UsOoAS2Du46RrmeUqkvLlfT0w=; b=errYpsc/4wXxXF8fL+BKKxPuoP
        Gg1cPIp2O2O08nsRFymxC1XNac0U0Zr6ChBuDnBhx8OwHCbUubbHSEgV5G4vU8Xc0VAIEb1zBUcm8
        gjSG1kYDepcbyiCdhekBtfb0mq+ygVBImo2TSke31slrGfYffL34p/kUUCowONOTW1polZD811XX9
        LkxYXe48sFhcTQI0ckYYmLShHZEEWTqr6IoxObrKk8yyv7z9BAs1o7zsBN2hE+ZjhQ4Fz5G45kemw
        Flh85NbELWYAe/D6WWyZr8FQ2wufT3oPMvOzmsnQcVz+ayUW+vQ08UY/AijqIer6DL0AI4nikYhac
        y4XNnbxA==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlSe6-0001YG-AH; Wed, 17 Jun 2020 07:38:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] maccess: rename probe_kernel_address to get_kernel_nofault
Date:   Wed, 17 Jun 2020 09:37:55 +0200
Message-Id: <20200617073755.8068-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617073755.8068-1-hch@lst.de>
References: <20200617073755.8068-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Better describe what this helper does, and match the naming of
copy_from_kernel_nofault.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/kernel/traps.c             |  2 +-
 arch/arm/mm/alignment.c             |  4 ++--
 arch/arm64/kernel/traps.c           |  2 +-
 arch/ia64/include/asm/sections.h    |  2 +-
 arch/parisc/kernel/process.c        |  2 +-
 arch/powerpc/include/asm/sections.h |  2 +-
 arch/powerpc/kernel/kgdb.c          |  2 +-
 arch/powerpc/kernel/kprobes.c       |  2 +-
 arch/powerpc/kernel/process.c       |  2 +-
 arch/powerpc/sysdev/fsl_pci.c       |  2 +-
 arch/riscv/kernel/kgdb.c            |  4 ++--
 arch/riscv/kernel/traps.c           |  4 ++--
 arch/s390/mm/fault.c                |  2 +-
 arch/sh/kernel/traps.c              |  2 +-
 arch/x86/kernel/probe_roms.c        | 20 ++++++++++----------
 arch/x86/kernel/traps.c             |  2 +-
 arch/x86/mm/fault.c                 |  6 +++---
 arch/x86/pci/pcbios.c               |  2 +-
 include/linux/uaccess.h             |  4 ++--
 lib/test_lockup.c                   |  6 +++---
 20 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 65a3b1e7548023..605d304c8e1491 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -396,7 +396,7 @@ int is_valid_bugaddr(unsigned long pc)
 	u32 insn = __opcode_to_mem_arm(BUG_INSTR_VALUE);
 #endif
 
-	if (probe_kernel_address((unsigned *)pc, bkpt))
+	if (get_kernel_nofault((unsigned *)pc, bkpt))
 		return 0;
 
 	return bkpt == insn;
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 84718eddae6039..236016f13bcd3c 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -774,7 +774,7 @@ static int alignment_get_arm(struct pt_regs *regs, u32 *ip, u32 *inst)
 	if (user_mode(regs))
 		fault = get_user(instr, ip);
 	else
-		fault = probe_kernel_address(ip, instr);
+		fault = get_kernel_nofault(ip, instr);
 
 	*inst = __mem_to_opcode_arm(instr);
 
@@ -789,7 +789,7 @@ static int alignment_get_thumb(struct pt_regs *regs, u16 *ip, u16 *inst)
 	if (user_mode(regs))
 		fault = get_user(instr, ip);
 	else
-		fault = probe_kernel_address(ip, instr);
+		fault = get_kernel_nofault(ip, instr);
 
 	*inst = __mem_to_opcode_thumb16(instr);
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 50cc30acf1064e..25f16b290f3820 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -376,7 +376,7 @@ static int call_undef_hook(struct pt_regs *regs)
 
 	if (!user_mode(regs)) {
 		__le32 instr_le;
-		if (probe_kernel_address((__force __le32 *)pc, instr_le))
+		if (get_kernel_nofault((__force __le32 *)pc, instr_le))
 			goto exit;
 		instr = le32_to_cpu(instr_le);
 	} else if (compat_thumb_mode(regs)) {
diff --git a/arch/ia64/include/asm/sections.h b/arch/ia64/include/asm/sections.h
index cea15f2dd38df7..ef03eec8666f8c 100644
--- a/arch/ia64/include/asm/sections.h
+++ b/arch/ia64/include/asm/sections.h
@@ -35,7 +35,7 @@ static inline void *dereference_function_descriptor(void *ptr)
 	struct fdesc *desc = ptr;
 	void *p;
 
-	if (!probe_kernel_address(&desc->ip, p))
+	if (!get_kernel_nofault(&desc->ip, p))
 		ptr = p;
 	return ptr;
 }
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 230a6422b99f36..c3b0f03bd0bf13 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -293,7 +293,7 @@ void *dereference_function_descriptor(void *ptr)
 	Elf64_Fdesc *desc = ptr;
 	void *p;
 
-	if (!probe_kernel_address(&desc->addr, p))
+	if (!get_kernel_nofault(&desc->addr, p))
 		ptr = p;
 	return ptr;
 }
diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index d19871763ed4aa..636bb1633de182 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -85,7 +85,7 @@ static inline void *dereference_function_descriptor(void *ptr)
 	struct ppc64_opd_entry *desc = ptr;
 	void *p;
 
-	if (!probe_kernel_address(&desc->funcaddr, p))
+	if (!get_kernel_nofault(&desc->funcaddr, p))
 		ptr = p;
 	return ptr;
 }
diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 652b2852bea307..b3d13495eb15c8 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -421,7 +421,7 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 	unsigned int instr;
 	struct ppc_inst *addr = (struct ppc_inst *)bpt->bpt_addr;
 
-	err = probe_kernel_address(addr, instr);
+	err = get_kernel_nofault(addr, instr);
 	if (err)
 		return err;
 
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 6f96f65ebfe892..f933a576b2a4df 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -289,7 +289,7 @@ int kprobe_handler(struct pt_regs *regs)
 	if (!p) {
 		unsigned int instr;
 
-		if (probe_kernel_address(addr, instr))
+		if (get_kernel_nofault(addr, instr))
 			goto no_kprobe;
 
 		if (instr != BREAKPOINT_INSTRUCTION) {
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index d4d0d10485003d..52d6f430881385 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1271,7 +1271,7 @@ static void show_instructions(struct pt_regs *regs)
 #endif
 
 		if (!__kernel_text_address(pc) ||
-		    probe_kernel_address((const void *)pc, instr)) {
+		    get_kernel_nofault((const void *)pc, instr)) {
 			pr_cont("XXXXXXXX ");
 		} else {
 			if (regs->nip == pc)
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 73fa37ca40ef95..483412d5a1973c 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1069,7 +1069,7 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)
 			ret = copy_from_user_nofault(&inst,
 					(void __user *)regs->nip, sizeof(inst));
 		else
-			ret = probe_kernel_address((void *)regs->nip, inst);
+			ret = get_kernel_nofault((void *)regs->nip, inst);
 
 		if (!ret && mcheck_handle_load(regs, inst)) {
 			regs->nip += 4;
diff --git a/arch/riscv/kernel/kgdb.c b/arch/riscv/kernel/kgdb.c
index a21fb21883e782..eed33d8cca970b 100644
--- a/arch/riscv/kernel/kgdb.c
+++ b/arch/riscv/kernel/kgdb.c
@@ -62,7 +62,7 @@ int get_step_address(struct pt_regs *regs, unsigned long *next_addr)
 	unsigned int rs1_num, rs2_num;
 	int op_code;
 
-	if (probe_kernel_address((void *)pc, op_code))
+	if (get_kernel_nofault((void *)pc, op_code))
 		return -EINVAL;
 	if ((op_code & __INSN_LENGTH_MASK) != __INSN_LENGTH_GE_32) {
 		if (is_c_jalr_insn(op_code) || is_c_jr_insn(op_code)) {
@@ -146,7 +146,7 @@ int do_single_step(struct pt_regs *regs)
 		return error;
 
 	/* Store the op code in the stepped address */
-	error = probe_kernel_address((void *)addr, stepped_opcode);
+	error = get_kernel_nofault((void *)addr, stepped_opcode);
 	if (error)
 		return error;
 
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index ecec1778e3a424..1e45b9e22d199d 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -137,7 +137,7 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
 {
 	bug_insn_t insn;
 
-	if (probe_kernel_address((bug_insn_t *)pc, insn))
+	if (get_kernel_nofault((bug_insn_t *)pc, insn))
 		return 0;
 
 	return GET_INSN_LENGTH(insn);
@@ -165,7 +165,7 @@ int is_valid_bugaddr(unsigned long pc)
 
 	if (pc < VMALLOC_START)
 		return 0;
-	if (probe_kernel_address((bug_insn_t *)pc, insn))
+	if (get_kernel_nofault((bug_insn_t *)pc, insn))
 		return 0;
 	if ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32)
 		return (insn == __BUG_INSN_32);
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 6a24751557f0ef..90d2ed0d4db36f 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -105,7 +105,7 @@ static int bad_address(void *p)
 {
 	unsigned long dummy;
 
-	return probe_kernel_address((unsigned long *)p, dummy);
+	return get_kernel_nofault((unsigned long *)p, dummy);
 }
 
 static void dump_pagetable(unsigned long asce, unsigned long address)
diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
index a33025451fcd09..a03b528adaf525 100644
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -118,7 +118,7 @@ int is_valid_bugaddr(unsigned long addr)
 
 	if (addr < PAGE_OFFSET)
 		return 0;
-	if (probe_kernel_address((insn_size_t *)addr, opcode))
+	if (get_kernel_nofault((insn_size_t *)addr, opcode))
 		return 0;
 	if (opcode == TRAPA_BUG_OPCODE)
 		return 1;
diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
index ee0286390a4c18..77f3341570e847 100644
--- a/arch/x86/kernel/probe_roms.c
+++ b/arch/x86/kernel/probe_roms.c
@@ -99,7 +99,7 @@ static bool probe_list(struct pci_dev *pdev, unsigned short vendor,
 	unsigned short device;
 
 	do {
-		if (probe_kernel_address(rom_list, device) != 0)
+		if (get_kernel_nofault(rom_list, device) != 0)
 			device = 0;
 
 		if (device && match_id(pdev, vendor, device))
@@ -125,13 +125,13 @@ static struct resource *find_oprom(struct pci_dev *pdev)
 			break;
 
 		rom = isa_bus_to_virt(res->start);
-		if (probe_kernel_address(rom + 0x18, offset) != 0)
+		if (get_kernel_nofault(rom + 0x18, offset) != 0)
 			continue;
 
-		if (probe_kernel_address(rom + offset + 0x4, vendor) != 0)
+		if (get_kernel_nofault(rom + offset + 0x4, vendor) != 0)
 			continue;
 
-		if (probe_kernel_address(rom + offset + 0x6, device) != 0)
+		if (get_kernel_nofault(rom + offset + 0x6, device) != 0)
 			continue;
 
 		if (match_id(pdev, vendor, device)) {
@@ -139,8 +139,8 @@ static struct resource *find_oprom(struct pci_dev *pdev)
 			break;
 		}
 
-		if (probe_kernel_address(rom + offset + 0x8, list) == 0 &&
-		    probe_kernel_address(rom + offset + 0xc, rev) == 0 &&
+		if (get_kernel_nofault(rom + offset + 0x8, list) == 0 &&
+		    get_kernel_nofault(rom + offset + 0xc, rev) == 0 &&
 		    rev >= 3 && list &&
 		    probe_list(pdev, vendor, rom + offset + list)) {
 			oprom = res;
@@ -183,14 +183,14 @@ static int __init romsignature(const unsigned char *rom)
 	const unsigned short * const ptr = (const unsigned short *)rom;
 	unsigned short sig;
 
-	return probe_kernel_address(ptr, sig) == 0 && sig == ROMSIGNATURE;
+	return get_kernel_nofault(ptr, sig) == 0 && sig == ROMSIGNATURE;
 }
 
 static int __init romchecksum(const unsigned char *rom, unsigned long length)
 {
 	unsigned char sum, c;
 
-	for (sum = 0; length && probe_kernel_address(rom++, c) == 0; length--)
+	for (sum = 0; length && get_kernel_nofault(rom++, c) == 0; length--)
 		sum += c;
 	return !length && !sum;
 }
@@ -211,7 +211,7 @@ void __init probe_roms(void)
 
 		video_rom_resource.start = start;
 
-		if (probe_kernel_address(rom + 2, c) != 0)
+		if (get_kernel_nofault(rom + 2, c) != 0)
 			continue;
 
 		/* 0 < length <= 0x7f * 512, historically */
@@ -249,7 +249,7 @@ void __init probe_roms(void)
 		if (!romsignature(rom))
 			continue;
 
-		if (probe_kernel_address(rom + 2, c) != 0)
+		if (get_kernel_nofault(rom + 2, c) != 0)
 			continue;
 
 		/* 0 < length <= 0x7f * 512, historically */
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 7003f2e7b1634a..3b0ffbbab8f27d 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -91,7 +91,7 @@ int is_valid_bugaddr(unsigned long addr)
 	if (addr < TASK_SIZE_MAX)
 		return 0;
 
-	if (probe_kernel_address((unsigned short *)addr, ud))
+	if (get_kernel_nofault((unsigned short *)addr, ud))
 		return 0;
 
 	return ud == INSN_UD0 || ud == INSN_UD2;
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e996aa3833b85b..43cc1bde58b67c 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -99,7 +99,7 @@ check_prefetch_opcode(struct pt_regs *regs, unsigned char *instr,
 		return !instr_lo || (instr_lo>>1) == 1;
 	case 0x00:
 		/* Prefetch instruction is 0x0F0D or 0x0F18 */
-		if (probe_kernel_address(instr, opcode))
+		if (get_kernel_nofault(instr, opcode))
 			return 0;
 
 		*prefetch = (instr_lo == 0xF) &&
@@ -133,7 +133,7 @@ is_prefetch(struct pt_regs *regs, unsigned long error_code, unsigned long addr)
 	while (instr < max_instr) {
 		unsigned char opcode;
 
-		if (probe_kernel_address(instr, opcode))
+		if (get_kernel_nofault(instr, opcode))
 			break;
 
 		instr++;
@@ -301,7 +301,7 @@ static int bad_address(void *p)
 {
 	unsigned long dummy;
 
-	return probe_kernel_address((unsigned long *)p, dummy);
+	return get_kernel_nofault((unsigned long *)p, dummy);
 }
 
 static void dump_pagetable(unsigned long address)
diff --git a/arch/x86/pci/pcbios.c b/arch/x86/pci/pcbios.c
index 9c97d814125eb9..b7f8699b18c1f9 100644
--- a/arch/x86/pci/pcbios.c
+++ b/arch/x86/pci/pcbios.c
@@ -302,7 +302,7 @@ static const struct pci_raw_ops *__init pci_find_bios(void)
 	     check <= (union bios32 *) __va(0xffff0);
 	     ++check) {
 		long sig;
-		if (probe_kernel_address(&check->fields.signature, sig))
+		if (get_kernel_nofault(&check->fields.signature, sig))
 			continue;
 
 		if (check->fields.signature != BIOS32_SIGNATURE)
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index bef48da242cc2c..5083e9fe1e3d8e 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -318,13 +318,13 @@ long strncpy_from_user_nofault(char *dst, const void __user *unsafe_addr,
 long strnlen_user_nofault(const void __user *unsafe_addr, long count);
 
 /**
- * probe_kernel_address(): safely attempt to read from a location
+ * get_kernel_nofault(): safely attempt to read from a location
  * @addr: address to read from
  * @retval: read into this variable
  *
  * Returns 0 on success, or -EFAULT.
  */
-#define probe_kernel_address(addr, retval)		\
+#define get_kernel_nofault(addr, retval)		\
 	copy_from_kernel_nofault(&retval, addr, sizeof(retval))
 
 #ifndef user_access_begin
diff --git a/lib/test_lockup.c b/lib/test_lockup.c
index f258743a0d8381..6bf712508673c5 100644
--- a/lib/test_lockup.c
+++ b/lib/test_lockup.c
@@ -419,8 +419,8 @@ static bool test_kernel_ptr(unsigned long addr, int size)
 	/* should be at least readable kernel address */
 	if (access_ok(ptr, 1) ||
 	    access_ok(ptr + size - 1, 1) ||
-	    probe_kernel_address(ptr, buf) ||
-	    probe_kernel_address(ptr + size - 1, buf)) {
+	    get_kernel_nofault(ptr, buf) ||
+	    get_kernel_nofault(ptr + size - 1, buf)) {
 		pr_err("invalid kernel ptr: %#lx\n", addr);
 		return true;
 	}
@@ -437,7 +437,7 @@ static bool __maybe_unused test_magic(unsigned long addr, int offset,
 	if (!addr)
 		return false;
 
-	if (probe_kernel_address(ptr, magic) || magic != expected) {
+	if (get_kernel_nofault(ptr, magic) || magic != expected) {
 		pr_err("invalid magic at %#lx + %#x = %#x, expected %#x\n",
 		       addr, offset, magic, expected);
 		return true;
-- 
2.26.2

