Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26F22B2615
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgKMU6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:58:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57234 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbgKMU6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605301094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=caqRUr/hGK5eDf7oWnPdB+Co8eGMVWpEmIa3X/coQ1o=;
        b=cvbQBFsa9kJM7D6BKFtmEM4aRMjpMRAh+CimOocGbz43hmJ7CDIn/lQjz7SsdcL4ouga71
        YzvCXELArkVTzyVb9ANXcBtHPWJefdwIKYDuB76YCehmNOA3MXkJhuYaruEd/xD+0BZ23j
        TBs8QEgkHVSFU5EQ9jQ/ti9qdMwyAuk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-ZdGO6eJuOOGfnnzOrtAWQQ-1; Fri, 13 Nov 2020 15:58:12 -0500
X-MC-Unique: ZdGO6eJuOOGfnnzOrtAWQQ-1
Received: by mail-wr1-f72.google.com with SMTP id f4so4567132wru.21
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=caqRUr/hGK5eDf7oWnPdB+Co8eGMVWpEmIa3X/coQ1o=;
        b=t4DLDMrycroeUGQzWRpfiK7LlI4PR5IyqPDMkFOXKvWG5vIBcpvw/ARV9LJAdZZqO/
         5GdAQJUhLtT+4vbsbP/N34QleeQgq0w4R+DJyJ7c92IskEG7rmMW0jCXUgbOJHyej9sF
         rlv2B3x8v9TG7QuLdO2x3A7r6ppVnbXCCXocXDKka85QmLD1zeWCScta4UxgNF6EXrmN
         pe45lhD4tfuS8O3O5Ts+487O5h3G/ABgdmpdtpL2+IJLlc/PV4kjw5X4+ct3UXzSbFwU
         lrawLdvqzGBlzFkik0IKSeO10cSc61ddvuyV/CUM/gP2MeakroCpQHQiFzgCDpr09F6I
         kBFA==
X-Gm-Message-State: AOAM530MAPtRKsbgIEwzMqyaQ+ZNdvNDL5bOY13Wh6THJLzKRw5A/DMk
        SGsHVVYzpy4A+IOEmd4d/vBsF6Zt7kYRidKwsN+RN+Gz9ip9T94RntrqQB1cGSEVip10YvCmsl6
        7VRuBY7bqoMqzfVou8fWuvHvQ
X-Received: by 2002:adf:f183:: with SMTP id h3mr5868956wro.239.1605301091562;
        Fri, 13 Nov 2020 12:58:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUP7KGoC5LMFhJ+nLztikS98Doz/I1nrzf9TmcdE2pPfEKpkPzuzajcguegL+5/Q93OCJfsA==
X-Received: by 2002:adf:f183:: with SMTP id h3mr5868936wro.239.1605301091313;
        Fri, 13 Nov 2020 12:58:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id s8sm12675383wrn.33.2020.11.13.12.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 12:58:10 -0800 (PST)
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Jim Mattson <jmattson@google.com>,
        Zdenek Kaspar <zkaspar82@gmail.com>
References: <20201111185337.1237383-1-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] kvm: x86/mmu: Fix is_tdp_mmu_check when using PAE
Message-ID: <6c4a78e8-8237-b604-d047-b1ea010cf655@redhat.com>
Date:   Fri, 13 Nov 2020 21:58:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201111185337.1237383-1-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/20 19:53, Ben Gardon wrote:
> When PAE is in use, the root_hpa will not have a shadow page assoicated
> with it. In this case the kernel will crash with a NULL pointer
> dereference. Add checks to ensure is_tdp_mmu_root works as intended even
> when using PAE.
> 
> Tested: compiles
> 
> Fixes: 02c00b3a2f7e ("kvm: x86/mmu: Allocate and free TDP MMU roots")
> Reported-by: Zdenek Kaspar <zkaspar82@gmail.com>
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>   arch/x86/kvm/mmu/tdp_mmu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 27e381c9da6c..13013f4d98ad 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -49,8 +49,18 @@ bool is_tdp_mmu_root(struct kvm *kvm, hpa_t hpa)
>   {
>   	struct kvm_mmu_page *sp;
>   
> +	if (WARN_ON(!VALID_PAGE(hpa)))
> +		return false;
> +
>   	sp = to_shadow_page(hpa);
>   
> +	/*
> +	 * If this VM is being run with PAE, the TDP MMU will not be enabled
> +	 * and the root HPA will not have a shadow page associated with it.
> +	 */
> +	if (!sp)
> +		return false;
> +
>   	return sp->tdp_mmu_page && sp->root_count;
>   }
>   
> 

If this was just PAE, it would be easier to test "if (shadow_root_level 
 >= PT64_ROOT_4LEVEL)"---and more correct too, because using the 
page_private of __pa(vcpu->arch.mmu->pae_root) is a bit untidy; we 
should only use page_private for pages that we know have a shadow page.

In Jamie's case however, it is x86_64 (so kvm_mmu_get_tdp_level(vcpu) == 
4 and therefore the "if (shadow_root_level >= PT64_ROOT_4LEVEL)" would 
be true) but without EPT.  In that case we go through

	vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->lm_root);

but lm_root is allocated with get_zeroed_page and therefore 
to_shadow_page is NULL.

I am thinking of testing simply "if (tdp_enabled)" so that we can see if 
there are other cases with to_shadow_page(hpa) == NULL and we don't 
sweep them under the rug.  Or test "if (tdp_enabled)" and also WARN if 
!sp.  What do you think?

Paolo

