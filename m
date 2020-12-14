Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F2D2DA396
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441228AbgLNWmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441174AbgLNWmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:42:10 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA433C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:41:23 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id g1so17410848ilk.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6MncYJLPHqsa5t+4ZaA2csmTjdSmcYEi6ittSvCXAzc=;
        b=SMJcu73Ckoo+mZC3Z3aZvQvAFzMEIkDWfJWH4Z6WewZJ0mLrjoDJk5Zg4BOB4/A8as
         OBGcX05KJd4AF1j+jXmvKsVuFSMdvnOxLP2uxPnI0ECbNlppM7qeq9CYzG9n2LyL2jLf
         V9ub9kFA3Ngve/D78ZyyaSfouuKEe/J4VoDKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6MncYJLPHqsa5t+4ZaA2csmTjdSmcYEi6ittSvCXAzc=;
        b=iEPPxhu2g43Wlhcy5Ftbb3GuLgvsofjHBq/gEOrfc8pgKSmhAtK14/KN0BMrVSKwwD
         geeL1leqeKJdVTX2ACYPF/qzV+rRxMMJChDhSKg7A38f3gPHMOobxdUe0a4jse581bKR
         ptuETcnzxp9c3dD9XVoPT9gSuQMsGkNBmfSkGBJyCMYEUOfus5uQ4DTJSX9cDxTcLEiX
         KbrQDff08JTgXZ2eFt3YHzPiLIpOu/J22G5QeUHhj41EdJBo6x0hvkYSzShpRHAFs41S
         KwN8Mn79xu9I8HWT2z3MQgv+oK7z9bFZDKcQJAWEgPxSPDtFP8hDZ+5gKuIwMlz9GDZk
         Zw0A==
X-Gm-Message-State: AOAM530lDbWpXNNml4KkV0TZ47E8pG5ex7PLN6UyqurMl0CoF5ktJMwo
        vERgk2f2TF23EoeNDSpamxgeJ491N6A7bQ==
X-Google-Smtp-Source: ABdhPJwkMPuKZ4smFPde+2LRGlDVsW9M3t1Z7jYmhakFJw5fo/xiEOEL9SO7CfA99sJeMRcmrNieDQ==
X-Received: by 2002:a92:6403:: with SMTP id y3mr37983087ilb.72.1607985682911;
        Mon, 14 Dec 2020 14:41:22 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v23sm9862550iol.21.2020.12.14.14.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 14:41:22 -0800 (PST)
Subject: Re: common_interrupt: No irq handler for vector
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9741d93c-3cd1-c4ef-74bb-7f635231c778@linuxfoundation.org>
 <87im96g6ox.fsf@nanos.tec.linutronix.de>
 <3630fe3f-0dff-e21e-17a8-ed251df81fbc@linuxfoundation.org>
 <87lfe0dst1.fsf@nanos.tec.linutronix.de>
 <d71e74e7-afae-39c3-1ea6-62bfcfa31413@linuxfoundation.org>
 <87czzcdnup.fsf@nanos.tec.linutronix.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c270b5af-1720-7dc6-cdd5-e9d8611a1704@linuxfoundation.org>
Date:   Mon, 14 Dec 2020 15:41:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <87czzcdnup.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/20 3:28 PM, Thomas Gleixner wrote:
> Shuah,
> 
> On Mon, Dec 14 2020 at 13:57, Shuah Khan wrote:
>> On 12/14/20 1:41 PM, Thomas Gleixner wrote:
>> Here is the processor and BIOS info:
>> AMD Ryzen 7 4700G with Radeon Graphics
>> LENOVO ThinkCentre Embedded Controller -[O4ZCT12A-1.12]-
>> LENOVO ThinkCentre BIOS Boot Block Revision 1.1C
>>
>>>
>>>> I am bisecting to isolate. Same issue on all stables 5.4, 4.19 and
>>>> so on. If it is BIOS problem I would expect to see it on 5.10-rc7
>>>> and wouldn't have expected to start seeing it 5.9.9.
>>>
>>> Can you provide some more details, e.g. dmesg please?
>>>
>>
>> __common_interrupt: 1.55 No irq handler for vector
>> __common_interrupt: 2.55 No irq handler for vector
>> __common_interrupt: 3.55 No irq handler for vector
>> __common_interrupt: 4.55 No irq handler for vector
>> __common_interrupt: 5.55 No irq handler for vector
>> __common_interrupt: 6.55 No irq handler for vector
>> __common_interrupt: 7.55 No irq handler for vector
>> __common_interrupt: 8.55 No irq handler for vector
>> __common_interrupt: 9.55 No irq handler for vector
>> __common_interrupt: 10.55 No irq handler for vector
> 
> This _IS_ the AGESA BIOS bug.
> 
>>>>> No. It's perfectly correct in the MSI code. See further down.
>>>>>
>>>>> 	if (IS_ERR_OR_NULL(this_cpu_read(vector_irq[cfg->vector])))
>>>>> 		this_cpu_write(vector_irq[cfg->vector], VECTOR_RETRIGGERED);
>>>>>
>>>>
>>>> I am asking about inconsistent comments and the actual message as the
>>>> comment implies if vector is VECTOR_UNUSED state, this message won't
>>>> be triggered in common_interrupt. Based on that my read is the comment
>>>> might be wrong if the code is correct as you are saying.
>>>
>>> The comment says:
>>>
>>>     >>    * anyway. If the vector is unused, then it is marked so it won't
>>>     >>    * trigger the 'No irq handler for vector' warning in
>>>     >>    * common_interrupt().
>>>
>>>     If the vector is unused, then it is _marked_ so ....
>>
>> See the messages above.
> 
> This code has absolutely nothing to do with these messages and this code
> marks the vector RETRIGGERED so the warning cannot happen if the MSI
> migration causes this spurious vector to be emitted. That marking is
> there _because_ the migration triggered the warning occasionally which
> is unavoidable due the silliness of hardware.
> 
> The problem is that the buggy BIOS causes vector 55 which is the legacy
> X86 interrupt 7 to be sent to the secondary CPUs 1-10 when they come up
> the first time during boot. This has been reported to death already and
> AMD confirmed that it is an AGESA BIOS bug and that it is fixed with
> AGESA BIOS version 1.1.8.0.
> 
> The reason why it shows up now might be timing related, nothing else.
> 

Thank you for confirming. I will save myself the bisect time and look
for BIOS update.

thanks,
-- Shuah

