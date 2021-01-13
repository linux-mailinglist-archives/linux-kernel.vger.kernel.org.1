Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22D32F5444
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 21:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbhAMUqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 15:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbhAMUqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:46:00 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAF8C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:45:19 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id i1so2448613qtw.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=dWjn342r4gchACatmFqBw1A1idiYczd8S0EYhHJ6cqk=;
        b=LXS3/ITVuk/SnWCJkR/nTg4MXjPt/brCtDBIjSa268qeWXDMMq0bw98grRjb4gSo/D
         Yr7m+C/5PGKWXusNkHcPVMhYTPJ2sVbVQxHIIrTd+Z8qhkUxwX4bVXE9fUD99RjF3+0N
         wAkNVxSfRvaLMPlhGjhgL56WC+aE1m05Sx4eY9rCgPnxa0ugufDJcyRmcnuxX0uU+nSh
         wCUVhh/upnrdv9BKmMtFxVLOBjtgz8R1wyGZv/+vk0lP5qNjhPV0PkyJFrM//U25ik6o
         yORifaOQzbA2M4IcWMXJ9SI7lewXs0MqLMamPwpIiHKY1F8/hf1Jswt0LkM/KOk5qu7t
         nkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=dWjn342r4gchACatmFqBw1A1idiYczd8S0EYhHJ6cqk=;
        b=s3v62+g3ebESVfpozJ+4TY7ucnnrrMYzRGX+jyzDB/Ph84diHpRDLs5ZUeC0A/9g2w
         Mt3Pjuhx+vc6YLCleniFe2xFTxRL/30Z8Z3qi/GvekXbe2ICm4SIZZHwCHxGKSY/HBCJ
         iePvm2g+8NXgz4GQrSAvAQ+uPZ+taRj5iLKb4rRVn5aCiM7kfhSb/pWwNZEthn7bH/gS
         mDjKOU2DgJv87AMg5asjOsbBhZHeh1wOmkI9z5cbO1a/zBwukNggFlMHVURp3i5iWeTi
         a6E/0Hk/a7FRnVFfgkhNUB673rlblx7QedjyJK2C+nneFH8F20rMrK1BoCcgR1T9suae
         44gA==
X-Gm-Message-State: AOAM533eYs9Gz0JgHiq0/MRKkR+xKKpOjRwasoFjf+Aiqv0QSRSHK3yY
        G+iKzQP2yh11ZqkORzbA+JNOrYB9t6s=
X-Google-Smtp-Source: ABdhPJyF7RbfCRZcwkggVCSN3NJKobLj0tCZ/19NtoaDlqZFS8agG3ajSJPtaiX0BegIC2cNmKIQYvYUP10=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:ca4f:: with SMTP id a76mr6085531ybg.140.1610570718745;
 Wed, 13 Jan 2021 12:45:18 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Jan 2021 12:45:15 -0800
Message-Id: <20210113204515.3473079-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH] KVM: x86: Add more protection against undefined behavior in rsvd_bits()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compile-time asserts in rsvd_bits() to guard against KVM passing in
garbage hardcoded values, and cap the upper bound at '63' for dynamic
values to prevent generating a mask that would overflow a u64.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 581925e476d6..261be1d2032b 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -44,8 +44,15 @@
 #define PT32_ROOT_LEVEL 2
 #define PT32E_ROOT_LEVEL 3
 
-static inline u64 rsvd_bits(int s, int e)
+static __always_inline u64 rsvd_bits(int s, int e)
 {
+	BUILD_BUG_ON(__builtin_constant_p(e) && __builtin_constant_p(s) && e < s);
+
+	if (__builtin_constant_p(e))
+		BUILD_BUG_ON(e > 63);
+	else
+		e &= 63;
+
 	if (e < s)
 		return 0;
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

