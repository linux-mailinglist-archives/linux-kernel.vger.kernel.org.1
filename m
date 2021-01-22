Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97129300DB7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 21:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbhAVU25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729901AbhAVU0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:26:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1A7C06121F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:22:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k7so6582444ybm.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ut/T6G9w71CC8HxNYO0u5RfiusnblVieh7wlxdxSOrI=;
        b=ZtWeshgPgZFT5yQIvxcM8SgjVvKSYldmaFOWVPWpa7cHVfKH1Vif6eY40k2Y5/9f4O
         ljrfJkzqfwvROg9IjLCwTTabk8eO35wsFAsljC7ZijOOcj2LI4ITfI2RKNxwu26GbK+J
         CEw64JAKIanQZE5O9DA4kgHRinl8/thJ66tv8mtj6J6rePNXHvhIrvNjMDhOVTgII4V8
         Wjy3gRo1RA2DLb3adHTd2KOaKhlc9a87qK3huJXbGsvZzTVfbKzMpf7+6RxADg7x3YUm
         WzNT7nYS5herjV4J3KXpLDxeNMKUzf8q8iFG8X0+OYpF52eFKqg6uw3NC9jFqoRTZQU0
         NGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ut/T6G9w71CC8HxNYO0u5RfiusnblVieh7wlxdxSOrI=;
        b=p7Whnf+zKP6qv9cCr1tBOZC/5sd9ab/ESZ8AOFJG7wmL+3+O18n9U1s7U98zQEEv3C
         /M9nYejJJ8RKQN0iQvRn/IsiK6hr1ZGFGD7SIxArNWK0G2UtsX4hEwXU5lEvN+viZojd
         SXoIqrr9TIFzMhw6iUup7QBm2zy9Rck7pqJRrlYGG6ycS0agKGXtrJv0qS7QRhWKy1Pq
         KYRU7w4YIW7pMgfUyC2fDvOtl0KlB90AMQ6Z4yfDzSgM95Mi1gUVH3J0oihX+xJE21Em
         YCwRUNHZMo87gmY9eP7BZKPRsKuSyNMqvhqvmWtmgDxlAaa+npUIEtBQmYK4xBprPI1J
         imQg==
X-Gm-Message-State: AOAM533D7wsrbyyuET/XQ41cPTOXpbgejaeY/QEuRIs1jXOm0KuP5VFK
        HC0usroTQcfT/6cdbIC/Po3zY9wvlzI=
X-Google-Smtp-Source: ABdhPJzU0vWM6wYGFiAUoIChr7p55Yc7uqfLcyX3pxdBDck5MZeamqNODJnRxoFV+aaIRs66gnd9KswWCuo=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a05:6902:701:: with SMTP id
 k1mr8686405ybt.342.1611346934044; Fri, 22 Jan 2021 12:22:14 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 22 Jan 2021 12:21:40 -0800
In-Reply-To: <20210122202144.2756381-1-seanjc@google.com>
Message-Id: <20210122202144.2756381-10-seanjc@google.com>
Mime-Version: 1.0
References: <20210122202144.2756381-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v3 09/13] KVM: SVM: Explicitly check max SEV ASID during sev_hardware_setup()
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

Query max_sev_asid directly after setting it instead of bouncing through
its wrapper, svm_sev_enabled().  Using the wrapper is unnecessary
obfuscation.

No functional change intended.

Reviewed by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 75a83e2a8a89..0c69de022614 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1278,8 +1278,7 @@ void __init sev_hardware_setup(void)
 
 	/* Maximum number of encrypted guests supported simultaneously */
 	max_sev_asid = ecx;
-
-	if (!svm_sev_enabled())
+	if (!max_sev_asid)
 		goto out;
 
 	/* Minimum ASID value that should be used for SEV guest */
-- 
2.30.0.280.ga3ce27912f-goog

