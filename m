Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9C92F4BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbhAMMtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:49:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25835 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbhAMMtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:49:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610542073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MN//j4KfkaQDO4C4FoLF4BEjv0MtOHoXDo9L7ieqXmM=;
        b=I5CmDh7EO/abyiii09JlW/09xm8GIRfUYlIGc/XoyOjQC9+Vfh+hT+649A5KMYP9jrN227
        VgSWzwBuR8oSeChb8n86Jb/F5GcrWAWQi19j+wFs02VcXj2P31cApfxe8BRcVyObOgFdo9
        t/9QeYMQT31G7he8nvAK/0h3YWbI7YQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-OF6w4_i2PXa9rb90N2oj-A-1; Wed, 13 Jan 2021 07:47:49 -0500
X-MC-Unique: OF6w4_i2PXa9rb90N2oj-A-1
Received: by mail-ed1-f72.google.com with SMTP id g14so805768edt.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:47:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MN//j4KfkaQDO4C4FoLF4BEjv0MtOHoXDo9L7ieqXmM=;
        b=fdys+Ow9ylGG5knxJTMXBZ9Mbh2ctDwm9JMMgfoC4JC3gXnC02Ll89IVq8oTjwGX+z
         56DI4euIVrKBtmi+M9ihUxqN4aOLkX90jhIpmhRGZO6AFoTpgmFWFrmxIX83QNfNa2lJ
         cr15TX0r8HO7BiOwbFwHX9Dd61e839kv7P7f5vQwyfedv7zkq8RIvotHxIFKpIxyeDy+
         ZJl1J1Gyi5P6CX30gUhHT0AP6u92I1JRCSP8UAZk1Po2S1+RtF1AZLXTW8C2zgmyor1z
         D2wtKiZJWTvRIeW8u1sEtlyDHeMP0HGydiqeQEWUdtv5setsjBi23DwclfCIvNa6DM7h
         muhg==
X-Gm-Message-State: AOAM530Ji8QGIf8ruXF12/y1k4M/kyPEGmsDs2lCGV2dO3crjtwf7FB2
        6L4xkZ3sPdQEQFWl7hjeZRRTdQrU0jz+RlwQuG9yo/s54cDfBUguj35bK4R0/q0AV3uDdFlPgrA
        +m9e9qIZ+l58qG5rIjRGYMSpBAkk35iABBjlJHqGf1BYu1shy4CPAhjT35eI0ZCiIOOOQt7O9Mk
        xP
X-Received: by 2002:a50:9ee6:: with SMTP id a93mr1676116edf.174.1610542068562;
        Wed, 13 Jan 2021 04:47:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyikRdfoGYoew5FvAMydezcXlv1r36t0us5uCD3RBdb1UXRawJ6L+W5SY23B2IER8QAu0mx/A==
X-Received: by 2002:a50:9ee6:: with SMTP id a93mr1676096edf.174.1610542068394;
        Wed, 13 Jan 2021 04:47:48 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id z25sm684934ejd.23.2021.01.13.04.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 04:47:47 -0800 (PST)
Subject: Re: [PATCH 1/2] KVM: x86: introduce definitions to support static
 calls for kvm_x86_ops
To:     Jason Baron <jbaron@akamai.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, peterz@infradead.org, aarcange@redhat.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1610379877.git.jbaron@akamai.com>
 <ce483ce4a1920a3c1c4e5deea11648d75f2a7b80.1610379877.git.jbaron@akamai.com>
 <X/4q/OKvW9RKQ+gk@google.com>
 <1784355c-e53e-5363-31e3-faeba4ba9e8f@akamai.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <86972c56-4d2e-a6ab-11ad-c972a395386a@redhat.com>
Date:   Wed, 13 Jan 2021 13:47:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1784355c-e53e-5363-31e3-faeba4ba9e8f@akamai.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/21 05:12, Jason Baron wrote:
>>
> Looking at the vmx definitions I see quite a few that don't
> match that naming. For example:
> 
> hardware_unsetup,
> hardware_enable,
> hardware_disable,
> report_flexpriority,
> update_exception_bitmap,
> enable_nmi_window,
> enable_irq_window,
> update_cr8_intercept,
> pi_has_pending_interrupt,
> cpu_has_vmx_wbinvd_exit,
> pi_update_irte,
> kvm_complete_insn_gp,
> 
> So I'm not sure if we want to extend these macros to
> vmx/svm.

Don't do it yourself, but once you introduce the new header it becomes a 
no-brainer to switch the declarations to use it.  So let's plan the new 
header to make that switch easy.

Using trailing commas unconditionally would be okay, i.e.

#define X86_OP(func)     .func = vmx_##func,
#include "kvm-x86-ops.h"

and leave out the terminator/delimiter in kvm-x86-ops.h.  This is 
similar to how we use vmx/vmcs_shadow_fields.h:

#define SHADOW_FIELD_RO(x, y) { x, offsetof(struct vmcs12, y) },
#include "vmcs_shadow_fields.h"

#define SHADOW_FIELD_RW(x, y) case x:
#include "vmcs_shadow_fields.h"

Thanks,

Paolo

