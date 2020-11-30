Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7282C8CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgK3Sge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:36:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727952AbgK3Sgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606761306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kAtSh0vAVlhpMtD2lkobZLGqAWWIIQOz9o3aS6mPtKQ=;
        b=cgbLZXJ3x7ESfzag15/d3FY5qTjHBkx4VLyScyEuWnCBh/HXRGJhTcx2IEaNZ9hEwUMjjb
        HUpM2k5HA+eVuXYqOiJOjKDTvdLnsu/Tb/ny+fJLwDLkmQuIsZqdpGKH9YNUsbnvcUzYUK
        EhHwVhcEjjb8m6x+pYknRFYCREBl4V8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-uif3Tbd3Mju1vvAbhi6PJA-1; Mon, 30 Nov 2020 13:35:05 -0500
X-MC-Unique: uif3Tbd3Mju1vvAbhi6PJA-1
Received: by mail-ed1-f72.google.com with SMTP id bc27so7213194edb.18
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kAtSh0vAVlhpMtD2lkobZLGqAWWIIQOz9o3aS6mPtKQ=;
        b=GQBxCjAuEvWjT2prRU5fgMWB13Vo8dmGY3xhHaOGKFA+CjMM1ecXyVEdW+UGwJsYng
         cPC4xUVrPqodgpyAnVwJB/wqSecQ+L1MEF/80hon9Divv2EC46+ZKzTq483Wt4Q7AHFg
         I1vH8pYrQQHy3XXp1FG+q0jLkSzr2VT1XxuGG7IsQxB8rZO0aLvYmUh+3iL8jbFCgFZ1
         JaFvRZS7YPqb9d5Izhkt62BWAszBKzJU6uzLgXIj0P8hfdnQ8Y+h6JnYSDVfnB437a+o
         kmcTcjfhbqKlISkey45LJ690yPS+5Er8Ucom6qWvzEBtBQhetWv2Zuz1/9lHeX73kgeN
         pdDQ==
X-Gm-Message-State: AOAM530IjNwrkNDbwaQR8QhqM6piVuOydFBBElANkaDTvoRnKFWdXvsR
        mvuI4G5Tg1B90L1pJQg4mj88AQm8R9JY62Rc6TwUF6ZEzsPcOnVx3uOQSRBY7UMYKGh1byDfhsE
        +1X2jnnxWxfY1SswHuo/3frc3
X-Received: by 2002:a50:d784:: with SMTP id w4mr22599318edi.201.1606761303827;
        Mon, 30 Nov 2020 10:35:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUjIL4juYIpVbV33ZJZ6ol0lRbKW1yriSL2v9cVpYAnJLQ1dU13hI1HeBdYGn/yFSNtPubzQ==
X-Received: by 2002:a50:d784:: with SMTP id w4mr22599303edi.201.1606761303657;
        Mon, 30 Nov 2020 10:35:03 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id co24sm600740edb.33.2020.11.30.10.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 10:35:02 -0800 (PST)
Subject: Re: [RFC PATCH 00/35] SEV-ES hypervisor support
To:     Sean Christopherson <seanjc@google.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <cover.1600114548.git.thomas.lendacky@amd.com>
 <20200914225951.GM7192@sjchrist-ice>
 <bee6fdda-d548-8af5-f029-25c22165bf84@amd.com>
 <20200916001925.GL8420@sjchrist-ice>
 <60cbddaf-50f3-72ca-f673-ff0b421db3ad@redhat.com>
 <X8U2gyj7F2wFU3JI@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8759948d-aa0b-3929-bda6-488b6788489a@redhat.com>
Date:   Mon, 30 Nov 2020 19:35:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X8U2gyj7F2wFU3JI@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/20 19:14, Sean Christopherson wrote:
>>> TDX also selectively blocks/skips portions of other ioctl()s so that the
>>> TDX code itself can yell loudly if e.g. .get_cpl() is invoked.  The event
>>> injection restrictions are due to direct injection not being allowed (except
>>> for NMIs); all IRQs have to be routed through APICv (posted interrupts) and
>>> exception injection is completely disallowed.
>>>
>>>     kvm_vcpu_ioctl_x86_get_vcpu_events:
>>> 	if (!vcpu->kvm->arch.guest_state_protected)
>>>           	events->interrupt.shadow = kvm_x86_ops.get_interrupt_shadow(vcpu);
>> Perhaps an alternative implementation can enter the vCPU with immediate exit
>> until no events are pending, and then return all zeroes?
>
> This can't work.  If the guest has STI blocking, e.g. it did STI->TDVMCALL with
> a valid vIRQ in GUEST_RVI, then events->interrupt.shadow should technically be
> non-zero to reflect the STI blocking.  But, the immediate exit (a hardware IRQ
> for TDX guests) will cause VM-Exit before the guest can execute any instructions
> and thus the guest will never clear STI blocking and never consume the pending
> event.  Or there could be a valid vIRQ, but GUEST_RFLAGS.IF=0, in which case KVM
> would need to run the guest for an indeterminate amount of time to wait for the
> vIRQ to be consumed.

Delayed interrupts are fine, since they are injected according to RVI 
and the posted interrupt descriptor.  I'm thinking more of events 
(exceptions and interrupts) that caused an EPT violation exit and were 
recorded in the IDT-vectored info field.

Paolo

> Tangentially related, I haven't looked through the official external TDX docs,
> but I suspect that vmcs.GUEST_RVI is listed as inaccessible for production TDs.
> This will be changed as the VMM needs access to GUEST_RVI to handle
> STI->TDVMCALL(HLT), otherwise the VMM may incorrectly put the vCPU into a
> blocked (not runnable) state even though it has a pending wake event.
> 

