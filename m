Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FFE280E5B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 09:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgJBH6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 03:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37807 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725961AbgJBH6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 03:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601625493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tMgNt08CRRmOXK3CIWenyUlTQX/4sjp7rZl7HOrw3DA=;
        b=MCUrcoAHndWtbiWMIWhFj1Ce2cx20Jk5ky5nUgCtUd0aldh8eSIwJ8kd20/XdItV5LeWk+
        v8a47Nw5Ia5qkBF7HrJEgjqo70dEMYmos4sSYMJOHDtiatRTXoXSrvOcMC59KPbipOTL0C
        4ofsoVGZ69U6uns6y8oCeAVakpuQXks=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-K5DEoN4UNUCvuX9z_p_QDQ-1; Fri, 02 Oct 2020 03:58:12 -0400
X-MC-Unique: K5DEoN4UNUCvuX9z_p_QDQ-1
Received: by mail-wm1-f70.google.com with SMTP id u5so253801wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 00:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tMgNt08CRRmOXK3CIWenyUlTQX/4sjp7rZl7HOrw3DA=;
        b=S2cnLM2sztx+7sX0HwU+CxGtzd4vyGRPGZHZpDQxxtDOE6D8MuVKJY0FurcgpAfN1u
         /GqdR7AAioh3JSqwFXxj57NdPY1SYGCGbsH75DLa5IacHKxFHt94vk4AgolGUoHp35qC
         h6VG8Eu6OQMy8v8/15zBElww7u0aMU0qqIlPdKPoC38IbNdtA4IHD1CAci1LzhflZXBM
         7V/gL6qbMz6LNp4nVD9svB5dk3QypH/t4ucySgBO2ih3Hk7VzxFr+uHBiZkMc6Wv0Eed
         fmfX4VynZAyC/XmBn+iaWRU3OQzqjOhtLDLcnzk5TIevT4+tXWTp/sB1W2ZnNqnjvP9m
         H6eQ==
X-Gm-Message-State: AOAM532CeUG9Iqp6ZcV4pJSQy39nOpqYgr1AGhMyaXkeE/q/86/9+pLY
        0jWwrI/yYHlAI9/DiajMYNpXf8XyjYe/csSIBkT7aexIPqjPAYG/hFZjP4hJdbnworJhVn+X7gD
        NRFHc+CDcjtfUkFrsxMOcj8hw
X-Received: by 2002:adf:a418:: with SMTP id d24mr1537777wra.80.1601625490927;
        Fri, 02 Oct 2020 00:58:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUO9y3AQg+kiMtHtpbAMV9S0Gq+elcdmP6P7MKm/4WwsJy3zoXR0uDgD0rnCYmyCKvBmBQ4A==
X-Received: by 2002:adf:a418:: with SMTP id d24mr1537748wra.80.1601625490656;
        Fri, 02 Oct 2020 00:58:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:11eb:3314:c22:e3c7? ([2001:b07:6468:f312:11eb:3314:c22:e3c7])
        by smtp.gmail.com with ESMTPSA id 76sm891200wma.42.2020.10.02.00.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 00:58:10 -0700 (PDT)
Subject: Re: [PATCH 2/6] docs: vcpu.rst: fix some build warnings
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601616399.git.mchehab+huawei@kernel.org>
 <b5385dd0213f1f070667925bf7a807bf5270ba78.1601616399.git.mchehab+huawei@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c3cb6146-4910-ea8e-f07c-9935cb971a18@redhat.com>
Date:   Fri, 2 Oct 2020 09:58:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <b5385dd0213f1f070667925bf7a807bf5270ba78.1601616399.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/20 07:49, Mauro Carvalho Chehab wrote:
> As warned with make htmldocs:
> 
> 	.../Documentation/virt/kvm/devices/vcpu.rst:70: WARNING: Malformed table.
> 	Text in column margin in table line 2.
> 
> 	=======  ======================================================
> 	-ENODEV: PMUv3 not supported or GIC not initialized
> 	-ENXIO:  PMUv3 not properly configured or in-kernel irqchip not
> 	         configured as required prior to calling this attribute
> 	-EBUSY:  PMUv3 already initialized
> 	-EINVAL: Invalid filter range
> 	=======  ======================================================
> 
> The ':' character for two lines are above the size of the column.
> Besides that, other tables at the file doesn't use ':', so
> just drop them.
> 
> While here, also fix this warning also introduced at the same patch:
> 
> 	.../Documentation/virt/kvm/devices/vcpu.rst:88: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> By marking the C code as a literal block.
> 
> Fixes: 8be86a5eec04 ("KVM: arm64: Document PMU filtering API")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/virt/kvm/devices/vcpu.rst | 26 ++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
> index da7c2ef7dafc..2acec3b9ef65 100644
> --- a/Documentation/virt/kvm/devices/vcpu.rst
> +++ b/Documentation/virt/kvm/devices/vcpu.rst
> @@ -67,25 +67,25 @@ irqchip.
>  :Returns:
>  
>  	 =======  ======================================================
> -	 -ENODEV: PMUv3 not supported or GIC not initialized
> -	 -ENXIO:  PMUv3 not properly configured or in-kernel irqchip not
> +	 -ENODEV  PMUv3 not supported or GIC not initialized
> +	 -ENXIO   PMUv3 not properly configured or in-kernel irqchip not
>  	 	  configured as required prior to calling this attribute
> -	 -EBUSY:  PMUv3 already initialized
> -	 -EINVAL: Invalid filter range
> +	 -EBUSY   PMUv3 already initialized
> +	 -EINVAL  Invalid filter range
>  	 =======  ======================================================
>  
> -Request the installation of a PMU event filter described as follows:
> +Request the installation of a PMU event filter described as follows::
>  
> -struct kvm_pmu_event_filter {
> -	__u16	base_event;
> -	__u16	nevents;
> +    struct kvm_pmu_event_filter {
> +	    __u16	base_event;
> +	    __u16	nevents;
>  
> -#define KVM_PMU_EVENT_ALLOW	0
> -#define KVM_PMU_EVENT_DENY	1
> +    #define KVM_PMU_EVENT_ALLOW	0
> +    #define KVM_PMU_EVENT_DENY	1
>  
> -	__u8	action;
> -	__u8	pad[3];
> -};
> +	    __u8	action;
> +	    __u8	pad[3];
> +    };
>  
>  A filter range is defined as the range [@base_event, @base_event + @nevents),
>  together with an @action (KVM_PMU_EVENT_ALLOW or KVM_PMU_EVENT_DENY). The
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

