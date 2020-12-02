Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A11B2CC57F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbgLBSmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgLBSmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:42:11 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF1CC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:41:30 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h21so11161968wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qy+VUI9BXr6HazxoMIsIcdlYXr2Zkw6Es0halgF2Fhw=;
        b=UAOOKMnPkO17JoHDZkxjQgAVO6zpGftV0wvNiSWjhlY7kOwOa1zo2h+ivb22qOwe+V
         OUeZ1kaZ2iuLe85sH3vKir/PolrJozCc8f5BEnZclJqkMHEnPBBe5RIxS54Uily8MPnK
         2Y1SjWE7pmPOCzK4bYInNyWMy9kenBr5/8ZdVX5elM6EWvAO1SdjrF2QGFKXUd9OqCb+
         NtIQnngm0PfEs5d3IgcTf7LhfVPkIPloHQMtfhVabrq5N7Rf/Jb5NOWKYhZgULgWXKhE
         BGxNfajR8eczlwMYDG1uEtwk+bce5hnubdI0gY+5v+YfNSeDCieQsZ2WmyKqfSlr+VD/
         1/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qy+VUI9BXr6HazxoMIsIcdlYXr2Zkw6Es0halgF2Fhw=;
        b=jB9RngQP+gw3f/rmgrNQLlw98JzCDuyCvgOQ5P69Zn2Jx2HYFOUY/moTRTJNGLFiew
         hAapDDureuGJ+bgKVjbguWakZNmKJt4FNJgdDX46NGv2bDMkTmaJdK0shf8FxDGswxtD
         hNbF6wwclhfeypdk7cygR/o4fumRX8JfGsZdDzsMOPc8Dmk+on5iDkIOeQwO1kDHlSNh
         PfKGMkJYUb2XnHCD/4hGUQuXxfO4JoawdQLRG8nKgpwZNMNTr9GMIVNIfKUhYFsplBLl
         5EQjV8RTeHTrrl7gVWvOPQvSj1n+55NHsYkdwRDZhEbOTCtgcK/LMmZxzrPHnKLoKmww
         gpNQ==
X-Gm-Message-State: AOAM533N4QtpdX6EhG9zADLDS6zAPC4oBPdTo+xWZkOC6rq/dOWiGk/v
        vN4Kevz5vJy7SVuZV+x6n5BQow==
X-Google-Smtp-Source: ABdhPJx5dw7ns+PEDpJmj41ddtOfdNs+k8f+Q+FRgiqp1pfkmjrl7qaCK6KSXenVzyoYRhNeR59CDw==
X-Received: by 2002:a1c:b402:: with SMTP id d2mr4422934wmf.38.1606934489275;
        Wed, 02 Dec 2020 10:41:29 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:5ddd:b7c5:e3c9:e87a])
        by smtp.gmail.com with ESMTPSA id o13sm2910262wmc.44.2020.12.02.10.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:41:28 -0800 (PST)
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
Subject: [PATCH v4 01/26] kvm: arm64: Add kvm-arm.mode early kernel parameter
Date:   Wed,  2 Dec 2020 18:40:57 +0000
Message-Id: <20201202184122.26046-2-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202184122.26046-1-dbrazdil@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an early parameter that allows users to select the mode of operation
for KVM/arm64.

For now, the only supported value is "protected". By passing this flag
users opt into the hypervisor placing additional restrictions on the
host kernel. These allow the hypervisor to spawn guests whose state is
kept private from the host. Restrictions will include stage-2 address
translation to prevent host from accessing guest memory, filtering its
SMC calls, etc.

Without this parameter, the default behaviour remains selecting VHE/nVHE
based on hardware support and CONFIG_ARM64_VHE.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 10 ++++++++++
 arch/arm64/include/asm/kvm_host.h               |  9 +++++++++
 arch/arm64/kvm/arm.c                            | 16 ++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 526d65d8573a..ee9f13776388 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2259,6 +2259,16 @@
 			for all guests.
 			Default is 1 (enabled) if in 64-bit or 32-bit PAE mode.
 
+	kvm-arm.mode=
+			[KVM,ARM] Select one of KVM/arm64's modes of operation.
+
+			protected: nVHE-based mode with support for guests whose
+				   state is kept private from the host.
+				   Not valid if the kernel is running in EL2.
+
+			Defaults to VHE/nVHE based on hardware support and
+			the value of CONFIG_ARM64_VHE.
+
 	kvm-arm.vgic_v3_group0_trap=
 			[KVM,ARM] Trap guest accesses to GICv3 group-0
 			system registers
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 21ce5c420247..bca38ccade58 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -50,6 +50,15 @@
 #define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
 				     KVM_DIRTY_LOG_INITIALLY_SET)
 
+/*
+ * Mode of operation configurable with kvm-arm.mode early param.
+ * See Documentation/admin-guide/kernel-parameters.txt for more information.
+ */
+enum kvm_mode {
+	KVM_MODE_DEFAULT,
+	KVM_MODE_PROTECTED,
+};
+
 DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
 extern unsigned int kvm_sve_max_vl;
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 7e86207fa2fc..01cf6ac5b2cb 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -45,6 +45,8 @@
 __asm__(".arch_extension	virt");
 #endif
 
+static enum kvm_mode kvm_mode = KVM_MODE_DEFAULT;
+
 DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
 
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
@@ -1868,6 +1870,20 @@ void kvm_arch_exit(void)
 	kvm_perf_teardown();
 }
 
+static int __init early_kvm_mode_cfg(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (strcmp(arg, "protected") == 0) {
+		kvm_mode = KVM_MODE_PROTECTED;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+early_param("kvm-arm.mode", early_kvm_mode_cfg);
+
 static int arm_init(void)
 {
 	int rc = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
-- 
2.29.2.454.gaff20da3a2-goog

