Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1E92AD804
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbgKJNut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:50:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:12929 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgKJNut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:50:49 -0500
IronPort-SDR: ITcDfpF2sn/Bn2HBdMNIioX/Pyc7jNVk8P7BraZ/dXCyUQRazSJGm8LYdTLq6nMLeKyQsCEjG7
 kw8UXtrS3uow==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="231600562"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="231600562"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 05:50:48 -0800
IronPort-SDR: szJYNq35NE62HJ8RZ9HSD419vCCDT+zT5SBHFxInAUPWQ0MOzqPuHocbqVzh7zhAbQwOwJm22/
 KeITNY5Crtnw==
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="541329911"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 05:50:46 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Borislav Petkov <bp@alien8.de>, Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][RFC] x86/microcode/intel: check cpu stepping and processor flag before saving microcode
Date:   Tue, 10 Nov 2020 21:52:47 +0800
Message-Id: <20201110135247.422-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently scan_microcode() leverages microcode_matches() to check if the
microcode matches the CPU by comparing the family and model. However before
saving the microcode in scan_microcode(), the processor stepping and flag
of the microcode signature should also be considered in order to avoid
incompatible update and caused the failure of microcode update.

For example on one platform the microcode failed to be updated to the
latest revison on APs during resume from S3 due to incompatible cpu stepping
and signature->pf. This is because the scan_microcode() has saved an incompatible
copy of intel_ucode_patch in save_microcode_in_initrd_intel() after bootup.
And this intel_ucode_patch is used by APs during early resume from S3 which
results in unchecked MSR access error during resume from S3:

[   95.519390] unchecked MSR access error: RDMSR from 0x123 at
	rIP: 0xffffffffb7676208 (native_read_msr+0x8/0x40)
[   95.519391] Call Trace:
[   95.519395]  update_srbds_msr+0x38/0x80
[   95.519396]  identify_secondary_cpu+0x7a/0x90
[   95.519397]  smp_store_cpu_info+0x4e/0x60
[   95.519398]  start_secondary+0x49/0x150
[   95.519399]  secondary_startup_64_no_verify+0xa6/0xab

The system keeps running on old microcode during resume:
[  210.366757] microcode: load_ucode_intel_ap: CPU1, enter, intel_ucode_patch: 0xffff9bf2816e0000
[  210.366757] microcode: load_ucode_intel_ap: CPU1, p: 0xffff9bf2816e0000, rev: 0xd6
[  210.366759] microcode: apply_microcode_early: rev: 0x84
[  210.367826] microcode: apply_microcode_early: rev after upgrade: 0x84

until mc_cpu_starting() is invoked on each AP during resume and the correct microcode
is updated via apply_microcode_intel().

To fix this issue, the scan_microcode() uses find_matching_signature() instead of
microcode_matches() to compare the (family, model, stepping, processor flag), and
only save the microcode that matches. As there is no other place invoking microcode_matches(),
remove it accordingly.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=208535
Fixes: 06b8534cb728 ("x86/microcode: Rework microcode loading")
Suggested-by: "Raj, Ashok" <ashok.raj@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Len Brown <len.brown@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Raj, Ashok" <ashok.raj@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
--
 arch/x86/kernel/cpu/microcode/intel.c | 50 ++-------------------------
 1 file changed, 2 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 6a99535d7f37..923853f79099 100644
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
@@ -344,7 +297,8 @@ scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
 
 		size -= mc_size;
 
-		if (!microcode_matches(mc_header, uci->cpu_sig.sig)) {
+		if (!find_matching_signature(data, uci->cpu_sig.sig,
+					     uci->cpu_sig.pf)) {
 			data += mc_size;
 			continue;
 		}
-- 
2.17.1

