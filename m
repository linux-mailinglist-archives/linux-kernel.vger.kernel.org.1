Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B092F566D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbhANBrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729866AbhANAlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:41:20 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2234EC061386
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:38:06 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id c14so2983026qtn.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=1PXhge3fECdAHH1859vG2tx3fWnGqtvpPe5jLHhEzH0=;
        b=m/Ob1h5k8Qcn86h2CKm17uiLwwi+HcZXFYLNsmav/IO+yAOVm4uctiGgBzR3fFQx5K
         DfwlDq10Nkdk+egN+XlxbksR9Z/EOa1wPysaHHw+4sqE48t+L86B/gmuPVeiEL0d/bdp
         YUGsJB0JZngM9egxtaZhbzTCu9RQEZ1C5FOgf1i4J+gI5W9Tf2h6w2qOWJEnWLMuUtM4
         X4aBhzZNbFhNiM6cpN7Ql9UZno4f78T7+e4bHhtS8TIY6FaqV3sDXuf/oK083JRCEXSk
         /gPAaVUoEMUek+EPjy05vninvqA/yCkFWJumuxkQBdPyH6Kl4DibF4V+vDkTR2Yg1AI/
         i26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=1PXhge3fECdAHH1859vG2tx3fWnGqtvpPe5jLHhEzH0=;
        b=CBodEhOdwkNKhpFrZz2ZcO56jYHngySlZP/LnwPVf084DF9VAgVBpz7K/vl09RqLAx
         9C6eyRd1fYiZDM9YbIOUqUAGuqCPG+X8MnVbSsu2kLPAuDTNjN7L+kEBvgoMpHSXU1W1
         dXURALFXDTWNM3EwrCuGItrF6ILNqmE83TWWmwjFfsAz7NvrkpgwkiHMDybxibbB2+N+
         LKTU8NU1idilSHbjaB8aZEm+kCDiMPT/zSAI9VM6Pzc9v/p2z1YS14mIkw1wagyQ5okw
         Sr8kWp4HGQd8K9rhuDYfV1FAFe2SFjba+V+KwEcX7JAs4lCh30XNM7WMlvDafMH/6HY4
         Ia2w==
X-Gm-Message-State: AOAM532nHYguxhYpTAqAlzDVQJKhuS06K1KkGxKbBpsyk8iaMf5XGSZv
        S2zFOu7wPAMXu+5ctT1E05S27DvRz3k=
X-Google-Smtp-Source: ABdhPJyaHN/uRUEixUUzBfLUNzNajPFT6fTPHGFQhOtZ0Wj/MkKbdgGOUNA4ftqsQr5uUW5rcKsLralN/lU=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:1b05:: with SMTP id b5mr7079991ybb.298.1610584685242;
 Wed, 13 Jan 2021 16:38:05 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Jan 2021 16:37:06 -0800
In-Reply-To: <20210114003708.3798992-1-seanjc@google.com>
Message-Id: <20210114003708.3798992-13-seanjc@google.com>
Mime-Version: 1.0
References: <20210114003708.3798992-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 12/14] KVM: SVM: Drop redundant svm_sev_enabled() helper
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

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 6 +++---
 arch/x86/kvm/svm/svm.h | 5 -----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a2c3e2d42a7f..7e14514dd083 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1057,7 +1057,7 @@ int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 	struct kvm_sev_cmd sev_cmd;
 	int r;
 
-	if (!svm_sev_enabled() || !sev_enabled)
+	if (!sev_enabled)
 		return -ENOTTY;
 
 	if (!argp)
@@ -1321,7 +1321,7 @@ void __init sev_hardware_setup(void)
 
 void sev_hardware_teardown(void)
 {
-	if (!svm_sev_enabled())
+	if (!sev_enabled)
 		return;
 
 	bitmap_free(sev_asid_bitmap);
@@ -1332,7 +1332,7 @@ void sev_hardware_teardown(void)
 
 int sev_cpu_init(struct svm_cpu_data *sd)
 {
-	if (!svm_sev_enabled())
+	if (!sev_enabled)
 		return 0;
 
 	sd->sev_vmcbs = kmalloc_array(max_sev_asid + 1, sizeof(void *),
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
2.30.0.284.gd98b1dd5eaa7-goog

