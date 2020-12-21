Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD082DFFC1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgLUSaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:30:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbgLUSaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608575318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TVJJqL1tHm2hXjZEZ4P1N+6G/kqyh0uXeqTDxi4rP94=;
        b=VXqadHrGTZpwTh2HTL+Yk4vrSvLBGugOY4cInVp8OEbdEBN5aK1Z4Zj1lyUooE1nSpbAO7
        F04QdOA0GzmgppBNuukyYjl3IWHXqOCquX33EDwuPicz3MTseZR2LJjlWteW+I7K/9rseR
        DV8z8CeEKLFF0I/euh+PcTeS4CTebpc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-uK7q1dNkOOuUKWzI2vTCHA-1; Mon, 21 Dec 2020 13:28:37 -0500
X-MC-Unique: uK7q1dNkOOuUKWzI2vTCHA-1
Received: by mail-wm1-f69.google.com with SMTP id r1so8137037wmn.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TVJJqL1tHm2hXjZEZ4P1N+6G/kqyh0uXeqTDxi4rP94=;
        b=YGsN6SWrQbkK4y4c85Ra1VLxAkC+4SE8bmyt9eWH1N+X4/Hx8JMMKBEeVqeahU8V6p
         qJ9mxrfMFcnCPPhIuOelXSz800oL7CYCmjE6/UsqQazvR/GhvZ4TBRJC4BtnU+g4ruFT
         Wn/zCN72B0EqBIFqgPdosFwCSrtTNrQXSNEp3v+BKhZn9RN+zCRia0vJPOuo16gcT/gG
         iZlo0GLDZ0bE7GeVrucvy0ZLRLulYpGbH3ZdeVOZ4GnJjVk5wm0qnqPBIQr4vIF5t6cc
         t7GVpyVXtrF2KN4psD4bZaIU3aKM8tGkAKHkTG3RjuovUHOznLwwqU1Y0HPPJzA9w9MT
         SY8A==
X-Gm-Message-State: AOAM530o66AADFZ659di36kmYqVcr8Kr4WIkXlNUqumJvybbblEWfEdt
        yjB0mXMUpdiilaXvgMcfY2w4WjyHAIyyZ+Nku7JMamfBfxo+s2Sjjv7MirF7Q1D+9wEslUAnwgh
        RRWWO+wyRXf64hq6qnbF6Dqqv
X-Received: by 2002:a05:600c:214a:: with SMTP id v10mr17688394wml.138.1608575315910;
        Mon, 21 Dec 2020 10:28:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqRkoCkPuI5CTSSfXxgW2LHq+bbmHqIlAY0s0cqBIou0V+z87FA8OveyNmesjHXD5IUTIFvA==
X-Received: by 2002:a05:600c:214a:: with SMTP id v10mr17688384wml.138.1608575315686;
        Mon, 21 Dec 2020 10:28:35 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b9sm26026445wmd.32.2020.12.21.10.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 10:28:35 -0800 (PST)
Subject: Re: [PATCH] KVM/SVM: Remove leftover __svm_vcpu_run prototype from
 svm.c
To:     Uros Bizjak <ubizjak@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tom Lendacky <thomas.lendacky@amd.com>
References: <20201220200339.65115-1-ubizjak@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fc2dabc5-d8c8-7667-c992-40ced93e56ac@redhat.com>
Date:   Mon, 21 Dec 2020 19:28:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201220200339.65115-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/20 21:03, Uros Bizjak wrote:
> Commit 16809ecdc1e8a moved __svm_vcpu_run the prototype to svm.h,
> but forgot to remove the original from svm.c.
> 
> Fixes: 16809ecdc1e8a ("KVM: SVM: Provide an updated VMRUN invocation for SEV-ES guests")
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>   arch/x86/kvm/svm/svm.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 941e5251e13f..2fa9726564af 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3675,8 +3675,6 @@ static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
>   	return EXIT_FASTPATH_NONE;
>   }
>   
> -void __svm_vcpu_run(unsigned long vmcb_pa, unsigned long *regs);
> -
>   static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu,
>   					struct vcpu_svm *svm)
>   {
> 

Queued, thanks.

Paolo

