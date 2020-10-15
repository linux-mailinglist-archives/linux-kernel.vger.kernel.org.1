Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADD828FA86
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 23:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388687AbgJOVQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 17:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730992AbgJOVQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 17:16:35 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7ECC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 14:16:35 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id p3so179209pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 14:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BeM8niXI2OA07OVE0Ugpm7rYY67JabFmH8jBnEKepfA=;
        b=qB6EIX3+C8HMjKZh50tEpGdr6/zjVUtyj86zNhmeVCBiKd4ES6iJ4z5K/BLvorgwm7
         9zk9MH6XcGH8p7Icl/9NzkJmn+GeeN786YxciPbSgl31+9CR7x95blctvq6GFqkl7q+D
         JdhPFKcXVSuc4IVLOEP3l0u+TUamkkB7f5ReYR/SZGtRWnXjxSCOvqjLw9XmsMSvHd23
         ZOh388ZNdBYuqi+Djco105dmSz0wCbZJTUuqqdbWjoI17EO1Trpv/2jC8MYljd566Yjy
         TTIThiLD6m28+a9t00NNZ3vwnRt/6Il+v7NpB8Z5Ff1xirEAjLgz1OqMdkcJ0H8jDx5z
         aPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BeM8niXI2OA07OVE0Ugpm7rYY67JabFmH8jBnEKepfA=;
        b=P6WAZ6zq+9cV3xP00mQh8SwXvjm+hGQOFjAHThXM+BbLelFz3thROY78H7BBJPBNOb
         j1EE62Dh3vRYCBOyp0+2rK+GsSkZXPclabpvEkPND/htYr1mbh2IJyRpDY9Eoxx+xZR8
         887ZSqXU51aBCYCgUpMTu+iqY429tGTROZf4TI8DLcMfVRlOaFclqnyKP2nEQ+qRbj6X
         2cVNQopU+bbA0RMbz8IJAFaRBaU6OF+63Z6AFnBj6Ux0qEiar/TJoqDFCrNk7z61/H17
         E/FbNaFUdcC97MH/C7gKfC/AymxnHHlHtH3oeDzpLH+JMSvXFz0TdTqJwx6xQJ+e9Rh3
         6WEQ==
X-Gm-Message-State: AOAM531VLeHQpk/na8/UH9maxqQ+ekP0HhWs6eaqXvO7UY3KlCL1Tu9M
        C0slpHZhg8kpVwyoX7EaOSE=
X-Google-Smtp-Source: ABdhPJx/1Vy55dDjuPdqJASzS2XnhbhTklsTAmjRXmNrtPJ8hr2pDYc5KRQOOcHClRTdCHFDV1C8fA==
X-Received: by 2002:a17:902:c383:b029:d3:d17a:1de with SMTP id g3-20020a170902c383b02900d3d17a01demr613396plg.84.1602796594758;
        Thu, 15 Oct 2020 14:16:34 -0700 (PDT)
Received: from [10.67.48.230] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id a18sm211444pgw.50.2020.10.15.14.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 14:16:34 -0700 (PDT)
Subject: Re: [PATCH 0/3] IRQ stack support for ARM
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     v.narang@samsung.com, a.sahrawat@samsung.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Huckleberry <nhuck@google.com>,
        Will Deacon <will@kernel.org>, Jian Cai <caij2003@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <CGME20201008071628epcas5p24d196a6023a47a3b0bfa7b7f231ec811@epcas5p2.samsung.com>
 <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
 <20201008083015.GK1551@shell.armlinux.org.uk>
 <CAKwvOdnyFGWLpyBWX1nAY4veQucmzL509XqfqHj896hS+YJfYw@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <b91633c3-ed1b-b1dc-71ba-5c4644167e1a@gmail.com>
Date:   Thu, 15 Oct 2020 14:16:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnyFGWLpyBWX1nAY4veQucmzL509XqfqHj896hS+YJfYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/20 1:59 PM, Nick Desaulniers wrote:
> On Thu, Oct 8, 2020 at 1:30 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
>>
>> On Thu, Oct 08, 2020 at 12:45:30PM +0530, Maninder Singh wrote:
>>> Observed Stack Overflow on 8KB kernel stack on ARM specially
>>> incase on network interrupts, which results in undeterministic behaviour.
>>> So there is need for per cpu dedicated IRQ stack for ARM.
>>>
>>> As ARm does not have extra co-processor register
>>> to save thread info pointer, IRQ stack will be at some
>>> performance cost, so code is under CONFIG_IRQ_STACK.
>>>
>>> and we don't have much knowledge and set up for CLANG
>>> and ARM_UNWIND, so dependency added for both cases.
>>>
>>> Tested patch set with QEMU for latest kernel
>>> and 4.1 kernel for ARM target with same patch set.
>>
>> You need to investigate and show where and why this is happening. My
>> guess is you have a network driver that uses a lot of kernel stack
>> space, which itself would be a bug.
>>
>> Note that there are compiler versions out there that mis-optimise and
>> eat stack space - the kernel build should be warning if a function
>> uses a large amount of stack.
> 
> For tracking down those not-super-helpful compiler warnings, I wrote a
> tool where if you rebuild with debug info, and give it the object file
> and string of the function the compiler warned about it will parse the
> DWARF to tell you the size of each local variable, and if it came from
> an inline frame.  Generally, it's possible to stack allocate something
> that's way too big; instead those should be allocated on the heap.
> https://github.com/ClangBuiltLinux/frame-larger-than
> (I haven't had time to sit down and use it to resolve all outstanding
> issues, but it has worked well for me in the past)

Things get a bit more difficult with the network stack and you easily
recurse into functions and blow up the stack size. This is especially
true if you have some complex network tunneling or filtering going on.

For one, in the 4.1 kernel that appears to have been used as a basis for
this work, if you have CONFIG_BPF enabled but not
CONFIG_BPF_JIT_ALWAYS_ON, __bpf_prog_run will require about 724 bytes of
stack last I measured, that's nearly 10% of the stack that goes away
just like that.
--
Florian
