Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2922FA86A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407315AbhARSMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406850AbhARSLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:11:39 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CB5C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 10:10:59 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u4so10337994pjn.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 10:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mOeEBdPivrLRTESI8UsU78b1key2d9wivkYHIjFi1HQ=;
        b=SRvvX6clwPIzZCmoK5B852dtqFYzURkZTDETDOiNKC9WCvItApmb3bwpsYpJ9R77hb
         hTK9hGhikayhd2D4B7fJnyqE7axKtf8UEGFB0lVPWgTSWMXycPpDJXtjBAa050Fpz6Hw
         9KDLDR9P7UdoUOC+advN0r+dE3MMXrBjNBX/0HZDZx7aO5QB7+T4yJZx9z9KqNfLkcCe
         ddSP5ah/kP6Dy2NLBNNAoNquz5ado3NBXYVIzTOJCPeePrgBcJGkkOsgUQG9unQB7t1/
         ZRHeA8QIg+6LM9E5idDMUPiN+x1XvHmjQOxdwIUyOkMrNYuJNE3wKJ66DUVmkiD1FXpn
         ALzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mOeEBdPivrLRTESI8UsU78b1key2d9wivkYHIjFi1HQ=;
        b=Zz2EqGTjyTP3ojnF2G50hKlC3XSFi8inVDV4wQJ1UmwypiYoHNe06p5/BBBLiP8Hvo
         KQmIZzoGaI3u9Bfr8iYfBBjh5W3WSrqGc2tvqS0Ifai61s+kBEmo+7TgRU3foQ8IuZKp
         lqB+T4LLgMAByh2rQ9EQhfxzl2hi0x2DhPhl85SG8fV1H296xNeuglMhlwiPvJq6SFg2
         D/iApu0AJ0Eshwg3+8geB3vrCeoj/+6JEqwF0ms9qka1r0hkAHmhfEAYgk7jYsV0GG6D
         u1H6pddehK6e6MjvMOKZlESb+AzcD3UtuPaS0ZPppm5RxPL3CvYP/B1RaNx8vNKtkgc+
         pWsA==
X-Gm-Message-State: AOAM532aVQ1Z9Zm7kGfbrMndog2a+Xo+eECKBzYQUPGg0UdG4XwFMJ3U
        lXW0zk1iMgZ9PH9tZVdLycbN
X-Google-Smtp-Source: ABdhPJyiYiIdO1xvfBnwfb92PNL9TNxSmGQrZxKFZmhnYL4psIaLQHtwG9BJWFZvb2L9AIvjfJ/dIg==
X-Received: by 2002:a17:90a:4494:: with SMTP id t20mr513625pjg.155.1610993458566;
        Mon, 18 Jan 2021 10:10:58 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6d10:e0cf:bf2b:fc5e:cb6d:136])
        by smtp.gmail.com with ESMTPSA id x14sm16628569pfp.77.2021.01.18.10.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 10:10:57 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linux@armlinux.org.uk, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2] ARM: kernel: Fix interrupted SMC calls
Date:   Mon, 18 Jan 2021 23:40:40 +0530
Message-Id: <20210118181040.51238-1-manivannan.sadhasivam@linaro.org>
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

Changes in v2:

* Preserved callee saved registers and used the registers r4, r5 which
  are getting pushed onto the stack.

 arch/arm/kernel/asm-offsets.c |  3 +++
 arch/arm/kernel/smccc-call.S  | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

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
index 00664c78faca..931df62a7831 100644
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
@@ -27,7 +29,14 @@ UNWIND(	.fnstart)
 UNWIND(	.save	{r4-r7})
 	ldm	r12, {r4-r7}
 	\instr
-	pop	{r4-r7}
+	ldr	r4, [sp, #36]
+	cmp	r4, #0
+	beq	1f			// No quirk structure
+	ldr     r5, [r4, #ARM_SMCCC_QUIRK_ID_OFFS]
+	cmp     r5, #ARM_SMCCC_QUIRK_QCOM_A6
+	bne	1f			// No quirk present
+	str	r6, [r4, #ARM_SMCCC_QUIRK_STATE_OFFS]
+1:	pop	{r4-r7}
 	ldr	r12, [sp, #(4 * 4)]
 	stm	r12, {r0-r3}
 	bx	lr
-- 
2.25.1

