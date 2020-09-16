Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEFF26C630
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 19:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgIPRgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 13:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgIPRfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:35:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BB0C06121E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:35:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z4so7804099wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N/a5esHE2nX/K6yt6KRtONQ/utoU9A1KMk/TmGOQstA=;
        b=cKP/rHoQVyZyHVqZKyh7DfsE+mZFPUCn8SD3R2cnVqPlL2IpZN/1aLKkpOuKklj1R1
         Ff4dtVMf31VqV7eFBh6ys+o6DxOtke8LtPBezFeyWpXkzs3EU+umYnaWkrQnejG9YXnB
         sHAqmCN4KOZBEQnZDiWlay4r0GDhl5YJGXgS8X0RlMcYif6v2kf7SYPcj7OcW10ScDk1
         vjhBdmd1g44WnQjvQUVjyp6PazaRbDijYf2bR5RSFaB6frYEk96o78v/rIri2yBfQGOr
         AGYUvN3smNU0kV381ttfiFlS2yJpKppiHzhvMlNiMB9av3Maor7OK9Esa5xZHrFb599K
         0BZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N/a5esHE2nX/K6yt6KRtONQ/utoU9A1KMk/TmGOQstA=;
        b=DXbYVjiTwuE+OafqYVNWQbYAlm6LnXuWm+JWuu2t0hkqU1l0Wz1xpXspM0RV6zUe4z
         qbN15Y1BDHHPhzIEZ3UE4jwUe1BBzik8JNo04l6TsUQGqUdH9C3gVUktf+hK3zxgK1HF
         DYuftvPhVL634Kw1bE4Hsyv75mkeNywgWXHGIhgqTFuiXvC7QGpgg1AH2bNryycQVnYF
         BRnHVQeOsy0CNpnGtmtlvzTySM2ITwvswhWCbOGn7cGILtV9T3T+/+B8cWIQGfsZvaoW
         oa164ATms6r+igf5FT+uGbwOpb60R1xL4WsbW/uHV297RH5zc9y2HbJyqZXHlSCz8VbU
         cF+Q==
X-Gm-Message-State: AOAM533AV1bBF90uoMreDb4cD00eT7Yv6uJhczaYX2OlV4fw9kgw6koC
        M8QL1GcrGTAzGRYPLToFiBjfgg==
X-Google-Smtp-Source: ABdhPJxomQAbrt08pj/u0T2EZWQsduo0LZzXxFu69uumIM0NIEhf5lzxyS7IebV8zrXzmcgv8Rs77w==
X-Received: by 2002:adf:f3c4:: with SMTP id g4mr28414841wrp.168.1600277699045;
        Wed, 16 Sep 2020 10:34:59 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:e49d:f6be:d31b:ad3c])
        by smtp.gmail.com with ESMTPSA id i3sm33528281wrs.4.2020.09.16.10.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 10:34:58 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v3 07/11] kvm: arm64: Duplicate arm64_ssbd_callback_required for nVHE hyp
Date:   Wed, 16 Sep 2020 18:34:35 +0100
Message-Id: <20200916173439.32265-8-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916173439.32265-1-dbrazdil@google.com>
References: <20200916173439.32265-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyp keeps track of which cores require SSBD callback by accessing a
kernel-proper global variable. Create an nVHE symbol of the same name
and copy the value from kernel proper to nVHE at KVM init time.

Done in preparation for separating percpu memory owned by kernel
proper and nVHE.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 10 +++++++---
 arch/arm64/kernel/image-vars.h   |  1 -
 arch/arm64/kvm/arm.c             |  2 +-
 arch/arm64/kvm/hyp/nvhe/switch.c |  3 +++
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 189839c3706a..9db93da35606 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -529,23 +529,27 @@ static inline int kvm_map_vectors(void)
 
 #ifdef CONFIG_ARM64_SSBD
 DECLARE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
+DECLARE_KVM_NVHE_PER_CPU(u64, arm64_ssbd_callback_required);
 
-static inline int hyp_map_aux_data(void)
+static inline int hyp_init_aux_data(void)
 {
 	int cpu, err;
 
 	for_each_possible_cpu(cpu) {
 		u64 *ptr;
 
-		ptr = per_cpu_ptr(&arm64_ssbd_callback_required, cpu);
+		ptr = per_cpu_ptr_nvhe(arm64_ssbd_callback_required, cpu);
 		err = create_hyp_mappings(ptr, ptr + 1, PAGE_HYP);
 		if (err)
 			return err;
+
+		/* Copy value from kernel to hyp. */
+		*ptr = per_cpu(arm64_ssbd_callback_required, cpu);
 	}
 	return 0;
 }
 #else
-static inline int hyp_map_aux_data(void)
+static inline int hyp_init_aux_data(void)
 {
 	return 0;
 }
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 76da2ad1010c..59d12a0b4622 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -67,7 +67,6 @@ KVM_NVHE_ALIAS(kvm_patch_vector_branch);
 KVM_NVHE_ALIAS(kvm_update_va_mask);
 
 /* Global kernel state accessed by nVHE hyp code. */
-KVM_NVHE_ALIAS(arm64_ssbd_callback_required);
 KVM_NVHE_ALIAS(kvm_host_data);
 KVM_NVHE_ALIAS(kvm_vgic_global_state);
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index b588c3b5c2f0..3bdc2661d276 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1552,7 +1552,7 @@ static int init_hyp_mode(void)
 		}
 	}
 
-	err = hyp_map_aux_data();
+	err = hyp_init_aux_data();
 	if (err)
 		kvm_err("Cannot map host auxiliary data: %d\n", err);
 
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index cc4f8e790fb3..4662df6330d7 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -27,6 +27,9 @@
 #include <asm/processor.h>
 #include <asm/thread_info.h>
 
+/* Non-VHE copy of the kernel symbol. */
+DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
+
 static void __activate_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val;
-- 
2.28.0.618.gf4bc123cb7-goog

