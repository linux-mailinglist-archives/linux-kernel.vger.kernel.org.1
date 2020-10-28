Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1027F29D2C0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgJ1Veh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:34:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:47179 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbgJ1Vea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:34:30 -0400
IronPort-SDR: dDNiq1q+eGD0HT5sYc5w3rXOwIouRkNrLaMD1WGSg6etuQQIm2qI6l4sB4pphxZeP4fnz3JO/X
 X/NctVg4eXxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="167551729"
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="167551729"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 13:28:15 -0700
IronPort-SDR: jia/gU5gyeTEnxsb3Aod47MDuzaAxauqKiUUppFwrQx1Nau19iEkBasFDAKEh+7a9/6RvKPv7h
 fbFeVLbRRmVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="526467869"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga005.fm.intel.com with ESMTP; 28 Oct 2020 13:28:15 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Christopherson Sean J" <sean.j.christopherson@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH RFC v2 1/4] x86/cpufeatures: Enumerate #DB for bus lock detection
Date:   Wed, 28 Oct 2020 20:28:01 +0000
Message-Id: <20201028202804.3562179-2-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028202804.3562179-1-fenghua.yu@intel.com>
References: <20201028202804.3562179-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bus lock is acquired either through split locked access to
writeback (WB) memory or by using locks to uncacheable (UC) memory
(e.g. direct device assignment). This is typically >1000 cycles slower
than an atomic operation within a cache line. It also disrupts performance
on other cores.

Some CPUs have ability to notify the kernel by an #DB trap after a user
instruction acquires a bus lock and is executed. This allows the kernel
to enforce user application throttling or mitigations.

The CPU feature flag to be shown in /proc/cpuinfo will be "bus_lock_detect".

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dad350d42ecf..f375d9cb8123 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -352,6 +352,7 @@
 #define X86_FEATURE_AVX512_VPOPCNTDQ	(16*32+14) /* POPCNT for vectors of DW/QW */
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
+#define X86_FEATURE_BUS_LOCK_DETECT	(16*32+24) /* Bus Lock detect */
 #define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
 #define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
 #define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
-- 
2.29.0

