Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1265E304023
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392752AbhAZOXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:23:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49666 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392725AbhAZOWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611670867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eNSgEeZdLLIuAUCEHsaDo4oQ9eCOI3cWro5zxhTZ7Zw=;
        b=UHy01+qSuctzVzQtKxOQJ5xwREjXR8drt9FNFtubDxGu2xGRmy/pPxwoLarD2KKcZ2Ahj0
        QEGdGVTiZr5KU0sseupmeSErL3OJ+sKPqdvUQJE7TdQzfiTSROIwpZr5vcE/+jjH7jBXO5
        c7LD7tw1fuvvWVwm2XRZZMEfdS5Jo74=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-z29P9GPcOnCMU6L5RrGxjw-1; Tue, 26 Jan 2021 09:21:05 -0500
X-MC-Unique: z29P9GPcOnCMU6L5RrGxjw-1
Received: by mail-ed1-f71.google.com with SMTP id a26so9506081edx.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eNSgEeZdLLIuAUCEHsaDo4oQ9eCOI3cWro5zxhTZ7Zw=;
        b=Agz7N7BKL4/uewA0od6rWsHURDLHxQ8BnaVIW5oUB5YFg5660GIyDvo5NcXyyEsHEN
         Wemr3Rj4vo8SbwIdc9TG+rQ8NWW0LWxDuK8Fh4DMNhnt4kTupeo+yN5HDHQiLmdS0+X6
         lUEFvxl7nACo7MB/SlE90so7UC8muDbv5Zr5mCr58lJhdfsbYobl9r5um1GV75RkQt1/
         f9+kxHlhcpQlb1kMOo3on26Ru1OjtGwdfGnMl9zwXLPjOpy34CyW8Nda0OG0CXkrAesl
         E2cl64eFXYtYoEBYd8irHFOPI108her7e7owM4YR2GlocGKw4LN1kSNaw5RO0LDJ0q/k
         F2MA==
X-Gm-Message-State: AOAM53331AeYcTUWDaxN5EBi8HNIo0RXuxbnAsYzIYZa0IBoMbxoALzm
        kEhtNisaDaySpWFYt/euxleE7ySnTZvEoYonM49OCn+Wf4ydwONhEElqyF2QBRfjf/dvghEH0Um
        HiLkhgbtzwbh8X5wGHvXd+X+T
X-Received: by 2002:a17:906:408:: with SMTP id d8mr3624268eja.280.1611670864713;
        Tue, 26 Jan 2021 06:21:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2W8EByYnzrwIDSPVxt774Ltw1ieXyNKu9vDpx3vyeHrpguT+p5+1YuhMLcKr0IZCwqLDswA==
X-Received: by 2002:a17:906:408:: with SMTP id d8mr3624251eja.280.1611670864513;
        Tue, 26 Jan 2021 06:21:04 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n5sm10943648edw.7.2021.01.26.06.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 06:21:03 -0800 (PST)
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
 <20210112181041.356734-21-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 20/24] kvm: x86/mmu: Add atomic option for setting SPTEs
Message-ID: <dc9e48b8-c5fb-ea17-c732-b224d78daa74@redhat.com>
Date:   Tue, 26 Jan 2021 15:21:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112181041.356734-21-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/21 19:10, Ben Gardon wrote:
>  static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
> -				u64 old_spte, u64 new_spte, int level);
> +				u64 old_spte, u64 new_spte, int level,
> +				bool atomic);

If you don't mind, I prefer "shared" as the name for the new argument 
(i.e. "this is what you need to know", rathar than "this is what I want 
you to do").

> 
> +/*
> + * tdp_mmu_set_spte_atomic - Set a TDP MMU SPTE atomically and handle the
> + * associated bookkeeping
> + *
> + * @kvm: kvm instance
> + * @iter: a tdp_iter instance currently on the SPTE that should be set
> + * @new_spte: The value the SPTE should be set to
> + * Returns: true if the SPTE was set, false if it was not. If false is returned,
> + *	    this function will have no side-effects.
> + */
> +static inline bool tdp_mmu_set_spte_atomic(struct kvm *kvm,
> +					   struct tdp_iter *iter,
> +					   u64 new_spte)
> +{
> +	u64 *root_pt = tdp_iter_root_pt(iter);
> +	struct kvm_mmu_page *root = sptep_to_sp(root_pt);
> +	int as_id = kvm_mmu_page_as_id(root);
> +
> +	kvm_mmu_lock_assert_held_shared(kvm);
> +
> +	if (cmpxchg64(iter->sptep, iter->old_spte, new_spte) != iter->old_spte)
> +		return false;
> +
> +	handle_changed_spte(kvm, as_id, iter->gfn, iter->old_spte, new_spte,
> +			    iter->level, true);
> +
> +	return true;
> +}
> +
> +

Still unused as of this patch, so please move it where it's used.

Note that in this case, "atomic" in the name is appropriate, think of 
hypothetical code like this:

	if (!shared)
		tdp_mmu_set_spte(...)
	else if (!tdp_mmu_set_spte_atomic(...)
		

which says "if there could be concurrent changes, be careful and do 
everything with atomic operations".

Paolo

