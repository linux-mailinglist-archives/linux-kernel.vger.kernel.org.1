Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413CC2808A8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733245AbgJAUnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:43:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:58716 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733078AbgJAUnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:43:18 -0400
IronPort-SDR: D4AT6eYMGM/6LRkAJq0dkfg+8Da6g3PN5HWDwRtFbI2xFXkB7GkkYeaT0PED46Wkvn0n6H4Tzo
 gvruEow0XgLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160170730"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="160170730"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:42:52 -0700
IronPort-SDR: 8hm4fRgfml4S2iIeBVV3o4+ddgFx1LRmMi/RQqbW+6EhVKnRsCqgfZ+42WpD30hYMfPuGWIoGj
 HB407z2LV4tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="351297068"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2020 13:42:52 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [RFC PATCH 14/22] x86/fpu/xstate: Inherit dynamic user state when used in the parent
Date:   Thu,  1 Oct 2020 13:39:05 -0700
Message-Id: <20201001203913.9125-15-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001203913.9125-1-chang.seok.bae@intel.com>
References: <20201001203913.9125-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a new task is created, the kernel copies all the states from the
parent. If the parent already has any dynamic user state in use, the new
task has to expand the XSAVE buffer to save them. Also, disable the
associated first-use fault.

No functional change until the kernel supports dynamic user states.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/fpu/core.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 2e07bfcd54b3..239c7798bc01 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -225,6 +225,7 @@ int fpu__copy(struct task_struct *dst, struct task_struct *src)
 {
 	struct fpu *dst_fpu = &dst->thread.fpu;
 	struct fpu *src_fpu = &src->thread.fpu;
+	unsigned int size;
 
 	dst_fpu->last_cpu = -1;
 
@@ -233,15 +234,26 @@ int fpu__copy(struct task_struct *dst, struct task_struct *src)
 
 	WARN_ON_FPU(src_fpu != &current->thread.fpu);
 
-	/*
-	 * Don't let 'init optimized' areas of the XSAVE area
-	 * leak into the child task:
-	 */
-	memset(&dst_fpu->state.xsave, 0, fpu_kernel_xstate_default_size);
-
-	dst_fpu->state_mask = xfeatures_mask_all & ~xfeatures_mask_user_dynamic;
 	dst_fpu->state_ptr = NULL;
 
+	/* Inherit the dynamic area if the parent already has. */
+	if (src_fpu->state_ptr) {
+		int ret;
+
+		dst_fpu->state_mask = 0;
+		ret = alloc_xstate_area(dst_fpu, src_fpu->state_mask, &size);
+		if (ret)
+			return ret;
+	} else {
+		dst_fpu->state_mask = src_fpu->state_mask & ~xfeatures_mask_user_dynamic;
+		size = fpu_kernel_xstate_default_size;
+		/*
+		 * Don't let 'init optimized' areas of the XSAVE area
+		 * leak into the child task:
+		 */
+		memset(&dst_fpu->state.xsave, 0, size);
+	}
+
 	/*
 	 * If the FPU registers are not current just memcpy() the state.
 	 * Otherwise save current FPU registers directly into the child's FPU
@@ -252,7 +264,7 @@ int fpu__copy(struct task_struct *dst, struct task_struct *src)
 	 */
 	fpregs_lock();
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
-		memcpy(__xstate(dst_fpu), __xstate(src_fpu), fpu_kernel_xstate_default_size);
+		memcpy(__xstate(dst_fpu), __xstate(src_fpu), size);
 
 	else if (!copy_fpregs_to_fpstate(dst_fpu))
 		copy_kernel_to_fpregs(dst_fpu);
-- 
2.17.1

