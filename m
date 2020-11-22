Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9402BC52F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 11:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgKVKyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 05:54:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:46284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbgKVKyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 05:54:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C2623ABE4;
        Sun, 22 Nov 2020 10:54:11 +0000 (UTC)
Date:   Sun, 22 Nov 2020 11:54:05 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.10-rc5
Message-ID: <20201122105405.GA20595@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the x86/urgent pile for -rc5.

Thx.

---
The following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.10-rc5

for you to fetch changes up to 01cf158e48d2b5ce947430de5896c10f4f7c1822:

  Revert "iommu/vt-d: Take CONFIG_PCI_ATS into account" (2020-11-19 15:07:19 +0100)

----------------------------------------------------------------
* An IOMMU VT-d build fix when CONFIG_PCI_ATS=n along with a revert of
  same because the proper one is going through the IOMMU tree. (Thomas Gleixner)

* An Intel microcode loader fix to save the correct microcode patch to
  apply during resume. (Chen Yu)

* A fix to not access user memory of other processes when dumping opcode
  bytes. (Thomas Gleixner)

----------------------------------------------------------------
Chen Yu (1):
      x86/microcode/intel: Check patch signature before saving microcode for early loading

Thomas Gleixner (3):
      iommu/vt-d: Take CONFIG_PCI_ATS into account
      x86/dumpstack: Do not try to access user space code of other tasks
      Revert "iommu/vt-d: Take CONFIG_PCI_ATS into account"

 arch/x86/kernel/cpu/microcode/intel.c | 63 ++++++-----------------------------
 arch/x86/kernel/dumpstack.c           | 23 ++++++++++---
 2 files changed, 29 insertions(+), 57 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 6a99535d7f37..7e8e07bddd5f 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -100,53 +100,6 @@ static int has_newer_microcode(void *mc, unsigned int csig, int cpf, int new_rev
 	return find_matching_signature(mc, csig, cpf);
 }
 
-/*
- * Given CPU signature and a microcode patch, this function finds if the
- * microcode patch has matching family and model with the CPU.
- *
- * %true - if there's a match
- * %false - otherwise
- */
-static bool microcode_matches(struct microcode_header_intel *mc_header,
-			      unsigned long sig)
-{
-	unsigned long total_size = get_totalsize(mc_header);
-	unsigned long data_size = get_datasize(mc_header);
-	struct extended_sigtable *ext_header;
-	unsigned int fam_ucode, model_ucode;
-	struct extended_signature *ext_sig;
-	unsigned int fam, model;
-	int ext_sigcount, i;
-
-	fam   = x86_family(sig);
-	model = x86_model(sig);
-
-	fam_ucode   = x86_family(mc_header->sig);
-	model_ucode = x86_model(mc_header->sig);
-
-	if (fam == fam_ucode && model == model_ucode)
-		return true;
-
-	/* Look for ext. headers: */
-	if (total_size <= data_size + MC_HEADER_SIZE)
-		return false;
-
-	ext_header   = (void *) mc_header + data_size + MC_HEADER_SIZE;
-	ext_sig      = (void *)ext_header + EXT_HEADER_SIZE;
-	ext_sigcount = ext_header->count;
-
-	for (i = 0; i < ext_sigcount; i++) {
-		fam_ucode   = x86_family(ext_sig->sig);
-		model_ucode = x86_model(ext_sig->sig);
-
-		if (fam == fam_ucode && model == model_ucode)
-			return true;
-
-		ext_sig++;
-	}
-	return false;
-}
-
 static struct ucode_patch *memdup_patch(void *data, unsigned int size)
 {
 	struct ucode_patch *p;
@@ -164,7 +117,7 @@ static struct ucode_patch *memdup_patch(void *data, unsigned int size)
 	return p;
 }
 
