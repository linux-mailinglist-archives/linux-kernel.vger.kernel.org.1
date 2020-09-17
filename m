Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB6526D824
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 11:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIQJwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 05:52:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726539AbgIQJwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600336326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nI7gqByx+HGjF7uAOxbv2eIXkfB1+ppWt4NPBNuXzwU=;
        b=OKINf+MuZdpwezWCz5rxwf27l4/lFjpW0rFnfOx120rHsyZ+fT9tjij/yo4Ed5SXTy4RVu
        KWCAFikoy01+z+KHKXUvi4pKAD6Qe5dACDS20YwA/fgdu0YUs/UmEXy/hzcd3YBWxZsZmh
        cRhxjBedlIAVJPu7reQFx2L3jibmxRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-qBMttKJrPuqY11Olw0jp0Q-1; Thu, 17 Sep 2020 05:45:56 -0400
X-MC-Unique: qBMttKJrPuqY11Olw0jp0Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EC4B64149;
        Thu, 17 Sep 2020 09:45:54 +0000 (UTC)
Received: from starship (unknown [10.35.206.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E75D7E73E;
        Thu, 17 Sep 2020 09:45:49 +0000 (UTC)
Message-ID: <24eaf0bbbc64da013b724adf1d6b2e0d53a6ed99.camel@redhat.com>
Subject: Re: [PATCH] KVM: SVM: use __GFP_ZERO instead of clear_page()
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     lihaiwei.kernel@gmail.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, x86@kernel.org
Cc:     pbonzini@redhat.com, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, Haiwei Li <lihaiwei@tencent.com>
Date:   Thu, 17 Sep 2020 12:45:48 +0300
In-Reply-To: <20200916083621.5512-1-lihaiwei.kernel@gmail.com>
References: <20200916083621.5512-1-lihaiwei.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-16 at 16:36 +0800, lihaiwei.kernel@gmail.com wrote:
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
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

