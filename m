Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0522AB734
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgKILgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbgKILda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:33:30 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA39C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:33:30 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d12so6789332wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TSwlUknyxMEI+6/IdIE7BFo27ktFepUyPMrayg9jAhU=;
        b=iAn2GzCfxNArh5CKayH8Vx8icaJ2i4fbykQO1kjXT9qJmzxGyHErFl5pAdrOwyItSF
         n61YAtEdFpK5GaHftfHCQeRp6ATxUD5xTKpJupnh7JfzXWnKshJWUdT6f7nOvBuZeX6g
         SGTh0c59Oy/Ar+Y5/KK20aP3f4pCWGqiLNdyaUMbq443GYcVvqwIsQ966yMSdc2E8cID
         3Mp9gTu52MoliwQgaKBilPbbycLyb+QisomKBY6VpW2r03L+l2WHjFsB8xxFhUSYzL8X
         A+z31ZTD4ZKDaaSAqD/uCOOH17EhMAWrV29kZe3P9LTQG8LRF2/gL4x0aWTjBkB3TWgg
         CJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TSwlUknyxMEI+6/IdIE7BFo27ktFepUyPMrayg9jAhU=;
        b=Knn23CZ+nW7ijqdJ1F+zrH7OOLEozmTf1XeflunN66R4LfVHtgj1BLSoox56NuYGx8
         5ZDi8DkiA6rFLvSGRG7LIcua+AdQJ3Vs5n7/R4cho3SpDGeB9fpJQpeP5qSsmxcDgRhw
         oMUaS6UXkwbM6ZfwW3AjA0i+tKauGKT6HQyHEml2rod9zY0AEpbI9y9eOJQOtrixVWwD
         LPybOxJAvtS68OUsLZfuD/UvdECOpvabNj5iQga23g2b+rxilAhz3ly5PtRaZ2q2leig
         WK/VmMOaodp4onOlBPmHJJgWYjMIo75BLeAtvQxRxltd/o8DVBPL3O580DDdE2Bg/Efn
         iXVg==
X-Gm-Message-State: AOAM532iqWNQMG3WkSTAxe8XRP2OhlroxHt/ezvW4bo0M6SAxPNV+I3y
        txlOBG56FNbnw8tHFMjbXqAyl19H6IP0y6+I
X-Google-Smtp-Source: ABdhPJxh4X0Ke2rWDYUSFAfru62h5H3hy1NB0X1m0Pp9aNMnCDnQcDcDX1PGxexIachYDmdrHQtBjQ==
X-Received: by 2002:a5d:6ca6:: with SMTP id a6mr17360696wra.348.1604921608925;
        Mon, 09 Nov 2020 03:33:28 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id z19sm12507964wmk.12.2020.11.09.03.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:33:28 -0800 (PST)
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
Subject: [PATCH v1 24/24] kvm: arm64: Fix EL2 mode availability checks
Date:   Mon,  9 Nov 2020 11:32:33 +0000
Message-Id: <20201109113233.9012-25-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With protected nVHE hyp code interception host's PSCI CPU_ON/OFF/SUSPEND
SMCs, from the host's perspective new CPUs start booting in EL1 while
previously they would have booted in EL2. The kernel logic which keeps
track of the mode CPUs were booted in needs to be adjusted to account
for this fact.

Add a static key enabled if KVM protected nVHE initialization is
successful.

When the key is enabled, is_hyp_mode_available continues to report
`true` because its users either treat it a check whether KVM will be /
has been initialized, or whether stub HVCs can be made (eg. hibernate).

is_hyp_mode_mismatched is changed to report `false` when the key is
enabled. That's because all cores' modes matched at the point of KVM
init and KVM will not allow cores not present at init to boot. That
said, the function is never used after KVM is initialized.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/virt.h | 17 +++++++++++++++++
 arch/arm64/kvm/arm.c          |  9 ++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 2c3124512c00..8159d6010f4b 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -66,10 +66,19 @@ void __hyp_set_vectors(phys_addr_t phys_vector_base);
 void __hyp_reset_vectors(void);
 
 DECLARE_STATIC_KEY_FALSE(kvm_protected_mode);
+DECLARE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
 
 /* Reports the availability of HYP mode */
 static inline bool is_hyp_mode_available(void)
 {
+	/*
+	 * If KVM protected mode is initialized, all CPUs must have been booted
+	 * in EL2. Avoid checking __boot_cpu_mode as CPUs now come up in EL1.
+	 */
+	if (IS_ENABLED(CONFIG_KVM) &&
+	    static_branch_likely(&kvm_protected_mode_initialized))
+		return true;
+
 	return (__boot_cpu_mode[0] == BOOT_CPU_MODE_EL2 &&
 		__boot_cpu_mode[1] == BOOT_CPU_MODE_EL2);
 }
@@ -77,6 +86,14 @@ static inline bool is_hyp_mode_available(void)
 /* Check if the bootloader has booted CPUs in different modes */
 static inline bool is_hyp_mode_mismatched(void)
 {
+	/*
+	 * If KVM protected mode is initialized, all CPUs must have been booted
+	 * in EL2. Avoid checking __boot_cpu_mode as CPUs now come up in EL1.
+	 */
+	if (IS_ENABLED(CONFIG_KVM) &&
+	    static_branch_likely(&kvm_protected_mode_initialized))
+		return false;
+
 	return __boot_cpu_mode[0] != __boot_cpu_mode[1];
 }
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index c09b95cfa00a..9a2329c92a01 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -48,6 +48,7 @@ __asm__(".arch_extension	virt");
 #endif
 
 DEFINE_STATIC_KEY_FALSE(kvm_protected_mode);
+DEFINE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
 
 DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
 
@@ -1838,12 +1839,14 @@ int kvm_arch_init(void *opaque)
 	if (err)
 		goto out_hyp;
 
-	if (is_kvm_protected_mode())
+	if (is_kvm_protected_mode()) {
+		static_branch_enable(&kvm_protected_mode_initialized);
 		kvm_info("Protected nVHE mode initialized successfully\n");
-	else if (in_hyp_mode)
+	} else if (in_hyp_mode) {
 		kvm_info("VHE mode initialized successfully\n");
-	else
+	} else {
 		kvm_info("Hyp mode initialized successfully\n");
+	}
 
 	return 0;
 
-- 
2.29.2.222.g5d2a92d10f8-goog

