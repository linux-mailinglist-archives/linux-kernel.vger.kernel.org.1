Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585C12791E2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgIYUSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727444AbgIYUQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:16:05 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601064964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhl/Hsd69IkJCl0CUgFQtqM/mmGWznBMV8K5DH4cezQ=;
        b=TO2Cvc5Oh3iUbnxfES+KYLrWKeSoSeIpa5N+CrvKu2zGvsI9ZPMR3xdaMBzOoxGFUQMqXN
        1k8NqGSvOApcYOsCAtsNrDBEMj58QB0mF+AdHJPv1VyG1ATRDr2+AMdkDYQtEHiWBmjApa
        qH6Wcfwe9nIHjV5VROamN63cyEdnulM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-BXClBjVuMs6E7tPyayjlUQ-1; Fri, 25 Sep 2020 16:16:01 -0400
X-MC-Unique: BXClBjVuMs6E7tPyayjlUQ-1
Received: by mail-wr1-f69.google.com with SMTP id v5so426017wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 13:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yhl/Hsd69IkJCl0CUgFQtqM/mmGWznBMV8K5DH4cezQ=;
        b=kZ/AgeungZy3jEScFqpiZAYob00GoVd7FlbaGINugiGoUXAiiIEE2+G83a4LEsGvme
         wLOvoticHG8kii8sFcW3+ufd75hBUmYQImBKdhBK6hiQQaXMVnWxWXC+vcMAeTF/1AR9
         HcgdJfJi13lYv/nQSz/W3znnUqhQ+hqoz84ZE+f7NxM27gtDKKFM4wMYO4mRUEJGTt+h
         N/2CGwFE+psyOrqKVrqXppzvG465WLqk6lZeNZVV1MWK0kPxy5vaJbCjI7iU37vtGeah
         Rj/izfic6csJSWYc/2LLPZB/xcab+V9ww5gjo8kWAOHHiNyvPxByp1pqLmgP85I/e6h3
         kWUA==
X-Gm-Message-State: AOAM5322NJJll7RoKnYQx8ZWb9PlmhP+FJkx78YWn6ZbBzqRz9VwFvqw
        oDL3F5NK/B9pNuIO66ZsDgWU3/jMIHjf9+W07vwYzEIwb8ukR9av5HFA+SDZVZ2mGAraeLPVnsQ
        qTPEqQgzeJmwmq4PjVUG8ILsB
X-Received: by 2002:a5d:494b:: with SMTP id r11mr6175511wrs.227.1601064960447;
        Fri, 25 Sep 2020 13:16:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylqyHYTjXqLHZ1ID1/RPnvh851snnby2Lsvah5UPlXNupftX3WXDUIYHw8Py2PIGY1bLejyA==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr6175495wrs.227.1601064960251;
        Fri, 25 Sep 2020 13:16:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf? ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
        by smtp.gmail.com with ESMTPSA id u17sm4333537wri.45.2020.09.25.13.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 13:15:59 -0700 (PDT)
Subject: Re: [PATCH] cpuidle-haltpoll: fix error comments in
 arch_haltpoll_disable
To:     Li Qiang <liq3ea@163.com>, x86@kernel.org, kvm@vger.kernel.org,
        mtosatti@redhat.com
Cc:     liq3ea@gmail.com, linux-kernel@vger.kernel.org
References: <20200924155800.4939-1-liq3ea@163.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f505ee30-6d13-5b48-e772-c715b78c2400@redhat.com>
Date:   Fri, 25 Sep 2020 22:15:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200924155800.4939-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/20 17:58, Li Qiang wrote:
> The 'arch_haltpoll_disable' is used to disable guest halt poll.
> Correct the comments.
> 
> Fixes: a1c4423b02b21 ("cpuidle-haltpoll: disable host side polling when kvm virtualized")
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  arch/x86/kernel/kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 08320b0b2b27..94ebb31cb4ce 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -954,7 +954,7 @@ void arch_haltpoll_disable(unsigned int cpu)
>  	if (!kvm_para_has_feature(KVM_FEATURE_POLL_CONTROL))
>  		return;
>  
> -	/* Enable guest halt poll disables host halt poll */
> +	/* Disable guest halt poll enables host halt poll */
>  	smp_call_function_single(cpu, kvm_enable_host_haltpoll, NULL, 1);
>  }
>  EXPORT_SYMBOL_GPL(arch_haltpoll_disable);
> 

Queued, thanks.

Paolo

