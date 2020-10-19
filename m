Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2FA292AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbgJSPyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:54:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730379AbgJSPyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603122892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4z1phI+SVOyafuXVS/D26W6DGzBcOPHN9ROuznA6UNI=;
        b=Qv9KH50OaXbRRkKvGPM+uq11O5b0r25K+htlAHPYM9CnyfujJ25gr+W0Hh4ym0a7BJ9bsc
        zCOcHqgc/akjo6gDfj+jIXHKvrjYqZ4c3n0EEr9uSSRAqMiMmvuCQ3tBkdwvD3/0PfogOO
        EilVCd5IX4njZCpeRl/kTKOIZaJBNwk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-0WERf3eaOFGu80yqFKQb0Q-1; Mon, 19 Oct 2020 11:54:49 -0400
X-MC-Unique: 0WERf3eaOFGu80yqFKQb0Q-1
Received: by mail-wm1-f69.google.com with SMTP id u207so95764wmu.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4z1phI+SVOyafuXVS/D26W6DGzBcOPHN9ROuznA6UNI=;
        b=H6YgJGSINj2XpKZM+CqEMJTfl9aAehXm24aD3qvxrXinbIEEQQucpzWOWD+TBdetlf
         gfHbRqQF75ukdv3RsAUcjhHODHRweLh2hVYMTudqfewsfKfzxhOkrYRQnhgjFncJcxMu
         ZEv9PXg/6y4MoxYLIZVPLRNyrpnJXiO1C+u/5fRCwsxBU+vUaqqOVQWHxz2bFx2a5p0X
         gjw0CBYtSxK5sjtBWcnYXJu9s83AojRMgJ4n+YUigS8B1aEW273E3C6zoDDthFPSNH04
         ao587S9mX/1iYzsGc/d4PDeR2Sd3JXjaTVxvVvHkDOXxOtr+buoWKi8nHoM8tKSbqIem
         42aA==
X-Gm-Message-State: AOAM530GtnynEltMupwyk7aq5xQ6esthaDz9j9vtDNKYLVUEfQdsRvnR
        9I2OJQawbTzDbveP6d6x2mACc2YjZoRAxif8a0fOaBLp3Af4rNvd/cO27rqxB8/TYJ7CdoIFiNB
        pBBDqlOuFGYsY8fhsa0yUkdnA
X-Received: by 2002:a05:600c:255:: with SMTP id 21mr39444wmj.69.1603122888718;
        Mon, 19 Oct 2020 08:54:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzdPa+6nVJnTD0myUKcXmclhTnkyjSzj09HiHnr2jgW57lnv4yiOFefo5M+s3BG0ruzYbjQQ==
X-Received: by 2002:a05:600c:255:: with SMTP id 21mr39417wmj.69.1603122888503;
        Mon, 19 Oct 2020 08:54:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u20sm1188wmm.29.2020.10.19.08.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 08:54:47 -0700 (PDT)
Subject: Re: [PATCH] KVM: SVM: Initialize prev_ga_tag before use
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     joro@8bytes.org
References: <20201003232707.4662-1-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f45801ff-9fd8-636d-44df-74a70a41a712@redhat.com>
Date:   Mon, 19 Oct 2020 17:54:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201003232707.4662-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/20 01:27, Suravee Suthikulpanit wrote:
> The function amd_ir_set_vcpu_affinity makes use of the parameter struct
> amd_iommu_pi_data.prev_ga_tag to determine if it should delete struct
> amd_iommu_pi_data from a list when not running in AVIC mode.
> 
> However, prev_ga_tag is initialized only when AVIC is enabled. The non-zero
> uninitialized value can cause unintended code path, which ends up making
> use of the struct vcpu_svm.ir_list and ir_list_lock without being
> initialized (since they are intended only for the AVIC case).
> 
> This triggers NULL pointer dereference bug in the function vm_ir_list_del
> with the following call trace:
> 
>     svm_update_pi_irte+0x3c2/0x550 [kvm_amd]
>     ? proc_create_single_data+0x41/0x50
>     kvm_arch_irq_bypass_add_producer+0x40/0x60 [kvm]
>     __connect+0x5f/0xb0 [irqbypass]
>     irq_bypass_register_producer+0xf8/0x120 [irqbypass]
>     vfio_msi_set_vector_signal+0x1de/0x2d0 [vfio_pci]
>     vfio_msi_set_block+0x77/0xe0 [vfio_pci]
>     vfio_pci_set_msi_trigger+0x25c/0x2f0 [vfio_pci]
>     vfio_pci_set_irqs_ioctl+0x88/0xb0 [vfio_pci]
>     vfio_pci_ioctl+0x2ea/0xed0 [vfio_pci]
>     ? alloc_file_pseudo+0xa5/0x100
>     vfio_device_fops_unl_ioctl+0x26/0x30 [vfio]
>     ? vfio_device_fops_unl_ioctl+0x26/0x30 [vfio]
>     __x64_sys_ioctl+0x96/0xd0
>     do_syscall_64+0x37/0x80
>     entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Therefore, initialize prev_ga_tag to zero before use. This should be safe
> because ga_tag value 0 is invalid (see function avic_vm_init).
> 
> Fixes: dfa20099e26e ("KVM: SVM: Refactor AVIC vcpu initialization into avic_init_vcpu()")
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  arch/x86/kvm/svm/avic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index ac830cd50830..381d22daa4ac 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -868,6 +868,7 @@ int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
>  			 * - Tell IOMMU to use legacy mode for this interrupt.
>  			 * - Retrieve ga_tag of prior interrupt remapping data.
>  			 */
> +			pi.prev_ga_tag = 0;
>  			pi.is_guest_mode = false;
>  			ret = irq_set_vcpu_affinity(host_irq, &pi);
>  
> 

Queued (with Cc: stable), thanks.

Paolo

