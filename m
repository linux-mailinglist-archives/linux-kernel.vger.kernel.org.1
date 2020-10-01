Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEF72808A5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbgJAUnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:43:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:58726 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733106AbgJAUnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:43:18 -0400
IronPort-SDR: QBh3gqjuvxmZF32/naBDP4V0QBjPPCXz65qD7p0iqoQxXUa4LLQVzCsBdVCzzBmduP4RJyDfl+
 mLJsoA94GcIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160170743"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="160170743"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:42:53 -0700
IronPort-SDR: kXpWi4238diClXui2pIJljgNehVmCqM5zYseJ10Fjs/2uzEGGJi/BChcsWMK1RuhKkneypEv8y
 Oh9zCzQZ3keg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="351297087"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2020 13:42:53 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [RFC PATCH 20/22] x86/fpu/amx: Enable the AMX feature in 64-bit mode
Date:   Thu,  1 Oct 2020 13:39:11 -0700
Message-Id: <20201001203913.9125-21-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001203913.9125-1-chang.seok.bae@intel.com>
References: <20201001203913.9125-1-chang.seok.bae@intel.com>
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
index aadbcf893cc0..872325768b13 100644
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
 #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (0)
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index ee6499075a89..8e2a77bc1782 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -229,8 +229,12 @@ static void __init fpu__init_system_xstate_size_legacy(void)
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

