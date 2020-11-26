Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB61D2C58D1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403893AbgKZPzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403866AbgKZPzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:55:20 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67B9C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:55:19 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a65so2874855wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aOLJOeUdUyn9Tp5EB3J9cYHwXErbIHpd/Aan89z6ZHs=;
        b=QM/rbtXwOgu6dblgPCWfx4ngm1/thgvoQ0YW4L2bPmt43izjfGp+feFlrQOkpQS9Om
         6IyiMWQDM9+9UTy3hB+J5mL08+VjIOU0v7HHn2JQNnWZfWWWlGmxzXwQJ5YeUMP4URzL
         1QtnGLr7B86YDgrOowd0eJ/ZlG7g90/JdTPeSBg4Np5jEsxeOF3riX5Aj+ZJnFB1nucH
         eGRGKeHAcqx9n6NEDtpKYSogxV+eRc23vpbWc9NRm5ShbBf3SY7zuFqqGKiDs+I9VeCG
         lbM65gvfMyzKPRVDcbtqP39F0X2J1baGFNxxaE1G/RusVZXby+KoCinFSOxt/dKolC8/
         f6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aOLJOeUdUyn9Tp5EB3J9cYHwXErbIHpd/Aan89z6ZHs=;
        b=ZS6wdQQNtB1gyMw3puKlOTEN8b5+j+Sxs2MGSP8MmQRoKraK0dTInwoicK+cFDKlxP
         sHHUI+waNDKrp4lGj4yFNfvhmdnkM5BeYo6otcE0gLAzALh1NKWJVnS19CSDTebslRSC
         Jvf0GmeXZXuM4QkXKrGT/mHExcxHGF39MMoHSYZm4IZedqBBz/JRhZdJ3Rvn/zxdHIIa
         toT27moySIK0+bCRlpDzWJPw7cpqg/7FkR7zPumWE6lmalHsW4g+aFw/1OZTKysor4rY
         yXdLgE/uOU7RHzjN5KECAD/e4c3GSWNj/ak+T+A3N8BJMv8yRLC87hz+QA264c8+Wgt0
         pNWQ==
X-Gm-Message-State: AOAM532Te2huyeuk5pEwQ8MDHwIJCeZIDC0401LLNJT/vapJ5UQ7QPTV
        SqxmZHfOnAfdxzo/dbInBSnaGQ==
X-Google-Smtp-Source: ABdhPJxNaayzFy0JXM9EQDhPZc7SkErVTVeHwN5g49VsWueupWVWXJ57HuFtoPXgm7dm47oDpr8iqg==
X-Received: by 2002:a1c:bd08:: with SMTP id n8mr4124459wmf.136.1606406116246;
        Thu, 26 Nov 2020 07:55:16 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:f008:704d:8d4b:9951])
        by smtp.gmail.com with ESMTPSA id j4sm9290305wrn.83.2020.11.26.07.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 07:55:15 -0800 (PST)
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
Subject: [PATCH v3 23/23] kvm: arm64: Fix EL2 mode availability checks
Date:   Thu, 26 Nov 2020 15:54:21 +0000
Message-Id: <20201126155421.14901-24-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126155421.14901-1-dbrazdil@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With protected nVHE hyp code interception host's PSCI CPU_ON/SUSPEND
SMCs, the host starts seeing new CPUs boot in EL1 instead of EL2. The
kernel logic that keeps track of the boot mode needs to be adjusted.

Add a static key enabled if KVM protected nVHE initialization is
successful.

When the key is enabled, is_hyp_mode_available continues to report
`true` because its users either treat it as a check whether KVM will be
/ was initialized, or whether stub HVCs can be made (eg. hibernate).

is_hyp_mode_mismatched is changed to report `false` when the key is
enabled. That's because all cores' modes matched at the point of KVM
init and KVM will not allow cores not present at init to boot. That
said, the function is never used after KVM is initialized.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/virt.h | 18 ++++++++++++++++++
 arch/arm64/kvm/arm.c          | 10 +++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 2fde1186b962..f7cf3f0e5297 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -65,9 +65,19 @@ extern u32 __boot_cpu_mode[2];
 void __hyp_set_vectors(phys_addr_t phys_vector_base);
 void __hyp_reset_vectors(void);
 
+DECLARE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
+
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
@@ -75,6 +85,14 @@ static inline bool is_hyp_mode_available(void)
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
index 6ec8ddf74643..b153c08e50fa 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -46,6 +46,8 @@
 __asm__(".arch_extension	virt");
 #endif
 
+DEFINE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
+
 DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
 
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
@@ -1877,12 +1879,14 @@ int kvm_arch_init(void *opaque)
 	if (err)
 		goto out_hyp;
 
-	if (is_protected_kvm_enabled())
+	if (is_protected_kvm_enabled()) {
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
2.29.2.454.gaff20da3a2-goog

