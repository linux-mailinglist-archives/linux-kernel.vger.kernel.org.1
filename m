Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26F62EFC5F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 01:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbhAIAtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 19:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbhAIAtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 19:49:11 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80313C06179C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 16:47:53 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id a17so10577851qko.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 16:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=dyPlu6qMQUJ5LjPtUc+nebDh2loDqHfHQ3wm6f9Tp5o=;
        b=dVRnIHGiQJSzr0UHXeto2OOOBaBXSN2owjt2UtrYDw4giQKl05OFRVg+fq3hekxNB5
         +GMPBB47eVpf8p41AmnbiYXBcAD9TsbX4wEEqZo1vYFa+UaBMmzjygCmkVPYIqlQOLV4
         9uFMoM7R1qnv1XvlIKdKHfYQc1eI6g69Kd/k0L95Qzi2k2i5trEMAWRDKfuJntVA5WT6
         ERRv91xXWkUkLPLUsUjxUwjZvtql2PVE2RbOht/e/jg7RMKGzfItHs/+E4ARkczFkGfY
         RKRK/yc2LQkW8C0QCh41LQhkIEEDJEStv4SKdS6kMNrwDJHWptb2k52doX9O/A8k55DE
         sgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=dyPlu6qMQUJ5LjPtUc+nebDh2loDqHfHQ3wm6f9Tp5o=;
        b=tmGACiCQ5MBLzgRvnwBpJp+aJYpECnOuvCtpc4GPDsODitpnu508OEpUwhUmMNCFb6
         tsLsxVFuiRuW6yGjaLIxwWo/kWB3ygIDZBsF/cw9gOKHSWM5uEjDVeX1ok2c9vuaX4Zz
         ze/dfXAtDzSRbPyfxgUhVC9jE0J3Z/bIW43ZGLTmY+iOYPZijhNc1t6P0FdSuyVZYaR5
         8fYLUkMFS4EzmDK98Uxpqz1W2Ffx7Ee8hXfyqEIrTzD54A7MIInHbzfzhQH04khln84B
         gOi548c4N4Wp7rCh7OLwgk60SHOMUfrlzk4NJDYO1mOSRK2p+bPf0LJGOqAi8TF/J1zg
         e9jQ==
X-Gm-Message-State: AOAM531VKyFoj2xv9os2QFKCLrAAGW5aKJbpZOcTOxwaKPSvoZmXVSwF
        Kp2Uq2VGpE1jyOLE45s23fJeXvhXlcs=
X-Google-Smtp-Source: ABdhPJx5uNFlnXoBmo29Hg2qrMf8X5oxWz9P6URzdT9YeG34B54qUi08KKILd1696s4SZ+fig3pUMd/8Q0s=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a05:6214:1868:: with SMTP id
 eh8mr6375071qvb.50.1610153272597; Fri, 08 Jan 2021 16:47:52 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  8 Jan 2021 16:47:08 -0800
In-Reply-To: <20210109004714.1341275-1-seanjc@google.com>
Message-Id: <20210109004714.1341275-8-seanjc@google.com>
Mime-Version: 1.0
References: <20210109004714.1341275-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 07/13] KVM: SVM: Append "_enabled" to module-scoped SEV/SEV-ES
 control variables
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
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename sev and sev_es to sev_enabled and sev_es_enabled respectively to
better align with other KVM terminology, and to avoid pseudo-shadowing
when the variables are moved to sev.c in a future patch ('sev' is often
used for local struct kvm_sev_info pointers).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 8ba93b8fa435..a024edabaca5 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -28,12 +28,12 @@
 #define __ex(x) __kvm_handle_fault_on_reboot(x)
 
 /* enable/disable SEV support */
-static int sev = IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT);
-module_param(sev, int, 0444);
+static bool sev_enabled = IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT);
+module_param_named(sev, sev_enabled, bool, 0444);
 
 /* enable/disable SEV-ES support */
-static int sev_es = IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT);
-module_param(sev_es, int, 0444);
+static bool sev_es_enabled = IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT);
+module_param_named(sev_es, sev_es_enabled, bool, 0444);
 
 static u8 sev_enc_bit;
 static int sev_flush_asids(void);
@@ -213,7 +213,7 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 static int sev_es_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 {
-	if (!sev_es)
+	if (!sev_es_enabled)
 		return -ENOTTY;
 
 	to_kvm_svm(kvm)->sev_info.es_active = true;
@@ -1052,7 +1052,7 @@ int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 	struct kvm_sev_cmd sev_cmd;
 	int r;
 
-	if (!svm_sev_enabled() || !sev)
+	if (!svm_sev_enabled() || !sev_enabled)
 		return -ENOTTY;
 
 	if (!argp)
@@ -1257,7 +1257,7 @@ void __init sev_hardware_setup(void)
 	bool sev_es_supported = false;
 	bool sev_supported = false;
 
-	if (!IS_ENABLED(CONFIG_KVM_AMD_SEV) || !sev)
+	if (!IS_ENABLED(CONFIG_KVM_AMD_SEV) || !sev_enabled)
 		goto out;
 
 	/* Does the CPU support SEV? */
@@ -1294,7 +1294,7 @@ void __init sev_hardware_setup(void)
 	sev_supported = true;
 
 	/* SEV-ES support requested? */
-	if (!sev_es)
+	if (!sev_es_enabled)
 		goto out;
 
 	/* Does the CPU support SEV-ES? */
@@ -1309,8 +1309,8 @@ void __init sev_hardware_setup(void)
 	sev_es_supported = true;
 
 out:
-	sev = sev_supported;
-	sev_es = sev_es_supported;
+	sev_enabled = sev_supported;
+	sev_es_enabled = sev_es_supported;
 }
 
 void sev_hardware_teardown(void)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

