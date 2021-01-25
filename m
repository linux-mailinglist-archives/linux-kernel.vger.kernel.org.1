Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4C13028CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 18:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbhAYR0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 12:26:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53864 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731028AbhAYRZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611595452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hABPZ/hSthf9YuEr1NMmkQT9Sp/nFeQHAsdXUsqC/dY=;
        b=PqWBzvbpvjEh0f66uGvgmkpxpfgvW53zW87G1I18On9MFVK+6+EVJXI8J+dMdJH9G4mDpR
        bJ+OM4OMMuJKrM8HuH+/ggYCNqgTQCAtrOxbR3fNROW5nQnvWbyTRNoKEIrJpuZcbedREB
        MyvrHSYmfPlho5MLAylfKqzvf3OQBWY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-R5lSj2GTNX2hNlY6eH2tJg-1; Mon, 25 Jan 2021 12:24:04 -0500
X-MC-Unique: R5lSj2GTNX2hNlY6eH2tJg-1
Received: by mail-ej1-f70.google.com with SMTP id q11so4085975ejd.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 09:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hABPZ/hSthf9YuEr1NMmkQT9Sp/nFeQHAsdXUsqC/dY=;
        b=qNs26aQaLNM48vOl6PtweShj4F7B/SjYY/E632AeMbcd40MqDYzjiTRZsn197LalP+
         N9VkyXNekZUwf8KZGK92BovbHtShtMesLFB5pxpxrxhMrRHbv0XoNDs4gIUj2jEG1cnV
         DEJgBQfKzIUBoT2t2sYzgza11O8uqoWpB3CJwpQqQMW2JXIz0YUrvoQuT8qdz/i3wMgR
         1YyWdSPtnL0t8KEgpZtLfyLdoxoiAJZBfMC7TBcE6RINR7vi5NhBD1y+7gLEe1QBFchJ
         zwLD4aIGJnA7lHwxVjtj1VWpIc1PeDv6Lt9JcPFVG4FRXSGmfYrvsBTazDpvIqVVSW0g
         js+Q==
X-Gm-Message-State: AOAM531WUORDrKGkvSZeUFP54RTH/5JRUjZn2QhYTY0Ku6qH5fu0Ie1E
        U9LpKeXk/B/0XBfQlklu+2vSu/ZX6D41p/FK7D0lVX5y/17MWPqWNO5A+OHqMtvcpIY4R//K877
        D1RtCSq1hfQAUvtJjg94G5jEG0o75o73nEzCbdMjrWX6Km8CN61IxUg1KoVyn/2jT+vqaB+nbNh
        TA
X-Received: by 2002:a17:906:95cf:: with SMTP id n15mr1071587ejy.178.1611595442856;
        Mon, 25 Jan 2021 09:24:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8rDEIkzVuwuIY9gHBDSMn8Bg4MrPxxaoj6eGZai/HanTxGtGKHWbtGf5J7TnI5+MPNOiEPQ==
X-Received: by 2002:a17:906:95cf:: with SMTP id n15mr1071572ejy.178.1611595442615;
        Mon, 25 Jan 2021 09:24:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n5sm9249509edw.7.2021.01.25.09.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 09:24:01 -0800 (PST)
Subject: Re: [PATCH] KVM: x86/mmu: Use boolean returns for (S)PTE accessors
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210123003003.3137525-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <723c5a63-1847-a377-e62e-806b06b0bf17@redhat.com>
Date:   Mon, 25 Jan 2021 18:24:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210123003003.3137525-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/21 01:30, Sean Christopherson wrote:
> Return a 'bool' instead of an 'int' for various PTE accessors that are
> boolean in nature, e.g. is_shadow_present_pte().  Returning an int is
> goofy and potentially dangerous, e.g. if a flag being checked is moved
> into the upper 32 bits of a SPTE, then the compiler may silently squash
> the entire check since casting to an int is guaranteed to yield a
> return value of '0'.
> 
> Opportunistically refactor is_last_spte() so that it naturally returns
> a bool value instead of letting it implicitly cast 0/1 to false/true.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/mmu.h      |  2 +-
>   arch/x86/kvm/mmu/spte.h | 12 ++++--------
>   2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 581925e476d6..f61e18dad2f3 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -145,7 +145,7 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>    *
>    * TODO: introduce APIs to split these two cases.
>    */
> -static inline int is_writable_pte(unsigned long pte)
> +static inline bool is_writable_pte(unsigned long pte)
>   {
>   	return pte & PT_WRITABLE_MASK;
>   }
> diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
> index 2b3a30bd38b0..398fd1bb13a7 100644
> --- a/arch/x86/kvm/mmu/spte.h
> +++ b/arch/x86/kvm/mmu/spte.h
> @@ -185,23 +185,19 @@ static inline bool is_access_track_spte(u64 spte)
>   	return !spte_ad_enabled(spte) && (spte & shadow_acc_track_mask) == 0;
>   }
>   
> -static inline int is_shadow_present_pte(u64 pte)
> +static inline bool is_shadow_present_pte(u64 pte)
>   {
>   	return (pte != 0) && !is_mmio_spte(pte);
>   }
>   
> -static inline int is_large_pte(u64 pte)
> +static inline bool is_large_pte(u64 pte)
>   {
>   	return pte & PT_PAGE_SIZE_MASK;
>   }
>   
> -static inline int is_last_spte(u64 pte, int level)
> +static inline bool is_last_spte(u64 pte, int level)
>   {
> -	if (level == PG_LEVEL_4K)
> -		return 1;
> -	if (is_large_pte(pte))
> -		return 1;
> -	return 0;
> +	return (level == PG_LEVEL_4K) || is_large_pte(pte);
>   }
>   
>   static inline bool is_executable_pte(u64 spte)
> 

Queued, thanks.

Paolo

