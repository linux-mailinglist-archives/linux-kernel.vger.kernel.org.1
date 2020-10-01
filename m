Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E7F2808A0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733173AbgJAUn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:43:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:58726 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733093AbgJAUnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:43:17 -0400
IronPort-SDR: gjR5I/LE9rLNMhePE0577fd0eYkDZjWinp0Epy9bqBz7fBlS3t9EaMvzYSj89eUR6T5hcAh+8p
 Uiy6s464uuVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160170732"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="160170732"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:42:53 -0700
IronPort-SDR: 5NRdxhSyiyobpInTN3xReQ2bCzf61fO1nG6YzwEoTpZ5V06r3SBOl1nhPiagEfkGku5q0O9A8B
 koSDnbu+bvCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="351297075"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2020 13:42:52 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [RFC PATCH 16/22] x86/fpu/xstate: Support dynamic user state in the signal handling path
Date:   Thu,  1 Oct 2020 13:39:07 -0700
Message-Id: <20201001203913.9125-17-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001203913.9125-1-chang.seok.bae@intel.com>
References: <20201001203913.9125-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Entering a signal handler, the kernel saves XSAVE area. The dynamic user
state is better to be saved only when used. fpu->state_mask can help to
exclude unused states.

Returning from signal handler, XRSTOR re-initializes the excluded state
components.

No functional change until the kernel actually supports the dynamic user
states.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/fpu/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index f5dbbaa060fb..fd044b31ce40 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -368,7 +368,7 @@ static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
  */
 static inline int copy_xregs_to_user(struct xregs_state __user *buf)
 {
-	u64 mask = xfeatures_mask_user();
+	u64 mask = current->thread.fpu.state_mask;
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
-- 
2.17.1

