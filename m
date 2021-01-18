Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9103C2FA7A7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 18:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436606AbhARRhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:37:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407135AbhARRfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610991255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wJ1XQaF5N2XscuyTik9CPVcNFvnzWRPGDeOnvBBvm2s=;
        b=JQuRypGma/GuA+gkKqrzN4GktNtTmwGDjQv2YbYc+NuV5M6kcyAbL3ASxeM+cwJE2I8zg2
        UThyIXklfI4cm+/POhflvJEvuv41XoIzR1A1Qr8IMBPAT2LUVOCv/3p8eGMq+k42ewEYqf
        wJNlwvW6srCILgnJLF4WsPuaXdZZd/w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-KTRq61vfNPWwCVU_1fK-yQ-1; Mon, 18 Jan 2021 12:34:13 -0500
X-MC-Unique: KTRq61vfNPWwCVU_1fK-yQ-1
Received: by mail-wr1-f69.google.com with SMTP id o12so8590586wrq.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:34:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wJ1XQaF5N2XscuyTik9CPVcNFvnzWRPGDeOnvBBvm2s=;
        b=jC1Eieq3YpLfoAOD5hWR1pSVEnwyRrPmUeRyfLcrh8ZzYCzD4o6Cksu8meiizc42rx
         SEuc6MbUpUtnrrbD4Dukb9ke+I/cwyZzi1HSlFZx1n499O2swPaCOXrXkHaPNPaT3VpO
         QycQtHgs6Ag7BbNf7V+DmKHCpBztXmorJImuUXmNLLr+D8S64Ag1BV83ynuqOsQ679z/
         2FzJ+Hbzw8RFOTX/r5llC2AfpbyNvTVaHSX3whb1AjCEShGkagEeNxDX9u+t3FE64ID0
         b/7BKZ7hM3aVTmuDLWb7f5HeZH41MdAvpjWvGakfGf+qSmndqexvOLOhQTjEg6qzSa7M
         ydbg==
X-Gm-Message-State: AOAM532Wc1t1QumT17c62Pz6hejj77eua3r25MdP0stBR7W4e4aO0jnB
        7naPEpn1PUEuQfVJxaxf6C5142fK/NJi4b1gmUiJHgdoYg9mj+YxVNQsfSfqfuecXThCEugA4pf
        Ob2ng8BNmRXs1gEhguEu1hR05
X-Received: by 2002:a1c:e055:: with SMTP id x82mr397527wmg.185.1610991252052;
        Mon, 18 Jan 2021 09:34:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwm1BjmHEiMUjtJAAYvl3gKUmOfJsMUZPraLww2DzaPyROieCIgKkzsogVh8SNrAHm4/ct6aw==
X-Received: by 2002:a1c:e055:: with SMTP id x82mr397515wmg.185.1610991251851;
        Mon, 18 Jan 2021 09:34:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id g1sm32214606wrq.30.2021.01.18.09.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 09:34:11 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: Zap the oldest MMU pages, not the newest
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zdenek Kaspar <zkaspar82@gmail.com>
References: <20210113205030.3481307-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0e8b9adb-1010-1b76-620b-4235eee405cf@redhat.com>
Date:   Mon, 18 Jan 2021 18:34:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210113205030.3481307-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/21 21:50, Sean Christopherson wrote:
> Walk the list of MMU pages in reverse in kvm_mmu_zap_oldest_mmu_pages().
> The list is FIFO, meaning new pages are inserted at the head and thus
> the oldest pages are at the tail.  Using a "forward" iterator causes KVM
> to zap MMU pages that were just added, which obliterates guest
> performance once the max number of shadow MMU pages is reached.
> 
> Fixes: 6b82ef2c9cf1 ("KVM: x86/mmu: Batch zap MMU pages when recycling oldest pages")
> Reported-by: Zdenek Kaspar <zkaspar82@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/mmu/mmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 6d16481aa29d..ed861245ecf0 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2417,7 +2417,7 @@ static unsigned long kvm_mmu_zap_oldest_mmu_pages(struct kvm *kvm,
>   		return 0;
>   
>   restart:
> -	list_for_each_entry_safe(sp, tmp, &kvm->arch.active_mmu_pages, link) {
> +	list_for_each_entry_safe_reverse(sp, tmp, &kvm->arch.active_mmu_pages, link) {
>   		/*
>   		 * Don't zap active root pages, the page itself can't be freed
>   		 * and zapping it will just force vCPUs to realloc and reload.
> 

Queued for 5.11, thanks.

Paolo

