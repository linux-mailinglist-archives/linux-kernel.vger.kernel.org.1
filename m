Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858EB3011BB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 01:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbhAWAa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 19:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbhAWAas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 19:30:48 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B110EC06178B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:30:07 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c9so7151621ybs.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=GW5YgzmGZ90upPWUw8yjcOOBzEGRL5zFdW5P2QKbWu4=;
        b=tVUg5jswvPuQC6WLS2bahbJifQc0hGtBAb1LmgRccRV33457farwPSINVvib3TUjNi
         LlJ0bpNcj8sohxrwtMs/cbdj6Mk1c4u3rMNn5Uxj6QNUF2Hu0Ug6ucuBWJ8BUSh7ike0
         o2Lhp6eaLCYULh6qJFr7vxuGZcjGzmrVgs0Ku3kNZVqs9JIyJkJt9jzuQZYwxnFOgZDR
         tmYC6NYkH3RV7g+ipQOzlKuRs9Sqenj3hKd7pHRQFdNrB+L4uaqRoA3g3lwwO2lGe3Mj
         SIYjRngC2F/h20GcR1NuJhS3enFn95NrjPUsYheaLAeDKuetdk4y/cGdZjEeqQWQMl/A
         0hMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=GW5YgzmGZ90upPWUw8yjcOOBzEGRL5zFdW5P2QKbWu4=;
        b=Bd+TxT4WU++OXt/N6EZJJzc5HsMGvXNIc7KZJ7kgh2C1qFUfjJf523iV9wniO0cpqm
         p3xO9dgrTVKSywTEaP1DRYsIFuPqgLhuKyDmjlv4S1yVinwQNWW8c0vZMbh9Q/HChlra
         1wknCqv4Qkz3C/AmR7vKP7mwCM1VU4oDVzCbr741pYV+MYNr9RsaBI74GF9w/Nj44nCP
         ierMCx5o7mJb9v6hQESJh4q2YhXUOGrasVsuN/VKEM9/zxZqRW1zR8wHpjdwSOAw4Xni
         JS+EKbO3FIyZ0YU9hykZm8DvUDLiqEbiiZ/lahn+kWsyvG0d5ZRBnxcJF2oxfzdoAdPs
         fcVw==
X-Gm-Message-State: AOAM530JIv2uvoJGgb4cJP1PoI/01x7jKwJh0Kzctr7JriZHF6/MJxFJ
        nVJ7ANVZRgzr8ys+QNjrO4yOIdz4gJM=
X-Google-Smtp-Source: ABdhPJyHyggUdYU/8G77pM1XxhCYkioicj73SgejqjhelE57ftM7XlgvkXTSZukL22UjRALAuYESbIsbyDc=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:5054:: with SMTP id e81mr10442630ybb.131.1611361806991;
 Fri, 22 Jan 2021 16:30:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 22 Jan 2021 16:30:03 -0800
Message-Id: <20210123003003.3137525-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH] KVM: x86/mmu: Use boolean returns for (S)PTE accessors
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

Return a 'bool' instead of an 'int' for various PTE accessors that are
boolean in nature, e.g. is_shadow_present_pte().  Returning an int is
goofy and potentially dangerous, e.g. if a flag being checked is moved
into the upper 32 bits of a SPTE, then the compiler may silently squash
the entire check since casting to an int is guaranteed to yield a
return value of '0'.

Opportunistically refactor is_last_spte() so that it naturally returns
a bool value instead of letting it implicitly cast 0/1 to false/true.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu.h      |  2 +-
 arch/x86/kvm/mmu/spte.h | 12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 581925e476d6..f61e18dad2f3 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -145,7 +145,7 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
  *
  * TODO: introduce APIs to split these two cases.
  */
-static inline int is_writable_pte(unsigned long pte)
+static inline bool is_writable_pte(unsigned long pte)
 {
 	return pte & PT_WRITABLE_MASK;
 }
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 2b3a30bd38b0..398fd1bb13a7 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -185,23 +185,19 @@ static inline bool is_access_track_spte(u64 spte)
 	return !spte_ad_enabled(spte) && (spte & shadow_acc_track_mask) == 0;
 }
 
-static inline int is_shadow_present_pte(u64 pte)
+static inline bool is_shadow_present_pte(u64 pte)
 {
 	return (pte != 0) && !is_mmio_spte(pte);
 }
 
-static inline int is_large_pte(u64 pte)
+static inline bool is_large_pte(u64 pte)
 {
 	return pte & PT_PAGE_SIZE_MASK;
 }
 
-static inline int is_last_spte(u64 pte, int level)
+static inline bool is_last_spte(u64 pte, int level)
 {
-	if (level == PG_LEVEL_4K)
-		return 1;
-	if (is_large_pte(pte))
-		return 1;
-	return 0;
+	return (level == PG_LEVEL_4K) || is_large_pte(pte);
 }
 
 static inline bool is_executable_pte(u64 spte)
-- 
2.30.0.280.ga3ce27912f-goog

