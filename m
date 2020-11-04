Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F012A6CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbgKDShB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732437AbgKDSg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:36:57 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7425C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:36:56 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id e6so5904269wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0K4yzmgUf7vVHr0iz04jMBBw0fWBZw8e2naPJ5vP+Z8=;
        b=QGvBnzgo0YRmIsUmCbkwh4pjuJnqEqI3AN4RP2WCjupA1IHn6Z0OnrMIpsPkymqpGw
         LP9vXOC4bb2uIkzXW0F524KSp23G15/moUgPgVXyGcaOdHz02/CsBg9vdKJ30wzamCGY
         /SWOL9tpI69HAqq6Lm3Ny8wX2p8T2D1MT7DbixVPelrjHpAmcQfQrSllDLrT8J7mD9cB
         9GcGSiXbr5xTAA5lqnnidjDOw8yi3CjQw/YpYaC2iN/JQlLnH0UqksA8MHDMKqloZlF7
         p+qMxb5zNbwWUudAMWkCby24Fe08vjsUpOoq5cImXofhjAevvHYe7xd/i7i9ef2L3nTG
         GeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0K4yzmgUf7vVHr0iz04jMBBw0fWBZw8e2naPJ5vP+Z8=;
        b=I2aQevxeGKhr+bPpIb601gRgcEmixJodMoQ6iGZu5oqqBMh6Q4sxRIj2zAaPWlOLgh
         iQrY3TA55rw8SWXqBkcDGaZWl8l06hyYxCdhO4Yj7Q4rhuypRwrlcNfaRzjPN9EO2z+N
         1ZE017t2RFhagU1lS7sgG0LVJsfcHeunrQZSEuLAI+7MkgmXMTIa54dC97nH+ykgNLWj
         AOVLWzrqISgNmIGlhiqyy26PbLZzoMbxYTSi232POFP2ZLrUGH8nvJjT2H+7xvisX+P5
         Rn9kyDFAvuXZHMQdYnQWeh+QX4i7kMK9TZxDjr2rdqWrcdezzY5vWp8X6364ujOlTcH3
         iU9A==
X-Gm-Message-State: AOAM532/+blV9TdB1+/1oXzQcdIE/BGnIugJnuievNN4NCH1ssBm3vTI
        E2/9rNzbuyJ5kyLJ/B2ozGNjCEvyUz5Y7ueZ
X-Google-Smtp-Source: ABdhPJxYOz8oN6hDQHajevWPLeTnGuUdeWGhUJpO55H7sotkzepkhC9LY3nZQ7oVr6rhj4DYoT519A==
X-Received: by 2002:adf:f246:: with SMTP id b6mr33349825wrp.111.1604515015435;
        Wed, 04 Nov 2020 10:36:55 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id l11sm3646430wro.89.2020.11.04.10.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:36:54 -0800 (PST)
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
Subject: [RFC PATCH 08/26] kvm: arm64: Create nVHE copy of cpu_logical_map
Date:   Wed,  4 Nov 2020 18:36:12 +0000
Message-Id: <20201104183630.27513-9-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When KVM starts validating host's PSCI requests, it will need to map
MPIDR back to the CPU ID. To this end, copy cpu_logical_map into nVHE
hyp memory when KVM is initialized.

Only copy the information for CPUs that are online at the point of KVM
initialization so that KVM rejects CPUs whose features were not checked
against the finalized capabilities.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/arm.c             | 17 +++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/percpu.c | 16 ++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 8bb9fffe2a8f..58e9cc183bd5 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1481,6 +1481,21 @@ static inline void hyp_cpu_pm_exit(void)
 }
 #endif
 
+static void init_cpu_logical_map(void)
+{
+	extern u64 kvm_nvhe_sym(__cpu_logical_map)[NR_CPUS];
+	int cpu;
+
+	/*
+	 * Copy the MPIDR <-> logical CPU ID mapping to hyp.
+	 * Only copy the set of online CPUs whose features have been chacked
+	 * against the finalized system capabilities. The hypervisor will not
+	 * allow any other CPUs from the `possible` set to boot.
+	 */
+	for_each_online_cpu(cpu)
+		CHOOSE_NVHE_SYM(__cpu_logical_map)[cpu] = cpu_logical_map(cpu);
+}
+
 static int init_common_resources(void)
 {
 	return kvm_set_ipa_limit();
@@ -1658,6 +1673,8 @@ static int init_hyp_mode(void)
 		}
 	}
 
+	init_cpu_logical_map();
+
 	return 0;
 
 out_err:
diff --git a/arch/arm64/kvm/hyp/nvhe/percpu.c b/arch/arm64/kvm/hyp/nvhe/percpu.c
index 5fd0c5696907..8b7f6b7dbd48 100644
--- a/arch/arm64/kvm/hyp/nvhe/percpu.c
+++ b/arch/arm64/kvm/hyp/nvhe/percpu.c
@@ -8,6 +8,22 @@
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
 
+/*
+ * nVHE copy of data structures tracking available CPU cores.
+ * Only entries for CPUs that were online at KVM init are populated.
+ * Other CPUs should not be allowed to boot because their features were
+ * not checked against the finalized system capabilities.
+ */
+u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
+
+u64 cpu_logical_map(int cpu)
+{
+	if (cpu < 0 || cpu >= ARRAY_SIZE(__cpu_logical_map))
+		hyp_panic();
+
+	return __cpu_logical_map[cpu];
+}
+
 unsigned long __hyp_per_cpu_offset(unsigned int cpu)
 {
 	unsigned long *cpu_base_array;
-- 
2.29.1.341.ge80a0c044ae-goog

