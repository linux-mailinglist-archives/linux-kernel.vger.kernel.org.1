Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB9A300DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 21:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbhAVU0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731096AbhAVUXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:23:42 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB23C061797
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:21:59 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id v130so1222148qkb.14
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=DVxhAu/UjXY5hWMeDmkVTFl5iW0qT/7YPmVJEXaHiSg=;
        b=ZiWyRwgQQPsTNO8N5PSnPu5eQG0ql29pRJuVy3Q0C7kKDGhFCO/+TQG6iSFTaXxXjx
         fUUZX7tK7+ogZkzXsq1Hpp3DSjuYwFg+IvlC4BLond2ANBD9oLoKQDgnNVJ/BswOC8M1
         x+mm/5jD58EFv0RyJ9gUUSUsVE0lu0jEKevCXKTRRLdyY7+JXnGVyjkDpbsiL+FGZgQU
         GEEAyXMt8JKLC7g96brHbYaigGyD3lSVM8HN6Sa0kOMsUvNObuMIL1GHtGVgz8nqH8+f
         Di/Y90jPGY842vnFqLC1DXPUf9dvzH6V8TSoAnFvDd8vuTkz6Uf7X6Xm0KSgdBi5I87X
         cEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=DVxhAu/UjXY5hWMeDmkVTFl5iW0qT/7YPmVJEXaHiSg=;
        b=GcoLBgZoW6T1REe+YQTyLMsBz/geHPLDzIKTqohw7UdPjszR77K8D2YFBGUYA6tpKL
         eKVZ57/x5h1g0/xz3jZWUEEo8AjRT7NfD9WY3CJ3jXglVFVU2vi2tgnCMYSPUJVtlGed
         /XHuQV0j2hiGX1s7UXdWdyMLkR9Ug3TlBEK5H32JjHtFG6WqLsgxIMCKmLyGZkXrfyEi
         f/FSck4tnEr+svvqbM2/2s7ezjT2Z0nAD7Ij4OemSmWe5yyH0cX92jNL4cM2qAx5c7fJ
         1d1GUISnLiJ8bgkSdgwzC7JpFbqUtPcYyD4QB9H1JgPPCPJ1fSzsh0RVxLMFdCbGejH7
         vEkQ==
X-Gm-Message-State: AOAM530hbWeyo8Eq+VfOODcnh57fKSga7GyiIm/PSfS1e1LA4HZc15VJ
        T8JvJU7g+cKrG6/HA6oawH4J8iLeWKQ=
X-Google-Smtp-Source: ABdhPJxaBwxpO2PVbRBf95Ce2ILMQNBt6KRaW/RPOxJeX8apG7sdSe+2zruPj77KXUpL2dzsQ0yn5xSnF9s=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a0c:a99e:: with SMTP id a30mr477497qvb.38.1611346918763;
 Fri, 22 Jan 2021 12:21:58 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 22 Jan 2021 12:21:34 -0800
In-Reply-To: <20210122202144.2756381-1-seanjc@google.com>
Message-Id: <20210122202144.2756381-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210122202144.2756381-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v3 03/13] KVM: SVM: Move SEV module params/variables to sev.c
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

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 11 +++++++++++
 arch/x86/kvm/svm/svm.c | 15 +--------------
 arch/x86/kvm/svm/svm.h |  2 --
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index ec742dabbd5b..4595f04310e2 100644
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
index 5bd797c7ee60..d223db3a77b0 100644
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
 
@@ -975,12 +967,7 @@ static __init int svm_hardware_setup(void)
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
2.30.0.280.ga3ce27912f-goog

