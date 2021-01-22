Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E26300DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 21:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbhAVU3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729854AbhAVU0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:26:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6F3C061224
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:22:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b62so6630018ybg.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=OCy456duBz1gUTENw/PGNr1MaaBImebv94ZBlfupr7M=;
        b=Yj28gS0BBPxkUQM8hmXirFPzaP+oJHyzCj/JId6vY5QRRDMTHtgAjoAXVveOq2+8IR
         K3/39u5QqK7ch2vvuvtqxxI/9qf12nuc4pqseMNiOKyyeGrqPEU5bbilbLm/fXVgul+a
         Tx6UDwK2+ldvL15/nJo13w9TgOFlA+3Gaei4qyvo/MMtnrV3O5m+RfD6Nlui/xA75Ku+
         esh71yRR3Mg8HBOBUkyle1wUm6MsOh0XkaN7jHfGDGOwVbRQD/qaFu6uE2xZ5pq8hT3o
         GK4doR/epDeJE/nCm3KH0bAq1GBD9CtsswQX0QLGLYzG9zQFgheCuXoBJwtr6B8JFnT8
         fQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=OCy456duBz1gUTENw/PGNr1MaaBImebv94ZBlfupr7M=;
        b=cA/sBzVg1gs6N8JDaQLgEARV9AW7mgjgJKto1mcSk9qTuaUNpj1+u/g35m38lmct9Y
         sZkHkrE8V1tnHs3sISRYCD++2crnRutVtBOCAX64l1H76fRMUn/mHi6Ld8YDebnqPq+e
         NfihV8pxzBOxkgnqLKBiwXg1ghzH9b8OxXlqrp+P4TedpZ20/ywCsCGVEedkAIf2/wDt
         QSEE7uzqn6e0rDhaW96OcbuajLUig0fWd334DFwJm/CmPvXyED7l16AUOCdP96Jxeazj
         mEfPU47H7DM475r2P+8rqQk7ZVKCSuMEx8infApyTWlExeNTp+zEGjL8w5b4U9OcRBHE
         i7Ng==
X-Gm-Message-State: AOAM532yu4QHAd0Lk/iieAb+SP9/q9JIMMJJiGj5TNSUG1+bC5MyAKxN
        KpEPeglQILcUUVxzukPSEr0ysS/3XNw=
X-Google-Smtp-Source: ABdhPJzYBv6MhPX2CO9MpRYE+DXMwRTMBvvYyW+dIEogD2+gdXiu+m1t2YG9WoYTUQdrrFnzRuZG8vvSlt0=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:7544:: with SMTP id q65mr7827570ybc.200.1611346938885;
 Fri, 22 Jan 2021 12:22:18 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 22 Jan 2021 12:21:42 -0800
In-Reply-To: <20210122202144.2756381-1-seanjc@google.com>
Message-Id: <20210122202144.2756381-12-seanjc@google.com>
Mime-Version: 1.0
References: <20210122202144.2756381-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v3 11/13] KVM: SVM: Drop redundant svm_sev_enabled() helper
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

Replace calls to svm_sev_enabled() with direct checks on sev_enabled, or
in the case of svm_mem_enc_op, simply drop the call to svm_sev_enabled().
This effectively replaces checks against a valid max_sev_asid with checks
against sev_enabled.  sev_enabled is forced off by sev_hardware_setup()
if max_sev_asid is invalid, all call sites are guaranteed to run after
sev_hardware_setup(), and all of the checks care about SEV being fully
enabled (as opposed to intentionally handling the scenario where
max_sev_asid is valid but SEV enabling fails due to OOM).

Reviewed by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 6 +++---
 arch/x86/kvm/svm/svm.h | 5 -----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 55a47a34a0ef..15bdc97454ab 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1057,7 +1057,7 @@ int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 	struct kvm_sev_cmd sev_cmd;
 	int r;
 
-	if (!svm_sev_enabled() || !sev_enabled)
+	if (!sev_enabled)
 		return -ENOTTY;
 
 	if (!argp)
@@ -1322,7 +1322,7 @@ void __init sev_hardware_setup(void)
 
 void sev_hardware_teardown(void)
 {
-	if (!svm_sev_enabled())
+	if (!sev_enabled)
 		return;
 
 	bitmap_free(sev_asid_bitmap);
@@ -1333,7 +1333,7 @@ void sev_hardware_teardown(void)
 
 int sev_cpu_init(struct svm_cpu_data *sd)
 {
-	if (!svm_sev_enabled())
+	if (!sev_enabled)
 		return 0;
 
 	sd->sev_vmcbs = kcalloc(max_sev_asid + 1, sizeof(void *), GFP_KERNEL);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 4eb4bab0ca3e..8cb4395b58a0 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -569,11 +569,6 @@ void svm_vcpu_unblocking(struct kvm_vcpu *vcpu);
 
 extern unsigned int max_sev_asid;
 
-static inline bool svm_sev_enabled(void)
-{
-	return IS_ENABLED(CONFIG_KVM_AMD_SEV) ? max_sev_asid : 0;
-}
-
 void sev_vm_destroy(struct kvm *kvm);
 int svm_mem_enc_op(struct kvm *kvm, void __user *argp);
 int svm_register_enc_region(struct kvm *kvm,
-- 
2.30.0.280.ga3ce27912f-goog

