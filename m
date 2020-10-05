Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875D12839F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgJEPaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:30:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29461 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727699AbgJEP34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601911794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j/PMUKM9cHJYwV2H699HxBBxNqTrB5QV3hcfweW1Wok=;
        b=M/kSdhqZw0mRPR0mLbax6AY4ep5M4O7b/20jF/4ujVz9YP+ob2LvKUEFHCw2Xizx+B75vh
        IiKxFRyiSBmpwohRxoX7KkCsLxvng2AM+/6axA95Uqh2Ux1G40HU3KOIoKHuW64OQ7jePe
        agZL6ry2FqlGLAqQc6TCEHUdSa86/bg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-73Y-4Q21MqumgzUh-w95Pg-1; Mon, 05 Oct 2020 11:29:53 -0400
X-MC-Unique: 73Y-4Q21MqumgzUh-w95Pg-1
Received: by mail-wm1-f71.google.com with SMTP id d197so1844180wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 08:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=j/PMUKM9cHJYwV2H699HxBBxNqTrB5QV3hcfweW1Wok=;
        b=JJGNEWkYVJhvfAp7XVjfbvHTDFTsj+vJ6Gqfcl6cskTWJxktvrkHE4lEPEbxcZoMXX
         UMm8Qd4h3b9R6SoXuNEsC4OzhldXDk7+fqDaO8Qzzppu/z1Ov0FlSPc48sPv5/djmOMq
         mgxlVp1fdmw+kcorMTheJaa0rrOykERvBSdnA2XJqpF2QJdImYOIQW5+JKAkCIw1rC2m
         nF7nypYUmoPMQCVgZlC4A7jj5n7Mx7TJ77IHhb38MmoZpV1HzCaLbJHL9rvtQTGRyMrq
         AeXzZHgVaALC8k8G/FObS4iXqsTEpNYESiLmh1dk6mLY7eBMCEombkwhv5oby2gkdi7H
         iiRw==
X-Gm-Message-State: AOAM5314veRBTt2OSkp7zfT7+53SyY+kgmbnQ2iWASvMwlBRt1mZcl34
        0oXU0P2Exw9wSbr5Df3t7bp2gOOBdVxCxLCoq256vP9dQc7oQvMzTosJrS/ItDit9ou4IuHxGCf
        vAyrj40EgeRiSI6GzN6cJVex2
X-Received: by 2002:adf:9f10:: with SMTP id l16mr13135027wrf.77.1601911789853;
        Mon, 05 Oct 2020 08:29:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9r5eAsNLBjBhrQWv2MV2F/19IjP1IOGWS27Zw2DhAKe0FfKdmSdIwQy1Qv4rgPM1SU21BXg==
X-Received: by 2002:adf:9f10:: with SMTP id l16mr13135006wrf.77.1601911789672;
        Mon, 05 Oct 2020 08:29:49 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id e19sm468756wme.2.2020.10.05.08.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 08:29:49 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: filter guest NX capability for cpuid2
In-Reply-To: <20201005145921.84848-1-tianjia.zhang@linux.alibaba.com>
References: <20201005145921.84848-1-tianjia.zhang@linux.alibaba.com>
Date:   Mon, 05 Oct 2020 17:29:47 +0200
Message-ID: <87ft6s8zdg.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tianjia Zhang <tianjia.zhang@linux.alibaba.com> writes:

> Original KVM_SET_CPUID has removed NX on non-NX hosts as it did
> before. but KVM_SET_CPUID2 does not. The two should be consistent.
>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  arch/x86/kvm/cpuid.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 3fd6eec202d7..3e7ba2b11acb 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -257,6 +257,7 @@ int kvm_vcpu_ioctl_set_cpuid2(struct kvm_vcpu *vcpu,
>  		goto out;
>  	}
>  
> +	cpuid_fix_nx_cap(vcpu);
>  	kvm_update_cpuid_runtime(vcpu);
>  	kvm_vcpu_after_set_cpuid(vcpu);
>  out:

I stumbled upon this too and came to the conclusion this is
intentional, e.g. see this:

commit 0771671749b59a507b6da4efb931c44d9691e248
Author: Dan Kenigsberg <danken@qumranet.com>
Date:   Wed Nov 21 17:10:04 2007 +0200

    KVM: Enhance guest cpuid management

...

    [avi: fix original KVM_SET_CPUID not removing nx on non-nx hosts as it did
          before]

but this is a very, very old story.

-- 
Vitaly

