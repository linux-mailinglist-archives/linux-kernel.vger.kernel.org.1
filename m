Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3BC26CA7D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgIPUCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgIPRfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:35:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7A1C0611BC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:35:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a17so7774574wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EdexJTeSJ1yzSq2NB9sPeJusVOkXFFsSU8w5tX+wAoY=;
        b=XBpFPnVnEXotZ9h7Vi96uiegtXa9f6RsxKZhjfRsj/bVOPdAq6fxcKcQEAWKY2yP/+
         j3PWyy1esATPnLP3uevSBbvUQKYvsCxNVoLaiGC/5iqudT2qc6itwteJuDQZN39vdob3
         QaDJj5Fg7ELcwgZceR5AuZcuIyWWmWGJn9h8tuNgYqFXJvF9GfV92xXB911rmrSm3IJz
         DEVO8XTVwMYWDmqJ1lvnk1kAgNDeDDzO49zUONaiMZF3cfbTO5K+56OTvnR1AU7UXbMn
         LvmycZKfMnvi9K9gtcHdirkVA7EoQe+EhLFDqe8HnRz+8V1xqmA+BY1XfOsJpaZD8LH6
         UDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EdexJTeSJ1yzSq2NB9sPeJusVOkXFFsSU8w5tX+wAoY=;
        b=A49w+J+SH9AlLE0yZHUL3EAAaTni99UKLm7a61BZZayWGRA3xUISWFM4hT9O0Xe+J2
         g98iQwLkcPOHmBAwG+DMZVKXg/TbD6nEitQn7g7rtIX46qm+S686NbMyMIfBcBDl6y+f
         O9VaYeFSd86cFuUbsgQUQxV2W1ft1jic/tJWLKHWr+YjBUPEJsLeVG+7YpeE6BLObk+c
         e+cD9OVp+L6coKIF2kYtqUkecLm3jo2d64XdYafzYQJ+F+RiHR612oJgUM93IsgC/7fy
         Uvk+RDOIPTqGUf0AZj7tGj8lGMKBh5yiLxZWnRgmza1xH8RXygT/csMKKZCpbAEPkraH
         FbjA==
X-Gm-Message-State: AOAM533PGPo+JFdZIkO3EWKXKUns5pjz/vgWteH7ShdoJij/ilOl/S49
        GV0u5OploskabCQuWxOUcXDbJw==
X-Google-Smtp-Source: ABdhPJxiNME7o6IoYWEvolPBp1wwKcDxQ2PJwQacH0w0glnZjPPICPGldNZPzVdYDrWU7SS+rM/Ucw==
X-Received: by 2002:adf:92c2:: with SMTP id 60mr29983169wrn.220.1600277707032;
        Wed, 16 Sep 2020 10:35:07 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:e49d:f6be:d31b:ad3c])
        by smtp.gmail.com with ESMTPSA id j10sm35693576wrn.2.2020.09.16.10.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 10:35:05 -0700 (PDT)
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
Subject: [PATCH v3 11/11] kvm: arm64: Remove unnecessary hyp mappings
Date:   Wed, 16 Sep 2020 18:34:39 +0100
Message-Id: <20200916173439.32265-12-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916173439.32265-1-dbrazdil@google.com>
References: <20200916173439.32265-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With all nVHE per-CPU variables being part of the hyp per-CPU region,
mapping them individual is not necessary any longer. They are mapped to hyp
as part of the overall per-CPU region.

Acked-by: Andrew Scull<ascull@google.com>
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 19 +++++--------------
 arch/arm64/kvm/arm.c             | 17 +----------------
 2 files changed, 6 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 9db93da35606..7d1581bc8b97 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -531,28 +531,19 @@ static inline int kvm_map_vectors(void)
 DECLARE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
 DECLARE_KVM_NVHE_PER_CPU(u64, arm64_ssbd_callback_required);
 
-static inline int hyp_init_aux_data(void)
+static inline void hyp_init_aux_data(void)
 {
-	int cpu, err;
+	int cpu;
 
+	/* Copy arm64_ssbd_callback_required values from kernel to hyp. */
 	for_each_possible_cpu(cpu) {
-		u64 *ptr;
+		u64 *ptr = per_cpu_ptr_nvhe(arm64_ssbd_callback_required, cpu);
 
-		ptr = per_cpu_ptr_nvhe(arm64_ssbd_callback_required, cpu);
-		err = create_hyp_mappings(ptr, ptr + 1, PAGE_HYP);
-		if (err)
-			return err;
-
-		/* Copy value from kernel to hyp. */
 		*ptr = per_cpu(arm64_ssbd_callback_required, cpu);
 	}
-	return 0;
 }
 #else
-static inline int hyp_init_aux_data(void)
-{
-	return 0;
-}
+static inline void hyp_init_aux_data(void) {}
 #endif
 
 #define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 8293319a32e7..4483b6aca5d7 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1634,22 +1634,7 @@ static int init_hyp_mode(void)
 		}
 	}
 
-	for_each_possible_cpu(cpu) {
-		kvm_host_data_t *cpu_data;
-
-		cpu_data = per_cpu_ptr_hyp(kvm_host_data, cpu);
-		err = create_hyp_mappings(cpu_data, cpu_data + 1, PAGE_HYP);
-
-		if (err) {
-			kvm_err("Cannot map host CPU state: %d\n", err);
-			goto out_err;
-		}
-	}
-
-	err = hyp_init_aux_data();
-	if (err)
-		kvm_err("Cannot map host auxiliary data: %d\n", err);
-
+	hyp_init_aux_data();
 	return 0;
 
 out_err:
-- 
2.28.0.618.gf4bc123cb7-goog

