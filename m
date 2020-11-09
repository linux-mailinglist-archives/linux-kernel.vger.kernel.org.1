Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873292AB73B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgKILgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729553AbgKILdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:33:07 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB16C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:33:05 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 23so5250171wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YdG01yv5L5aUOCAWsL0c1AI2VybNbkzT+FglMLEKPUc=;
        b=VscquQxnoFwls/oqHCEPpTF7SsklW2SmI3fLE1F5tN+dxJgy3126pQhYRhyWkGvJIp
         KRmeP24h8deaDxwtzjlMieLgmBUlFsjhUi2pn0JMhw4TjUrc/7yP3r+3yL0UJpi61Vyd
         hG1vant3CV08pg/Sz0fn+TUu3AYvp0ZsSrk0b5+H/QLxcLfAZsX3iI/aGB3XEbW0tpDa
         /1+EhkRGYmrcDHK6NRYGxx9rztUPZiXN/BvdGNLPpnekFtzi9eAtwHElENEJD3a07VHU
         ospDdFOtyypJeJSVppNpzOmBV1BYsT7xmGdDkoNgLrrtu3ByjGzeJulL64nvB0vqtcBG
         OXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YdG01yv5L5aUOCAWsL0c1AI2VybNbkzT+FglMLEKPUc=;
        b=IMMkYwpcZEn9hzqLLWeK/4H2OO8IcONCRFsLPT45I4fg54apq3Gnxpxancc7eRE3zj
         0FwMSLTQ6HU3B58HpndvpuO4iS6g99zjHil3o8GnmhbxlkSQPfa8hBwBIfREPI6XKZ5f
         O8bCBXGVPEKb12zeVbcpgWs1qZShhPhSZsBru0KPX6tJc03rj8t4eZSsm1GhykLMw3BI
         Mk6cwgzVwZ/rvjMvULX58RJ7lUi0tkXxMGy32s82+C9+RaX/5zQI3MCTlUo6hX5WQ++C
         D6yu2gUDYxI0tPT5Zk/MfMLGVX+EMMKv+nN+oxxlZ+0bmlGdHW9ars07DsP3LZO+PS9F
         58Pw==
X-Gm-Message-State: AOAM531Jsu6uACu2dvrsUcF/LzbSNw8/NWyioaLBUMoGqfKDIQqlcw9w
        1Fctbgry7m+0xfWGHs/Zc69uaw==
X-Google-Smtp-Source: ABdhPJzK69A1Q7likl7qMwl1Im0ltc4/Nfe7H1rxArIqrin2R1yRgaBVm6eGs7AcogdA8AWyKibl5A==
X-Received: by 2002:a1c:e345:: with SMTP id a66mr13968140wmh.188.1604921584566;
        Mon, 09 Nov 2020 03:33:04 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id d2sm12884700wrq.34.2020.11.09.03.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:33:03 -0800 (PST)
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
Subject: [PATCH v1 12/24] kvm: arm64: Extract __do_hyp_init into a helper function
Date:   Mon,  9 Nov 2020 11:32:21 +0000
Message-Id: <20201109113233.9012-13-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
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
index 6f3ac5d428ec..1697d25756e9 100644
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
 
-	ldr	x0, [x1, #NVHE_INIT_STACK_PTR]
-	mov	sp, x0
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
+	ldr	x1, [x0, #NVHE_INIT_STACK_PTR]
+	mov	sp, x1
 
-	ldr	x0, [x1, #NVHE_INIT_VECTOR_PTR]
-	msr	vbar_el2, x0
+	ldr	x1, [x0, #NVHE_INIT_VECTOR_PTR]
+	msr	vbar_el2, x1
 
-	ldr	x1, [x1, #NVHE_INIT_PGD_PTR]
+	ldr	x1, [x0, #NVHE_INIT_PGD_PTR]
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
2.29.2.222.g5d2a92d10f8-goog

