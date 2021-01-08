Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28D92EF263
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbhAHMSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbhAHMR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:17:28 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E1BC0612A3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 04:15:44 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id c17so8140529qvv.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 04:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=FNjMcGMBepA+DKYzWBZdafn9Pfvz5tgi5bFjDXzrpjw=;
        b=MnwPPAzoXNwaOiIaAGjdxyYKgCpjZp6Y/8k70XQrFxP2o4aKAID1+AZSD9MNSZDBu7
         C1KdtY+o82o9hD3Jv3i9pN11yqVnvTEMzLJECVqtKuxjPOhr4G+fCEVPEA1slzI1JowR
         CSXnnwarOjT0oN1R+ZhxnBm4V4rEHrNYwYu1fsoKb+lRL7HgwNvni2KmTT4h/RzLGhOO
         llmt1BjnI2tjj0RTLZJ49lVdW1/iNrO+a1O+zULzBx1EyMYKzRKJa7IR/UiOX2z6y3so
         2Qt8L9hn3buycUtLVrwGXMuKpsy74lToWQTVDmDWMw+PhLbObGNxGzeYdWb4/SRx0AMn
         srfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FNjMcGMBepA+DKYzWBZdafn9Pfvz5tgi5bFjDXzrpjw=;
        b=HX2dZ8eJagUN9i6SiN26e/7TAx5o3Q2hWT+X4kJpgztqoBYjOIjIBiZKM6fyZMk47H
         dtGEsX1ROAdsurZdCO1vsPh6/QOVVPKnaYTzKrKq6oFEMtX0/whKx7DWKStDgM1Ehc3P
         0b7sBGNTiuMdH7qvOb49ga5to6XcYn6EhGFeopjY/kO26InqnArqGlwbTFXu2vgHauQ6
         0BvdZGFUsc7kIGGHOfwDvzKi8t85Dt9tREyy5Ybre4FSehSE+okb7OUHkgDZ8kT3lTye
         yDVqWp2M/FSAFRvg1DZm16vu3qUf20iVmaqwYnmn4KGS9MgETE92/ZDCuPaoVd05Ujk7
         GBxA==
X-Gm-Message-State: AOAM533C7hT54z/4nEyD5TPuld6BiqvYuJz/0wFsYr9jO/M+coGdc6f7
        4MBsK/f/f+53YrQX9tXzwFkUJncqxv74
X-Google-Smtp-Source: ABdhPJzuZf85ALEgP2PMc7AcYtKZ4On8truit0/ITvMunEfbpbr7IAAERcJbv904cp6MdFKGk7/AvT6xTBf6
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6214:1754:: with SMTP id
 dc20mr3314023qvb.7.1610108143358; Fri, 08 Jan 2021 04:15:43 -0800 (PST)
Date:   Fri,  8 Jan 2021 12:15:06 +0000
In-Reply-To: <20210108121524.656872-1-qperret@google.com>
Message-Id: <20210108121524.656872-9-qperret@google.com>
Mime-Version: 1.0
References: <20210108121524.656872-1-qperret@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v2 08/26] KVM: arm64: Make kvm_call_hyp() a function call
 at Hyp
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_call_hyp() has some logic to issue a function call or a hypercall
depending the EL at which the kernel is running. However, all the code
compiled under __KVM_NVHE_HYPERVISOR__ is guaranteed to run only at EL2,
and in this case a simple function call is needed.

Add ifdefery to kvm_host.h to symplify kvm_call_hyp() in .hyp.text.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 8fcfab0c2567..81212958ef55 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -592,6 +592,7 @@ int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 void kvm_arm_halt_guest(struct kvm *kvm);
 void kvm_arm_resume_guest(struct kvm *kvm);
 
+#ifndef __KVM_NVHE_HYPERVISOR__
 #define kvm_call_hyp_nvhe(f, ...)						\
 	({								\
 		struct arm_smccc_res res;				\
@@ -631,6 +632,11 @@ void kvm_arm_resume_guest(struct kvm *kvm);
 									\
 		ret;							\
 	})
+#else /* __KVM_NVHE_HYPERVISOR__ */
+#define kvm_call_hyp(f, ...) f(__VA_ARGS__)
+#define kvm_call_hyp_ret(f, ...) f(__VA_ARGS__)
+#define kvm_call_hyp_nvhe(f, ...) f(__VA_ARGS__)
+#endif /* __KVM_NVHE_HYPERVISOR__ */
 
 void force_vm_exit(const cpumask_t *mask);
 void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

