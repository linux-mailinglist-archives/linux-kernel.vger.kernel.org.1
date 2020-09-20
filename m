Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D392271460
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 15:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgITNJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 09:09:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbgITNJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 09:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600607385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tQtZIkCK0ktr8AegN7dbuaoNkHFsFqqE+L/tvd9j/To=;
        b=PCwtaUPNywK90C7M5Jte57gEPW3EKJDA7slKA17ANMb6SeTn5LL/dKORn3j6K8zeXxbiLg
        /4V55Ip1D84M1M/y0j6UQTuLSx4yK+cGffLNEtmzWLsv0gbnx9K2DqKvtovmp6c43i0rYd
        3qhI6rCh5odWh1S5oeTHtQEWohvRJ8k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-6V0goYUmM7eebqTg06ynGA-1; Sun, 20 Sep 2020 09:09:41 -0400
X-MC-Unique: 6V0goYUmM7eebqTg06ynGA-1
Received: by mail-wm1-f71.google.com with SMTP id m19so1234854wmg.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 06:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tQtZIkCK0ktr8AegN7dbuaoNkHFsFqqE+L/tvd9j/To=;
        b=VcPncnSMT/1kQQkWX9D3qGK0MF4U0uZwIv3U3dUHD6+Mg0Jpn6arlWGKtM84FaHgSt
         PcytwtX7V0t/yXPf0vUHvBix0gpLPgi08TDbh124Oqra6fFZgwlCQToj/RI4mi/U55oH
         fUWXe+PbTcLzYCaxJlDrtXysjrSrKtUaL7gEkQWfZ5ngwmDF031dbDS3ZiSRkDerOvYY
         7NB4cTWBTEMUqNPXSSBoNWVmGGKZE42AFmva3P/dA/FtzVmRPrWkEt6fWCwLND8NuS75
         0KbpgFIxzcOTtE27sEYcdWo1IfWCabo0UzCLAJrka+Qi4QeKKWFY7J5mlA1ZdelCt0SG
         3X0g==
X-Gm-Message-State: AOAM533NRyc4/nI/jitUnZY5MzPYPxT3RtPfBFSNduFUvBNUAR+mcuGW
        r6y+OTf3WnOLTd9ZjeULWtBejbc0xkJgLuQs/cjwGdPEO48M10L/4ZjiWJCWu/ZelbNVEmxL0q9
        e3hwo+Z1LryoZkxqL2Pi5cUQa
X-Received: by 2002:a5d:6406:: with SMTP id z6mr45948209wru.133.1600607380223;
        Sun, 20 Sep 2020 06:09:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZZBDFgZsVVruHy6ea7pNPzN/aDtsTbqyZ1AtRME/1RE+BY6Pj4qCkK/pcztX4FOvViS2i/Q==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr45948191wru.133.1600607380035;
        Sun, 20 Sep 2020 06:09:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:458b:b280:cf0:4acf? ([2001:b07:6468:f312:458b:b280:cf0:4acf])
        by smtp.gmail.com with ESMTPSA id f12sm14086468wmf.26.2020.09.20.06.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 06:09:39 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: Fix the build error
To:     lihaiwei.kernel@gmail.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, x86@kernel.org
Cc:     sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        lihaiwei@tencent.com, kernel test robot <lkp@intel.com>
References: <20200914091148.95654-1-lihaiwei.kernel@gmail.com>
 <20200914091148.95654-2-lihaiwei.kernel@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1810e3e5-8286-29e0-ff10-636d6c32df6d@redhat.com>
Date:   Sun, 20 Sep 2020 15:09:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914091148.95654-2-lihaiwei.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/20 11:11, lihaiwei.kernel@gmail.com wrote:
> From: Haiwei Li <lihaiwei@tencent.com>
> 
> When CONFIG_SMP is not set, an build error occurs with message "error:
> use of undeclared identifier 'kvm_send_ipi_mask_allbutself'"
> 
> Fixes: 0f990222108d ("KVM: Check the allocation of pv cpu mask", 2020-09-01)
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Haiwei Li <lihaiwei@tencent.com>
> ---
>  arch/x86/kernel/kvm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 1b51b727b140..7e8be0421720 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -797,7 +797,9 @@ static __init int kvm_alloc_cpumask(void)
>  			}
>  		}
>  
> +#if defined(CONFIG_SMP)
>  	apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
> +#endif
>  	pv_ops.mmu.flush_tlb_others = kvm_flush_tlb_others;
>  	return 0;
>  
> 

If CONFIG_SMP is not set you don't need kvm_alloc_cpumask or
pv_ops.mmu.flush_tlb_others at all.  Can you squash these two into the
original patch and re-submit for 5.10?

Paolo

