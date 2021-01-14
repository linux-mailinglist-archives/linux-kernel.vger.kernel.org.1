Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9742F567E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbhANBsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbhANAi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:38:26 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB58C061795
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:37:37 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id i13so2971994qtp.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=+lfNaOH1CNuPDcxuYVHAHObVf+9wEEDIr0zVJxlAHxg=;
        b=gIjihO2I8gwcFheB4YOs8u4uVfZFwXse/1YgRjreNWQX/e2LFZ9vHhNU3O2UbMJppT
         hbZqpHYf8uNM9lVGC2jEABPKdK+55wkuZSf/POIfMsZ5LvFBacWcKJNaPDRCFWSRout+
         uMFxXkDz0idqm68ZyJ+iooMcEsfRvxeGZcE3jvqoHKICY5e/jlJ/Ce3WTRib5aCm+2mn
         UAxR2lfbyXAMgnM+w0ZAZdihFN2j4rNDsAn9pUY2X9QzpGeBGYiPFnqtIdSFRglaIAJC
         iory/Ch11tHGh9uc9FOYACz9x3TLLUhe0ZhJRFn9WwPDIRkKFroNhMwGXCzZWhWHkV8f
         7GRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=+lfNaOH1CNuPDcxuYVHAHObVf+9wEEDIr0zVJxlAHxg=;
        b=tfzREh7xK1qNNvJ5jljtBgFwKr6ZttMciTj6W5KzL5zB8X1gvif37cn0ha5AMZ78O2
         AlJDefGjzWTxWAjiBU/Diyi/KC+FahZ55RG7bJNbh0JSsBCENOwvpXJymu6z3OCVdl8V
         bz+oDVnvfxgWY+aDsEmS7QZgBO9QIwf/iYvsdyZgBH1FU/H4y2ZgyGkHBZ9cQwkkkvv9
         XMcZZbBbAfCe9ONZWb2y/c6y0aZY9LOpRhnmRg/bD16t4wV1q0hLHNEixc+hV4x8sQmx
         jR5XN1DGG2sjH4/UY6V/Po6cc8mUUE2T+Tejx8+N4eIze0QtEWY9oqV9rS2SGNLHZHXy
         ncog==
X-Gm-Message-State: AOAM5303/OkbfDPoprTEsE6q2axUt0+V+4xeCQ4dYwPKc9cZGBi7Ycqq
        GgHBF7XCHLEuLjcmlJG32rF4yz+Y4VE=
X-Google-Smtp-Source: ABdhPJz6SZlx5VJJIc17Aooj99sknhXwjukqTwoNewwxv6DIs9ZCRWUkLmY0rTV2mz8FiqTixYZn5yW997c=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:8b:: with SMTP id 133mr7308631yba.513.1610584656762;
 Wed, 13 Jan 2021 16:37:36 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Jan 2021 16:36:55 -0800
In-Reply-To: <20210114003708.3798992-1-seanjc@google.com>
Message-Id: <20210114003708.3798992-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210114003708.3798992-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 01/14] KVM: SVM: Zero out the VMCB array used to track SEV
 ASID association
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

Zero out the array of VMCB pointers so that pre_sev_run() won't see
garbage when querying the array to detect when an SEV ASID is being
associated with a new VMCB.  In practice, reading random values is all
but guaranteed to be benign as a false negative (which is extremely
unlikely on its own) can only happen on CPU0 on the first VMRUN and would
only cause KVM to skip the ASID flush.  For anything bad to happen, a
previous instance of KVM would have to exit without flushing the ASID,
_and_ KVM would have to not flush the ASID at any time while building the
new SEV guest.

Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Fixes: 70cd94e60c73 ("KVM: SVM: VMRUN should use associated ASID when SEV is enabled")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7ef171790d02..ccf52c5531fb 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -573,7 +573,7 @@ static int svm_cpu_init(int cpu)
 	if (svm_sev_enabled()) {
 		sd->sev_vmcbs = kmalloc_array(max_sev_asid + 1,
 					      sizeof(void *),
-					      GFP_KERNEL);
+					      GFP_KERNEL | __GFP_ZERO);
 		if (!sd->sev_vmcbs)
 			goto free_save_area;
 	}
-- 
2.30.0.284.gd98b1dd5eaa7-goog

