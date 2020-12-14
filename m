Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D2B2DA36B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438602AbgLNWaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403758AbgLNW25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:28:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41008C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:28:16 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607984894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZwGjXDtahr4KTyDSi0g260yZ5xO8g59eVFxZugK4RhQ=;
        b=W/BWUe9NLEDOafBYlG5e2drZwX/5QOfOGhJk6+YMbZ4jmQiLYr/P0bpalwFJBiSniL6QaZ
        WmJbU8a6rd2dvt6u6XZyq89/BnUccVIS9s/sWd4nLS4HpBCSgXLzU87iueylW4p8JH0B/Q
        wZZ9tpfEuSQAM2iAi1+MKehUfyZIJYwS2WxJdBk2C0mVwX6t/VBzxdHuHuSV+233nxQtke
        xQshOygnQocTgF1QNd0Q91uhX/xO5ttBiMcGJwJhNGz28XvTQStY/yJpoFFngEL1uQRqaY
        omGvKo7dGw6gOok5e8yiuSiWPmKPnC5qwrp6qW+xfO58EQ5o2+mZhH/R884VkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607984894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZwGjXDtahr4KTyDSi0g260yZ5xO8g59eVFxZugK4RhQ=;
        b=OPMq20ndnvOpLVv122m/QGRtNM+eRoPX61xzOlci9C6Pf3FtaqXOzx7Uv+waufrLwOOV/p
        P4gJ71eNg8szSnDg==
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     "x86\@kernel.org" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: common_interrupt: No irq handler for vector
In-Reply-To: <d71e74e7-afae-39c3-1ea6-62bfcfa31413@linuxfoundation.org>
References: <9741d93c-3cd1-c4ef-74bb-7f635231c778@linuxfoundation.org> <87im96g6ox.fsf@nanos.tec.linutronix.de> <3630fe3f-0dff-e21e-17a8-ed251df81fbc@linuxfoundation.org> <87lfe0dst1.fsf@nanos.tec.linutronix.de> <d71e74e7-afae-39c3-1ea6-62bfcfa31413@linuxfoundation.org>
Date:   Mon, 14 Dec 2020 23:28:14 +0100
Message-ID: <87czzcdnup.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuah,

On Mon, Dec 14 2020 at 13:57, Shuah Khan wrote:
> On 12/14/20 1:41 PM, Thomas Gleixner wrote:
> Here is the processor and BIOS info:
> AMD Ryzen 7 4700G with Radeon Graphics
> LENOVO ThinkCentre Embedded Controller -[O4ZCT12A-1.12]-
> LENOVO ThinkCentre BIOS Boot Block Revision 1.1C
>
>> 
>>> I am bisecting to isolate. Same issue on all stables 5.4, 4.19 and
>>> so on. If it is BIOS problem I would expect to see it on 5.10-rc7
>>> and wouldn't have expected to start seeing it 5.9.9.
>> 
>> Can you provide some more details, e.g. dmesg please?
>> 
>
> __common_interrupt: 1.55 No irq handler for vector
> __common_interrupt: 2.55 No irq handler for vector
> __common_interrupt: 3.55 No irq handler for vector
> __common_interrupt: 4.55 No irq handler for vector
> __common_interrupt: 5.55 No irq handler for vector
> __common_interrupt: 6.55 No irq handler for vector
> __common_interrupt: 7.55 No irq handler for vector
> __common_interrupt: 8.55 No irq handler for vector
> __common_interrupt: 9.55 No irq handler for vector
> __common_interrupt: 10.55 No irq handler for vector

This _IS_ the AGESA BIOS bug.

>>>> No. It's perfectly correct in the MSI code. See further down.
>>>>
>>>> 	if (IS_ERR_OR_NULL(this_cpu_read(vector_irq[cfg->vector])))
>>>> 		this_cpu_write(vector_irq[cfg->vector], VECTOR_RETRIGGERED);
>>>>
>>>
>>> I am asking about inconsistent comments and the actual message as the
>>> comment implies if vector is VECTOR_UNUSED state, this message won't
>>> be triggered in common_interrupt. Based on that my read is the comment
>>> might be wrong if the code is correct as you are saying.
>> 
>> The comment says:
>> 
>>    >>    * anyway. If the vector is unused, then it is marked so it won't
>>    >>    * trigger the 'No irq handler for vector' warning in
>>    >>    * common_interrupt().
>> 
>>    If the vector is unused, then it is _marked_ so ....
>
> See the messages above.

This code has absolutely nothing to do with these messages and this code
marks the vector RETRIGGERED so the warning cannot happen if the MSI
migration causes this spurious vector to be emitted. That marking is
there _because_ the migration triggered the warning occasionally which
is unavoidable due the silliness of hardware.

The problem is that the buggy BIOS causes vector 55 which is the legacy
X86 interrupt 7 to be sent to the secondary CPUs 1-10 when they come up
the first time during boot. This has been reported to death already and
AMD confirmed that it is an AGESA BIOS bug and that it is fixed with
AGESA BIOS version 1.1.8.0.

The reason why it shows up now might be timing related, nothing else.

Thanks,

        tglx
