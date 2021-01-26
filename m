Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59B8303FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391374AbhAZOSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:18:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42211 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405602AbhAZOP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611670438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNCgxUQir3txorT8ut5xBapMDlIH7jLnPf32y1Xl4zA=;
        b=TY5GFxhb0q1ITeESgyAg/g25nWRXyvIjKDAe8FUlqarI9s5oM1U7OkhXZrcXR4QPW6hva9
        OLqtoIvpb151blTfoZLv1oka2/3pYZK1/WFW4lMd9LKlJzLjkfSgO7QdvF/LOl116zfO3j
        Xclpht6YNt2oOlcA9nbQTcKfT/R47lQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-heo_wqAfOJ2zL9Lj2mAeBQ-1; Tue, 26 Jan 2021 09:13:56 -0500
X-MC-Unique: heo_wqAfOJ2zL9Lj2mAeBQ-1
Received: by mail-ej1-f71.google.com with SMTP id hd8so3463190ejc.22
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WNCgxUQir3txorT8ut5xBapMDlIH7jLnPf32y1Xl4zA=;
        b=mXSvTVOjZmwtaf5kN315M2RHWUZhWSdV4RNw09WtUL3AoiEq/73wfKBOG6NpQQONCL
         2wM/6H2VqRfkfNJ4+fbYR1HfCANCHRrYeDLOw7/Qx9ALdCswN9spotNoFolt6XYZjvha
         CbdmcN1H5OoNZk63f+Nagg934Ng5euq52PrwDvBey0TfwY3Wn50fP2giTEXrY2xHi1OR
         sPCuOf1kXBNzUGG+s0lZ/HLpvEZ4qLdSLRWYfKRLd5/2Yl4LTrSS4P7PTr2lVWYzB2E2
         ETkEOm8aOzlfeuYYOaqzqTBDg6jX0L6iU1noJYreqNX4pMVXA6qjWPz0UpUOGHgQfTT5
         7DKg==
X-Gm-Message-State: AOAM531d14+bRwELy19X4zxsEWCi6SJh6Lh6lwqJoG2KDL+Bi7Mvl6jl
        crlk77EPljpJOpqvy6JN+Ghc+wce5zqI+hvq9JLQPpouX7oqa5+WpgL/tj7JC5J3GKoSPUWkqdi
        QzKMEI388QAC+yU7xWH6+sR6W
X-Received: by 2002:aa7:d64b:: with SMTP id v11mr4529213edr.16.1611670435543;
        Tue, 26 Jan 2021 06:13:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwY7vgpp3lQAQOt4e9Fjtxz70y0tbEdnRYyoa3bXlLDhpXfSeLI4NX1npATa2HkjvR//OcKvA==
X-Received: by 2002:aa7:d64b:: with SMTP id v11mr4529195edr.16.1611670435366;
        Tue, 26 Jan 2021 06:13:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id lz27sm9689388ejb.50.2021.01.26.06.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 06:13:54 -0800 (PST)
Subject: Re: [PATCH 08/24] kvm: x86/mmu: Add lockdep when setting a TDP MMU
 SPTE
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210112181041.356734-1-bgardon@google.com>
 <20210112181041.356734-9-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f532b3f2-6ac6-a5ab-9653-212a1b15b7b4@redhat.com>
Date:   Tue, 26 Jan 2021 15:13:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112181041.356734-9-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/21 19:10, Ben Gardon wrote:
> Add lockdep to __tdp_mmu_set_spte to ensure that SPTEs are only modified
> under the MMU lock. This lockdep will be updated in future commits to
> reflect and validate changes to the TDP MMU's synchronization strategy.
> 
> No functional change intended.
> 
> Reviewed-by: Peter Feiner <pfeiner@google.com>
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>   arch/x86/kvm/mmu/tdp_mmu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index b033da8243fc..411938e97a00 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -381,6 +381,8 @@ static inline void __tdp_mmu_set_spte(struct kvm *kvm, struct tdp_iter *iter,
>   	struct kvm_mmu_page *root = sptep_to_sp(root_pt);
>   	int as_id = kvm_mmu_page_as_id(root);
>   
> +	lockdep_assert_held(&kvm->mmu_lock);
> +
>   	WRITE_ONCE(*iter->sptep, new_spte);
>   
>   	__handle_changed_spte(kvm, as_id, iter->gfn, iter->old_spte, new_spte,
> 

Queued, thanks.

Paolo

