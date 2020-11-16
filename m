Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366532B43B9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgKPM1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbgKPM1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:27:45 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930B5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 04:27:45 -0800 (PST)
Received: from zn.tnic (p200300ec2f076800a8b99feb8264551e.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:6800:a8b9:9feb:8264:551e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E4C8B1EC025D;
        Mon, 16 Nov 2020 13:27:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605529663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ajKvF9P6TbEwBqfWEcF6a3RuHXf37EP5r4hM1aoVHTw=;
        b=KaCSgSw/P3SX1wEm4MFHi9akTEvb3TNnRg18cpiy4faTT7qEZKbo7LTlOoM5gmQFdv20Co
        +Xw1QSR7jq+xIwDwP66VUY+OxtbSzN7GmEJAeL8SqbzCg54O0PVmtomHdiFWTY93txr5Os
        C3Sc5Aq6uIFJTE7LvLKHV6EOUqpOCY8=
Date:   Mon, 16 Nov 2020 13:27:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Ashok Raj <ashok.raj@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v2] x86/microcode/intel: check cpu stepping and
 processor flag before saving microcode
Message-ID: <20201116122735.GA1131@zn.tnic>
References: <20201113015923.13960-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201113015923.13960-1-yu.c.chen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

( drop stable@ from Cc because this is not how fixes get added to stable@ )

On Fri, Nov 13, 2020 at 09:59:23AM +0800, Chen Yu wrote:
> Currently scan_microcode() leverages microcode_matches() to check if the
> microcode matches the CPU by comparing the family and model. However before
> saving the microcode in scan_microcode(), the processor stepping and flag
> of the microcode signature should also be considered in order to avoid
> incompatible update and caused the failure of microcode update.

This is going in the right direction but needs to take care of one
more angle. I've extended your fix to the version below. Lemme know if
something's not clear or still missing.

Thx.

---
From: Chen Yu <yu.c.chen@intel.com>
Date: Fri, 13 Nov 2020 09:59:23 +0800
Subject: [PATCH] x86/microcode/intel: Check patch signature before saving microcode for early loading

Currently, scan_microcode() leverages microcode_matches() to check
if the microcode matches the CPU by comparing the family and model.
However, the processor stepping and flags of the microcode signature
should also be considered when saving a microcode patch for early
update.

Use find_matching_signature() in scan_microcode() and get rid of the
now-unused microcode_matches() which is a good cleanup in itself.

Complete the verification of the patch being saved for early loading in
save_microcode_patch() directly. This needs to be done there too because
save_mc_for_early() will call save_microcode_patch() too.

The second reason why this needs to be done is because the loader still
tries to support, at least hypothetically, mixed-steppings systems and
thus adds all patches to the cache that belong to the same CPU model
albeit with different steppings.

For example:

  microcode: CPU: sig=0x906ec, pf=0x2, rev=0xd6
  microcode: mc_saved[0]: sig=0x906e9, pf=0x2a, rev=0xd6, total size=0x19400, date = 2020-04-23
  microcode: mc_saved[1]: sig=0x906ea, pf=0x22, rev=0xd6, total size=0x19000, date = 2020-04-27
  microcode: mc_saved[2]: sig=0x906eb, pf=0x2, rev=0xd6, total size=0x19400, date = 2020-04-23
  microcode: mc_saved[3]: sig=0x906ec, pf=0x22, rev=0xd6, total size=0x19000, date = 2020-04-27
  microcode: mc_saved[4]: sig=0x906ed, pf=0x22, rev=0xd6, total size=0x19400, date = 2020-04-23

The patch which is being saved for early loading, however, can only be
the one which fits the CPU this runs on so do the signature verification
before saving.

 [ bp: Do signature verification in save_microcode_patch()
       and rewrite commit message. ]

Fixes: 06b8534cb728 ("x86/microcode: Rework microcode loading")
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: stable@vger.kernel.org #v4.10+
Link: https://bugzilla.kernel.org/show_bug.cgi?id=208535
Link: https://lkml.kernel.org/r/20201113015923.13960-1-yu.c.chen@intel.com
---
 arch/x86/kernel/cpu/microcode/intel.c | 63 +++++----------------------
 1 file changed, 10 insertions(+), 53 deletions(-)

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
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
