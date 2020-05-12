Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281F31CF800
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 16:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgELOza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 10:55:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:29539 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730411AbgELOzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:55:12 -0400
IronPort-SDR: MF+rmYGRC+dONSs+Vi17H+Pu5DvRqEkFUTBIqZOmCm8D73MC0kwUWV8Jnkm9gq7dK+lF+a67dP
 ol6+44yLagnQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 07:55:09 -0700
IronPort-SDR: 5BGt1Er0IEtYNiIdToDY6IItbQ969MpoNCRYRf5kJhQEEVwL8hvJwMQ8ky5czNTWq9AzNYRJ+f
 peoXAgVRONWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,384,1583222400"; 
   d="scan'208";a="371587823"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga001.fm.intel.com with ESMTP; 12 May 2020 07:55:08 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v4 07/10] x86/fpu/xstate: Update copy_kernel_to_xregs_err() for XSAVES supervisor states
Date:   Tue, 12 May 2020 07:54:41 -0700
Message-Id: <20200512145444.15483-8-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200512145444.15483-1-yu-cheng.yu@intel.com>
References: <20200512145444.15483-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function copy_kernel_to_xregs_err() uses XRSTOR, which can work with
standard or compacted format without supervisor xstates.  However, when
supervisor xstates are present, XRSTORS must be used.  Fix it by using
XRSTORS when XSAVES is enabled.

I also considered if there were additional cases where XRSTOR might be
mistakenly called instead of XRSTORS.  There are only three XRSTOR sites
in kernel:

1. copy_kernel_to_xregs_booting(), already switches between XRSTOR and
   XRSTORS based on X86_FEATURE_XSAVES.
2. copy_user_to_xregs(), which *needs* XRSTOR because it is copying from
   userspace and must never copy supervisor state with XRSTORS.
3. copy_kernel_to_xregs_err() mistakenly used XRSTOR only.  Fixed it.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/include/asm/fpu/internal.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index a42fcb4b690d..42159f45bf9c 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -400,7 +400,10 @@ static inline int copy_kernel_to_xregs_err(struct xregs_state *xstate, u64 mask)
 	u32 hmask = mask >> 32;
 	int err;
 
-	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
+	if (static_cpu_has(X86_FEATURE_XSAVES))
+		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
+	else
+		XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
 
 	return err;
 }
-- 
2.21.0