-static void save_microcode_patch(void *data, unsigned int size)
+static void save_microcode_patch(struct ucode_cpu_info *uci, void *data, unsigned int size)
 {
 	struct microcode_header_intel *mc_hdr, *mc_saved_hdr;
 	struct ucode_patch *iter, *tmp, *p = NULL;
@@ -210,6 +163,9 @@ static void save_microcode_patch(void *data, unsigned int size)
 	if (!p)
 		return;
 
+	if (!find_matching_signature(p->data, uci->cpu_sig.sig, uci->cpu_sig.pf))
+		return;
+
 	/*
 	 * Save for early loading. On 32-bit, that needs to be a physical
 	 * address as the APs are running from physical addresses, before
@@ -344,13 +300,14 @@ scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
 
 		size -= mc_size;
 
-		if (!microcode_matches(mc_header, uci->cpu_sig.sig)) {
+		if (!find_matching_signature(data, uci->cpu_sig.sig,
+					     uci->cpu_sig.pf)) {
 			data += mc_size;
 			continue;
 		}
 
 		if (save) {
-			save_microcode_patch(data, mc_size);
+			save_microcode_patch(uci, data, mc_size);
 			goto next;
 		}
 
@@ -483,14 +440,14 @@ static void show_saved_mc(void)
  * Save this microcode patch. It will be loaded early when a CPU is
  * hot-added or resumes.
  */
-static void save_mc_for_early(u8 *mc, unsigned int size)
+static void save_mc_for_early(struct ucode_cpu_info *uci, u8 *mc, unsigned int size)
 {
 	/* Synchronization during CPU hotplug. */
 	static DEFINE_MUTEX(x86_cpu_microcode_mutex);
 
 	mutex_lock(&x86_cpu_microcode_mutex);
 
-	save_microcode_patch(mc, size);
+	save_microcode_patch(uci, mc, size);
 	show_saved_mc();
 
 	mutex_unlock(&x86_cpu_microcode_mutex);
@@ -935,7 +892,7 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 	 * permanent memory. So it will be loaded early when a CPU is hot added
 	 * or resumes.
 	 */
-	save_mc_for_early(new_mc, new_mc_size);
+	save_mc_for_early(uci, new_mc, new_mc_size);
 
 	pr_debug("CPU%d found a matching microcode update with version 0x%x (current=0x%x)\n",
 		 cpu, new_rev, uci->cpu_sig.rev);
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 25c06b67e7e0..97aa900386cb 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -78,6 +78,9 @@ static int copy_code(struct pt_regs *regs, u8 *buf, unsigned long src,
 	if (!user_mode(regs))
 		return copy_from_kernel_nofault(buf, (u8 *)src, nbytes);
 
+	/* The user space code from other tasks cannot be accessed. */
+	if (regs != task_pt_regs(current))
+		return -EPERM;
 	/*
 	 * Make sure userspace isn't trying to trick us into dumping kernel
 	 * memory by pointing the userspace instruction pointer at it.
@@ -85,6 +88,12 @@ static int copy_code(struct pt_regs *regs, u8 *buf, unsigned long src,
 	if (__chk_range_not_ok(src, nbytes, TASK_SIZE_MAX))
 		return -EINVAL;
 
+	/*
+	 * Even if named copy_from_user_nmi() this can be invoked from
+	 * other contexts and will not try to resolve a pagefault, which is
+	 * the correct thing to do here as this code can be called from any
+	 * context.
+	 */
 	return copy_from_user_nmi(buf, (void __user *)src, nbytes);
 }
 
@@ -115,13 +124,19 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
 	u8 opcodes[OPCODE_BUFSIZE];
 	unsigned long prologue = regs->ip - PROLOGUE_SIZE;
 
-	if (copy_code(regs, opcodes, prologue, sizeof(opcodes))) {
-		printk("%sCode: Unable to access opcode bytes at RIP 0x%lx.\n",
-		       loglvl, prologue);
-	} else {
+	switch (copy_code(regs, opcodes, prologue, sizeof(opcodes))) {
+	case 0:
 		printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
 		       __stringify(EPILOGUE_SIZE) "ph\n", loglvl, opcodes,
 		       opcodes[PROLOGUE_SIZE], opcodes + PROLOGUE_SIZE + 1);
+		break;
+	case -EPERM:
+		/* No access to the user space stack of other tasks. Ignore. */
+		break;
+	default:
+		printk("%sCode: Unable to access opcode bytes at RIP 0x%lx.\n",
+		       loglvl, prologue);
+		break;
 	}
 }
 

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
