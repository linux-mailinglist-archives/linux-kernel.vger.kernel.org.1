Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E83E2A6CE9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbgKDSh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732573AbgKDShZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:37:25 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6468C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:37:24 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id d142so3351293wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D2iY/f0Emp/4ip0BhAwKDaO2Rz6fYg/GzmDoqFEl2bY=;
        b=K5lok9pXB0Y/9UmYflOIZMDSkGGd3u23Q2HOsAtpB2GQgdWbczb37MrT+zOkXv17wT
         XLC9vOedqgdzZukxYXUCfWK/KmpoLoHZtcqTjOfbzpJCWVRhTNn0OILGLegfnc3HNByb
         EiNdcjUUM9WM0ul/8L3ypEWnLJH522G2M/Whv3nq2waX0fzH+tavrd5hfyBwCWZ47rIH
         M/e50E9Agk8EUpEMjPxiQU7m7K6l6KIaF84T3dfGn48L0baNZQrBvimX4U882V+fCi24
         OWGZhINKWlBuvULKaAafjWdNi+d8GRiezt45uezGFm5E9OxwAXUa2w/uxQNhsQbs+D1U
         3Czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D2iY/f0Emp/4ip0BhAwKDaO2Rz6fYg/GzmDoqFEl2bY=;
        b=FC5cp1fMcw13cLX1nRlqwh6oPzMEXgUxIOGaCvhdGAD1jnKxjbWQji2ohiHe5IYRK3
         F/Ut52l0SExIcvFO+sreMarloW1E8mm9ivwduBTXE778yn50Allp0xWJrKfSpEAaKHOf
         Cvil6rYuHTB4DBLDux07gdwC0yBv64dy23y/MPiilZX1i4ayVNBZf2/ATsFtJf9L6O12
         lGu6GhBlUS2QVNCSbesSm5gVlIWdfILtxwyJS29sHKJDdcQUnXOt/CsjgGNdVQPVlIPb
         KTyCwFFwdY51Q3UmgRWB0/pFrSElwZwO2/4LrzVqdwsxfQEWPFCl+Czcx59EAnHwa0mm
         XOvw==
X-Gm-Message-State: AOAM5332hdu2vVi/C+xnIhhQ799TNFqebb5j43PWL6WWR5WWEZJlLA4g
        jc+mGTNlIm2SrTs9uRCmlobvLTqU1uavh5cF
X-Google-Smtp-Source: ABdhPJxUC4D2whchkuH0BO+rZJkzPCz7MjPZCo5o94FSQjlFtlPHCIT/1kpZb8MvemUgYYaqMdixvg==
X-Received: by 2002:a1c:b487:: with SMTP id d129mr6273792wmf.38.1604515043233;
        Wed, 04 Nov 2020 10:37:23 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id d3sm1049184wrg.16.2020.11.04.10.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:37:22 -0800 (PST)
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
Subject: [RFC PATCH 21/26] kvm: arm64: Add function to enter host from KVM nVHE hyp code
Date:   Wed,  4 Nov 2020 18:36:25 +0000
Message-Id: <20201104183630.27513-22-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All nVHE hyp code is currently executed as handlers of host's HVCs. This
will change as nVHE starts intercepting host's PSCI CPU_ON SMCs. The
newly booted CPU will need to initialize EL2 state and then enter the
host. Add __host_enter function that branches into the existing
host state-restoring code after the trap handler would have returned.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/host.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index ed27f06a31ba..ff04d7115eab 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -41,6 +41,7 @@ SYM_FUNC_START(__host_exit)
 	bl	handle_trap
 
 	/* Restore host regs x0-x17 */
+__host_enter_restore_full:
 	ldp	x0, x1,   [x29, #CPU_XREG_OFFSET(0)]
 	ldp	x2, x3,   [x29, #CPU_XREG_OFFSET(2)]
 	ldp	x4, x5,   [x29, #CPU_XREG_OFFSET(4)]
@@ -63,6 +64,14 @@ __host_enter_without_restoring:
 	sb
 SYM_FUNC_END(__host_exit)
 
+/*
+ * void __noreturn __host_enter(struct kvm_cpu_context *host_ctxt);
+ */
+SYM_FUNC_START(__host_enter)
+	mov	x29, x0
+	b	__host_enter_restore_full
+SYM_FUNC_END(__host_enter)
+
 /*
  * void __noreturn __hyp_do_panic(bool restore_host, u64 spsr, u64 elr, u64 par);
  */
-- 
2.29.1.341.ge80a0c044ae-goog

