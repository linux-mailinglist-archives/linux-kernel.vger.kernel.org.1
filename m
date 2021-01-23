Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5264301165
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 01:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbhAWAJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 19:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbhAWAF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 19:05:59 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E165AC061797
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:03:40 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id w1so332449qvj.21
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=kAWuaESsc2ZEzrFWxj8fVnjbm69FHkEio6nEEHrCqso=;
        b=vPheHINMwQ7x81BAVOdlxaLV9ZmxEAUxLwRQEterkex73h1GF1e0JJOYRw917hMlJS
         FjIRezaFCAn8JbR+AXZr+AcnJ3CebTq465UDw75KfzxtM4TRaQCtV3gq/CRx8YeCNoTw
         RbNr1fj2/TsWw0R3YPkIvv4sqI1fwZp+G5aM9StcUIGhKnUYY39MI131/gVsHTV6uNvF
         Xxuz6WK7rAVqq1FamjRJaBpl2CNt4D8B41KeEa98aaDnHtwvVlQ9oBcKS/1WSS5cN9Uv
         D6/FDFzy3zLDM2Hhkk8PnrXd1cGoCSjw4d5gVOxUV5JqjSs9EaOTNab2/rhN0kCRkCb2
         3j1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=kAWuaESsc2ZEzrFWxj8fVnjbm69FHkEio6nEEHrCqso=;
        b=mCVtAJszswg58m8dEp2E4exFC+UaQc4hqJjOLM5KWus9FEIGdUCiAnYwmRGKJqpC5V
         yDj0XLYoDfTb/81X70FGIQ6+g4OD+qMpHRGr8QwICdO9T5GG0zHIwWG3aBnn3L5c1dTR
         iU/tzWivwioAkWhXoBGBo3IxgbRchYRK4iuenryZKWqWLU5/iaLEzipJOZsFTQhXKRcQ
         ICk6Bb1LXJatgaWyMthj8LJy+xUE6nbU0EHywFlcejZ2zakah4FZV68ThKylFdYk8VuN
         TZHqLTLWp43QFsMfJ9ZluXJ8fxEvV2f+U+WyyImePM5CPKAkbdnlB57yU5nLS+b91MNZ
         qp2A==
X-Gm-Message-State: AOAM531Lr7EdbT3CuIspnYZ+98mB+dcrZ1XgCCQPO+EaE6WbZ2bzoKF0
        BW0KfEg03GRUND9cOTujT85AMhm5M8s=
X-Google-Smtp-Source: ABdhPJzIaxvGYNmKQCnDZF49b4i+ePgAT9JFDk8xFGgl9hTFC178lmVaRjBqNudM58fgQn4oA9eD1zI+Xk8=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:ad4:5904:: with SMTP id ez4mr6848541qvb.30.1611360220039;
 Fri, 22 Jan 2021 16:03:40 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 22 Jan 2021 16:03:33 -0800
In-Reply-To: <20210123000334.3123628-1-seanjc@google.com>
Message-Id: <20210123000334.3123628-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210123000334.3123628-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 1/2] KVM: x86: Remove obsolete disabling of page faults in kvm_arch_vcpu_put()
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

Remove the disabling of page faults across kvm_steal_time_set_preempted()
as KVM now accesses the steal time struct (shared with the guest) via a
cached mapping (see commit b043138246a4, "x86/KVM: Make sure
KVM_VCPU_FLUSH_TLB flag is not missed".)  The cache lookup is flagged as
atomic, thus it would be a bug if KVM tried to resolve a new pfn, i.e.
we want the splat that would be reached via might_fault().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9a8969a6dd06..3f4b09d9f25b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4031,15 +4031,6 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	if (vcpu->preempted && !vcpu->arch.guest_state_protected)
 		vcpu->arch.preempted_in_kernel = !kvm_x86_ops.get_cpl(vcpu);
 
-	/*
-	 * Disable page faults because we're in atomic context here.
-	 * kvm_write_guest_offset_cached() would call might_fault()
-	 * that relies on pagefault_disable() to tell if there's a
-	 * bug. NOTE: the write to guest memory may not go through if
-	 * during postcopy live migration or if there's heavy guest
-	 * paging.
-	 */
-	pagefault_disable();
 	/*
 	 * kvm_memslots() will be called by
 	 * kvm_write_guest_offset_cached() so take the srcu lock.
@@ -4047,7 +4038,6 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 	kvm_steal_time_set_preempted(vcpu);
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
-	pagefault_enable();
 	kvm_x86_ops.vcpu_put(vcpu);
 	vcpu->arch.last_host_tsc = rdtsc();
 	/*
-- 
2.30.0.280.ga3ce27912f-goog

