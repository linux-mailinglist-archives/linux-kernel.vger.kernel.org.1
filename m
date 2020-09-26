Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC482795F7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 03:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgIZBZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 21:25:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54011 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729830AbgIZBZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 21:25:35 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601083534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKw7q25KXo2grABOIw7jgZQmp7SGBPjTObh8YDtmdsA=;
        b=JzOVTLpgKEz/LC2ZJ6Rf8akwq1uN3c4u5xeWlVr7DNnnlRBaqJvicTl/SE5A96iEWxqLJz
        USvjGMEnuRM8NlW2eqlF20S2jGatOC59EMk/xPZGAug0juo33pNa2nwMjpKZMMk/rxaQMw
        2TRGfuThgB61u8nu4YFQLNh1ZT3S4GM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-vJ8jbZsrMG667zyB51LTQg-1; Fri, 25 Sep 2020 21:25:32 -0400
X-MC-Unique: vJ8jbZsrMG667zyB51LTQg-1
Received: by mail-wm1-f71.google.com with SMTP id p20so311223wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 18:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pKw7q25KXo2grABOIw7jgZQmp7SGBPjTObh8YDtmdsA=;
        b=eiVbttttFl+MLF4fgKpJveHjdQiAiWC/8lA4ArEvwoB/Wf7CrGgzFkeoSuolrgu3uY
         tyQa16ufsVYK+kjcyfLr+NMXcyb3fR+H+B45ZaayYFjlyRtmT4lIYnWusYDZLe/9Syro
         4DfwN4ly75Ymp9y/GVeRYJW1V0ok4TrnW+SXy47OO2Zair5Q9V3676PZFgFcxE7c9TeG
         sEMNbRV3nmie45xyf9eL2ADZqQYu34BjewEyaKkoeD1OUBm37LAx1KCpmDT0zBZH2bS1
         5lW156NBlGcQ9WhAoHN46B3AJbcGV5E9JZkuZ4Na0IWTOpqap6T4g6ylMf28ipyOytth
         0R1g==
X-Gm-Message-State: AOAM531lIZL+fUvrcat6LTolDwoGlsFopkXBu0NVgh21yRFVCMXMiPpu
        TGKwl+sUPbu3a1+eFF/GGOm+HaRd+po4xGD+k6SyhIsZ8ZrQcBeFRJ4oaUo4YNPKHCNSS8+fRPu
        QbsqQYW+auVisAlFfR3GrbSdV
X-Received: by 2002:a1c:4b13:: with SMTP id y19mr270898wma.75.1601083531045;
        Fri, 25 Sep 2020 18:25:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzThgdX914l+MTa9+nGQsYTkHA8HLmXG6y1HNqm+vlYR20PVKsv9dF9RWb7LbGP4KMz1BX+ww==
X-Received: by 2002:a1c:4b13:: with SMTP id y19mr270883wma.75.1601083530844;
        Fri, 25 Sep 2020 18:25:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf? ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
        by smtp.gmail.com with ESMTPSA id u186sm774281wmu.34.2020.09.25.18.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 18:25:30 -0700 (PDT)
Subject: Re: [PATCH 22/22] kvm: mmu: Don't clear write flooding count for
 direct roots
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20200925212302.3979661-1-bgardon@google.com>
 <20200925212302.3979661-23-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a95cacdb-bc65-e11e-2114-b5c045b0eac5@redhat.com>
Date:   Sat, 26 Sep 2020 03:25:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925212302.3979661-23-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/20 23:23, Ben Gardon wrote:
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 42dde27decd75..c07831b0c73e1 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -124,6 +124,18 @@ static struct kvm_mmu_page *find_tdp_mmu_root_with_role(
>  	return NULL;
>  }
>  
> +hpa_t kvm_tdp_mmu_root_hpa_for_role(struct kvm *kvm,
> +				    union kvm_mmu_page_role role)
> +{
> +	struct kvm_mmu_page *root;
> +
> +	root = find_tdp_mmu_root_with_role(kvm, role);
> +	if (root)
> +		return __pa(root->spt);
> +
> +	return INVALID_PAGE;
> +}
> +
>  static union kvm_mmu_page_role page_role_for_level(struct kvm_vcpu *vcpu,
>  						   int level)
>  {
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
> index cc0b7241975aa..2395ffa71bb05 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.h
> +++ b/arch/x86/kvm/mmu/tdp_mmu.h
> @@ -9,6 +9,8 @@ void kvm_mmu_init_tdp_mmu(struct kvm *kvm);
>  void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm);
>  
>  bool is_tdp_mmu_root(struct kvm *kvm, hpa_t root);
> +hpa_t kvm_tdp_mmu_root_hpa_for_role(struct kvm *kvm,
> +				    union kvm_mmu_page_role role);
>  hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu);
>  void kvm_tdp_mmu_put_root_hpa(struct kvm *kvm, hpa_t root_hpa);
>  

Probably missing a piece since this code is not used and neither is the
new argument to is_root_usable.

I'm a bit confused by is_root_usable since there should be only one PGD
for the TDP MMU (the one for the root_mmu).

Paolo

