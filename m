Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6773E2A6CF8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbgKDSjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731218AbgKDShF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:37:05 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4E7C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:37:05 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s9so23140467wro.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nKgIpHjS/zdI3tb1vXzwoiiNM/jjodo8Otz1dws/lFM=;
        b=hv2R5Zu/z6mSOSF7dEe47i7r5T2cQPVysT7HoseP6g1eSaz6nNutmQSMgNBOdCt8eb
         PBT+5ilqIWofeWIil70QAAfQ++jMMGIDYwQCqScBeSD6s1/xacLom1Lg7Y6fr07ETPLc
         T5oVlB+HcrdVLb2F6SrnRwFCeUH9eLTNlKI8QXPxO6kK7HuFF6bgPtuTH+9dGZYRnmHe
         uXqrakMk7K/yAkrJV315umztyia9WU0yS91B2aTAWtmZ3Vxtl5rRie/Z8nLO2muqf32T
         +md4szIJBymJW9d9MDCf+3bjNANk8thtWZ0W8yjJnHGaSBHiCNp86qmYoNJNVZIuipRO
         Tl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nKgIpHjS/zdI3tb1vXzwoiiNM/jjodo8Otz1dws/lFM=;
        b=T9xDslvXI+T/4eMZen2zMD0K+IgF4amG6/4bhab9vC4KKrAkLaX8XWzWLZlPMhHVTC
         koleFqQ/XBmPAsBaS7XfQFBB3R4soFm4SLFOk+9BYgnjwsjAQAwTtoY+MVHdTbohohzK
         B4RbfVywcNBej3Ehg+JPb1k9ceSuwYF2J8tNco1B9juJ/4zI0eX5e3bbL6BJfnQkI+Zt
         XNIX8n6we3BR/t+wT167h6MT4PmMnFTAKC6sAAZJ740s4zwIOjLb735z2mHaPOHPLdy3
         oIDkCfyUVDPida4EN1BLZ0ZZ9MRNG4rYdaJtjbW0/civo0n1Va/Sl6ZJ8ZCOREBfpyPr
         XCaw==
X-Gm-Message-State: AOAM531iQmVDEathpeCeouhW/DHPLhpHaSLG3yalSHjhmncdNFrwFtQi
        R/cVA4OPzvP8GcqMAlfKLFxN1w==
X-Google-Smtp-Source: ABdhPJw7mLZKqMBluuUKvkKmIlrqh8pTnCd64tbISLpXPLgmZa+Ae3kp7ph+K6q6eNWevcaZKm0Gcw==
X-Received: by 2002:a5d:5387:: with SMTP id d7mr33257971wrv.224.1604515023950;
        Wed, 04 Nov 2020 10:37:03 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id t11sm3428092wmf.35.2020.11.04.10.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:37:02 -0800 (PST)
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
Subject: [RFC PATCH 12/26] kvm: arm64: Add SMC handler in nVHE EL2
Date:   Wed,  4 Nov 2020 18:36:16 +0000
Message-Id: <20201104183630.27513-13-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add handler of host SMCs in KVM nVHE trap handler. Forward all SMCs to
EL3 and propagate the result back to EL1. This is done in preparation
for validating host SMCs.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 19332c20fcde..fffc2dc09a1f 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -106,6 +106,38 @@ static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
 	host_ctxt->regs.regs[1] = ret;
 }
 
+static void skip_host_instruction(void)
+{
+	write_sysreg_el2(read_sysreg_el2(SYS_ELR) + 4, SYS_ELR);
+}
+
+static void forward_host_smc(struct kvm_cpu_context *host_ctxt)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_smc(host_ctxt->regs.regs[0], host_ctxt->regs.regs[1],
+			  host_ctxt->regs.regs[2], host_ctxt->regs.regs[3],
+			  host_ctxt->regs.regs[4], host_ctxt->regs.regs[5],
+			  host_ctxt->regs.regs[6], host_ctxt->regs.regs[7],
+			  &res);
+	host_ctxt->regs.regs[0] = res.a0;
+	host_ctxt->regs.regs[1] = res.a1;
+	host_ctxt->regs.regs[2] = res.a2;
+	host_ctxt->regs.regs[3] = res.a3;
+}
+
+static void handle_host_smc(struct kvm_cpu_context *host_ctxt)
+{
+	/*
+	 * Unlike HVC, the return address of an SMC is the instruction's PC.
+	 * Move the return address past the instruction.
+	 */
+	skip_host_instruction();
+
+	/* Forward SMC not handled in EL2 to EL3. */
+	forward_host_smc(host_ctxt);
+}
+
 void handle_trap(struct kvm_cpu_context *host_ctxt)
 {
 	u64 esr = read_sysreg_el2(SYS_ESR);
@@ -114,6 +146,10 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
 	case ESR_ELx_EC_HVC64:
 		handle_host_hcall(host_ctxt);
 		break;
+	case ESR_ELx_EC_SMC32:
+	case ESR_ELx_EC_SMC64:
+		handle_host_smc(host_ctxt);
+		break;
 	default:
 		hyp_panic();
 	}
-- 
2.29.1.341.ge80a0c044ae-goog

