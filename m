Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E8329CAFD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 22:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373539AbgJ0VJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 17:09:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731914AbgJ0VJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 17:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603832977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qVwaS8BTcuMOMUfHEzFFtE2wVD4D7uQ2zVsYJoC6aXQ=;
        b=G3Jcho8Q4OcwBKC+xjoRevK0KiVmWvAAC+/0m0NnG3ySkkDqHdyPlv3tu8RY2yEk3GqnzV
        haPuuzyL5ctayXZLvH0cW4/DOBxL/T3jFTH6Np3GK9gkhW3ZHfnXUJidI8U+9OwL/i7gV1
        8ZsfZXjGTJwj5l/Xis8as4v5wWlhwt4=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-0lqFgvlENEyKsa7jpeYbzQ-1; Tue, 27 Oct 2020 17:09:35 -0400
X-MC-Unique: 0lqFgvlENEyKsa7jpeYbzQ-1
Received: by mail-ot1-f69.google.com with SMTP id e5so895473otp.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 14:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qVwaS8BTcuMOMUfHEzFFtE2wVD4D7uQ2zVsYJoC6aXQ=;
        b=PHx7s9K/GveC8Tm/pvJYKNQ0r3ugUYim2wPuqCoKckKuLPVbKR+bN/AqA8wDZlyI16
         j2sadiEf37i2x287LTK3nYfcajnAby3PrbqFAciMHkZBIP7bn0iFL3S27kXEkaPcsSUE
         61yAQ/pwtIW4RIxjxZvvurU4vzBUD7Qc6hM+G9zIsg8d0Xwo7xO796yy3bP9fSJ1yqQq
         46rMDbciEs0GVqh9LoidLRFAIQ9c0NfNH8moh4oYBqMV7X1xyJyRLZQblknB/ekbz1aQ
         BbTpub3ZBqM9HyvfktY6AphV/LTCmLYLWTdsi0E0dUdseOY41RIrFzNaQVue6meecRVZ
         Ihlw==
X-Gm-Message-State: AOAM533kwVmzeG6EXiVXwQmpT8QuknVY4QwR4mD1hJGg1SOpAH4AlsBm
        IjIcBVxKQM3S2Q3W1KIbJ35WWxaF9NvX/X6uEEDvTd15Uc01kpWy94Q/AQQ3WEceJxYxDy0werf
        dm2E+tVey+Ad14MBgsCM7hVhd
X-Received: by 2002:a4a:7c85:: with SMTP id v127mr3275900ooc.29.1603832974725;
        Tue, 27 Oct 2020 14:09:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysAfRp8j/ZP5YN2JfWvZmU9l8uTXc/Khi6vIE4elxS3sJoxjDY6Vw4q+4qjoeiuLSmPHXvHw==
X-Received: by 2002:a4a:7c85:: with SMTP id v127mr3275883ooc.29.1603832974485;
        Tue, 27 Oct 2020 14:09:34 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l11sm1553497oon.35.2020.10.27.14.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 14:09:33 -0700 (PDT)
Subject: Re: Subject: [RFC] clang tooling cleanups
To:     Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-toolchains@vger.kernel.org, Julia.Lawall@lip6.fr,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Huckleberry <nhuck15@gmail.com>
References: <20201027164255.1573301-1-trix@redhat.com>
 <CAKwvOd=83v0Sv-NhQ5xgqdNSRm2b=pOJDziX8axZ9t2YyYwz-A@mail.gmail.com>
 <8abd1e5a-511a-e4f6-6f2c-a045d33fa2aa@redhat.com>
 <a4c58c21f0361f844588f5479f6fee33dc1a1dae.camel@perches.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <cfad533d-1a9e-cf01-cefe-47c23de27a33@redhat.com>
Date:   Tue, 27 Oct 2020 14:09:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a4c58c21f0361f844588f5479f6fee33dc1a1dae.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/27/20 12:51 PM, Joe Perches wrote:
> (Adding Stephen Rothwell)
>
> On Tue, 2020-10-27 at 12:33 -0700, Tom Rix wrote:
>> On 10/27/20 11:42 AM, Nick Desaulniers wrote:
>>> (cutting down the CC list to something more intimate)
> []
>
>> I am interested in treewide fixes.
> As am I, but here the definition of fixes is undefined though.
> Whitespace / style changes and other bits that don't change generated
> object code aren't considered fixes by many maintainers.
>
>> Cleaning them up (maybe me not doing all the patches) and keeping them clean.
>>
>> The clang -Wextra-semi-stmt -fixit will fix all 10,000 problems
> I rather doubt there are 10K extra semicolons in the kernel source tree.
> Is there a proposed diff/patch posted somewhere?

Not as-such, the number comes from adding -Wextra-semi-stmt to a clang allyesconfig.

grepping and sorting unique warnings.

I did a similar over view for no newlines at end of file and unneeded breaks which

turned up 2 and ~250 problems.

>
>> This clang tidy fixer will fix only the 100 problems that are 'switch() {};'
>>
>> When doing a treewide cleanup, batching a bunch of fixes that are the same problem and fix 
>> is much easier on everyone to review and more likely to be accepted.
> That depends on the definition of batching.
>
> If individual patches are sent to multiple maintainers, the
> acceptance / apply rate seems always < 50% and some are rejected
> outright by various maintainers as "unnecessary churn".
>
> Single treewide patches are generally not applied unless by Linus.
> The trivial tree isn't widely used for this.
>
> Perhaps a 'scripted' git tree could be established that is integrated
> into -next that would allow these automated patches to be better
> vetted and increase the acceptance rate of these automated patches.
>
>> Long term, a c/i system would keep the tree clean by running the switch-semi checker/fixer. 
>> And we can all move onto the next problem.
> Good idea...
> I hope a scripted patches mechanism will be established.

I would be interested in this as well.

I already have a repo tracking next.

I can code up a script to do the commits.

Then we can poke at it with sticks and see if hooking it into next is worthwhile.

Tom

>
>

