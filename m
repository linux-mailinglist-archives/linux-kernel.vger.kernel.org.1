Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9CF2EFC5D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 01:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbhAIAtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 19:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbhAIAtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 19:49:01 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A43C06179A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 16:47:50 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b131so17254741ybc.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 16:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=d4pr2++w40O0CLns88f/iirKEVNPW2czC2n8QXn3KSs=;
        b=jOYGQisjm9xhAXR+CLMMyJg7LdjSdq9yi0HPO1bF6wAKQ1S7bheGPmquyLr2unxV0i
         Z/GUQBpPxP0mtbaANOzCBQKkFoy3XLHtGui971CsN2lIon9nV0kJC6PdCjXTbKMWGMsS
         bGg4C6ztOfSm3OdTjJnOBjkwVV6EWXSmm/9skbaRspNARSCewKDPS8xFb4SxjTPqiERL
         TO/Ml7hd71+URP+m8JdvZWHhOF3+3tHpGoE0biUtDFojYQgKFZzgL7jubpKjIpzWvJ2G
         Q1tYaGoZQJgxUGpty5T/RMnqFrRDHPjLI7GaxRPkPMou56tSjCJrgihNqJNCKbFFjG+s
         E2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=d4pr2++w40O0CLns88f/iirKEVNPW2czC2n8QXn3KSs=;
        b=U3WsKYtLBRUWJNeuYJUAanBs1kzEDKGEiBYMx+gAHfv3zsC2xhws++QM0UUhvWtRy7
         4s3c8MasOrnO6pFGv2TZNBdzVUOaLJorbtBl0chF19BjhHybHrwMzqcQ59A/dRkTHO6u
         VNNOV/9TznpGcDGsY6rj/9vV3nVTh/E+XWPyJEgLwKagfzeckqHjGVYgiZSgFCZgHAB+
         GdEUapm6aHo6dQVxMz6AUCTSvl/aGj3N6CEZ75KW1qyx3aJN6j68bIGJz31CMBTgwcEt
         lS1nzD3ESokQDwchCKI8Xs2uzWil2mQZhBm3JbLS8Xu8lhmBKtPrafXA4lUX5H4GE/Ju
         iv0g==
X-Gm-Message-State: AOAM532pbb7Yz5RkV8s7yCefiT0T2PDrYhu2d1hKY14aWEed35Zp/t8r
        P31+9PdEN1+mrtCmL/sICOQY29j2xW8=
X-Google-Smtp-Source: ABdhPJxM39JuPDl5IOydMdQW3d2GaPMtqTBVSEufrjpujCuiHWOYifsHOltB/A/6IgqsOGYr4Vw3IoAvxU0=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:743:: with SMTP id 64mr8822114ybh.333.1610153269944;
 Fri, 08 Jan 2021 16:47:49 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  8 Jan 2021 16:47:07 -0800
In-Reply-To: <20210109004714.1341275-1-seanjc@google.com>
Message-Id: <20210109004714.1341275-7-seanjc@google.com>
Mime-Version: 1.0
References: <20210109004714.1341275-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 06/13] x86/sev: Rename global "sev_enabled" flag to "sev_guest"
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

Use "guest" instead of "enabled" for the global "running as an SEV guest"
flag to avoid confusion over whether "sev_enabled" refers to the guest or
the host.  This will also allow KVM to usurp "sev_enabled" for its own
purposes.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/mem_encrypt.h | 2 +-
 arch/x86/mm/mem_encrypt.c          | 4 ++--
 arch/x86/mm/mem_encrypt_identity.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 2f62bbdd9d12..9b3990928674 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -20,7 +20,7 @@
 
 extern u64 sme_me_mask;
 extern u64 sev_status;
-extern bool sev_enabled;
+extern bool sev_guest;
 
 void sme_encrypt_execute(unsigned long encrypted_kernel_vaddr,
 			 unsigned long decrypted_kernel_vaddr,
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index bc0833713be9..0f798355de03 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -44,7 +44,7 @@ EXPORT_SYMBOL(sme_me_mask);
 DEFINE_STATIC_KEY_FALSE(sev_enable_key);
 EXPORT_SYMBOL_GPL(sev_enable_key);
 
-bool sev_enabled __section(".data");
+bool sev_guest __section(".data");
 
 /* Buffer used for early in-place encryption by BSP, no locking needed */
 static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
@@ -344,7 +344,7 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
  */
 bool sme_active(void)
 {
-	return sme_me_mask && !sev_enabled;
+	return sme_me_mask && !sev_guest;
 }
 
 bool sev_active(void)
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 6c5eb6f3f14f..91b6b899c02b 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -545,7 +545,7 @@ void __init sme_enable(struct boot_params *bp)
 
 		/* SEV state cannot be controlled by a command line option */
 		sme_me_mask = me_mask;
-		sev_enabled = true;
+		sev_guest = true;
 		physical_mask &= ~sme_me_mask;
 		return;
 	}
-- 
2.30.0.284.gd98b1dd5eaa7-goog

