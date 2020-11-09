Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE3F2AB6F3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgKILdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729589AbgKILdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:33:04 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CA4C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:33:03 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a65so7614346wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LKrqV3xLA/ibeJM+AQCXY9IBi6Twfnl4kI7peR0SVVU=;
        b=OQc11lBoTR5fJLdx+W2P8jL214ocEiZbxcjChcEvDu+j2dkB9NsUrsMdFWRHDmee3D
         sYikdoR0rn5I+XINzOWJlUa5jGseeRnNVR8gfCsKBm4VUfReK9aFmu18nleZIGhQSzcq
         D68YQ0GXpLN6ipsxq+zdaVPhgTboJ4+FUJeb/M67GrzOMDLPVZcxDPi0fFbPdWeXmFrl
         hCTReFIEwsH5+p+JPg27Ma8hKvS3cDoYmhYKAFBpXZ9yuycea852h2+1pF7f6la98cXt
         wq5a4CtNC/F6NmihcNri6n2Nfcia3CNPUHmhxlM6YWwOI7QNr+5owVOn0ujXVRZi7D2n
         1QqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LKrqV3xLA/ibeJM+AQCXY9IBi6Twfnl4kI7peR0SVVU=;
        b=lIxnZZPZHyjarnM2vvWHCgcVLkuUHgCmRy9Jb2XMXbqtoqZRYTfo4DRVbrbwGb2H4a
         WGp0lrRvOzM/3xByfpfpOWLlMGjApPmuVPX6wwUSEyBVRHY7pymIDPI1z6b/sflN0w7g
         +OWbVK6zis7CVkAznFjj4E2TwgBsxY7IkT8Bd0P6M0Oeui9/IvrRpG4HEcLFhL3zlvgc
         1Bh2juggfnzitab0hG9KwLO1ySu/O/B9E8eYWV8Td/j3V0vs3dOKWucaoq542TtYb2VL
         ALwlxJtRXZHp5QGOSz+8arJk4NgNLO5Gh+vAFMroutJH84TaznC/mzQOB1JQPPfEn7kd
         ockg==
X-Gm-Message-State: AOAM531DByQfGrLaA6bZz2a6vFxydgz5y+T/T7mFadM6Ww7uPaZclAmh
        C6W9X/kTT/Cio+Luo6Pc2iFto+nJlmlxWaY4
X-Google-Smtp-Source: ABdhPJzvaLtgbVxyZ2GDPcw/eFFKQNxLYoWLsP6DD3k4mKvCQB7oh0IBN8nQ6nLo0FuIJVxGVngrTA==
X-Received: by 2002:a7b:c20d:: with SMTP id x13mr13474111wmi.167.1604921582538;
        Mon, 09 Nov 2020 03:33:02 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id t11sm12458783wmf.35.2020.11.09.03.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:33:01 -0800 (PST)
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
Subject: [PATCH v1 11/24] kvm: arm64: Add SMC handler in nVHE EL2
Date:   Mon,  9 Nov 2020 11:32:20 +0000
Message-Id: <20201109113233.9012-12-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add handler of host SMCs in KVM nVHE trap handler. Forward all SMCs to
EL3 and propagate the result back to EL1. This is done in preparation
for validating host SMCs in KVM nVHE protected mode.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 35 ++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 19332c20fcde..8661bc7deaa9 100644
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
@@ -114,6 +146,9 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
 	case ESR_ELx_EC_HVC64:
 		handle_host_hcall(host_ctxt);
 		break;
+	case ESR_ELx_EC_SMC64:
+		handle_host_smc(host_ctxt);
+		break;
 	default:
 		hyp_panic();
 	}
-- 
2.29.2.222.g5d2a92d10f8-goog

