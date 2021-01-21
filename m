Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189242FDF0F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 02:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390692AbhAUBtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 20:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbhAUA4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 19:56:53 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1948EC061786
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 16:56:00 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id o20so417105pfu.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 16:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q+sTlfHUdpFVsp7Fzw5vyE8GQzeyLMw9GCNbrTB8/LI=;
        b=j++IUpn6j1YjY0jaRYpasY0t7mWxbprI/uufZaqvRpzXY7SfRQBXrkesPaHK5LfAje
         9eZTc7RJS4BrgtC8qKKBMdjihNBmzgkJ3GayOGCBhSnczTDdxc0jR+/LAP7T69F9bPV5
         +JlNEqdzDeKkhE5qtCSH2XFrXQ/9EARog181f10bDQsfuJPHiRYvQ9ed6fzniodqkQOx
         kQGPu3ybQtoUCafVUY4bKv6O+VZvHGLcIa+zAbUHNJf8gCNYWHaPHcXc0pKAjpPdotG6
         j4e78F3hql0oeS2t3MqJKF6eVA7xItM57hmKMaAcrkMV5ruvXqhdDltnv3STtpucnLW/
         idDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q+sTlfHUdpFVsp7Fzw5vyE8GQzeyLMw9GCNbrTB8/LI=;
        b=oZr8zZt/LHXF28fp8XhdKDMM5cEhirRIGUi08zJUuwW7rzvqGaEFCn9hNQUN114/6W
         QGz0HZ6M0HQESUevWUBYI3vlf8Ta1/TP3maS764x+5DxOV9R2gU+hfjTCwPbi7rt1Tjq
         +FS18+Bvjkp1v8SOMwqb6wbZV8Ya2K6FftcK/kwReIYLNKWPeHuHBk98JVbeMjaRMsLq
         Dyp7nIBOKOJBQU10dw5GP5FL0FCDboyyUo8lE7nW06NU8OlXgPlWKTUyjyUGiCmqsezR
         9sZpxUs4t3MjIcfkoNWKtX1muv5l7ewjT/Hi0g4wy8OTTmuLJQicr7Au6nRDFNN1oD/X
         VNSg==
X-Gm-Message-State: AOAM532Dwhqm43FapRSSNl2swAdulH1ykD7qI5rmlE7MvE0eFP7yezeg
        dyK+DbSyNU2oVMdgRUN3/nqxdQ==
X-Google-Smtp-Source: ABdhPJxq2YQ42sEdEfikrjIe/ByaxfW6cpKWSBURUQhCc3OJthAG57W63TewMsqRe6hAoWPI0TpIRw==
X-Received: by 2002:a62:1b95:0:b029:19b:178f:84d7 with SMTP id b143-20020a621b950000b029019b178f84d7mr11918516pfb.70.1611190559429;
        Wed, 20 Jan 2021 16:55:59 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id z11sm3714996pjn.5.2021.01.20.16.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 16:55:58 -0800 (PST)
Date:   Wed, 20 Jan 2021 16:55:52 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Subject: Re: [PATCH 24/24] kvm: x86/mmu: Allow parallel page faults for the
 TDP MMU
Message-ID: <YAjRGBu5tAEt9xpv@google.com>
References: <20210112181041.356734-1-bgardon@google.com>
 <20210112181041.356734-25-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112181041.356734-25-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021, Ben Gardon wrote:
> Make the last few changes necessary to enable the TDP MMU to handle page
> faults in parallel while holding the mmu_lock in read mode.
> 
> Reviewed-by: Peter Feiner <pfeiner@google.com>
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 280d7cd6f94b..fa111ceb67d4 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3724,7 +3724,12 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
>  		return r;
>  
>  	r = RET_PF_RETRY;
> -	kvm_mmu_lock(vcpu->kvm);
> +
> +	if (is_tdp_mmu_root(vcpu->kvm, vcpu->arch.mmu->root_hpa))

Off topic, what do you think about rewriting is_tdp_mmu_root() to be both more
performant and self-documenting as to when is_tdp_mmu_root() !=
kvm->arch.tdp_mmu_enabled?  E.g. key off is_guest_mode() and then do a thorough
audit/check when CONFIG_KVM_MMU_AUDIT=y?

#ifdef CONFIG_KVM_MMU_AUDIT
bool is_tdp_mmu_root(struct kvm *kvm, hpa_t hpa)
{
	struct kvm_mmu_page *sp;

	if (!kvm->arch.tdp_mmu_enabled)
		return false;
	if (WARN_ON(!VALID_PAGE(hpa)))
		return false;

	sp = to_shadow_page(hpa);
	if (WARN_ON(!sp))
		return false;

	return sp->tdp_mmu_page && sp->root_count;
}
#endif

bool is_tdp_mmu(struct kvm_vcpu *vcpu)
{
	bool is_tdp_mmu = kvm->arch.tdp_mmu_enabled && !is_guest_mode(vcpu);

#ifdef CONFIG_KVM_MMU_AUDIT
	WARN_ON(is_tdp_mmu != is_tdp_mmu_root(vcpu->kvm, vcpu->arch.mmu->root_hpa));
#endif
	return is_tdp_mmu;
}

> +		kvm_mmu_lock_shared(vcpu->kvm);
> +	else
> +		kvm_mmu_lock(vcpu->kvm);
> +
>  	if (mmu_notifier_retry(vcpu->kvm, mmu_seq))
>  		goto out_unlock;
>  	r = make_mmu_pages_available(vcpu);
> @@ -3739,7 +3744,10 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
>  				 prefault, is_tdp);
>  
>  out_unlock:
> -	kvm_mmu_unlock(vcpu->kvm);
> +	if (is_tdp_mmu_root(vcpu->kvm, vcpu->arch.mmu->root_hpa))
> +		kvm_mmu_unlock_shared(vcpu->kvm);
> +	else
> +		kvm_mmu_unlock(vcpu->kvm);
>  	kvm_release_pfn_clean(pfn);
>  	return r;
>  }
> -- 
> 2.30.0.284.gd98b1dd5eaa7-goog
> 
