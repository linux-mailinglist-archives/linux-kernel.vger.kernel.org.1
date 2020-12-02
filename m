Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51F82CC5A0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389574AbgLBSnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387950AbgLBSn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:43:28 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B1BC0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:42:11 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so11092459wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C6am4hqHGk+Vo0ud1IP29/X2lpqX4cUlMBiGKiun4f8=;
        b=hoQt5BzIWgY7qXX3fYCd3gye89dvXes5OcxZR1oaFHiJQ0uNuctf0EfXcXsXQqJZHi
         lyMsVJArQ0COsJ3V461k6nveoLNzCLiKZbAL5LUSG4DkZ0mZ4TD+7GR+bvNwn6Oztk+b
         junmL8dzKUi31Dphr3YG92zBLKleqoCJLPlvFxbGeHyYhHq5d6poYXr1fCeGHotQtBSR
         HE+mkv/OIjfKLvHevZZVRrqv3+kaP8yMimI6sQpItNZb7BDN+1luqcdtgtiTsgiqIFoE
         bB/s2tgV4B1tzXzOp8LoYqmDeZbINdCG9fd4QhlOCkBE+gk5X9QdHlI8qQkX3t6UKEwH
         0a9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C6am4hqHGk+Vo0ud1IP29/X2lpqX4cUlMBiGKiun4f8=;
        b=Cw/ygCNOruBVd/FEdKWUP03tZuAdkMAE1k6aXRcCiA95TVsbzUgv1CgyY7cpE1m0UH
         ADqfhjnwSgOfk+eL3mTHxHHEHHnWq4zKR8IHUXHlLcMZH9VDk/43uYCOi5+tek/F/Jfw
         asw2XJJHNXQz9lycgvynzvzny1Z34nUiE8cTSXWuHhlD8SADK1Rq6icJIfneUOgT0u1K
         cIjkL1JvL7yL2XWWQWeadrN66SAbMn2iSnDdpL7hvmlA2GJOxGvREPjNV6dUhdor3pUY
         aDKflS5tST5qJ0kEM73a9jm6HAuncWCbp5PYW4yNq9JrWks5BUEr7Mw5CB1vCDwIA/P5
         aHHw==
X-Gm-Message-State: AOAM532uVVGJjEPlCuLWa05MBJJt2JOQfqIvaRpooqevvTSJuxBQba9n
        ejKYT0Hrpoio3SrAqejjoxUcSw==
X-Google-Smtp-Source: ABdhPJzQrJ/LWyt16hrvnyOSjGz1ckoWGV76pEesTOfeJNYR/dIM8PSyGIBinNhf3COj/w3pWBottw==
X-Received: by 2002:a7b:ce17:: with SMTP id m23mr4554470wmc.117.1606934530064;
        Wed, 02 Dec 2020 10:42:10 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:5ddd:b7c5:e3c9:e87a])
        by smtp.gmail.com with ESMTPSA id y20sm3136706wma.15.2020.12.02.10.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:42:08 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v4 19/26] kvm: arm64: Extract __do_hyp_init into a helper function
Date:   Wed,  2 Dec 2020 18:41:15 +0000
Message-Id: <20201202184122.26046-20-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202184122.26046-1-dbrazdil@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding a CPU entry point in nVHE hyp code, extract
most of __do_hyp_init hypervisor initialization code into a common
helper function. This will be invoked by the entry point to install KVM
on the newly booted CPU.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 47 ++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index 712f57289357..b0856b006bc0 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -68,17 +68,36 @@ __do_hyp_init:
 	mov	x0, #SMCCC_RET_NOT_SUPPORTED
 	eret
 
-1:	ldr	x0, [x1, #NVHE_INIT_TPIDR_EL2]
-	msr	tpidr_el2, x0
+1:	mov	x0, x1
+	mov	x4, lr
+	bl	___kvm_hyp_init
+	mov	lr, x4
 
-	ldr	x0, [x1, #NVHE_INIT_MAIR_EL2]
-	msr	mair_el2, x0
+	/* Hello, World! */
+	mov	x0, #SMCCC_RET_SUCCESS
+	eret
+SYM_CODE_END(__kvm_hyp_init)
+
+/*
+ * Initialize the hypervisor in EL2.
+ *
+ * Only uses x0..x3 so as to not clobber callee-saved SMCCC registers
+ * and leave x4 for the caller.
+ *
+ * x0: struct kvm_nvhe_init_params PA
+ */
+SYM_CODE_START_LOCAL(___kvm_hyp_init)
+	ldr	x1, [x0, #NVHE_INIT_TPIDR_EL2]
+	msr	tpidr_el2, x1
+
+	ldr	x1, [x0, #NVHE_INIT_STACK_HYP_VA]
+	mov	sp, x1
 
-	ldr	x0, [x1, #NVHE_INIT_STACK_HYP_VA]
-	mov	sp, x0
+	ldr	x1, [x0, #NVHE_INIT_MAIR_EL2]
+	msr	mair_el2, x1
 
-	ldr	x0, [x1, #NVHE_INIT_PGD_PA]
-	phys_to_ttbr x2, x0
+	ldr	x1, [x0, #NVHE_INIT_PGD_PA]
+	phys_to_ttbr x2, x1
 alternative_if ARM64_HAS_CNP
 	orr	x2, x2, #TTBR_CNP_BIT
 alternative_else_nop_endif
@@ -87,9 +106,9 @@ alternative_else_nop_endif
 	/*
 	 * Set the PS bits in TCR_EL2.
 	 */
-	ldr	x0, [x1, #NVHE_INIT_TCR_EL2]
-	tcr_compute_pa_size x0, #TCR_EL2_PS_SHIFT, x1, x2
-	msr	tcr_el2, x0
+	ldr	x1, [x0, #NVHE_INIT_TCR_EL2]
+	tcr_compute_pa_size x1, #TCR_EL2_PS_SHIFT, x2, x3
+	msr	tcr_el2, x1
 
 	isb
 
@@ -117,10 +136,8 @@ alternative_else_nop_endif
 	kimg_hyp_va x0, x1
 	msr	vbar_el2, x0
 
-	/* Hello, World! */
-	mov	x0, #SMCCC_RET_SUCCESS
-	eret
-SYM_CODE_END(__kvm_hyp_init)
+	ret
+SYM_CODE_END(___kvm_hyp_init)
 
 SYM_CODE_START(__kvm_handle_stub_hvc)
 	cmp	x0, #HVC_SOFT_RESTART
-- 
2.29.2.454.gaff20da3a2-goog

