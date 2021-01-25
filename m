Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B40D302376
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 11:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbhAYKDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 05:03:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21666 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727292AbhAYKAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611568728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5qvNwK9Eh5sztpVmXUqhiLY8j0P2hRONqOuGd/Z0cw=;
        b=hsUthOawGbgnKbDw/8UbW5xgVubl35rSdLRhwNynULnCcv1AvNGh9spshT4hVJMElrOgeJ
        fTdalYrO79rLZXSvF/tEHcSrtnVKo8C26BoSM4+hIugpJUggHESUKH/D+V5cvg8VEYIeDz
        vV0zdic4n3FkYGyvD4kiD2wc8xAy9Kc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-uyDhJZNSPIC6DoHuY25OKw-1; Mon, 25 Jan 2021 04:58:46 -0500
X-MC-Unique: uyDhJZNSPIC6DoHuY25OKw-1
Received: by mail-ed1-f70.google.com with SMTP id a24so7035700eda.14
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 01:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I5qvNwK9Eh5sztpVmXUqhiLY8j0P2hRONqOuGd/Z0cw=;
        b=Q8RpNXzKD4J8L8ZuUwPOBXejInbrMDVHoQ0ORWIz4DHEcvwmiykGkXujN0niIOBus5
         3uKdbtdVS9qqmtFsmCLtaywVihZxYg0h/+RUi5pbrjYM5sixbbsSeZJ/MQGZSJIepKp9
         izIhhXjIWvfHolKovR1I63aAnhhIKH2b0tbqg0SSd/9IeJsMUocnbqCfR/KRYmmiOdux
         XQ8BMkgpTtpnHArFqtk89v66UZkY6pPuhynWZLXDuOkdKwWHJwBiDcDd/jLg6rSAec3M
         J4FEjvev+PRix9PfHlI9BZGYUomWe3bCGjtzOeqNL7UBhH8pkspzIPC/ohmZaYMz8oXm
         9Kcg==
X-Gm-Message-State: AOAM531CnLO5sc8NtVAW76b0pFTNWA6jymYhFos0r78gmpbTerUUeRxN
        KdCq8I/sUvDUUuNBzxbUTfrVjH75NK/QjkKwTZFMJGQ+OQZCW0pjKWihP7BZVwoRkWx5KSYDYYc
        jahHFpowannmAEf3WTDb4tcPF
X-Received: by 2002:aa7:dace:: with SMTP id x14mr862792eds.300.1611568725549;
        Mon, 25 Jan 2021 01:58:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQ4gfGMmhFnROhe7nsAtZpVsiUl1zkraUWm/PZk66fih7yway/EpdSqFBNEaVdkT9kgyApew==
X-Received: by 2002:aa7:dace:: with SMTP id x14mr862782eds.300.1611568725435;
        Mon, 25 Jan 2021 01:58:45 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k22sm10408741edv.33.2021.01.25.01.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 01:58:44 -0800 (PST)
Subject: Re: [PATCH] KVM: x86/mmu: improve robustness of some functions
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Stephen Zhang <stephenzhangzsd@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        seanjc@google.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com
References: <1611314323-2770-1-git-send-email-stephenzhangzsd@gmail.com>
 <87a6sx4a0l.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <99258705-ff9e-aa0c-ba58-da87df760655@redhat.com>
Date:   Mon, 25 Jan 2021 10:58:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87a6sx4a0l.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/21 10:54, Vitaly Kuznetsov wrote:
> 
> What if we do something like (completely untested):
> 
> diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> index bfc6389edc28..5ec15e4160b1 100644
> --- a/arch/x86/kvm/mmu/mmu_internal.h
> +++ b/arch/x86/kvm/mmu/mmu_internal.h
> @@ -12,7 +12,7 @@
>  extern bool dbg;
>  
>  #define pgprintk(x...) do { if (dbg) printk(x); } while (0)
> -#define rmap_printk(x...) do { if (dbg) printk(x); } while (0)
> +#define rmap_printk(fmt, args...) do { if (dbg) printk("%s: " fmt, __func__, ## args); } while (0)
>  #define MMU_WARN_ON(x) WARN_ON(x)
>  #else
>  #define pgprintk(x...) do { } while (0)
> 
> and eliminate the need to pass '__func__,' explicitly? We can probably
> do the same to pgprintk().

Nice indeed.  Though I wonder if anybody has ever used these.  For those 
that I actually needed in the past I created tracepoints instead.

Paolo

