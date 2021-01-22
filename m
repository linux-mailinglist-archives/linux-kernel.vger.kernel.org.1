Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAB3300DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 21:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbhAVU3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729907AbhAVU01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:26:27 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059CBC061226
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:22:22 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b62so6630100ybg.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=9YyrF+bNfu25OZDUV03DuKXOU6fNcwhwu/YWG0B3SQ8=;
        b=rkx40f1M9VAr0cpXIu1eyy0Dwe7m7iby0h03XkrYRYabaqizQuaf1H8qCwh/pj/OmP
         oVYOWprMssUUpaNEfGiWq/9j5wrdXdW/EuQJVKjcINwGtFviuakOht313AMOPbeKiZc/
         dTFYHUUrTyVTmrp+xiX8/FpOFDoGJ8KsRIrA8CBQvGsTlap/gQvcKGG5Z2RYEf/no5Hs
         t55FirMq2F32tcozXIjNPDaXjkjPyj0o8xnk4ZzQWOjHQFeWuCIgWPjlynyY5fPifDKa
         b7NvK7OFfmwENO6Dehg8Br8iYkO/P0IOhvLyyicQgj0H37Ib8pG6Qu/AlxOJ4XnG5+Jm
         p9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=9YyrF+bNfu25OZDUV03DuKXOU6fNcwhwu/YWG0B3SQ8=;
        b=aKnI4EkBNcmSsT7kXMvX9stGeWC9AmMpr+nMxa8jIX8cPyJcNKhFoQ3AQfOKntV/Dm
         UZVA9gu0ukeEEuKxNS1hKjulUs9I2inyES4oDkcH8hzdwtRCBpfLsKcPWPO0J/iFqhAn
         mKCyQLHHCoAlmYHkqlK/ITmoCMjI4MaPnvm4ouhm3GG3f1AhkKV5HUMWt12Gay/fFxFK
         NnB6vn7d1r+eP+1NPGDyQvxbJVXTR5quGfBWe9U3ymWvgcHODGvAnvsn/xEPcPTtiS6x
         NH+w4Wkt9t9m3DuxMdcPgj0HzekbS6Goej7TruTPYvkN1U9O343AgjFIQl4aaf0wgE3/
         r2UA==
X-Gm-Message-State: AOAM5307NkPBYxNIXR5JFfTZxvBdn4DOn9VTLXlUlFDR6YuRurlhlxau
        ZI/gRBPCtaM5QKJBg57KhFS1/bM1TtI=
X-Google-Smtp-Source: ABdhPJyql0wBNVi8A3QrBM2L9OyFhQYkW3e5KFrtuET9Bxef7hzsQORrwjs0oMpO64gWKMEfJwqbVZ8nTRU=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:d80d:: with SMTP id p13mr9004983ybg.327.1611346941233;
 Fri, 22 Jan 2021 12:22:21 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 22 Jan 2021 12:21:43 -0800
In-Reply-To: <20210122202144.2756381-1-seanjc@google.com>
Message-Id: <20210122202144.2756381-13-seanjc@google.com>
Mime-Version: 1.0
References: <20210122202144.2756381-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v3 12/13] KVM: SVM: Remove an unnecessary prototype
 declaration of sev_flush_asids()
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

Remove the forward declaration of sev_flush_asids(), which is only a few
lines above the function itself.

No functional change intended.

Reviewed by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 15bdc97454ab..73da2af1e25d 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -41,7 +41,6 @@ module_param_named(sev_es, sev_es_enabled, bool, 0444);
 #endif /* CONFIG_KVM_AMD_SEV */
 
 static u8 sev_enc_bit;
-static int sev_flush_asids(void);
 static DECLARE_RWSEM(sev_deactivate_lock);
 static DEFINE_MUTEX(sev_bitmap_lock);
 unsigned int max_sev_asid;
-- 
2.30.0.280.ga3ce27912f-goog

