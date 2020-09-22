Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58B2274A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 22:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgIVUtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 16:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgIVUtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 16:49:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C57C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:49:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k18so4726301wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EQoerP3tBfn00ZbzFIq6padP28pN7slotXicRp3957E=;
        b=H9Qf7DVjzS2uazzSXcsF8UxvWOQKx0YXcEpjys0QzFlKULYxwAudttOshKaEI0RuGb
         4prt+n606mkeJnvIfKgeFNTlwVwlhtSJD0+RZnlVnWFk3fZ4nUnaRPb6MXAgbeyuXVun
         pq7vfFGhwkMqfw+3auW+vxQqRRlSQ8SCE7Nn1MNv7PRGWmatEP4MLbSn5TNCgvqY3eOw
         a9qDfY42N1RtFtFwqdvHF5aAPfgP7wyquROGWLpWezzG1V78CKbgDQ/B29XsdbO7C4fR
         4b7gie1b35wjCzbbUJYBQAXq4G0Mp6m2BWA+R+OLZUs2WHa7DWZv8DDrFo4xqRr9qLMn
         ukSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EQoerP3tBfn00ZbzFIq6padP28pN7slotXicRp3957E=;
        b=WRooajGQEp+Kraq0GIUoG3fIaOpU5yAuCDaWKCYmT6S8ruuFYzIpvi+/26ySpDu9z9
         O0IqPLCuPP4aUrKPp4pYxokyMTBEBc88V/OWYy4Goc67q+wiFhjtsgwW0vVTIGDu8O+O
         3S/LJEszZ4pjxflLLNblE+u4yVLhHbccQwzuMut8g290mlGpJuaA00BN5uxpH3L8gFrP
         HaLq73Vnp7NhBErADgwPv8Nwl5gC1iCq0MGV1n2t0fC8Amipl7cFXzz5sEiVPyA+PUMX
         U0a561hN1jFDgBlKFOldFZliBiqTEYjI1A0npMKbMh4QOs3asf7hUxgvoNN5ZupW5cNe
         OeaA==
X-Gm-Message-State: AOAM533OJP+Ac1mrFJvaOmYZ89+juJpA2PvtQLraZpYC07MzM7Im28ro
        wCbVmKFAIDIyhXsbgsVIcSVUIQ==
X-Google-Smtp-Source: ABdhPJyCu2UBtJO54u19JC9bNyMnYGleK4AbttUj2Zv5iMIbquV3VAo22onzrk/JeZubQXQ7ykQibg==
X-Received: by 2002:a7b:cd06:: with SMTP id f6mr3030151wmj.66.1600807769052;
        Tue, 22 Sep 2020 13:49:29 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:1105:630f:e990:272f])
        by smtp.gmail.com with ESMTPSA id a15sm29708484wrn.3.2020.09.22.13.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 13:49:28 -0700 (PDT)
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
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>,
        Andrew Scull <ascull@google.com>
Subject: [PATCH v4 10/10] kvm: arm64: Remove unnecessary hyp mappings
Date:   Tue, 22 Sep 2020 21:49:10 +0100
Message-Id: <20200922204910.7265-11-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922204910.7265-1-dbrazdil@google.com>
References: <20200922204910.7265-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With all nVHE per-CPU variables being part of the hyp per-CPU region,
mapping them individual is not necessary any longer. They are mapped to hyp
as part of the overall per-CPU region.

Acked-by: Andrew Scull<ascull@google.com>
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 20 --------------------
 arch/arm64/kvm/arm.c             | 16 ----------------
 2 files changed, 36 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index e134c2ba2c5d..8e7919801196 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -531,21 +531,6 @@ static inline int kvm_map_vectors(void)
 DECLARE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
 DECLARE_KVM_NVHE_PER_CPU(u64, arm64_ssbd_callback_required);
 
-static inline int hyp_map_aux_data(void)
-{
-	int cpu, err;
-
-	for_each_possible_cpu(cpu) {
-		u64 *ptr;
-
-		ptr = per_cpu_ptr_nvhe_sym(arm64_ssbd_callback_required, cpu);
-		err = create_hyp_mappings(ptr, ptr + 1, PAGE_HYP);
-		if (err)
-			return err;
-	}
-	return 0;
-}
-
 static inline void hyp_init_aux_data(void)
 {
 	u64 *ptr;
@@ -555,11 +540,6 @@ static inline void hyp_init_aux_data(void)
 	*ptr = __this_cpu_read(arm64_ssbd_callback_required);
 }
 #else
-static inline int hyp_map_aux_data(void)
-{
-	return 0;
-}
-
 static inline void hyp_init_aux_data(void) {}
 #endif
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index cd5293e55fec..22ec7176f95b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1591,22 +1591,6 @@ static int init_hyp_mode(void)
 		}
 	}
 
-	for_each_possible_cpu(cpu) {
-		kvm_host_data_t *cpu_data;
-
-		cpu_data = per_cpu_ptr_hyp_sym(kvm_host_data, cpu);
-		err = create_hyp_mappings(cpu_data, cpu_data + 1, PAGE_HYP);
-
-		if (err) {
-			kvm_err("Cannot map host CPU state: %d\n", err);
-			goto out_err;
-		}
-	}
-
-	err = hyp_map_aux_data();
-	if (err)
-		kvm_err("Cannot map host auxiliary data: %d\n", err);
-
 	return 0;
 
 out_err:
-- 
2.28.0.681.g6f77f65b4e-goog

