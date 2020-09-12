Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE9426781E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 08:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgILGP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 02:15:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55653 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725805AbgILGPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 02:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599891352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYkkhNgkJ+I++Y6K6W6FUcw4iXrMY+1fU6LYC+KZvHA=;
        b=OXR0CspHyierXIguTkY4G9rGWpnSJ2ROfZOakIjlA4v1U3Q4CKEQNFxrZlmawX9NS3BBpb
        tGpT/ttxJbl88D1S+FQi/udz201bOt7afLkwD5vuE1OZlFeC/pdT1Gfn1pw5+bcWoTUSQr
        5C+q8kKzI7/Oe7+sjDF33U2FtMXQlp8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-6C1D2EeLOrm6F4P-jJ6Nrg-1; Sat, 12 Sep 2020 02:15:50 -0400
X-MC-Unique: 6C1D2EeLOrm6F4P-jJ6Nrg-1
Received: by mail-wm1-f70.google.com with SMTP id l15so1185286wmh.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 23:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hYkkhNgkJ+I++Y6K6W6FUcw4iXrMY+1fU6LYC+KZvHA=;
        b=GhCx1s3QwP/Sr/z7Lc2GG8mOHSMJuh6KuCz8+3XaV/mfc75K4ahdxsNQ2uLx9AgD13
         NXcLBpOZ/ckPJwgMDn7n1TVSurJ28rkJxu3YrMK7sxagHd7hMoxR+3W/o0iG74z7dp6h
         WUMn2wtHpYBDNJJkW7Ydhr3UjfaJR+X15YNxGz1zVf35jpFTJbLn3VJP70/ZYYFv9q4f
         wgh5+MEaE2IafOBFr5GH5ss9ROUU5dNYQKRyhP7qXBk8nJKefg4Lu3nH0qeMhsA+y2se
         hPIOS9Y8kxQWjA4lanLiRhezeMVEZhupjSUjuqp00K+FQnz1DoFBMkLwVokgVstY7b3o
         28cw==
X-Gm-Message-State: AOAM530a/D4BzASRAQEcN8TnHHpGTKZROdhnjYcZiAwtAgRcSE3DAi9R
        j/gUo1Oe2myQ91moEqHkfcnbPFQJ8Sa1ZjRyvLU5tOmPldCdZ3IHr/ZyDdURjX4nOV4RPukj5XO
        ki1ESFTyPY7XT6pbR510wXCQb
X-Received: by 2002:a1c:7d4d:: with SMTP id y74mr5446725wmc.73.1599891348781;
        Fri, 11 Sep 2020 23:15:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtCvkRcwSIjSWR09pA1CZCs6u6O/FehNxkRo6n8yeCCzNuFPbrV9n6E7hdrdtDgwMwb+7uGQ==
X-Received: by 2002:a1c:7d4d:: with SMTP id y74mr5446710wmc.73.1599891348596;
        Fri, 11 Sep 2020 23:15:48 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id a17sm9049061wra.24.2020.09.11.23.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 23:15:47 -0700 (PDT)
Subject: Re: [PATCH RESEND 3/3] KVM: SVM: Reenable
 handle_fastpath_set_msr_irqoff() after complete_interrupts()
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Paul K ." <kronenpj@kronenpj.dyndns.org>
References: <1599620237-13156-1-git-send-email-wanpengli@tencent.com>
 <1599620237-13156-3-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <da8342cc-5c7f-b04a-ed79-8527cf74b746@redhat.com>
Date:   Sat, 12 Sep 2020 08:15:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1599620237-13156-3-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The overall patch is fairly simple:

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 03dd7bac8034..d6ce75e107c0 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2938,8 +2938,6 @@ static int handle_exit(struct kvm_vcpu *vcpu,
fastpath_t exit_fastpath)
 	if (npt_enabled)
 		vcpu->arch.cr3 = svm->vmcb->save.cr3;

-	svm_complete_interrupts(svm);
-
 	if (is_guest_mode(vcpu)) {
 		int vmexit;

@@ -3504,7 +3502,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct
kvm_vcpu *vcpu)
 	stgi();

 	/* Any pending NMI will happen here */
-	exit_fastpath = svm_exit_handlers_fastpath(vcpu);

 	if (unlikely(svm->vmcb->control.exit_code == SVM_EXIT_NMI))
 		kvm_after_interrupt(&svm->vcpu);
@@ -3537,6 +3534,9 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct
kvm_vcpu *vcpu)
 		     SVM_EXIT_EXCP_BASE + MC_VECTOR))
 		svm_handle_mce(svm);

+	svm_complete_interrupts(svm);
+	exit_fastpath = svm_exit_handlers_fastpath(vcpu);
+
 	vmcb_mark_all_clean(svm->vmcb);
 	return exit_fastpath;
 }

so I will just squash everything.

Paolo

