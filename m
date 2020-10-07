Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214CA286797
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgJGSn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:43:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:26830 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgJGSn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:43:27 -0400
IronPort-SDR: CP1Gl9nTcB5RFHVXbr5oQsqvS4rhh34KuG+LB/pohmpSkuy48yq+37pfDPFOwkYVJfGhP4MeT3
 ypcaJRLLiMnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="162443739"
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="162443739"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 11:43:26 -0700
IronPort-SDR: 28VHoGOndfRnWTasoHT1hQdzfg/1H2hWmZA8KwIuABiy+4waKFUCmBCW10nvcxycazrmxxsp0F
 uzTinV6I+Ylg==
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="297604799"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 11:43:02 -0700
Subject: [PATCH] x86/mce: Gate copy_mc_fragile() export by
 CONFIG_COPY_MC_TEST=y
From:   Dan Williams <dan.j.williams@intel.com>
To:     bp@alien8.de
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Date:   Wed, 07 Oct 2020 11:24:32 -0700
Message-ID: <160209507277.2768223.9933672492157583642.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <20201007111447.GA23257@zn.tnic>
References: <20201007111447.GA23257@zn.tnic>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that modpost is not happy about exporting assembly symbols
that are not consumed in the same build. As Boris reports:

    WARNING: modpost: EXPORT symbol "copy_mc_fragile" [vmlinux] version generation failed, symbol will not be versioned.

The export is only consumed in the CONFIG_COPY_MC_TEST=y case, and even
then not in a way that modpost could see. CONFIG_COPY_MC_TEST uses a
module built in tools/testing/nvdimm/ to exercise the copy_mc_fragile()
corner cases.  Given the test already requires manually editing the
config entry for CONFIG_COPY_MC_TEST to make it "def_bool y" the
additional dependency to require is CONFIG_MODVERSIONS=n is not too
onerous.

Alternatively, COPY_MC_TEST and its related infrastructure could just be
ripped out because it has served its purpose. For now, just stop
exporting the symbol by default, and add the MODVERSIONS dependency to
the test.

Fixes: ec6347bb4339 ("x86, powerpc: Rename memcpy_mcsafe() to copy_mc_to_{user, kernel}()")
Reported-by: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/Kconfig.debug    |    1 +
 arch/x86/lib/copy_mc_64.S |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 27b5e2bc6a01..6f0f5d8ac62e 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -63,6 +63,7 @@ config EARLY_PRINTK_USB_XDBC
 	  crashes or need a very simple printk logging facility.
 
 config COPY_MC_TEST
+	depends on !MODVERSIONS
 	def_bool n
 
 config EFI_PGT_DUMP
diff --git a/arch/x86/lib/copy_mc_64.S b/arch/x86/lib/copy_mc_64.S
index 892d8915f609..50fb05256751 100644
--- a/arch/x86/lib/copy_mc_64.S
+++ b/arch/x86/lib/copy_mc_64.S
@@ -88,7 +88,9 @@ SYM_FUNC_START(copy_mc_fragile)
 .L_done:
 	ret
 SYM_FUNC_END(copy_mc_fragile)
+#ifdef CONFIG_COPY_MC_TEST
 EXPORT_SYMBOL_GPL(copy_mc_fragile)
+#endif
 
 	.section .fixup, "ax"
 	/*

