Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DECE2CEA2C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgLDIuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:50:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729168AbgLDIua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607071743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJUKgDLlBfd+N6NBEwIyZQmlOVw83+uE6UZggl/HWsE=;
        b=fTqRb292+7cXg77uT4amQGph6MSClSkLadDGDLKevtIMRr5W4Ngujmze7hlaZQ5qN0qRTv
        MwpdG5mvLTpFREFSvnDddSuyg+/AHSPZ1VicZWXUs3Ni1lwIkaR3eZ49wgH4DCgKNXf8vH
        IVWw7VEjfUIZXs6xlvPYwIjrTvIab1k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388--vITCsc7NM-C5WvYkeydRw-1; Fri, 04 Dec 2020 03:49:02 -0500
X-MC-Unique: -vITCsc7NM-C5WvYkeydRw-1
Received: by mail-ed1-f69.google.com with SMTP id s7so2079920eds.17
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 00:49:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZJUKgDLlBfd+N6NBEwIyZQmlOVw83+uE6UZggl/HWsE=;
        b=nV5kIKlVsCexBlGJUc/83o+Of9Nndu48rchyk96lAx0unt6oW5nYgHGBijPKTJeawD
         qcebykFfTesJemHoarxoXhkqNK2HLklkJXb/nbAoIb1ULp0uIiqgYgz97IU0TffWfR+o
         YiGdfAfMEgYDWqmZwPSNSW+vxDuEt86EeObXDoWdEOwdVCGSLB8SpR0KMiOjtURYDaIo
         sB1skOEwD+HUOkezRdwE6zzj81PInPOjkJk9krBxZaNHYTAIdeq48ja8n4mK6W7henGH
         P6b0/EEdlZpiCj/ZuJtn8p2tWetpIq39o/8zJwLtGR2T9VGYDiXgn1n1ARueAX1weESo
         oHwQ==
X-Gm-Message-State: AOAM530+MkEfaCN6MzkvvKTxjOwCrLDrIOhQlr/+boetE5BnF4uXRzXN
        f/PxLcbS3MSA+E15T8dKhiIrhANdb8dKRCYs05lbrsDQa3wfRzzdxHwVeMpOw/3SaANGREJfGaO
        rune6Afwz2CGC+UcR6zi/JCc6OZclYOgq2FsAymV3HFlzGhTg1W7K1QjKYBengtpPwG0Crzf1+O
        IS
X-Received: by 2002:a17:906:8587:: with SMTP id v7mr5905914ejx.381.1607071740464;
        Fri, 04 Dec 2020 00:49:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnV0uE83zM6QtZjqvs59h1QGi9blGzyBKnCeqNnT92giSPfDfrQQ3JxSIO806fYbu9yLQsaA==
X-Received: by 2002:a17:906:8587:: with SMTP id v7mr5905900ejx.381.1607071740284;
        Fri, 04 Dec 2020 00:49:00 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r1sm2625150eje.51.2020.12.04.00.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 00:48:59 -0800 (PST)
Subject: Re: [PATCH] kvm: x86/mmu: Use cpuid to determine max gfn
To:     Sean Christopherson <seanjc@google.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, bgardon@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201203231120.27307-1-rick.p.edgecombe@intel.com>
 <X8mGSoB6KCiFsJdC@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9f527b7b-96de-6657-aa48-8de401f5083e@redhat.com>
Date:   Fri, 4 Dec 2020 09:48:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X8mGSoB6KCiFsJdC@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/20 01:43, Sean Christopherson wrote:
> On Thu, Dec 03, 2020, Rick Edgecombe wrote:
>> In the TDP MMU, use shadow_phys_bits to dermine the maximum possible GFN
>> mapped in the guest for zapping operations. boot_cpu_data.x86_phys_bits
>> may be reduced in the case of HW features that steal HPA bits for other
>> purposes. However, this doesn't necessarily reduce GPA space that can be
>> accessed via TDP. So zap based on a maximum gfn calculated with MAXPHYADDR
>> retrieved from CPUID. This is already stored in shadow_phys_bits, so use
>> it instead of x86_phys_bits.
>>
>> Fixes: faaf05b00aec ("kvm: x86/mmu: Support zapping SPTEs in the TDP MMU")
>> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> Dang, in hindsight it'd be nice if KVM_CAP_SMALLER_MAXPHYADDR allowed explicitly
> setting the max MAXPHYADDR for an entire VM instead of being a simple toggle.
> E.g. TDX and SEV-ES likely could also make use of "what's this VM's max GPA?".
> 
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> 

Queued, thanks.

Paolo

