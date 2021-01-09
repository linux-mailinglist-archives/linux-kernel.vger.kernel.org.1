Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0456C2EFC5B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 01:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbhAIAtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 19:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbhAIAs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 19:48:58 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA13C061798
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 16:47:48 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n205so17317873ybf.20
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 16:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=6IjwYJ9nQQQ0VcUn254Dijwa+O3I16q70UCT60xMF6g=;
        b=VLOPOJ9HSsvTYI90Ybol+JWVm/ZNX/feHYo0aiZshBkwP0suEzToNYT24Su9ecnntO
         ZuApO308Gmd2c14dpt8Ud+2/e+qchelVHkY2rH+MhykB2bFMYNq0rjypZO6q3Be5pFB/
         +b/C1bvmytV4mG4LZNiGQJxZH0QoMVCjemAHoswQT/yvF4Y3pBpPyKHIDPnGE0qZKGJv
         91eXGEFz04FyD8+vuuTbcpt6zZ+hb/CDfroTVZyIS8EFZWORlueLiiq7/URseIL2tecP
         OdbK1msOXVq4ThCk79bcTIdjo2uP9ib3rl1pnBotny/0Y/JZImFEjEmpAy64+s02GUzo
         /BIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=6IjwYJ9nQQQ0VcUn254Dijwa+O3I16q70UCT60xMF6g=;
        b=Xbn58mniUSl0OF7DHLIXSTgVslSgXLg5a7Hn4XZ56fZtckKBLoM5FMymdg2fioX1S4
         FnezGlLpUNmEMG0CkB3Kb5/jqnkG9k0VRqMpWri2yWTS7BcR+tKfo684dHpMgKG4nawd
         bPjIk/5D9j1lnYQEGOTFTvQxKgsCiHbU0VwMoOdMKiIJjLcyFx1flc3sLyPGpO2vA625
         arEPotLKe05Y2G/MMhukwvp79JQUrAeP+pfZLrYqXIMdJ1JlCJ4cHwIFoWcA1Ouh2YgU
         rcAtbs9KBlDBwRXRwDMQKVkdmqyw3AKmLrUcUQtQ0OG8z5LH+Gok17adR/APp6J2q9g5
         ApZQ==
X-Gm-Message-State: AOAM530P/F7Kaw9CKEqaw/OfVKaW6HP4zZ8s9yHd4tk2bxVToiL2PsAI
        FxE52xPtBYMROO6ZLxInpJGcy0wObLI=
X-Google-Smtp-Source: ABdhPJzYPDKo26cD95Eoyaw8zqWykJfVRWquY1kv7ix//qit0AEvzQGBLaZGGOLoBQYS8n3IvAUsf7nILo8=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:6902:: with SMTP id e2mr9172424ybc.97.1610153267416;
 Fri, 08 Jan 2021 16:47:47 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  8 Jan 2021 16:47:06 -0800
In-Reply-To: <20210109004714.1341275-1-seanjc@google.com>
Message-Id: <20210109004714.1341275-6-seanjc@google.com>
Mime-Version: 1.0
References: <20210109004714.1341275-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 05/13] KVM: x86: Override reported SME/SEV feature flags with
 host mask
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

Add a reverse-CPUID entry for the memory encryption word, 0x8000001F.EAX,
and use it to override the supported CPUID flags reported to userspace.
Masking the reported CPUID flags avoids over-reporting KVM support, e.g.
without the mask a SEV-SNP capable CPU may incorrectly advertise SNP
support to userspace.

Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 2 ++
 arch/x86/kvm/cpuid.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 13036cf0b912..b7618cdd06b5 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -855,6 +855,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 	case 0x8000001F:
 		if (!boot_cpu_has(X86_FEATURE_SEV))
 			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
+		else
+			cpuid_entry_override(entry, CPUID_8000_001F_EAX);
 		break;
 	/*Add support for Centaur's CPUID instruction*/
 	case 0xC0000000:
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index dc921d76e42e..8b6fc9bde248 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -63,6 +63,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_8000_0007_EBX] = {0x80000007, 0, CPUID_EBX},
 	[CPUID_7_EDX]         = {         7, 0, CPUID_EDX},
 	[CPUID_7_1_EAX]       = {         7, 1, CPUID_EAX},
+	[CPUID_8000_001F_EAX] = {0x8000001f, 1, CPUID_EAX},
 };
 
 /*
-- 
2.30.0.284.gd98b1dd5eaa7-goog

