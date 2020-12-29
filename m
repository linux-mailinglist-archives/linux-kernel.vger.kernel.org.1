Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80302E720B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 17:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgL2QCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 11:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgL2QCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 11:02:04 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD52C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 08:01:23 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r3so15060915wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 08:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NtCljhLriYtvqTyh0Oi7f3SoeajHUSS/0DAzm3hIGXE=;
        b=Oz7Ml7QJVCMzwv2c3OvZUVS1nQR+4abLjG0AvTqtcYOBygQ3cV++dq2Q6H5LlAKrJT
         yiLsX9sMElJJfJRsPvDEaP+TbemQEMjDGRraLIfCVxGD+J1oRK5SOotiiGSBR1h+utFs
         k3pYH3lbVXXATfVz7oopjMSJzngGXuu/egoKdfuLkxzdA0cJVJK5H1HBZcheS6le/UX2
         bR7Wy/OEayCryx50CMsvlN8wahXfGjPH3yP5ucV7N9nK9AGU3X/DyctWqEyNDF6LCIEA
         4b7vbgmlTU4v2FSk5RCmiSPrrdDZY0nYjL0nBX3BHVA/0Xyyv+6JRgMuPGWQUtZ8JJrL
         yrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NtCljhLriYtvqTyh0Oi7f3SoeajHUSS/0DAzm3hIGXE=;
        b=qRDyY+Tn3HQhniXXSbcDly2Fa5osVfKiI/R7smY12dx8+ASsJrigir7zIFdnuj+FfH
         nFkq97raG5+EIV+GtoM+Ee2e7vhVUfUvu6nTLQW8aYbku6WO8LURFh1QsbQhqRSbe20r
         ZsiTgf2lsGPhthPgg30/VjEAhtyExd5qnU74kp8PJjmROcANVqWoEDz0B6VChuS5Xfzg
         POrlwvIAS6vTuZHc7Yp9WCQpp23tFM7OypbglBzX7fK3Pg0/fajehUv9PkQ7dJDGFGuJ
         azyGe1dMwdGj89eVD0+L5kuZG4Gjl/fU6KXLo6WxRVu+V75bUKporPjkrDqqmzI6qmKs
         u2+w==
X-Gm-Message-State: AOAM533HeTMe3/yKA6GOCbyP3Ngc5UI+malMCqz/oRNseoBsDY+jZpUU
        pFj1IDN2t3W9iPixcaJCwCRzeg==
X-Google-Smtp-Source: ABdhPJw9Ayoh9M0GtPyVtC0R8Y+dAZ8drQfvlYeo93ZmkqUpL9igbq4DREd39sZg1DlSlN4TeaAUKw==
X-Received: by 2002:adf:8290:: with SMTP id 16mr54668406wrc.27.1609257682161;
        Tue, 29 Dec 2020 08:01:22 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:b0e4:997:fb3:e517])
        by smtp.gmail.com with ESMTPSA id l5sm61284118wrv.44.2020.12.29.08.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 08:01:20 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH] KVM: arm64: Allow PSCI SYSTEM_OFF/RESET to return
Date:   Tue, 29 Dec 2020 16:00:59 +0000
Message-Id: <20201229160059.64135-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KVM/arm64 PSCI relay assumes that SYSTEM_OFF and SYSTEM_RESET should
not return, as dictated by the PSCI spec. However, there is firmware out
there which breaks this assumption, leading to a hyp panic. Make KVM
more robust to broken firmware by allowing these to return.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/psci-relay.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index e3947846ffcb..8e7128cb7667 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -77,12 +77,6 @@ static unsigned long psci_forward(struct kvm_cpu_context *host_ctxt)
 			 cpu_reg(host_ctxt, 2), cpu_reg(host_ctxt, 3));
 }
 
-static __noreturn unsigned long psci_forward_noreturn(struct kvm_cpu_context *host_ctxt)
-{
-	psci_forward(host_ctxt);
-	hyp_panic(); /* unreachable */
-}
-
 static unsigned int find_cpu_id(u64 mpidr)
 {
 	unsigned int i;
@@ -251,10 +245,13 @@ static unsigned long psci_0_2_handler(u64 func_id, struct kvm_cpu_context *host_
 	case PSCI_0_2_FN_MIGRATE_INFO_TYPE:
 	case PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU:
 		return psci_forward(host_ctxt);
+	/*
+	 * SYSTEM_OFF/RESET should not return according to the spec.
+	 * Allow it so as to stay robust to broken firmware.
+	 */
 	case PSCI_0_2_FN_SYSTEM_OFF:
 	case PSCI_0_2_FN_SYSTEM_RESET:
-		psci_forward_noreturn(host_ctxt);
-		unreachable();
+		return psci_forward(host_ctxt);
 	case PSCI_0_2_FN64_CPU_SUSPEND:
 		return psci_cpu_suspend(func_id, host_ctxt);
 	case PSCI_0_2_FN64_CPU_ON:
-- 
2.29.2.729.g45daf8777d-goog

