Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CC621E3FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 01:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgGMXtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 19:49:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:36778 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbgGMXso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 19:48:44 -0400
IronPort-SDR: nJUZ+fCf4ug7CP28xoWUuqulojSJvZjUGDDnBLV9lUXKEeOM9FXWxKiCq1KsEprGfWX2t8S7Le
 bQkmxH83NcmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="148748419"
X-IronPort-AV: E=Sophos;i="5.75,349,1589266800"; 
   d="scan'208";a="148748419"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 16:48:43 -0700
IronPort-SDR: L+Dhg0Wclq3RFr++in/oMW1yRzogJL8GL71tVItUeixpZH4pbL89uXZYA/HJfQYIQM7/uNKuA5
 zYxfc+qUdk3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,349,1589266800"; 
   d="scan'208";a="281570442"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga003.jf.intel.com with ESMTP; 13 Jul 2020 16:48:43 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Joerg Roedel" <joro@8bytes.org>, "Ingo Molnar" <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "H Peter Anvin" <hpa@zytor.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Felix Kuehling" <Felix.Kuehling@amd.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, iommu@lists.linux-foundation.org,
        "amd-gfx" <amd-gfx@lists.freedesktop.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v6 04/12] x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions
Date:   Mon, 13 Jul 2020 16:47:59 -0700
Message-Id: <1594684087-61184-5-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Work submission instruction comes in two flavors. ENQCMD can be called
both in ring 3 and ring 0 and always uses the contents of PASID MSR when
shipping the command to the device. ENQCMDS allows a kernel driver to
submit commands on behalf of a user process. The driver supplies the
PASID value in ENQCMDS. There isn't any usage of ENQCMD in the kernel
as of now.

The CPU feature flag is shown as "enqcmd" in /proc/cpuinfo.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Re-write commit message (Thomas)

 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 02dabc9e77b0..4469618c410f 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -351,6 +351,7 @@
 #define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
 #define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
 #define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
+#define X86_FEATURE_ENQCMD		(16*32+29) /* ENQCMD and ENQCMDS instructions */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 3cbe24ca80ab..3a02707c1f4d 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -69,6 +69,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_CQM_MBM_TOTAL,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
+	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
 	{}
 };
 
-- 
2.19.1

