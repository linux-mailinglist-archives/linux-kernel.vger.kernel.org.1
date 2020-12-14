Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6062DA205
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503262AbgLNUvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:51:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54308 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503007AbgLNUvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:51:21 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607979038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rCTymTmGA50gQnjmXjjE3tYEWOtqBAP2ro0QHEwDggU=;
        b=V/q6uvSATT0S/zhZEKyvbc7RJCrESaCbuKVOpCds9/+uZ5FjF6I8Z0B4N4LQC3lp/W0d3w
        eatD2q7laGkCQa2PrKIBa+Ab5k12S6oz0Rga2O/fcOzCBXp1ne9NnMpZs1gx/rcBkw2PtX
        L7jg7uGksdeYlGkDpmOGIRaqYO/C2LDIQbXtXU5Np4IMPI7vSEDGzLrf343CDOyP7cp58C
        CmLJmWZ48na1LD4/m8GtuAzv0GUl7ELEbWlYN8ePLnTP9dPJp78gj/0UCdUP6mV75gkxGc
        yOUwaOr+AalO1AhWVD1q1KlQ7HY6YKXeEMj4uMwH1xVKT2q/Hs1pK2KExj27Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607979038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rCTymTmGA50gQnjmXjjE3tYEWOtqBAP2ro0QHEwDggU=;
        b=2Ud7M09oHpq5AxnJVNSI20Xes1xUZQttHrJtZxb3dgET3a7FJX0HLVKZKKTl4tZeL9NicA
        FUi2Jr3IDlmsfRAg==
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     "x86\@kernel.org" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: common_interrupt: No irq handler for vector
In-Reply-To: <87lfe0dst1.fsf@nanos.tec.linutronix.de>
References: <9741d93c-3cd1-c4ef-74bb-7f635231c778@linuxfoundation.org> <87im96g6ox.fsf@nanos.tec.linutronix.de> <3630fe3f-0dff-e21e-17a8-ed251df81fbc@linuxfoundation.org> <87lfe0dst1.fsf@nanos.tec.linutronix.de>
Date:   Mon, 14 Dec 2020 21:50:38 +0100
Message-ID: <87im94dsdd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14 2020 at 21:41, Thomas Gleixner wrote:
> On Mon, Dec 14 2020 at 09:11, Shuah Khan wrote:
>> On 12/12/20 12:33 PM, Thomas Gleixner wrote:
>>> On Fri, Dec 11 2020 at 13:41, Shuah Khan wrote:
>>> 
>>>> I am debugging __common_interrupt: 1.55 No irq handler for vector
>>>> messages and noticed comments and code don't agree:
>>> 
>>> I bet that's on an AMD system with broken AGESA BIOS.... Good luck
>>> debugging it :) BIOS updates are on the way so I'm told.
>>> 
>> Interesting. The behavior I am seeing doesn't seem to be consistent
>> with BIOS problem. I don't see these messages on 5.10-rc7. I started
>> seeing them on stable releases. It started right around 5.9.9 and
>> not present on 5.9.7.
>
> What kind of machine?
>
>> I am bisecting to isolate. Same issue on all stables 5.4, 4.19 and
>> so on. If it is BIOS problem I would expect to see it on 5.10-rc7
>> and wouldn't have expected to start seeing it 5.9.9.
>
> Can you provide some more details, e.g. dmesg please?
>
>>> No. It's perfectly correct in the MSI code. See further down.
>>> 
>>> 	if (IS_ERR_OR_NULL(this_cpu_read(vector_irq[cfg->vector])))
>>> 		this_cpu_write(vector_irq[cfg->vector], VECTOR_RETRIGGERED);
>>> 
>>
>> I am asking about inconsistent comments and the actual message as the
>> comment implies if vector is VECTOR_UNUSED state, this message won't
>> be triggered in common_interrupt. Based on that my read is the comment
>> might be wrong if the code is correct as you are saying.
>
> The comment says:
>
>   >>    * anyway. If the vector is unused, then it is marked so it won't
>   >>    * trigger the 'No irq handler for vector' warning in
>   >>    * common_interrupt().
>
>   If the vector is unused, then it is _marked_ so ....
>
> It perhaps should explicitely say 'is marked as VECTOR_RETRIGGERED' to make
> it clear.

And it's only marked for this particular case to prevent the message
from being shown. Because the insanities we need to do to migrate
unmaskable (*sigh*) MSI interrupts can trigger that warning which would
be just wrong and confusing. You warning is _not_ coming from a broken
MSI migration attempt, believe me.

Thanks,

        tglx
