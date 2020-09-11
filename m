Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCDD26666C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgIKR1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48072 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726164AbgIKR1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 13:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599845239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=germb81mdbPxJ2sh80nFaxpLsRawudu0Nob2MSBfAQQ=;
        b=bJvW3JU1/o5OIk0o5+tM/BqN0UiNYFPadscXvvzLUBvdqnaHLbcaDaNnsWNUHePsOrbLwt
        Uob49ASg+znX/UX9KdcWZkcW84uA0Fh2oQIHoMUDJdtQX6bzbGgM776WfhwBZEv3lbC7n9
        hfrcuPWcBRh6rqq1p/c1LLM5UxldAq0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-c1b5MOjpNR-tQcuZrg0bSg-1; Fri, 11 Sep 2020 13:27:16 -0400
X-MC-Unique: c1b5MOjpNR-tQcuZrg0bSg-1
Received: by mail-wm1-f69.google.com with SMTP id c72so1620796wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 10:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=germb81mdbPxJ2sh80nFaxpLsRawudu0Nob2MSBfAQQ=;
        b=McxqMk+lU9TS/30qTUY/Vbh9tfJBKAf1zUL4Slvy84dOiYsbD5bLgiRJ9A4FUjvlkw
         N+THWZ50NgoouECH+sQUpKgvgSvQCYO3S9eTj4fB4JMkcxeZdw9l7nxzCoRHA8d+5X9o
         pIRXWMSSLPB6PLKbIHjvF+Gy/6Q/dGwWj6fzgYuQoS20cxfeHxXXUVITmfFl3n0zu/Vw
         VZoR9+LBhIbymV0umomRUgM6w7TSI1nqlK6qyt4o/scDvt2z0DFaIh238XlIrYyLfz19
         Sxe46vWJ5STmoWC5TvaSEJPDZToLJ7ioojnJ4ZPzhF+S7oUYMY9KDPm1rdPaSdH+xSIl
         d2GA==
X-Gm-Message-State: AOAM531G4qoSTXUoaq34P2E2k2bgdLC/zNc715p861DbXL9ZVkKGhMc9
        0YtqmWv4NxrriHsOf4pi+D6ihwnDOXrSPNFOiA2ioASmpaXkGHt1V0l8z09jBB75JwPM2GNcmsa
        X4blwMTAHeZfvDL6ebhBIw7+/
X-Received: by 2002:adf:ed05:: with SMTP id a5mr3055393wro.364.1599845234711;
        Fri, 11 Sep 2020 10:27:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+714Ss/NtU7n/+81wJkJaafGSQ6jwDl3NWbZRIsM4cOwwvUkTxSTzyff5S0Xi1bh4AodWHA==
X-Received: by 2002:adf:ed05:: with SMTP id a5mr3055372wro.364.1599845234466;
        Fri, 11 Sep 2020 10:27:14 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id e18sm6500243wra.36.2020.09.11.10.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 10:27:13 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: always allow writing '0' to MSR_KVM_ASYNC_PF_EN
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20200911093147.484565-1-vkuznets@redhat.com>
 <20200911160455.GB4344@sjchrist-ice>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c3f4d7d4-59b1-088d-cc85-ccd55d9e2e79@redhat.com>
Date:   Fri, 11 Sep 2020 19:27:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911160455.GB4344@sjchrist-ice>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/20 18:04, Sean Christopherson wrote:

> This doesn't actually verify that @data == 0.  kvm_pv_async_pf_enabled()
> returns true iff KVM_ASYNC_PF_ENABLED and KVM_ASYNC_PF_DELIVERY_AS_INT are
> set, e.g. this would allow setting one and not the other.  This also allows
> userspace to set vcpu->arch.apf.msr_en_val to an unsupported value, i.e.
> @data has already been propagated to the vcpu and isn't unwound.
> 
> Why not just pivot on @data when lapic_in_kernel() is false?  vcpu->arch.apic
> is immutable so there's no need to update apf.msr_en_val in either direction.
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 539ea1cd6020..36969d5ec291 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2735,7 +2735,7 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
>                 return 1;
> 
>         if (!lapic_in_kernel(vcpu))
> -               return 1;
> +               return data ? 1 : 0;
> 
>         vcpu->arch.apf.msr_en_val = data;
> 
> 
>> +		return 1;
>> +
>>  	if (kvm_gfn_to_hva_cache_init(vcpu->kvm, &vcpu->arch.apf.data, gpa,
>>  					sizeof(u64)))
>>  		return 1;
>> -- 
>> 2.25.4
>>
> 

Committed this instead, though.

Paolo

