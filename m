Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DBB2AB73F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbgKILhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbgKILc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:32:56 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8F4C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:32:55 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id s8so1210625wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E1NKlSXbosotz7yE3k2vTKr2ydlvsygMA7t9DehWpvE=;
        b=l5mFBYX18Rn7YX+QOaWfw6pSERAucDkfSD0fLjY2La9KEXAkogCnx0MlXxkUnnQruE
         hcRz3mFUUHEK7BkHrKmHKS7z4K9kzSMySOyP7FbGc3/T8JrugpkNZIt/AJ44AdxcV/y9
         7EGITSkupXBoishh0kGdsfNPWgvqpzGLGKMdOBFcz0OhhjZ9kNWpadYeoPxbZ90OQ0rG
         QoZLm++zKXNxDhFNzhQ4FEt5gWvnAlfXkA27lW91g6b2Ie32EmXFrFBg/m4ggOxY1441
         ypg58scvklmkltXN9bpd2eLzNMuaLpFOQc9Qw8AdB4l22lVMqsm9gnPrsu3lwPJtpD7k
         bfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E1NKlSXbosotz7yE3k2vTKr2ydlvsygMA7t9DehWpvE=;
        b=sbZsWdovy0mpJFsfvnr/ad1/DaHPQ7CCbTiop+6dqSqa/XQHvDRsX0gf6TsYelxWIm
         Gs2/ySCXOMFPjNDrYs5IaS9/SCgKi/gnLIhBw/bpDexn7tDEVFROZb7kJyFOBC16LyA1
         mByzYxC19mNwCe5G69pfdHwaNwTIjkPx6pk8H8FhZTI0qKirEs04x3gzMUjyztxjrD24
         5W5kw2Y4qABUgtujpbMiJO+KW+O0zDjqys3pkPtoVy93A0Dx84Q1dV8rxqNQl4d4GkqR
         jciEYb5cLtu0ctOgrQGpTvZammtIkweRudhUR3gUcL3BG6RgGzjGDP2vtoc8FicB/LIp
         mPpA==
X-Gm-Message-State: AOAM532wH466Z8CLljXO6+Dd2T0Rdd8sFoKsKDOgYXdxa/S2S6Gcjx0M
        TdWvVXkkSNENd3Z7V8526BXuyw==
X-Google-Smtp-Source: ABdhPJz/l/6GQDBPHymkPNzaoMyRUmvzkHblO9n04gDj4zUaNX37jiQdcZNRxwl4SGl32T4mexwRmg==
X-Received: by 2002:adf:e287:: with SMTP id v7mr17824035wri.252.1604921574345;
        Mon, 09 Nov 2020 03:32:54 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id f23sm12132699wmb.43.2020.11.09.03.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:32:53 -0800 (PST)
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
Subject: [PATCH v1 07/24] kvm: arm64: Create nVHE copy of cpu_logical_map
Date:   Mon,  9 Nov 2020 11:32:16 +0000
Message-Id: <20201109113233.9012-8-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
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
index 9ba9db2aa7f8..b85b4294b72d 100644
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
@@ -1659,6 +1674,8 @@ static int init_hyp_mode(void)
 		}
 	}
 
+	init_cpu_logical_map();
+
 	return 0;
 
 out_err:
diff --git a/arch/arm64/kvm/hyp/nvhe/percpu.c b/arch/arm64/kvm/hyp/nvhe/percpu.c
index 5fd0c5696907..d0b9dbc2df45 100644
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
+u64 __ro_after_init __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
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
2.29.2.222.g5d2a92d10f8-goog

