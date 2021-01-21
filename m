Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26372FEDE0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbhAUPCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:02:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732005AbhAUPCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611241237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YvTj5mZlUjeEiSgRgjWnpR6n1a3j79ysy/DqBL/aEpc=;
        b=QVjtbeh2Wu0voD/H5zTXWnWKOyLuAy8kZ8B6NKY3nDp0sxAMhUGMTOTEWmcmzW3RhlwPG3
        vDWEHhrnP63gD/PP0FwGKejibLEE0+wLwsi/rRVTq/HQDQy1mKeVvst9tu7ZnBnAuupGAR
        x4LsyNtHS/sjSCd+xj6mh2CSLb1I8xI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-1sTC--hfOCaexJg8Ulr9mQ-1; Thu, 21 Jan 2021 10:00:34 -0500
X-MC-Unique: 1sTC--hfOCaexJg8Ulr9mQ-1
Received: by mail-ed1-f71.google.com with SMTP id a24so1279350eda.14
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 07:00:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YvTj5mZlUjeEiSgRgjWnpR6n1a3j79ysy/DqBL/aEpc=;
        b=a9sXxVePQAktL1Ci9Z+GULL+GeFvziA7HHwlWzAe+8oZMvOKEiRzetD31290FUGhZ2
         p7f7QC+c4l7PaVsjsUECuoif6MT5hqTW714NAVrpSot6t6xzKaZpY5PAqmMK9Czez4wB
         8OtAGeDKwE59TxOmjkwCKxWpkVXiH4BkqgSVdeYep1r3jVUzYgm4IlF+XvtV5UQ5goLv
         ZPjXfnwiBZydpQIX7sdSyvO8CIRtny6yx9Mq11h5hU036X4yZeXfMhnfafK7dwqyMSnW
         NxIB1bjwW/Bffr9cI1byc4iPMLeMvlbUYf/kaAXpn6PJQH0OR/T6UZwo25PqfsMk4vGm
         gmgQ==
X-Gm-Message-State: AOAM530AG3ZxsFsOwGP1Uiql25IKqu1r6Zj38xHgoutmOFIs5ACkkoD/
        dePY8IQc6s4DjHQ/nuWTq85iEkiMe3wKJChZwIED1MiJe6bQLGxUaN66CvUAhd9qnHKzVQ6aQbP
        CmMcNdv/Th8JHj/y0/mn4ZRSI
X-Received: by 2002:a05:6402:524f:: with SMTP id t15mr9664217edd.158.1611241232943;
        Thu, 21 Jan 2021 07:00:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+AbqnlUD6UZVyvnlOafcon4z7EVgf4bsatgiCIeDcTrvME5a9PVJ19DBIaLkfqd+tYH6xOw==
X-Received: by 2002:a05:6402:524f:: with SMTP id t15mr9664185edd.158.1611241232698;
        Thu, 21 Jan 2021 07:00:32 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id bo20sm2877133edb.1.2021.01.21.07.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 07:00:31 -0800 (PST)
Subject: Re: [PATCH v2 0/3] VMX: more nested fixes
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
References: <20210114205449.8715-1-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2db36a66-a823-6fc7-ecb0-b6e8e8f6bfd9@redhat.com>
Date:   Thu, 21 Jan 2021 16:00:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210114205449.8715-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/21 21:54, Maxim Levitsky wrote:
> This is hopefully the last fix for VMX nested migration
> that finally allows my stress test of migration with a nested guest to pass.
> 
> In a nutshell after an optimization that was done in commit 7952d769c29ca,
> some of vmcs02 fields which can be modified by the L2 freely while it runs
> (like GSBASE and such) were not copied back to vmcs12 unless:
> 
> 1. L1 tries to vmread them (update done on intercept)
> 2. vmclear or vmldptr on other vmcs are done.
> 3. nested state is read and nested guest is running.
> 
> What wasn't done was to sync these 'rare' fields when L1 is running
> but still has a loaded vmcs12 which might have some stale fields,
> if that vmcs was used to enter a guest already due to that optimization.
> 
> Plus I added two minor patches to improve VMX tracepoints
> a bit. There is still a large room for improvement.
> 
> Best regards,
> 	Maxim Levitsky
> 
> Maxim Levitsky (3):
>    KVM: nVMX: Always call sync_vmcs02_to_vmcs12_rare on migration
>    KVM: nVMX: add kvm_nested_vmlaunch_resume tracepoint
>    KVM: VMX: read idt_vectoring_info a bit earlier
> 
>   arch/x86/kvm/trace.h      | 30 ++++++++++++++++++++++++++++++
>   arch/x86/kvm/vmx/nested.c | 19 ++++++++++++++-----
>   arch/x86/kvm/vmx/vmx.c    |  3 ++-
>   arch/x86/kvm/x86.c        |  1 +
>   4 files changed, 47 insertions(+), 6 deletions(-)
> 

I committed patch 1 since I need to send it out to Linus quite soonish, 
but please adjust and resend the others based on Sean's review.

Paolo

