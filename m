Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B24220A6AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 22:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436630AbgFYUTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 16:19:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:20511 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436554AbgFYUSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 16:18:42 -0400
IronPort-SDR: PLiHLbl3I1BrvBt7GT+3xQmRGiTeMxBqAw1kFylEE8cXxnppIPyb63keRjYd4EG1N2gFr6VkNJ
 v0PcdonAV3IQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="132505271"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="132505271"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 13:18:39 -0700
IronPort-SDR: AAgquAkm1l/NqlL9WDyZ0cKvUdTTaegXPTF/KUycK8i/0U8HgUJlW03H6K4RoCnRpmWaIexUWZ
 R0cE70GNsQvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="453132234"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 25 Jun 2020 13:18:38 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Joerg Roedel" <joro@8bytes.org>, "Ingo Molnar" <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "H Peter Anvin" <hpa@zytor.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        "Christoph Hellwig" <hch@infradeed.org>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, iommu@lists.linux-foundation.org,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 06/12] x86/msr-index: Define IA32_PASID MSR
Date:   Thu, 25 Jun 2020 13:17:16 -0700
Message-Id: <1593116242-31507-7-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1593116242-31507-1-git-send-email-fenghua.yu@intel.com>
References: <1593116242-31507-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IA32_PASID MSR (0xd93) contains the Process Address Space Identifier
(PASID), a 20-bit value. Bit 31 must be set to indicate the value
programmed in the MSR is valid. Hardware uses PASID to identify process
address space and direct responses to the right address space.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Change "identify process" to "identify process address space" in the
  commit message (Thomas)

 arch/x86/include/asm/msr-index.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e8370e64a155..e5f699ff1dd6 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -237,6 +237,9 @@
 #define MSR_IA32_LASTINTFROMIP		0x000001dd
 #define MSR_IA32_LASTINTTOIP		0x000001de
 
+#define MSR_IA32_PASID			0x00000d93
+#define MSR_IA32_PASID_VALID		BIT_ULL(31)
+
 /* DEBUGCTLMSR bits (others vary by model): */
 #define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
 #define DEBUGCTLMSR_BTF_SHIFT		1
-- 
2.19.1

