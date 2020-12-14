Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF802D9C44
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 17:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501877AbgLNQOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 11:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439397AbgLNQMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 11:12:40 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC10C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 08:12:00 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id u12so16214192ilv.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 08:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZTXoG2qokwQOOAH/JCxYPppMWBym+BlZjzxgmZUXCVA=;
        b=Q7xtmIHUjBmP9MyxpCti4E92ojbb6m/4TSlSAFG35wQi9sLBGWySchq6vG5SmeGrPx
         HE8yxovn6hO08uhu6udFkC78WXrhouysC7GDBB47YrVTTCBAyd3lRB4BiSlJf+97xSmT
         Qyg0lcLI1e6weX+d6qNgLYadaU0UZSotR+JhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZTXoG2qokwQOOAH/JCxYPppMWBym+BlZjzxgmZUXCVA=;
        b=s5SLNVOvW84q7IyFuAlPi78AUb6WFJwxTX+Q8GvlaRMFYc885pXN4TwAOFfkf7cJJ3
         kuNhXptc7qSy/iKNW40ognYKn6tXQ70tzryJAjcaz2+TfFR9GhFjSGl1sMKLZYuK3VN2
         EfdasYbJkAswkscDGGd9yR/QsTgM10UDQwCuLgvs0ZruSFzoP9Ua5ZP4XRJhOK4jH++U
         ej5SKIY4WHDCV7/S51hADQltIBm5nVs2r4t8qNjiFxURYB9qW5jGTS1OfyOAw4cgPi56
         3FIlUZSWrIxJd223ET4BM18XUjbw6+MXlGSLSgZsv2DH9TEzcRqAjAXU9coicp4LPoHA
         jI0w==
X-Gm-Message-State: AOAM532BtOFF2Rk2oc3mxyAfKEldfSW4VU19r50GKzXnwB/UEN8ov2UH
        np4O5p36aXxLZoLss6ogYo+Aow==
X-Google-Smtp-Source: ABdhPJwTJtMrK6jTitNgqNdP9+kywP+Rjc1AaXMNvpHgWoe/Uqfy3Gu4wa/Y74Asy9OY45yE/FCcqQ==
X-Received: by 2002:a92:cb82:: with SMTP id z2mr36633148ilo.195.1607962319435;
        Mon, 14 Dec 2020 08:11:59 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n10sm66089ila.69.2020.12.14.08.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 08:11:58 -0800 (PST)
Subject: Re: common_interrupt: No irq handler for vector
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <9741d93c-3cd1-c4ef-74bb-7f635231c778@linuxfoundation.org>
 <87im96g6ox.fsf@nanos.tec.linutronix.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3630fe3f-0dff-e21e-17a8-ed251df81fbc@linuxfoundation.org>
Date:   Mon, 14 Dec 2020 09:11:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <87im96g6ox.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/20 12:33 PM, Thomas Gleixner wrote:
> On Fri, Dec 11 2020 at 13:41, Shuah Khan wrote:
> 
>> I am debugging __common_interrupt: 1.55 No irq handler for vector
>> messages and noticed comments and code don't agree:
> 
> I bet that's on an AMD system with broken AGESA BIOS.... Good luck
> debugging it :) BIOS updates are on the way so I'm told.
> 

Interesting. The behavior I am seeing doesn't seem to be consistent
with BIOS problem. I don't see these messages on 5.10-rc7. I started
seeing them on stable releases. It started right around 5.9.9 and
not present on 5.9.7.

I am bisecting to isolate. Same issue on all stables 5.4, 4.19 and
so on. If it is BIOS problem I would expect to see it on 5.10-rc7
and wouldn't have expected to start seeing it 5.9.9.

+ add Greg since I am talking about stable releases.

>> arch/x86/kernel/apic/msi.c: msi_set_affinity() says:
>>
>>
>>    * If the vector is in use then the installed device handler will
>>    * denote it as spurious which is no harm as this is a rare event
>>    * and interrupt handlers have to cope with spurious interrupts
>>    * anyway. If the vector is unused, then it is marked so it won't
>>    * trigger the 'No irq handler for vector' warning in
>>    * common_interrupt().
>>
>> common_interrupt() prints message if vector is unused: VECTOR_UNUSED
>>
>> ack_APIC_irq();
>>
>> if (desc == VECTOR_UNUSED) {
>>       pr_emerg_ratelimited("%s: %d.%u No irq handler for vector\n",
>>                             __func__, smp_processor_id(), vector);
>> }
>>
>> Something wrong here?
> 
> No. It's perfectly correct in the MSI code. See further down.
> 
> 	if (IS_ERR_OR_NULL(this_cpu_read(vector_irq[cfg->vector])))
> 		this_cpu_write(vector_irq[cfg->vector], VECTOR_RETRIGGERED);
> 

I am asking about inconsistent comments and the actual message as the
comment implies if vector is VECTOR_UNUSED state, this message won't
be triggered in common_interrupt. Based on that my read is the comment
might be wrong if the code is correct as you are saying.

thanks,
-- Shuah
