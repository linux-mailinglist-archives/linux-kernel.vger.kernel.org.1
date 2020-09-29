Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C612D27CB49
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732608AbgI2M01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:26:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731931AbgI2M0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:26:23 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601382381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gYCM27eQBX+C1GSLSFKxmj4gnOFHGu50TnKuH5f77Uw=;
        b=MbbQmcVSJCECXC7Lk/pWxHFiHlDjqhzSumqG3zcVbHGtZg2E46vtGaDqIKMPL+rxIsDe4S
        6WZLSjn8jCdxDP6/7nIRB9QeCj+A/IqWZEb0Zkkt5vIZc1Y0XRfLOPw8eT3FNnFM/qAAIR
        Lplog8E5tIWtx25i9nbVte9kli0FQ2M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-XTHID-QhO0CGtwCPdkvJWg-1; Tue, 29 Sep 2020 08:26:20 -0400
X-MC-Unique: XTHID-QhO0CGtwCPdkvJWg-1
Received: by mail-wr1-f71.google.com with SMTP id b2so1677397wrs.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 05:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gYCM27eQBX+C1GSLSFKxmj4gnOFHGu50TnKuH5f77Uw=;
        b=RgeJJKh2YhY/D/Ay9fLGghUhn5ZqEDzagCQra3FI6FOCWf0jZkX2XZY1HTYtMo88CS
         Fh+YhvpUqavGpC7nc+GQo++IrnYkpRgOOgb7wbobvlCsaQ2ojSx9o6CuCjs4cwPOOm3Q
         eZq3oMUVUj59f/28iLPSwj2K/IUMMwkkPCnn5RHrP8i73UmLfBUk3CQ6oAdsl3k9ghMM
         1D6t4xnvtQuWD22PgcCjhUTKv8hLsXnc0REz21P/8inwWndXCK0ti8pHDD9dGQtVsF7A
         Y6tG+u909RZ06PhPm6cvIx/WxuWJ2yZrDOTyMBXjJYFr5u7rQqaAOkdK/vY7VrZHVA6f
         9rEg==
X-Gm-Message-State: AOAM530XWOlMflA8xwzu7WnQ711skmf2cBSWfI5CaZjHlmXsk9jjN+rk
        F+/G2wWiJIXLDIKPHhcpgZtKw8Br7hDjZBixTGM8eXxqJ23FLAxvkiuxicJ7Dl1y4CkuNlhOgUn
        JJxgG4GiOY+8iyrwsSRFcI67h
X-Received: by 2002:a7b:c749:: with SMTP id w9mr4033754wmk.29.1601382376049;
        Tue, 29 Sep 2020 05:26:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2s4HKbrVlR26BGHrynO5370fP6WNbutA1OCmeWGjDR5Zag1+91h5hGA+sTgEMJPKwtl+9PA==
X-Received: by 2002:a7b:c749:: with SMTP id w9mr4033734wmk.29.1601382375843;
        Tue, 29 Sep 2020 05:26:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9dbe:2c91:3d1b:58c6? ([2001:b07:6468:f312:9dbe:2c91:3d1b:58c6])
        by smtp.gmail.com with ESMTPSA id l18sm5937819wrp.84.2020.09.29.05.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 05:26:15 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: VMX: Make smaller physical guest address space
 support user-configurable
To:     Qian Cai <cai@redhat.com>, Mohammed Gamal <mgamal@redhat.com>,
        kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200903141122.72908-1-mgamal@redhat.com>
 <1f42d8f084083cdf6933977eafbb31741080f7eb.camel@redhat.com>
 <e1dee0fd2b4be9d8ea183d3cf6d601cf9566fde9.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ebcd39a5-364f-c4ac-f8c7-41057a3d84be@redhat.com>
Date:   Tue, 29 Sep 2020 14:26:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <e1dee0fd2b4be9d8ea183d3cf6d601cf9566fde9.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/20 13:59, Qian Cai wrote:
> 
> WARN_ON_ONCE(!allow_smaller_maxphyaddr);
> 
> I noticed the origin patch did not have this WARN_ON_ONCE(), but the mainline
> commit b96e6506c2ea ("KVM: x86: VMX: Make smaller physical guest address space
> support user-configurable") does have it for some reasons.

Because that part of the code should not be reached.  The exception
bitmap is set up with

        if (!vmx_need_pf_intercept(vcpu))
                eb &= ~(1u << PF_VECTOR);

where

static inline bool vmx_need_pf_intercept(struct kvm_vcpu *vcpu)
{
        if (!enable_ept)
                return true;

        return allow_smaller_maxphyaddr &&
		 cpuid_maxphyaddr(vcpu) < boot_cpu_data.x86_phys_bits;
}

We shouldn't get here if "enable_ept && !allow_smaller_maxphyaddr",
which implies vmx_need_pf_intercept(vcpu) == false.  So the warning is
genuine; I've sent a patch.

Paolo

