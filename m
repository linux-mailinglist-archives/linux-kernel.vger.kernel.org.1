Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B1B304022
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392727AbhAZOWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:22:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403985AbhAZOPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611670411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0XmClLgpdiAZK6ABwbP7OwH9PhDGGYb9dqqasaMbUXU=;
        b=YeSf+i818qMN53wZ7drhI33di3GhqGaJkaML4XcIIb7nqKKDvP09PDvTHBXj8c0ySVdvA3
        KYiTIC1cjYOeHeTe1OHlJ5S5KPlBTp6qWCUaX2PAfD3fJRCs6BwZdyb6IwA36K5XB2rNJ5
        f9awN7SosR+xAFs0DB9AmillDvP0r9I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-ll-Ij2BeNDij3f9vS-GpeA-1; Tue, 26 Jan 2021 09:13:29 -0500
X-MC-Unique: ll-Ij2BeNDij3f9vS-GpeA-1
Received: by mail-ej1-f69.google.com with SMTP id b18so4958892ejz.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0XmClLgpdiAZK6ABwbP7OwH9PhDGGYb9dqqasaMbUXU=;
        b=L805MZh51w5GUe3lGIFZChSCNXL7A5Fk8fEJOLQvn7xO9w9CEpcp34hRpiYkkaPHnV
         ops+KEC0iNheXuWRHLiNMGNnD1VO7BgflYmF29ekwI1K1OkoepQ+t1zKWjYeFqT2nWwv
         NLBwAxEX9EQ8CH9sKw/ts5IYOZ1bk0ZpJHR/fbLomfdv3+OlUErw/3JISV7JFbIY9+or
         lk+uMXBPvYLVf/wCpSmFZu10V8wV4+lddUIk60Qz3koQ05XForwvV+z9Cj48l5SPNoSf
         lX5r7WfUEvzJDzWw4h6AXjK3Nq5qpQsmx3etct5eleu400K65XTWbEY1o5ayzZ3lB+Tk
         FCZQ==
X-Gm-Message-State: AOAM531TdFDcXvA06rj0iMauHNNtrcRcc5feaKLnX111Cvw4pHmkfZv1
        wjg/bddjAcdzGxiNptt8EKt+2cZqiV3qONqnke2i3dXjH3tVFZVeO41dFydP9ufgn15ivUQmt5y
        gS6BQfvAmS2VvSc1MGelnhGtQ
X-Received: by 2002:a17:906:1689:: with SMTP id s9mr3502064ejd.500.1611670408301;
        Tue, 26 Jan 2021 06:13:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxi1QfIxQADqBnFEJxOPrj4y68FFhT3rMTNL2K3ql/AAo8qnrn8CLNhzsYz8mHMWZ8PTcrtw==
X-Received: by 2002:a17:906:1689:: with SMTP id s9mr3502048ejd.500.1611670408146;
        Tue, 26 Jan 2021 06:13:28 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id d5sm4951358edu.12.2021.01.26.06.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 06:13:27 -0800 (PST)
Subject: Re: [PATCH 07/24] kvm: x86/mmu: Add comment on __tdp_mmu_set_spte
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
 <20210112181041.356734-8-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <59044c30-3ffb-e0ca-9bb0-7b409e6bec08@redhat.com>
Date:   Tue, 26 Jan 2021 15:13:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112181041.356734-8-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/21 19:10, Ben Gardon wrote:
> __tdp_mmu_set_spte is a very important function in the TDP MMU which
> already accepts several arguments and will take more in future commits.
> To offset this complexity, add a comment to the function describing each
> of the arguemnts.
> 
> No functional change intended.
> 
> Reviewed-by: Peter Feiner <pfeiner@google.com>
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>   arch/x86/kvm/mmu/tdp_mmu.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 2650fa9fe066..b033da8243fc 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -357,6 +357,22 @@ static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
>   				      new_spte, level);
>   }
>   
> +/*
> + * __tdp_mmu_set_spte - Set a TDP MMU SPTE and handle the associated bookkeeping
> + * @kvm: kvm instance
> + * @iter: a tdp_iter instance currently on the SPTE that should be set
> + * @new_spte: The value the SPTE should be set to
> + * @record_acc_track: Notify the MM subsystem of changes to the accessed state
> + *		      of the page. Should be set unless handling an MMU
> + *		      notifier for access tracking. Leaving record_acc_track
> + *		      unset in that case prevents page accesses from being
> + *		      double counted.
> + * @record_dirty_log: Record the page as dirty in the dirty bitmap if
> + *		      appropriate for the change being made. Should be set
> + *		      unless performing certain dirty logging operations.
> + *		      Leaving record_dirty_log unset in that case prevents page
> + *		      writes from being double counted.
> + */
>   static inline void __tdp_mmu_set_spte(struct kvm *kvm, struct tdp_iter *iter,
>   				      u64 new_spte, bool record_acc_track,
>   				      bool record_dirty_log)
> 

Queued, thanks.

Paolo

