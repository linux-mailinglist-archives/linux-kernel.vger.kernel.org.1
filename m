Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E16F274300
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgIVN1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726605AbgIVN1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600781223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYweaPoxSyxRUmR5BPefHZ5reFbuJPY2rXIelCPCijE=;
        b=OILEC0/RqdM/vUtCeDSJgDVwX2z3uXJzWBgAuFxctdHoo2jzbyM97URGTDn5XBffgg0wu2
        nn28M6e3Pe8xfvgYswdZaapwLeuUtce33PLXqki6zGOAIWeoypf0Y6doA0L2FyqSo0gM3d
        9pq3clWk9QGL1jWeCTzXtcSdZ8izf0Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-42dkTZkTOEeYSbC7YBdh-A-1; Tue, 22 Sep 2020 09:27:01 -0400
X-MC-Unique: 42dkTZkTOEeYSbC7YBdh-A-1
Received: by mail-wr1-f69.google.com with SMTP id s8so7390210wrb.15
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 06:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hYweaPoxSyxRUmR5BPefHZ5reFbuJPY2rXIelCPCijE=;
        b=OjzjqAaqwdOXKXZJ/riTeUhkWcqZEc+fHHCpnTioUXeNFQIiZ8EsiQfZHUO81sOEFm
         a1YhfpTt8x5xpC+xLS/B2YQxOLMxQcalJmBsSId7r+eIt20mFlolzM10+/byW8GTb13y
         ngto9QICTqdxNlX/qSvcsbpVGbUWKiJ7vQCCh+T8YY6ejVod8w73wiSCfv4jCAPf7wL2
         ZX0CDT9GgaDyZvD3UoQUnhPw6Td33I2/F26Vtcbs4gOXyT6EgHUHXLqHGz7xPSrc13+y
         NEjgJZ8SATInLT8MVUFWW/lRiPqa2jFMHiUOVf3GXqB7KQ5mEbth8orx9hGbyrozSeYR
         zqiw==
X-Gm-Message-State: AOAM530cLvzftWZAAV/CsmjQAiGIrtm5itfYa/PZEjuGESXa3FwQDrMo
        3r/+R8h3r/eL7tkisyS8L+iUKNvDAd45Z4eWcNYt/dJyFFtoPcCtf/zqNCT1OpNGIr4i5aVsJP5
        WasbV9Kk2aul1kMtH5/G/fP/Y
X-Received: by 2002:a7b:c241:: with SMTP id b1mr1057531wmj.98.1600781220284;
        Tue, 22 Sep 2020 06:27:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoPytxWYHPO2fWQv8MFY/GXUC85pNlEfOIkadCwoBDqNiJj6dspkpBTM6r4pm1SlYpR+HGAw==
X-Received: by 2002:a7b:c241:: with SMTP id b1mr1057502wmj.98.1600781220011;
        Tue, 22 Sep 2020 06:27:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec2c:90a9:1236:ebc6? ([2001:b07:6468:f312:ec2c:90a9:1236:ebc6])
        by smtp.gmail.com with ESMTPSA id a17sm29264265wra.24.2020.09.22.06.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 06:26:59 -0700 (PDT)
Subject: Re: [PATCH] KVM: SVM: use __GFP_ZERO instead of clear_page()
To:     lihaiwei.kernel@gmail.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, x86@kernel.org
Cc:     sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Haiwei Li <lihaiwei@tencent.com>
References: <20200916083621.5512-1-lihaiwei.kernel@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5bab508c-09c7-4b91-89a6-322f52c5d77d@redhat.com>
Date:   Tue, 22 Sep 2020 15:26:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200916083621.5512-1-lihaiwei.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/20 10:36, lihaiwei.kernel@gmail.com wrote:
> From: Haiwei Li <lihaiwei@tencent.com>
> 
> Use __GFP_ZERO while alloc_page().
> 
> Signed-off-by: Haiwei Li <lihaiwei@tencent.com>
> ---
>  arch/x86/kvm/svm/avic.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index ac830cd50830..f73f84d56452 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -153,20 +153,18 @@ int avic_vm_init(struct kvm *kvm)
>  		return 0;
>  
>  	/* Allocating physical APIC ID table (4KB) */
> -	p_page = alloc_page(GFP_KERNEL_ACCOUNT);
> +	p_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
>  	if (!p_page)
>  		goto free_avic;
>  
>  	kvm_svm->avic_physical_id_table_page = p_page;
> -	clear_page(page_address(p_page));
>  
>  	/* Allocating logical APIC ID table (4KB) */
> -	l_page = alloc_page(GFP_KERNEL_ACCOUNT);
> +	l_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
>  	if (!l_page)
>  		goto free_avic;
>  
>  	kvm_svm->avic_logical_id_table_page = l_page;
> -	clear_page(page_address(l_page));
>  
>  	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
>   again:
> 

Queued, thanks.

Paolo

