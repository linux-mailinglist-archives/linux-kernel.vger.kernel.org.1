Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CE22A6CEF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732634AbgKDShx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732556AbgKDShU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:37:20 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2371DC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:37:20 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id e6so5905355wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lntpB9k/GNt3DHKTS6XU+Lzi+3feR2/TDoLFam5OEsI=;
        b=C7k/+8DYRMsN5av0hh1p2auJO+TujqPhkBo9BQOirCYTD1fGH4MKjmZ90c5bMU7Dvs
         7iXLOCA5XTk7X+s6+G/FADEg1vlFiJNnSKQpNHFzsfJuI/egt0VB2R4bGqay6pSEtMzV
         mugN96IDPyJUl9J8nZJmCNxxPlcS7q0g1lFjISxMbqwVf9hoORqeGPgKxbvioXh+Gz1z
         LKEVEAz2BDBUn3fCSiGXaFJKOrRpL0Tc+GLucbHuJ/FMZdaIvRy4x7frQIOcGnejA6Lw
         PAlCYBfM7fvOkTtGmNbT8j+d/lf3B55XUIwrtUiNVEb55mNzk9xPRhDXqT+vgc88HxfL
         Zb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lntpB9k/GNt3DHKTS6XU+Lzi+3feR2/TDoLFam5OEsI=;
        b=pPWdfGAbJtJg6YJawbyiFQrORF1jZVoNunXbk/wo5Lha2bdJndYwRfjF6RQpKthiSn
         UyXDyRB6F5ewgBrOjDJXINOrxQx27tbIMS3Sdas7WwUviuj2G7hBnORpYV1g3kempctm
         QGBBHUuJ353vYiXzPY2bQ/NOdv6fjgPP9xZ7Pcu8GJXSoBRgCqjIpwR2C8Egx9XZGrbp
         xP3GrQ2mE1XjWscJeY2fZX8H9QV+SJIz0g9jo6NttuiDGmWJR9aXlnGNgLkX7aZ0pKDz
         U7puUUp/tB488c2x68dmjvBPQK7HiCEGS+LCDb48bPLj1H679EnecO5WeRUuWKy1gt+P
         VVhA==
X-Gm-Message-State: AOAM5302kPfU5WfPfjEJQyXvB5WySAoFhUijxEK1m6bkV8Lp0h/IjOmV
        zrug7Z5T7GkDTj1oS4bvm1xTfA==
X-Google-Smtp-Source: ABdhPJzp3ZjoC9LnEvi+UKHAL909ZKm0IHo36bHGz5PnMfBxU0GoHEvnmkwHDRi5tS6FA8eyTXdSfQ==
X-Received: by 2002:adf:f104:: with SMTP id r4mr33995916wro.202.1604515038644;
        Wed, 04 Nov 2020 10:37:18 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id r1sm3905404wro.18.2020.11.04.10.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:37:17 -0800 (PST)
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
        Andrew Scull <ascull@google.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [RFC PATCH 19/26] kvm: arm64: Extract __do_hyp_init into a helper function
Date:   Wed,  4 Nov 2020 18:36:23 +0000
Message-Id: <20201104183630.27513-20-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
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
index 6f3ac5d428ec..1726cc44b3ee 100644
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
+ * Only modifies x0..x3 so as to not clobber callee-saved SMCCC registers
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
2.29.1.341.ge80a0c044ae-goog

