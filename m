Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988CB2F55AE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 01:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbhANAyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 19:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbhANAkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:40:09 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F63C0617BD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:37:55 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id t18so2951107qva.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Eex86gs96hXZoQkhC7w4R41A1RqEr+1bAqfy74t/uNE=;
        b=sNbbozuRHglAPmDNM3t2ZBQKhdBPsyzcxyC0flAsMj+J3jsbYRvq3Wr3TvUCV/XREN
         bMI3C+ufPzudYBYmTGBZ5/BZB6AHF9fms/jbQ7GEzHpXv61YjON5uHQ3VXpIY5OVaFZO
         sApoLda/kV4sTXxEIupOGGDN/gQ+AFqPpkSMFiMKVPN8SDfnntmbt60bjFPINYWX3PJD
         560Gs4wOoNZwKAsh7FEI25Ydsk9TZvWvbE25DwB7ISB4QiazsN3C6oDq2f0JUuE4MG8v
         RkUIyuv5zH4M2OHZEDQqy9YS0VmvYcvW6zFvzoQUvQeFezEtltf9e8eOipjg2l3q+VEE
         FOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Eex86gs96hXZoQkhC7w4R41A1RqEr+1bAqfy74t/uNE=;
        b=j1MxG4/2mlAAYyY1iP/RdYWzYX1KUkPeDDvBb8lfr+birXC2lFUJsNGSfONkYB08Hr
         k1nESuDGoF5QKYeZVZYVWlJRMBQBI9VSClRAO7SuCtrwI+prbExDqoKA/wp62jNbkMLV
         L9mS/97d/CP8RvJvv1idem3IaAk5A1WCQc1pZNJMIc9oMHsE77D62PbVuWh/1qHdLqgJ
         pewgdSgJ0DIr3Cfulu46blkTKXQir8DNgafg98Qhut6UoBK526OyMvCTomsF+iG7rUCK
         8dGzL1d3647DQtbBoCIN6mKkzEE0gAixgyUV+FPjomby3cR7aAxfbmqQ8FewYzylVltd
         H0xg==
X-Gm-Message-State: AOAM532be+A0MzaaMnfM6csvyF7WcgoLSz61hr1LrjSZiJeMdKZJbiKR
        OTtPr33U92UhTTEPg6nC7aM9nQKX/rE=
X-Google-Smtp-Source: ABdhPJwxLJFIcGZAW1SDEzJekpBS1zpkc/ptjpzUb3ZhOdP4HHSylaa/lyrgMl3PsCTZHSmE0euTzijUicw=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:500c:: with SMTP id e12mr7458603ybb.129.1610584675025;
 Wed, 13 Jan 2021 16:37:55 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Jan 2021 16:37:02 -0800
In-Reply-To: <20210114003708.3798992-1-seanjc@google.com>
Message-Id: <20210114003708.3798992-9-seanjc@google.com>
Mime-Version: 1.0
References: <20210114003708.3798992-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 08/14] KVM: SVM: Condition sev_enabled and sev_es_enabled
 on CONFIG_KVM_AMD_SEV=y
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

Define sev_enabled and sev_es_enabled as 'false' and explicitly #ifdef
out all of sev_hardware_setup() if CONFIG_KVM_AMD_SEV=n.  This kills
three birds at once:

  - Makes sev_enabled and sev_es_enabled off by default if
    CONFIG_KVM_AMD_SEV=n.  Previously, they could be on by default if
    CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y, regardless of KVM SEV
    support.

  - Hides the sev and sev_es module params when CONFIG_KVM_AMD_SEV=n.

  - Resolves a false positive -Wnonnull in __sev_recycle_asids() that is
    currently masked by the equivalent IS_ENABLED(CONFIG_KVM_AMD_SEV)
    check in svm_sev_enabled(), which will be dropped in a future patch.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a024edabaca5..02a66008e9b9 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -28,12 +28,17 @@
 #define __ex(x) __kvm_handle_fault_on_reboot(x)
 
 /* enable/disable SEV support */
+#ifdef CONFIG_KVM_AMD_SEV
 static bool sev_enabled = IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT);
 module_param_named(sev, sev_enabled, bool, 0444);
 
 /* enable/disable SEV-ES support */
 static bool sev_es_enabled = IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT);
 module_param_named(sev_es, sev_es_enabled, bool, 0444);
+#else
+#define sev_enabled false
+#define sev_es_enabled false
+#endif /* CONFIG_KVM_AMD_SEV */
 
 static u8 sev_enc_bit;
 static int sev_flush_asids(void);
@@ -1253,11 +1258,12 @@ void sev_vm_destroy(struct kvm *kvm)
 
 void __init sev_hardware_setup(void)
 {
+#ifdef CONFIG_KVM_AMD_SEV
 	unsigned int eax, ebx, ecx, edx;
 	bool sev_es_supported = false;
 	bool sev_supported = false;
 
-	if (!IS_ENABLED(CONFIG_KVM_AMD_SEV) || !sev_enabled)
+	if (!sev_enabled)
 		goto out;
 
 	/* Does the CPU support SEV? */
@@ -1311,6 +1317,7 @@ void __init sev_hardware_setup(void)
 out:
 	sev_enabled = sev_supported;
 	sev_es_enabled = sev_es_supported;
+#endif
 }
 
 void sev_hardware_teardown(void)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

