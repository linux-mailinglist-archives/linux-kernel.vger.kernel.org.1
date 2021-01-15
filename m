Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2D72F7D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbhAON6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:58:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45461 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732077AbhAON6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610719006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVQxHC5aDenqNcWvmG07Bn72UrucFZIJp0uxXWZdvVg=;
        b=STFeHCjsTgXB5dWXiPqoIE2T5WzlXgmA7EStt6v8tXTdVB5vNIiKEWG6ps+p6QrVSuhmCf
        +pb8fMfv89Z5yNAJrOgsryqzLtFJaSDsVo0kZ8U5UgfaykaJmnp2qMD2AloGoSPIJrQpDs
        FxI2b6m9CnPfrGxREA83N85AHG4PCrs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-BZkqw8NFMjqLJpghVYn7-Q-1; Fri, 15 Jan 2021 08:56:44 -0500
X-MC-Unique: BZkqw8NFMjqLJpghVYn7-Q-1
Received: by mail-ej1-f71.google.com with SMTP id d19so3620667ejo.18
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:56:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oVQxHC5aDenqNcWvmG07Bn72UrucFZIJp0uxXWZdvVg=;
        b=fbauw0B/DBbFoKEScjz+8uwU0eR8vG5iGdnqiDgrlguilqeCmNc2FFHX1YcP4jI6MI
         6oAM79+PLRPp7wdWSDxtBtJY/esGCavt/8jx6b7KWomW4BTDUId4JbKWRfnvMBDMVxgJ
         NOqbgShBi0LjvA79dShdAoROdDNSJENSvj/WDVNiG2W/iMz0zCO8OpjssY7dacpwFrrS
         QNsgaQH1/xN+hpnGYkhnWOcndRwhqTBZ4UbiD50kH3FZuP3CoMB48ARzXoVzTOrqgV+E
         0mosGarzrQsBVcHgYEfxOKH1Ur9eylIjXLt8s4hHtwphAP2ApYd2ZL5AbXcW6F1YikR1
         pS7w==
X-Gm-Message-State: AOAM5325D8d91d8Wr3jPINX3UVXWhly8bFWSoAi5FxwAQUj13532+bL9
        ciu1YFhDq1fBWIwvmtzhXazPhKe0CmsoZGlXhb03HYYvinAjNj1/+XuUoK4LIEm4GcCdiFd/oOW
        Ci1MOzgCytg9REu6BaQdR/U14
X-Received: by 2002:a17:906:2648:: with SMTP id i8mr3523384ejc.262.1610719003674;
        Fri, 15 Jan 2021 05:56:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIIhl/T+nMWLDpTcbKOVPkHNGdwkNyQg86Kt82V1Ox5TAYsXX+C+MiQjW40aRyOm7KmSGPHA==
X-Received: by 2002:a17:906:2648:: with SMTP id i8mr3523373ejc.262.1610719003537;
        Fri, 15 Jan 2021 05:56:43 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id h15sm1459370ejj.43.2021.01.15.05.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 05:56:42 -0800 (PST)
Subject: Re: [PATCH v2 3/3] KVM: x86: use static calls to reduce kvm_x86_ops
 overhead
To:     Peter Zijlstra <peterz@infradead.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     seanjc@google.com, kvm@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <cover.1610680941.git.jbaron@akamai.com>
 <e057bf1b8a7ad15652df6eeba3f907ae758d3399.1610680941.git.jbaron@akamai.com>
 <YAFkTSnSut1h/jWt@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8e13aa15-2f64-8e54-03b1-c4843af96bc1@redhat.com>
Date:   Fri, 15 Jan 2021 14:56:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YAFkTSnSut1h/jWt@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/21 10:45, Peter Zijlstra wrote:
> On Thu, Jan 14, 2021 at 10:27:56PM -0500, Jason Baron wrote:
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 5060922..9d4492b 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -1350,7 +1350,7 @@ void kvm_arch_free_vm(struct kvm *kvm);
>>   static inline int kvm_arch_flush_remote_tlb(struct kvm *kvm)
>>   {
>>   	if (kvm_x86_ops.tlb_remote_flush &&
>> -	    !kvm_x86_ops.tlb_remote_flush(kvm))
>> +	    !static_call(kvm_x86_tlb_remote_flush)(kvm))
>>   		return 0;
>>   	else
>>   		return -ENOTSUPP;
> 
> Would you be able to use something like this?
> 
>    https://lkml.kernel.org/r/20201110101307.GO2651@hirez.programming.kicks-ass.net
> 
> we could also add __static_call_return1(), if that would help.
> 

I think I'd rather make the default callee return -ENOTSUPP directly and 
remove the "if" completely.  So __static_call_return1() is not 
particularly useful here.

Paolo

