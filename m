Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DB5292AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbgJSPwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:52:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52005 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730051AbgJSPwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603122752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XC8R3HHY11M/hrrbkifbLXLUcYHIAgrXDf8csH9a4/c=;
        b=N9MlWmIAXT3i5JARV/vmagGdwXzZ8Lz7AUuoBhwD/MoTxBlSJpml/JgTASU/6weXbjNeBQ
        jrTH80GDCsa3vJmgObT+c8yLsw2GsfwJdHuPopg7uF6q91TLYXl/ZZtqEk6m19gfREjIH6
        w9QMa119rpEB4dgPt1fLqz1WGrR6rEQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-KGGuTKQiPX6oEgW01XIrzA-1; Mon, 19 Oct 2020 11:52:30 -0400
X-MC-Unique: KGGuTKQiPX6oEgW01XIrzA-1
Received: by mail-wr1-f71.google.com with SMTP id t17so40391wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XC8R3HHY11M/hrrbkifbLXLUcYHIAgrXDf8csH9a4/c=;
        b=bxhlXFkQKrP5de9RoiGjgaVy8eZK/0PHHy93jTK0sgq/wPixt5mXfmqfBOoYXgPtRu
         1Z1H4ETm/fUKxpK8SR1QKpVw0AM6XOzIvfF38WKykXfT08GX+s3JQaOENjPvWk6ohu3U
         /53yeNAf14xWD3bzfrKhxws99vO0wcioP/c/MMJowSTbPKqsJ49qE97J9B50a4diAZ8V
         TMxXAL53Ml5FHCjPo0waHESW8U6Bm0Y740napO4axHzSg5GpNQ0RsXBm3ns2tWpedCIg
         XGthxokcmR18tibHji+Du+xhM+zQMzivgGagjAAmXmPRmYXL80zcrxds/4ySRaZwekiR
         bxzg==
X-Gm-Message-State: AOAM531In/xy2GAdM0o50kf/2sY7M3ebVEDh2gYhkqe9qWlbU2RHIlD8
        o688KRmAtZb4vNxfoglPlF0H1fotxDd6Is8/blyw0OKxLQz7IFw2iQ7yxk+3fiOXJaAxpGvyy+q
        +6ecDIJRbLSEYB++mqjrPZGHE
X-Received: by 2002:a1c:2108:: with SMTP id h8mr26430wmh.63.1603122749206;
        Mon, 19 Oct 2020 08:52:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2AwSIV8crVhtGFxc2jh3WIKCAGDXH1rOOylH1uDp8JeVmB4VsCq9Uxr0spo00NdxsC9Mtcw==
X-Received: by 2002:a1c:2108:: with SMTP id h8mr26394wmh.63.1603122748931;
        Mon, 19 Oct 2020 08:52:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id t10sm455946wmf.46.2020.10.19.08.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 08:52:28 -0700 (PDT)
Subject: Re: [PATCH v7 0/4] KVM: nSVM: ondemand nested state allocation
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20201001112954.6258-1-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2c7ad393-9a7e-359e-a076-0d9ed702fe23@redhat.com>
Date:   Mon, 19 Oct 2020 17:52:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201001112954.6258-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/20 13:29, Maxim Levitsky wrote:
> This is the next version of this patch series.
> 
> In V5 I adopted Sean Christopherson's suggestion to make .set_efer return
> a negative error (-ENOMEM in this case) which in most cases in kvm
> propagates to the userspace.
> 
> I noticed though that wrmsr emulation code doesn't do this and instead
> it injects #GP to the guest on _any_ error.
> 
> So I fixed the wrmsr code to behave in a similar way to the rest
> of the kvm code.
> (#GP only on a positive error value, and forward the negative error to
> the userspace)
> 
> I had to adjust one wrmsr handler (xen_hvm_config) to stop it from returning
> negative values	so that new WRMSR emulation behavior doesn't break it.
> This patch was only compile tested.
> 
> The memory allocation failure was tested by always returning -ENOMEM
> from svm_allocate_nested.
> 
> The nested allocation itself was tested by countless attempts to run
> nested guests, do nested migration on both my AMD and Intel machines.
> I wasn't able to break it.
> 
> Changes from V5: addressed Sean Christopherson's review feedback.
> Changes from V6: rebased the code on latest kvm/queue
> 
> Best regards,
> 	Maxim Levitsky
> 
> Maxim Levitsky (4):
>   KVM: x86: xen_hvm_config: cleanup return values
>   KVM: x86: report negative values from wrmsr emulation to userspace
>   KVM: x86: allow kvm_x86_ops.set_efer to return an error value
>   KVM: nSVM: implement on demand allocation of the nested state
> 
>  arch/x86/include/asm/kvm_host.h |  2 +-
>  arch/x86/kvm/emulate.c          |  4 +--
>  arch/x86/kvm/svm/nested.c       | 42 ++++++++++++++++++++++
>  arch/x86/kvm/svm/svm.c          | 64 ++++++++++++++++++---------------
>  arch/x86/kvm/svm/svm.h          | 10 +++++-
>  arch/x86/kvm/vmx/vmx.c          |  6 ++--
>  arch/x86/kvm/x86.c              | 39 ++++++++++----------
>  7 files changed, 114 insertions(+), 53 deletions(-)
> 

Queued, thanks.

Paolo

