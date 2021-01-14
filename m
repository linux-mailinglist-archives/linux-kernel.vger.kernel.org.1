Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B4C2F55FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbhANArW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 19:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbhANAjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:39:15 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97D4C0617A4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:37:42 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id l7so2936158qvp.15
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Yn6K+Al6keU4qwvbVZAct8COFyc60/5tuafg8uWsv9s=;
        b=GS6+9cj6bVKPfRttuQ0OZ/gu/AsdxWthI6birI03VxeJb329XZwukIQq4bqq7K4gJS
         j91y+ixUlBa+XlE8v7BJbEh3opw0dlXyeMZ1gAX0edJAlFapMSehK/ME8xkZrOE1bxEc
         4LHRU4RdoHMq7krywcO/0tV5tsJIBWHXX+J/TSWdRUf6KwSb3QCz2L4EKvZ5r19Vvmlg
         7cJxtmSqa/q2cFomiqcWZzaNpDI/BOzwCdqrtJEMx4QT6iA5ODADGquyUKIe1R+NVmq0
         kMVppEH/pbzbWNzt7gTer5fwzh9t2qzV5HiXMaEO1s/zpPQBfoyf/nH4520yX7ychR6A
         vF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Yn6K+Al6keU4qwvbVZAct8COFyc60/5tuafg8uWsv9s=;
        b=c/I5Sz1GZ4zFbIj2XYIq/bcZJWsvi/qqahYR/+SmfcgMIishu+7oqpq4a5t0xcDjUg
         axqyOGZOIOMvKKbpuK2GpWAJIRG35WoNx7K2GuBnhc5EV7T1zWYxX3TEXuSJfFfO7HIo
         iMtkKby1Yk5NvP7ExuQMll9xIkE6wmpkBZ/LMBIdI3y3KkiVuvOndWdISizCViE6bmvU
         uG/4CgVxtdDrDwKc+gDhgg159hMxc8oPrD3xNpz9I31cL1uNez/7C0jmZ0ouhF6737dG
         0Cpi0T8agYOWMoO/U9fGRBV5mpIvtEaX6rpv82llZWOEzi8mnSL2mRZSE3OvcnlAxk2N
         QRIQ==
X-Gm-Message-State: AOAM5302zFS/f0yqnqQL9ajR/DrNPkA+G4dDDfgfJh04MEsT2/sgXmT5
        aBMrWUEJAr4uFifCzCHvS0K+DosPvAE=
X-Google-Smtp-Source: ABdhPJwET5/FgHxggwO9NJkiIa/7tDnom5JB75FWqiMIu+CYa8J3rxhBsOEsUoDXlnwDytx02ooiXilB3kI=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a0c:8445:: with SMTP id l63mr4984501qva.60.1610584662011;
 Wed, 13 Jan 2021 16:37:42 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Jan 2021 16:36:57 -0800
In-Reply-To: <20210114003708.3798992-1-seanjc@google.com>
Message-Id: <20210114003708.3798992-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210114003708.3798992-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 03/14] KVM: SVM: Move SEV module params/variables to sev.c
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unconditionally invoke sev_hardware_setup() when configuring SVM and
handle clearing the module params/variable 'sev' and 'sev_es' in
sev_hardware_setup().  This allows making said variables static within
sev.c and reduces the odds of a collision with guest code, e.g. the guest
side of things has already laid claim to 'sev_enabled'.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 11 +++++++++++
 arch/x86/kvm/svm/svm.c | 15 +--------------
 arch/x86/kvm/svm/svm.h |  2 --
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0eeb6e1b803d..8ba93b8fa435 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -27,6 +27,14 @@
 
 #define __ex(x) __kvm_handle_fault_on_reboot(x)
 
+/* enable/disable SEV support */
+static int sev = IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT);
+module_param(sev, int, 0444);
+
+/* enable/disable SEV-ES support */
+static int sev_es = IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT);
+module_param(sev_es, int, 0444);
+
 static u8 sev_enc_bit;
 static int sev_flush_asids(void);
 static DECLARE_RWSEM(sev_deactivate_lock);
@@ -1249,6 +1257,9 @@ void __init sev_hardware_setup(void)
 	bool sev_es_supported = false;
 	bool sev_supported = false;
 
+	if (!IS_ENABLED(CONFIG_KVM_AMD_SEV) || !sev)
+		goto out;
+
 	/* Does the CPU support SEV? */
 	if (!boot_cpu_has(X86_FEATURE_SEV))
 		goto out;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ccf52c5531fb..f89f702b2a58 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -189,14 +189,6 @@ module_param(vls, int, 0444);
 static int vgif = true;
 module_param(vgif, int, 0444);
 
-/* enable/disable SEV support */
-int sev = IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT);
-module_param(sev, int, 0444);
-
-/* enable/disable SEV-ES support */
-int sev_es = IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT);
-module_param(sev_es, int, 0444);
-
 bool __read_mostly dump_invalid_vmcb;
 module_param(dump_invalid_vmcb, bool, 0644);
 
@@ -976,12 +968,7 @@ static __init int svm_hardware_setup(void)
 		kvm_enable_efer_bits(EFER_SVME | EFER_LMSLE);
 	}
 
-	if (IS_ENABLED(CONFIG_KVM_AMD_SEV) && sev) {
-		sev_hardware_setup();
-	} else {
-		sev = false;
-		sev_es = false;
-	}
+	sev_hardware_setup();
 
 	svm_adjust_mmio_mask();
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 0fe874ae5498..8e169835f52a 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -408,8 +408,6 @@ static inline bool gif_set(struct vcpu_svm *svm)
 #define MSR_CR3_LONG_MBZ_MASK			0xfff0000000000000U
 #define MSR_INVALID				0xffffffffU
 
-extern int sev;
-extern int sev_es;
 extern bool dump_invalid_vmcb;
 
 u32 svm_msrpm_offset(u32 msr);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

