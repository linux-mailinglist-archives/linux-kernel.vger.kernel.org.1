Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3929300DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 21:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbhAVU1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731114AbhAVUXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:23:46 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9F2C061351
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:22:04 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b62so6629397ybg.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=BH6NW1Mai4rLQ4WRK3FXI0EJ7CD5vswe91Mx0hLmZ8Q=;
        b=sFyAqgQ4OA9JfFvBiFO9c1rzOFk12NVND877+/Kh03E+Rm94ZVyWOIhqjnuK0x+aIF
         DDty17fBmsQcHpo7vd4eMlxb2KEGVD7l1HX1VCGRj3NcD/wRTBcVK2qXl5R8g7YW1ejv
         ixqWWGxuDeUs1IWD1e1Fjr42HuroGp6pY0IvemsG+Z1a6/1Q8EkWl9Gh2eKMT8UXHqQx
         97In8zxJBK2tROyozyuBZwIjD3NDiNSK3HbvSiafi1ujYOhIE5G5V/lptZCDqsbPC+UJ
         y2cEn8g9mA0qumtTITxMLpIqo3/cH0LPaCOOPTcOFpO4zjXgT82tJ79RWWBqtcC8ih7a
         tbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=BH6NW1Mai4rLQ4WRK3FXI0EJ7CD5vswe91Mx0hLmZ8Q=;
        b=OY6F/UcLHMtXJp4Cq6K0zB4i2LyMYoCZbVfJ/QrOnTo7vwGKm2r03dBRRoNSZfvuys
         uOh++YYhuV2r5fgaFH/zGn48FXAN0EG4JRnEKtU6D2c9I5N/48ANMzsgC7mxAltpWH8Y
         B/DaySkZZdg57XviJ+fvLhBZfYqvDrZwmZUJkctKYWDiCNokqmUstfNO3NRz+yEPhC4R
         M6sddZyDeeKVbPMu8Flc4btAEZjVvXCgWPgjqgTAc7NuK4D0N/zSQf5T1fT3y/omxUc2
         s0FPaeSzgRGdmLuE56YILAZy6CDyfM36AmAboK2HdJBe0hDQkpiOsyKK3WpZPo8i0Si4
         IxVQ==
X-Gm-Message-State: AOAM533kJ9kbtqJ7ibXktC4QqXP0rSEA2cDbYzq3mlnGIeovdmRkulB+
        Zn4PMKI/4MytsCB65pcWOPCp2rUPauA=
X-Google-Smtp-Source: ABdhPJwLnUcbJsYdvZxuW9eVZhvnZG6RpQtX1OzQypXUkD2zAq1VzX/umeH+Ar1m1M1cQqGjaBB4p0fAWVQ=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:8508:: with SMTP id w8mr9526074ybk.63.1611346923809;
 Fri, 22 Jan 2021 12:22:03 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 22 Jan 2021 12:21:36 -0800
In-Reply-To: <20210122202144.2756381-1-seanjc@google.com>
Message-Id: <20210122202144.2756381-6-seanjc@google.com>
Mime-Version: 1.0
References: <20210122202144.2756381-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v3 05/13] KVM: SVM: Append "_enabled" to module-scoped
 SEV/SEV-ES control variables
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

Rename sev and sev_es to sev_enabled and sev_es_enabled respectively to
better align with other KVM terminology, and to avoid pseudo-shadowing
when the variables are moved to sev.c in a future patch ('sev' is often
used for local struct kvm_sev_info pointers.

No functional change intended.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 4595f04310e2..ef2ae734b6bc 100644
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
@@ -1295,7 +1295,7 @@ void __init sev_hardware_setup(void)
 	sev_supported = true;
 
 	/* SEV-ES support requested? */
-	if (!sev_es)
+	if (!sev_es_enabled)
 		goto out;
 
 	/* Does the CPU support SEV-ES? */
@@ -1310,8 +1310,8 @@ void __init sev_hardware_setup(void)
 	sev_es_supported = true;
 
 out:
-	sev = sev_supported;
-	sev_es = sev_es_supported;
+	sev_enabled = sev_supported;
+	sev_es_enabled = sev_es_supported;
 }
 
 void sev_hardware_teardown(void)
-- 
2.30.0.280.ga3ce27912f-goog

