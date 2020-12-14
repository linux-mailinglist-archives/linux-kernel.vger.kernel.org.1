Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3502DA22A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503559AbgLNU6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503545AbgLNU6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:58:30 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C6AC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:57:49 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id u12so17080995ilv.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wpWHPfdq59YYN644FSU0HEkdYYIYIg1YmV1eUPZefQ8=;
        b=AYyPXnFjjR0Sd2WHAYZNMbv/27fGqBonaVOkxYv+UNFGv+VRqcepVKzKMAaFs0xLkU
         qG9x2zyh7cUOco1BPRicv7ZwoU2i3ZgBIOLrVdZw/UQ7TbBhfoqVDjFBbLrDnQZGvNnv
         +ENAt7L1JEsP3oJ5/A5JXczwLPR4VJavfQO54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wpWHPfdq59YYN644FSU0HEkdYYIYIg1YmV1eUPZefQ8=;
        b=cGp+k4fG0lm/xkTEQeaOd9wfwck/8j9sXgXrzZHGAYsNwnuMO3cR97YpVMXPorhelp
         xHd/DpS/cQt1xRkGjh6dJAoQKc1qLY2ZWAxJ0PjgA0kMKKIyRxJFBmVrwPQXCXlEuPrV
         iir51xEdAU8q8nYzCZTmjl/lWcxDbdkuPV8T3eHm4EYZz6hNzjKY5s0ML7cMy97DUOi6
         CLaXJO+42KoB4uzNvr6SdslFodkUsrSpyhtqfy2NManFXPshXAHpxKxp4Nq42cvAjgHg
         wLTotYrA2kR2gQPjCauMQUvQbKB+9oYLyNSccHVifNkBcfLSDOmgoDc10Wxl16xVGVFh
         IUJA==
X-Gm-Message-State: AOAM531Uy5y+5qiH8zOQ+pXo7hp4X8a0dZFMph6O1SY/OwGZasO5u0qz
        CnFnTm6w2GSklPCMjEQBcp92Gw==
X-Google-Smtp-Source: ABdhPJzSeoXTGw9wixTSmhCPbxdYA7smtFpy2mH60j8S9FNzUUdkysLRUTUvC3BdnrOxys7wwTKf1w==
X-Received: by 2002:a92:aa4c:: with SMTP id j73mr36209895ili.123.1607979469310;
        Mon, 14 Dec 2020 12:57:49 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 143sm12381636ila.4.2020.12.14.12.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 12:57:48 -0800 (PST)
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
 <3630fe3f-0dff-e21e-17a8-ed251df81fbc@linuxfoundation.org>
 <87lfe0dst1.fsf@nanos.tec.linutronix.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d71e74e7-afae-39c3-1ea6-62bfcfa31413@linuxfoundation.org>
Date:   Mon, 14 Dec 2020 13:57:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <87lfe0dst1.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/20 1:41 PM, Thomas Gleixner wrote:
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

Here is the processor and BIOS info:
AMD Ryzen 7 4700G with Radeon Graphics
LENOVO ThinkCentre Embedded Controller -[O4ZCT12A-1.12]-
LENOVO ThinkCentre BIOS Boot Block Revision 1.1C

> 
>> I am bisecting to isolate. Same issue on all stables 5.4, 4.19 and
>> so on. If it is BIOS problem I would expect to see it on 5.10-rc7
>> and wouldn't have expected to start seeing it 5.9.9.
> 
> Can you provide some more details, e.g. dmesg please?
> 

__common_interrupt: 1.55 No irq handler for vector
__common_interrupt: 2.55 No irq handler for vector
__common_interrupt: 3.55 No irq handler for vector
__common_interrupt: 4.55 No irq handler for vector
__common_interrupt: 5.55 No irq handler for vector
__common_interrupt: 6.55 No irq handler for vector
__common_interrupt: 7.55 No irq handler for vector
__common_interrupt: 8.55 No irq handler for vector
__common_interrupt: 9.55 No irq handler for vector
__common_interrupt: 10.55 No irq handler for vector

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
>    >>    * anyway. If the vector is unused, then it is marked so it won't
>    >>    * trigger the 'No irq handler for vector' warning in
>    >>    * common_interrupt().
> 
>    If the vector is unused, then it is _marked_ so ....

See the messages above.

> 
> It perhaps should explicitely say 'is marked as VECTOR_RETRIGGERED' to make
> it clear.
> 

Possibly. I am running bisect starting at v5.9.7 (good) and compare with
v5.9.13 and see why this problems started showing up.

thanks,
-- Shuah

