Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615332A6CEC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732618AbgKDShh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732605AbgKDShe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:37:34 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81ACC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:37:33 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id e6so5906070wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iZCBnLMJdYcxZwBzQ3Sarf0ddb9E9I/tpQ6NvhqLTsI=;
        b=B4IhEM6i7eYAD2ymU3gP34oS4vn1E/wZkt1PdaiPM5/5CtTpRosOvwsKQKo0X96cCK
         0+g8w1fiydBxSAvZustLDS0jWbYdNwVoVeSGiVp01VErE+3NmXu2Zguj4zhDd3RQwoNG
         en6FWwAw0dLaqo1BuTfum7Ta4FxBg0BjZWLF6bqxR53vkiKPlHv0os4fdHkCfVcSOUha
         CL9qYevzyEmHuWS9pBv5RwzPROVRKDWww8V+k967+KldgQKur4GRkaO8J8q5SOBxRSpK
         YvVewWO1VZib5H/HpCQ7HbmNXpRdZWPNttE3mKM8sUogeVrex2BX1GvjsLxVqnF1JotD
         ALOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iZCBnLMJdYcxZwBzQ3Sarf0ddb9E9I/tpQ6NvhqLTsI=;
        b=aQA3WNywWJ8TxToqt1q6uumCuh5CxX00ZpZDXqC3jNXeFnEvOLCfCEputPDpkx1DZT
         mfrjdT6fFCdxkFNFrfSTCbt1/DL+cYSf1hVpRP6kz4cZF1ZzhK1nc75vx4Ld1iJnbLT/
         D/bA3lNIMW00fISVEhMoy6lwuuzUGW9hiiWGtVlpG1MpD8n5umeEnc4tK22y4BIbV/6o
         ppYNdDRBFdwSPHBeMIt99zPMoe6GCsIt4cnLFH78wLce3zWvZJkLSXnGZkrKxFWR4eNs
         Tw1AX2W3g5XuVoudf+on4MWJT5NVMf26ycmAIfbrxCF5tK89GSG8X0qVWiSN1CVnvsqC
         v/Dw==
X-Gm-Message-State: AOAM533e7/qbjH3HM58B9jc4wS8/txCYWM6R2yTl0trZNGBFdvHgGN/F
        YE2AQLFNdpXUUen/8OkFbVWKMQ==
X-Google-Smtp-Source: ABdhPJwUdVDMguoQlzBKa3UHyXk6rhVG7P6EPtc5ja0S5UDbXD4NiQS5VqgFkkGyhfeVbjM4nCuCpA==
X-Received: by 2002:adf:fe48:: with SMTP id m8mr33208177wrs.127.1604515052352;
        Wed, 04 Nov 2020 10:37:32 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id r10sm3396829wmg.16.2020.11.04.10.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:37:31 -0800 (PST)
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
Subject: [RFC PATCH 25/26] kvm: arm64: Trap host SMCs
Date:   Wed,  4 Nov 2020 18:36:29 +0000
Message-Id: <20201104183630.27513-26-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While nVHE KVM is installed, start trapping all host SMCs. By default,
these are simply forwarded to EL3, but PSCI SMCs are validated first.

Create new constant HCR_HOST_NVHE_STUB_FLAGS with the old set of HCR
flags to use before the nVHE vector is installed or when switching back
to stub vector.

Extend HCR_HOST_NVHE_FLAGS to contain HCR_TSC. Set HCR_EL2 to it before
installing nVHE vector.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_arm.h   | 3 ++-
 arch/arm64/kernel/head.S           | 2 +-
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 6 ++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 64ce29378467..04b862955f32 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -79,7 +79,8 @@
 			 HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
 			 HCR_FMO | HCR_IMO | HCR_PTW )
 #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
-#define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK | HCR_ATA)
+#define HCR_HOST_NVHE_STUB_FLAGS (HCR_RW | HCR_API | HCR_APK | HCR_ATA)
+#define HCR_HOST_NVHE_FLAGS (HCR_HOST_NVHE_STUB_FLAGS | HCR_TSC)
 #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
 
 /* TCR_EL2 Registers bits */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index e7270b63abed..ea17413a04e0 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -522,7 +522,7 @@ SYM_FUNC_START(el2_setup)
 #endif
 
 SYM_INNER_LABEL(el2_setup_nvhe, SYM_L_LOCAL)
-	mov_q	x0, HCR_HOST_NVHE_FLAGS
+	mov_q	x0, HCR_HOST_NVHE_STUB_FLAGS
 	msr	hcr_el2, x0
 	isb
 
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index dd297a1a8f82..97684deba6c1 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -88,6 +88,10 @@ SYM_CODE_END(__kvm_hyp_init)
  * x0: struct kvm_nvhe_init_params PA
  */
 SYM_CODE_START(___kvm_hyp_init)
+	mov_q	x1, HCR_HOST_NVHE_FLAGS
+	msr	hcr_el2, x1
+	isb
+
 	ldr	x1, [x0, #NVHE_INIT_TPIDR_EL2]
 	msr	tpidr_el2, x1
 
@@ -220,6 +224,8 @@ reset:
 	bic	x5, x5, x6		// Clear SCTL_M and etc
 	pre_disable_mmu_workaround
 	msr	sctlr_el2, x5
+	mov_q	x5, HCR_HOST_NVHE_STUB_FLAGS
+	msr	hcr_el2, x5
 	isb
 
 	/* Install stub vectors */
-- 
2.29.1.341.ge80a0c044ae-goog

