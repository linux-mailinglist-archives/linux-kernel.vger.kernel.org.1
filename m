Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0BF2DFFD1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgLUScJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:32:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21727 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726766AbgLUScI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608575442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u6aof73yWrybwGG51AadR/+S6Y7ScgNPoSw+eELySBE=;
        b=K0Kd+FuIqPSL8tQtnfsfwhx+MdJQGwHXRLHG/xtWqdQBP1v5wgWFsNSqSFVy7PsrQEKSi1
        oPsAYPnhhHbe1Ik7Y+EcoCy2LTyfvW3T1pFc8qjJH+tST+azCUPE0qBRKZuaKKU6dXTT3b
        c/cVD0HO+2CDt/HMInqV7JVKilfLem4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-F0yh-BjfMGqNjo3T59LPSQ-1; Mon, 21 Dec 2020 13:30:41 -0500
X-MC-Unique: F0yh-BjfMGqNjo3T59LPSQ-1
Received: by mail-wm1-f70.google.com with SMTP id r1so8143089wmn.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u6aof73yWrybwGG51AadR/+S6Y7ScgNPoSw+eELySBE=;
        b=pmBfG7C2R55zc1/wAcEzlAzOsZyryvDCNuPF9voeqbNQPKoRQj3dI8UGpCm66t/Tm/
         SSiYITsz+sadBfAa8Vbvm0UuwHVF6mxiScWqwEg7YzGWIOijsgpgopVQZ1BqcnOUJg5m
         GLPuallApdTMm5Y0gePYHxzmavfAwwD6G9iR22KJEJjfuSZTQo9VNgBIkCD9dyC2hpRX
         hBHgGSguiBCku5IIMbp7gjFcMnmoanGo516WJ/Lz29KL68s6gFHMY/PN2w4qoFD8KBSq
         TLMYcMZv3o5EhRvkZdBlAxX7fv9gjlHeMmt2GcpOAZRpEh9nXVOGn4DOdgR5ZUhG15Q3
         aV/g==
X-Gm-Message-State: AOAM5310T1r6JwDsPNpYPeij16VbSQGjlQGFNYiwAzJGinMMmBuamOrR
        PvGGreq5k2ZrA9atv3sVOulDA817BhFdKGiQTPvK30Wqbfnn7E2xtHLwn1o+ZLSPL1WNhhPh01e
        7WpFlsn0SLldGveZLk6DZl/FxcmIhU0GWbU75Onr1JKMtHABiHSbGN+zxefguQ9DSkbNOwTDYqM
        Z0
X-Received: by 2002:a05:6000:1290:: with SMTP id f16mr20405405wrx.298.1608575439437;
        Mon, 21 Dec 2020 10:30:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkUMftZ4r7w6EsobFo3hiS67k++nqGU3UWtRZFFfSZL36Z97x51VJVsFQ8GVT4G3fc3H17eg==
X-Received: by 2002:a05:6000:1290:: with SMTP id f16mr20405384wrx.298.1608575439250;
        Mon, 21 Dec 2020 10:30:39 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j59sm28954198wrj.13.2020.12.21.10.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 10:30:38 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: change in pv_eoi_get_pending() to make code
 more readable
To:     Stephen Zhang <stephenzhangzsd@gmail.com>, seanjc@google.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1608277897-1932-1-git-send-email-stephenzhangzsd@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a22baa12-7f37-054d-646b-b6ca393e01f7@redhat.com>
Date:   Mon, 21 Dec 2020 19:30:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1608277897-1932-1-git-send-email-stephenzhangzsd@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/20 08:51, Stephen Zhang wrote:
> Signed-off-by: Stephen Zhang <stephenzhangzsd@gmail.com>
> ---
>   arch/x86/kvm/lapic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 3136e05..7882322 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -674,7 +674,7 @@ static bool pv_eoi_get_pending(struct kvm_vcpu *vcpu)
>   			   (unsigned long long)vcpu->arch.pv_eoi.msr_val);
>   		return false;
>   	}
> -	return val & 0x1;
> +	return val & KVM_PV_EOI_ENABLED;
>   }
>   
>   static void pv_eoi_set_pending(struct kvm_vcpu *vcpu)
> 

Queued, thanks.

Paolo

