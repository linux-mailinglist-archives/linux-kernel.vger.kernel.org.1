Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E292CEA27
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgLDIte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:49:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726471AbgLDItd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607071687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6MMxa7zrFLtOLXox2hJ/V5Hrw06U6BAmIekgZQ7GgTk=;
        b=i8Pv5W4JOGmmd53SObq6NNJTZlOMtUc1K/ZJktbrJnlQbfJeKmp+VrkQMTG1CY0TQqjIQh
        N+kc/hFGI1ZQlKiZus3/KzXynJuIF1fXz7lKvD+JMwRwMGqdSXJSQss6vi0HA9ZLon31/I
        7e2na+P83aYhlyxXHgAznSBm1aGGu+c=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-mYRr-4nYMNKWoBwENfd1ig-1; Fri, 04 Dec 2020 03:48:05 -0500
X-MC-Unique: mYRr-4nYMNKWoBwENfd1ig-1
Received: by mail-ej1-f69.google.com with SMTP id p18so1807989ejl.14
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 00:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6MMxa7zrFLtOLXox2hJ/V5Hrw06U6BAmIekgZQ7GgTk=;
        b=tWW4/w0B1cv73oXqV8WJNotEVWGxoDbWMRakQKaUgdhb9g+58wpQraF7NAeJHz3oX0
         DY/VU4zv2F/ohODOYULpQKqS/n4bWAg+YsNizxANHc8sdTEpsQsOZBNtEKXv3KZirHI9
         0GtKeXEZKcgqx+qaLX3gRdto0vQ2FLx0LWNkwLilIdf1bjHmQS6mbRjyvmt/KFx/PB0v
         X9plk60EhDSGZRCgRsnS8MwSdp4Li7bTK8PJYoLTESLkFqOQbBxlZoeJWamiPpI2CgeZ
         iKpDNaf5KhibgKR2rJAizviaKv6iVFb0e9Qehac3WVXefmm9qn7WcZfUhwkNngyoZ4H0
         +6Gw==
X-Gm-Message-State: AOAM531vfLZgqMI1hGOM/iPWnSKnOTS/Hr/Hk6L70JL2VN7wgLnoKgdh
        MR/p2FDgXaFyRxByFN4Sw4ngLDsYJ75sZKvV3CD408jgLwj2vAG+YQoVmMJ2YLnQB2pfrqWlLDi
        mugzzH5aU8ZeB7pCMrpR6++ARPb0zu7hc3ohOkc0dUdB98MTzw7Luo6ZfwbWt9ZoMO7zEo/EfKI
        Bd
X-Received: by 2002:a17:906:2581:: with SMTP id m1mr6027371ejb.28.1607071682948;
        Fri, 04 Dec 2020 00:48:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHFC+QWHXMUIE0IdFj/TFJAFBO6+tV1sGQBp5HVgsqZMLkL55A9lpIaom+F3ndTLLtMnGX+w==
X-Received: by 2002:a17:906:2581:: with SMTP id m1mr6027348ejb.28.1607071682694;
        Fri, 04 Dec 2020 00:48:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y6sm2588259ejl.15.2020.12.04.00.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 00:48:01 -0800 (PST)
Subject: Re: [PATCH] kvm: svm: de-allocate svm_cpu_data for all cpus in
 svm_cpu_uninit()
To:     Jacob Xu <jacobhxu@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        Oliver Upton <oupton@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201203205939.1783969-1-jacobhxu@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e5a132a0-4085-a5d5-eca9-d054f5375afd@redhat.com>
Date:   Fri, 4 Dec 2020 09:47:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203205939.1783969-1-jacobhxu@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/20 21:59, Jacob Xu wrote:
> The cpu arg for svm_cpu_uninit() was previously ignored resulting in the
> per cpu structure svm_cpu_data not being de-allocated for all cpus.
> 
> Signed-off-by: Jacob Xu <jacobhxu@google.com>
> ---
>   arch/x86/kvm/svm/svm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 79b3a564f1c9..da7eb4aaf44f 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -530,12 +530,12 @@ static int svm_hardware_enable(void)
>   
>   static void svm_cpu_uninit(int cpu)
>   {
> -	struct svm_cpu_data *sd = per_cpu(svm_data, raw_smp_processor_id());
> +	struct svm_cpu_data *sd = per_cpu(svm_data, cpu);
>   
>   	if (!sd)
>   		return;
>   
> -	per_cpu(svm_data, raw_smp_processor_id()) = NULL;
> +	per_cpu(svm_data, cpu) = NULL;
>   	kfree(sd->sev_vmcbs);
>   	__free_page(sd->save_area);
>   	kfree(sd);
> 

Queued, thanks.

Paolo

