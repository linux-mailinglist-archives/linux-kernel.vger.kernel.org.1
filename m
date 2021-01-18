Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABFE2FA53C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406048AbhARPxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389885AbhARPwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:52:49 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC863C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:52:08 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id h10so10410594pfo.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0pDSU6bAYm4v0S5tyvU/TnzjGcaf+2G3ePumYZ4Xdo8=;
        b=j/XoMmnZ9J74SKF7Rh1xKqcu6i3ZGt2B436LoUKt09f4LmZpVAurdYxtiOpY1iEQmo
         kas9x0d7DtJV/BHc9+RelJTSdeGGccCSNMD8HFMuYz82SOwJsLCD3IVTE4Vc5Fi+41/W
         siLtR2jUO5Zp6Hw41DuhYPSxf+uCpzO3HkQK2TORksvGWHtcGm72S+7LHxQZTCnIl9d1
         lG2TLU7KQ7yQIHQyZEazDOoPEEhC7jjWQA3dMvKTuVtC3eH5Dx2nQlPPoQ9CwCMHOzIy
         rRcmDUfYzCqoMm2gB8ZimtcfjqufJa+IysuX50yzDwRc1RdkZv/RBAK68LbngZxB+9Ga
         gRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0pDSU6bAYm4v0S5tyvU/TnzjGcaf+2G3ePumYZ4Xdo8=;
        b=P+ig+mL5sQboxB8K6EfHeop5JFJk6A/CxQWvBRHVhWVEmQ9GkbJLtNIsFdEibxpYiS
         snNVvNtVtnx2J/XN4LV7922LS71vzN5hf9dDQPvmcrmR+yEUqP8p07T4KzMXPfn2UIEY
         X5t7XRAqCFEdDK95bIKr3dgdjQ++seoJ8ocDm8y2K3nCEYHoE4cPSakPFq4uP75ceAd6
         x2HlqRLce9nHJIZKwj6HLsHT0yn8EFbr0F4zIPNkn4NAdsrH4//ealfsyKJpDK7P3iKF
         UeqDLMzanEeQlFKjBv9hs6IFu5uzyVoGTegc+ebHVsncD5PpNj1osz0GELRSofulVS0D
         k0xw==
X-Gm-Message-State: AOAM530QpgaYoGAQhS/acrAy943eGh9kbRRFo7CSOXx/qumsX+E+zjDu
        xxrdxAXM+NDilJR3B5Fjdlko
X-Google-Smtp-Source: ABdhPJzk1yrGmfK+11mlAOIA0fnH5Z/XUKpI9fHxGn6Ovb2G1Th7pDE2zCXpeNWa09azG69ybYm9uA==
X-Received: by 2002:a62:6d06:0:b029:1a8:4d3f:947a with SMTP id i6-20020a626d060000b02901a84d3f947amr241920pfc.6.1610985128193;
        Mon, 18 Jan 2021 07:52:08 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6d10:e0cf:bf2b:fc5e:cb6d:136])
        by smtp.gmail.com with ESMTPSA id d133sm15776543pfd.6.2021.01.18.07.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 07:52:07 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linux@armlinux.org.uk, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] ARM: kernel: Fix interrupted SMC calls
Date:   Mon, 18 Jan 2021 21:21:53 +0530
Message-Id: <20210118155153.21520-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Qualcomm ARM32 platforms, the SMC call can return before it has
completed. If this occurs, the call can be restarted, but it requires
using the returned session ID value from the interrupted SMC call.

The ARM32 SMCC code already has the provision to add platform specific
quirks for things like this. So let's make use of it and add the
Qualcomm specific quirk (ARM_SMCCC_QUIRK_QCOM_A6) used by the QCOM_SCM
driver.

This change is similar to the below one added for ARM64 a while ago:
commit 82bcd087029f ("firmware: qcom: scm: Fix interrupted SCM calls")

Without this change, the Qualcomm ARM32 platforms like SDX55 will return
-EINVAL for SMC calls used for modem firmware loading and validation.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/kernel/asm-offsets.c |  3 +++
 arch/arm/kernel/smccc-call.S  | 12 +++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index a1570c8bab25..2e2fa6fc2d4f 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -23,6 +23,7 @@
 #include <asm/vdso_datapage.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <linux/kbuild.h>
+#include <linux/arm-smccc.h>
 #include "signal.h"
 
 /*
@@ -147,6 +148,8 @@ int main(void)
   DEFINE(SLEEP_SAVE_SP_PHYS,	offsetof(struct sleep_save_sp, save_ptr_stash_phys));
   DEFINE(SLEEP_SAVE_SP_VIRT,	offsetof(struct sleep_save_sp, save_ptr_stash));
 #endif
+  DEFINE(ARM_SMCCC_QUIRK_ID_OFFS,	offsetof(struct arm_smccc_quirk, id));
+  DEFINE(ARM_SMCCC_QUIRK_STATE_OFFS,	offsetof(struct arm_smccc_quirk, state));
   BLANK();
   DEFINE(DMA_BIDIRECTIONAL,	DMA_BIDIRECTIONAL);
   DEFINE(DMA_TO_DEVICE,		DMA_TO_DEVICE);
diff --git a/arch/arm/kernel/smccc-call.S b/arch/arm/kernel/smccc-call.S
index 00664c78faca..e1ab00b8244b 100644
--- a/arch/arm/kernel/smccc-call.S
+++ b/arch/arm/kernel/smccc-call.S
@@ -3,7 +3,9 @@
  * Copyright (c) 2015, Linaro Limited
  */
 #include <linux/linkage.h>
+#include <linux/arm-smccc.h>
 
+#include <asm/asm-offsets.h>
 #include <asm/opcodes-sec.h>
 #include <asm/opcodes-virt.h>
 #include <asm/unwind.h>
@@ -27,10 +29,18 @@ UNWIND(	.fnstart)
 UNWIND(	.save	{r4-r7})
 	ldm	r12, {r4-r7}
 	\instr
+	mov	r9, r6			// Copy r6 before popping from stack
 	pop	{r4-r7}
 	ldr	r12, [sp, #(4 * 4)]
 	stm	r12, {r0-r3}
-	bx	lr
+	ldr	r10, [sp, #20]
+	cmp	r10, #0
+	beq	1f			// No quirk structure
+	ldr     r11, [r10, #ARM_SMCCC_QUIRK_ID_OFFS]
+	cmp     r11, #ARM_SMCCC_QUIRK_QCOM_A6
+	bne	1f			// No quirk present
+	str	r9, [r10, #ARM_SMCCC_QUIRK_STATE_OFFS]
+1:	bx	lr
 UNWIND(	.fnend)
 	.endm
 
-- 
2.25.1

