Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A553B300DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 21:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbhAVUYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbhAVUWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:22:34 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC873C061786
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:21:54 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id u8so4718921qvm.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=na/73VMReTKtB9cBdzddT3dFufGs+FA2GpJ7zLFbNE0=;
        b=sR2mbkVcciaudaJO/zw/eEvj6Q7oBcRY0RAz4GWPIa6JEVX53Nzqlr8lncX51w1OwK
         NO1X6XCfd3jEzWpq6fGB2xVpt0Lg6NZcjz2/R7NlryJ1+POAaxFG/hxOvp9Of1+tWHHq
         imVj9l7I3JWun1lRk8K91cV3TZnqClWXRT6UYWdr/jxAI6FEGrGPoeDDnnk0qfzZKzA1
         kPQH9v+FcflIEL/D2/uwmccwELlbDWP59fh3wzE3ZQKsYfA2sunWnE9ge3/KoioYRyj8
         EE7Za1PS9leb0CUYRu8NGP+oDsMzNXNCg9pfBLIiFwlKXdGt1L+Clc0cRZH8UcWJxMam
         quJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=na/73VMReTKtB9cBdzddT3dFufGs+FA2GpJ7zLFbNE0=;
        b=tU27+dEAeVJTLMUdPxe/EiDLmhKecTacMuBjTfjpu7XfsUD4IBrnFzTvAO2/j0g0hU
         cHWpPbuxMIsqlx/vqFxrfmeilHxyDqziqJky6QhnDxfg/6tLOGMAPJPJL1JYUQ5PRlk8
         mX02sUomhgkS2LY46u2IH+iabECBvAbNO7bObFL1w1GE4RO9/6gcfsugneSIsALTkWy7
         ngByEEagMD3SjYYcLT+Nd/ki5cxcKZ4tK2QQ4hcOg3AupHZwTDLY0E8GPTHIagj4OnRY
         r89FqcH6G7X54IPtWMSb2G2Oqxr+kDXysCl30Nc8obuXio6K+4aJ5Zk/YLikbU6rdGV5
         Hglg==
X-Gm-Message-State: AOAM532rkziSHrU+qRprRZYDLcH937Ux0tYD86K0VEm48+gNN500sxX0
        m1U2fR8yd4pfootZkzMhXuCLl2NFQPA=
X-Google-Smtp-Source: ABdhPJxpMPloC8ZCgmz7TNLfHDME7K98h9vup115ZsV8cJ44FAIvocqZSyO1jCbESrt7ZIEvDB6U30Llk7o=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a0c:becc:: with SMTP id f12mr2470648qvj.31.1611346913861;
 Fri, 22 Jan 2021 12:21:53 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 22 Jan 2021 12:21:32 -0800
In-Reply-To: <20210122202144.2756381-1-seanjc@google.com>
Message-Id: <20210122202144.2756381-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210122202144.2756381-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v3 01/13] KVM: SVM: Zero out the VMCB array used to track SEV
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
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Fixes: 70cd94e60c73 ("KVM: SVM: VMRUN should use associated ASID when SEV is enabled")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7ef171790d02..5bd797c7ee60 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -571,9 +571,8 @@ static int svm_cpu_init(int cpu)
 	clear_page(page_address(sd->save_area));
 
 	if (svm_sev_enabled()) {
-		sd->sev_vmcbs = kmalloc_array(max_sev_asid + 1,
-					      sizeof(void *),
-					      GFP_KERNEL);
+		sd->sev_vmcbs = kcalloc(max_sev_asid + 1, sizeof(void *),
+					GFP_KERNEL);
 		if (!sd->sev_vmcbs)
 			goto free_save_area;
 	}
-- 
2.30.0.280.ga3ce27912f-goog

