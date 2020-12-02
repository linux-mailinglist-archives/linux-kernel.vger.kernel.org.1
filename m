Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEE52CC59E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389550AbgLBSnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389542AbgLBSnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:43:23 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E6CC09424B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:42:13 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so5195227wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yTPqxuNIHyHcxIGVDRFuzMb//a26J9RNoM2ThcyKbSM=;
        b=aCv+2fOzVacnmojuOT7cqdovfGr22fjEzJv+MRvW19pxd/At/2+SeBvsnBovv23E0a
         4ejG9x3wrILwl7LMVEeZNAy3Oz04NMiHm2Fj4hdnEr9LAkH0YCPP1X0lywRi3nVmOGD7
         nkwvoIwyzCN0kTWt4W3zAUBl+ihGtvBa9iAj7T1vlVaWad8lbsjZhFTC3rh2nTTEeoVN
         /Lvdr5l6vK5yD3B1B66RYBHWXz9OiYZYIBnuFg7gVGUh0Sw1Q8cGh4Im1B7YS4gfugr6
         oyO6bJiThSBLLb5BdbTjsa1DmmAbRvnlt4Ys1b6GgaoLrc+4THiITVFGUu94qhXAsFdT
         AhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yTPqxuNIHyHcxIGVDRFuzMb//a26J9RNoM2ThcyKbSM=;
        b=gTiBTWyikyeY05UrIKeZQKjwf6luAyJY1fckHfC9i+pz+P3oOo5GtCEMtmvqu6kZap
         4VqiMbLxhtfP6qo0C4ZAOonCz5p5fdoC9+K1Q4YFNk2Z++PvrUcsYk0mARJaZ8bUVsnx
         8HHifWZygrgknCuQ+SBRMD7KCZxjFvzfGaiWH7bJt/iMEbb4gczXe5huk73GgFRnZdM6
         10b92ZUemY/6yuvE5auto+cTa3/b7B3yn8CiKNtoaWi5Rc52w+r2phFLq3TRjR+VLxhl
         r/MsvOP5iZN7COCZ5f8oWAIApLhs0/7gz8IQ8EwM0S415xLtBaanxeBgt4eU9P+bKnBh
         GmOQ==
X-Gm-Message-State: AOAM530i9awFAhtD9mwstQNUm9p7V1FHhuRszzlwBY7eXrqYQfe9+9C6
        eGhCi/A8yZUKSrNm09GaD9MZCg==
X-Google-Smtp-Source: ABdhPJylrxzOOF0czEtZ7fv5Klvs9l0NUYOehr4kbC+Jl1sFVyJ7nzp854Drk3FK4NwPazSOzLk5iA==
X-Received: by 2002:a5d:504f:: with SMTP id h15mr5035439wrt.402.1606934532259;
        Wed, 02 Dec 2020 10:42:12 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:5ddd:b7c5:e3c9:e87a])
        by smtp.gmail.com with ESMTPSA id b200sm3008640wmb.10.2020.12.02.10.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:42:11 -0800 (PST)
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
Subject: [PATCH v4 20/26] kvm: arm64: Add function to enter host from KVM nVHE hyp code
Date:   Wed,  2 Dec 2020 18:41:16 +0000
Message-Id: <20201202184122.26046-21-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202184122.26046-1-dbrazdil@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
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
index 2b56f0bdf874..a820dfdc9c25 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -39,6 +39,7 @@ SYM_FUNC_START(__host_exit)
 	bl	handle_trap
 
 	/* Restore host regs x0-x17 */
+__host_enter_restore_full:
 	ldp	x0, x1,   [x29, #CPU_XREG_OFFSET(0)]
 	ldp	x2, x3,   [x29, #CPU_XREG_OFFSET(2)]
 	ldp	x4, x5,   [x29, #CPU_XREG_OFFSET(4)]
@@ -61,6 +62,14 @@ __host_enter_without_restoring:
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
2.29.2.454.gaff20da3a2-goog

