Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F2523DE21
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 19:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgHFRWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 13:22:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:3476 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729665AbgHFRWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:22:37 -0400
IronPort-SDR: yyORRzSJEl0V8o5hcvxC/eYyQIuLKGuLaZ8xFtrq3juxDof2VuGbePyuXWEPhvzTHZdGen/wX9
 JjuxI0WMQAsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="150518237"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="150518237"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 04:39:34 -0700
IronPort-SDR: GVSZ3kCnw8m+69EDPK41POPkktXHjiKGvSG3bhUH3UdHGxrs3zrMjvRdtn11fOgC27cPV+7RJP
 J7MU0L3LCb0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="316119581"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.135])
  by fmsmga004.fm.intel.com with ESMTP; 06 Aug 2020 04:39:30 -0700
From:   Shuo Liu <shuo.a.liu@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH] x86/acrn: Allow ACRN guest to use X2APIC mode
Date:   Thu,  6 Aug 2020 19:38:02 +0800
Message-Id: <20200806113802.9325-1-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACRN Hypervisor did not support x2APIC and thus x2APIC support was
disabled by always returning false when VM checked for x2APIC support.

ACRN received full support of x2APIC and exports the capability through
CPUID feature bits.

Let VM decide if it needs to switch to x2APIC mode according to CPUID
features.

Originally-by: Yakui Zhao <yakui.zhao@intel.com>
Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Fengwei Yin <fengwei.yin@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/acrn.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 1da9b1c9a2db..3b08cdfc6514 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -11,6 +11,7 @@
 
 #include <linux/interrupt.h>
 #include <asm/apic.h>
+#include <asm/cpufeatures.h>
 #include <asm/desc.h>
 #include <asm/hypervisor.h>
 #include <asm/idtentry.h>
@@ -29,12 +30,7 @@ static void __init acrn_init_platform(void)
 
 static bool acrn_x2apic_available(void)
 {
-	/*
-	 * x2apic is not supported for now. Future enablement will have to check
-	 * X86_FEATURE_X2APIC to determine whether x2apic is supported in the
-	 * guest.
-	 */
-	return false;
+	return boot_cpu_has(X86_FEATURE_X2APIC);
 }
 
 static void (*acrn_intr_handler)(void);

base-commit: 48778464bb7d346b47157d21ffde2af6b2d39110
-- 
2.28.0

