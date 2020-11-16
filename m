Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8ED2B5307
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbgKPUoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387795AbgKPUn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:43:58 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA8DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:58 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id m125so578776wmm.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hQXzDl51KVgbTar8bkfG4D68l5PW6Ptu4C4orihp8eA=;
        b=XxYQjjbQleEihGMa6lBSPLJbnrgLF3MhlG+Qu+TFdEYUkdmG7GgeK76GDetwpVPHY+
         0Wmobxvoo+IcbO5006lnCYMaHKA3+o7cg07Lpw5pUAz79/GiwHnt2YetgapOC++rPmOS
         Ii7mnl9pyeKqz+lDTJCt7JESqOZ2YfL/nSXFqu+xsw7L6Sm3Emeub2G1TELu8hoJmc5B
         2Dwoq3u3cN7OEuCDg7M1/0dYmxeDQgDTPE8yFgyMNBO2bme3lxShcx91uRWRDP0+fpVe
         //VCXI5sWgiT7bRrGjtKa6911fco03WZ3KylE68B5I0VC1px0rU6dKBFWCgbIujqtOUf
         UUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hQXzDl51KVgbTar8bkfG4D68l5PW6Ptu4C4orihp8eA=;
        b=oUMDvGHYbJSvEc3MdpNf9ICn1XRF6tgPDFmbNNzb0QymMuHCip2yJchFIdgX+jKjvn
         5FLdMQMtoWpklIlgPubHpKNagnlH1eYRZlqWPcGjvSycpveVbfSnu3Mmlt3LUz/q8wMN
         5I1Tb67Zn2DwWuj948Msp8eWu4MYmgTFeQG3Tj24V+Dk/7gBU1ryMVZSRYgQH9ywylHc
         mg0aDf8DRak23tPRAG+LriTLIB/2Lc+/G1HsevWlfoT/ph2xIEdzSNFYpryHp27GCyw4
         xW0oaEySpq4FFurCLQ7R5vCX+zn2kYKeJINV8Tnz6Vz7gfmQnKcx96Swat9DEusevDlN
         79Hg==
X-Gm-Message-State: AOAM530OEr987ROiDpLHsCR5FYa5cuFLPy9y5bvShjII9muzqvsUa92x
        YJf3N7qDAkRpuIx59YJ+cMoHQA==
X-Google-Smtp-Source: ABdhPJxTuT2kvs6GtAew3CuJwBuPd4l6HxRhRGRHy6MpC962TpnwI8AZ7XOYLkPXnutxFIpVOB44Fg==
X-Received: by 2002:a1c:bac1:: with SMTP id k184mr713025wmf.76.1605559437094;
        Mon, 16 Nov 2020 12:43:57 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id t11sm18002272wrm.8.2020.11.16.12.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:43:56 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 16/24] kvm: arm64: Extract __do_hyp_init into a helper function
Date:   Mon, 16 Nov 2020 20:43:10 +0000
Message-Id: <20201116204318.63987-17-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
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
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 39 +++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index 67342cc9930f..d4a71ac34254 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -68,16 +68,35 @@ __do_hyp_init:
 	mov	x0, #SMCCC_RET_NOT_SUPPORTED
 	eret
 
-1:	ldr	x0, [x1, #NVHE_INIT_TPIDR_EL2]
-	msr	tpidr_el2, x0
+1:	mov	x0, x1
+	mov	x4, lr
+	bl	___kvm_hyp_init
+	mov	lr, x4
 
-	ldr	x0, [x1, #NVHE_INIT_VECTOR_HYP_VA]
-	msr	vbar_el2, x0
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
+SYM_CODE_START(___kvm_hyp_init)
+	ldr	x1, [x0, #NVHE_INIT_TPIDR_EL2]
+	msr	tpidr_el2, x1
+
+	ldr	x1, [x0, #NVHE_INIT_VECTOR_HYP_VA]
+	msr	vbar_el2, x1
 
-	ldr	x0, [x1, #NVHE_INIT_STACK_HYP_VA]
-	mov	sp, x0
+	ldr	x1, [x0, #NVHE_INIT_STACK_HYP_VA]
+	mov	sp, x1
 
-	ldr	x1, [x1, #NVHE_INIT_PGD_PA]
+	ldr	x1, [x0, #NVHE_INIT_PGD_PA]
 	phys_to_ttbr x0, x1
 alternative_if ARM64_HAS_CNP
 	orr	x0, x0, #TTBR_CNP_BIT
@@ -137,10 +156,8 @@ alternative_else_nop_endif
 	msr	sctlr_el2, x0
 	isb
 
-	/* Hello, World! */
-	mov	x0, #SMCCC_RET_SUCCESS
-	eret
-SYM_CODE_END(__kvm_hyp_init)
+	ret
+SYM_CODE_END(___kvm_hyp_init)
 
 SYM_CODE_START(__kvm_handle_stub_hvc)
 	cmp	x0, #HVC_SOFT_RESTART
-- 
2.29.2.299.gdc1121823c-goog

