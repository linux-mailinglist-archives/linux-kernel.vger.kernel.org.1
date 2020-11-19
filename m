Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AA42B9E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgKSXhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:37:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:7299 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbgKSXhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:37:06 -0500
IronPort-SDR: F5PIjiMfrKJ5gTI2uFBDOS1fcnA+TGTpJZRuwXKp2bSdemh1O9HusN+3MVlGodOK0zogP5cuW2
 23LQsEA517gg==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="171552665"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="171552665"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 15:37:04 -0800
IronPort-SDR: TWA5k5aE213v1LxAgBTwcaiMSOChMn5F19x0DMK/OhyGDS9QCcPVJpR152DHFd2FWwaQ3UQjSn
 n6o+E4qp85kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="431392249"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2020 15:37:03 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v2 19/22] x86/fpu/amx: Enable the AMX feature in 64-bit mode
Date:   Thu, 19 Nov 2020 15:32:54 -0800
Message-Id: <20201119233257.2939-20-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119233257.2939-1-chang.seok.bae@intel.com>
References: <20201119233257.2939-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 64-bit mode, include the AMX state components in
XFEATURE_MASK_USER_SUPPORTED.

The XFD feature will be used to dynamically allocate per-task XSAVE
buffer on first use.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/fpu/xstate.h | 3 ++-
 arch/x86/kernel/fpu/init.c        | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index d2ad69230d0e..1544a874b748 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -34,7 +34,8 @@
 				      XFEATURE_MASK_Hi16_ZMM	 | \
 				      XFEATURE_MASK_PKRU | \
 				      XFEATURE_MASK_BNDREGS | \
-				      XFEATURE_MASK_BNDCSR)
+				      XFEATURE_MASK_BNDCSR | \
+				      XFEATURE_MASK_XTILE)
 
 /* All currently supported supervisor features */
 #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID)
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 5e217bd6e85a..954ac4f0f761 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -228,8 +228,12 @@ static void __init fpu__init_system_xstate_size_legacy(void)
  */
 u64 __init fpu__get_supported_xfeatures_mask(void)
 {
-	return XFEATURE_MASK_USER_SUPPORTED |
-	       XFEATURE_MASK_SUPERVISOR_SUPPORTED;
+	u64 mask = XFEATURE_MASK_USER_SUPPORTED | XFEATURE_MASK_SUPERVISOR_SUPPORTED;
+
+	if (!IS_ENABLED(CONFIG_X86_64))
+		mask &= ~(XFEATURE_MASK_XTILE);
+
+	return mask;
 }
 
 /* Legacy code to initialize eager fpu mode. */
-- 
2.17.1

