Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C8829CB1C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 22:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505064AbgJ0VVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 17:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34671 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732492AbgJ0VVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 17:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603833668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J50aX1Edk3DFLyS24ty0stdo5ZU9u9zVLScpcoiA/8E=;
        b=ZyP6AeJyb6t8SyvgZ/ip2SabYQq4Ky59gj91i3SFVQ0CN8ogzLncCvkDf/rZ9dDEMuKFpq
        EU73tz3EObFbs9O/vQ9A6CEi9jzQO9fWdWRcvM0+bMM3mDjGTeAk7o5OxvfVFsPSXYcjlx
        CBADzdIBRB2EvxxaTWu/hbVXY/Kj/eo=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-Nd_3OusRMwGyhlwlwEmn6A-1; Tue, 27 Oct 2020 17:21:06 -0400
X-MC-Unique: Nd_3OusRMwGyhlwlwEmn6A-1
Received: by mail-ot1-f70.google.com with SMTP id y26so910878otk.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 14:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=J50aX1Edk3DFLyS24ty0stdo5ZU9u9zVLScpcoiA/8E=;
        b=sNwbUmXe3lK9RPwZXKgOuQRNZdJLfY9vXovEfNHpe5lq4txy3U4BRO9cyNaMQnEh7l
         Mvsl6S0qm2FdVuov7GZMgVy3wx6ZxTQT079dCezZHVmJnfftHCL7AR5Og0CJ6eYeGMnY
         o5rDSnqUeDUNc0R+Ca40oV+82ZJ8vF2uyHOCSuVRlObjfktmqQB3FpcRvLG/3yTz/TN3
         U3OfzsLFwdzh05KhF54Q7Kq/dMfQqd1rtXk/oriu6L70gr1IzFyYhf/EijgVPgK/Jjv5
         zq/vb454vvgXJBYzB4zItulSt76lDHp8LHFNbeATjznonAp8U5atCme7ww5h6SS0ltar
         TqZQ==
X-Gm-Message-State: AOAM5318EntPqcyZY9Dpbnet1ech5AKUdXujKk//xUvW5mfJs7LsPGRV
        jKWwm3+snvi+cU5NLJNPbx7JD4+fi4UFUl48qQ6WtTutQsdNVIPjaHgghgkUHT8v+xojXPq+zJh
        +oFpYCfdsRbZ42vYxmhwDuc6s
X-Received: by 2002:a4a:e40b:: with SMTP id t11mr3343263oov.43.1603833666031;
        Tue, 27 Oct 2020 14:21:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPKxh3i0FcFYQbqbDuA3UOwrFx3pL1SszVWVNxDwVuI9T0xhGFE0ZMr1ontS9IYnqBoxF4ng==
X-Received: by 2002:a4a:e40b:: with SMTP id t11mr3343243oov.43.1603833665754;
        Tue, 27 Oct 2020 14:21:05 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f142sm2092468oib.10.2020.10.27.14.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 14:21:05 -0700 (PDT)
Subject: Re: Subject: [RFC] clang tooling cleanups
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-toolchains@vger.kernel.org, Julia.Lawall@lip6.fr,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Huckleberry <nhuck15@gmail.com>
References: <20201027164255.1573301-1-trix@redhat.com>
 <CAKwvOd=83v0Sv-NhQ5xgqdNSRm2b=pOJDziX8axZ9t2YyYwz-A@mail.gmail.com>
 <8abd1e5a-511a-e4f6-6f2c-a045d33fa2aa@redhat.com>
 <a4c58c21f0361f844588f5479f6fee33dc1a1dae.camel@perches.com>
 <CAKwvOd=NiUEv51BCXVUDERwbs9qCX1SbMarrof5H0RoCdxP0NA@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <1e05fa22-491c-75fa-8ece-7c87a8b34b0e@redhat.com>
Date:   Tue, 27 Oct 2020 14:21:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOd=NiUEv51BCXVUDERwbs9qCX1SbMarrof5H0RoCdxP0NA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/27/20 1:50 PM, Nick Desaulniers wrote:
> On Tue, Oct 27, 2020 at 12:52 PM Joe Perches <joe@perches.com> wrote:
>> (Adding Stephen Rothwell)
>>
>> On Tue, 2020-10-27 at 12:33 -0700, Tom Rix wrote:
>>> On 10/27/20 11:42 AM, Nick Desaulniers wrote:
>>>> (cutting down the CC list to something more intimate)
>> []
>>
>>> I am interested in treewide fixes.
>> As am I, but here the definition of fixes is undefined though.
>> Whitespace / style changes and other bits that don't change generated
>> object code aren't considered fixes by many maintainers.
>>
>>> Cleaning them up (maybe me not doing all the patches) and keeping them clean.
>>>
>>> The clang -Wextra-semi-stmt -fixit will fix all 10,000 problems
>> I rather doubt there are 10K extra semicolons in the kernel source tree.
>> Is there a proposed diff/patch posted somewhere?
> Ah, I think I see where I (and Joe) may be misinterpreting.  Tom, do
> you mean to say that `clang -fixit` will attempt to fix EVERY warning
> in tree (including but regardless of -Wextra-semi-stmt, where
> -Wextra-semi-stmt is a red herring), so the clang-tidy check is
> specific to applying fixits just for -Wextra-semi-stmt?  (If so, I
> wonder if we could improve clang to accept more fine grain control
> over *which* fixits we want applied.  Not at all of them for all of
> the different distinct warnings, for example).

Using clang and -fixit with -Wextra-semi-stmt will fix all of this warning AND all of the other warnings.

(At least thats what i think it will do)

My opinion, clang doing the fixes is a neat but the purpose of the compiler is to compile.

Fixing should be left to all the other clang-tools.

Tom

>>> This clang tidy fixer will fix only the 100 problems that are 'switch() {};'
>>>
>>> When doing a treewide cleanup, batching a bunch of fixes that are the same problem and fix
>>> is much easier on everyone to review and more likely to be accepted.
>> That depends on the definition of batching.
>>
>> If individual patches are sent to multiple maintainers, the
>> acceptance / apply rate seems always < 50% and some are rejected
>> outright by various maintainers as "unnecessary churn".
>>
>> Single treewide patches are generally not applied unless by Linus.
>> The trivial tree isn't widely used for this.
>>
>> Perhaps a 'scripted' git tree could be established that is integrated
>> into -next that would allow these automated patches to be better
>> vetted and increase the acceptance rate of these automated patches.
>>
>>> Long term, a c/i system would keep the tree clean by running the switch-semi checker/fixer.
>>> And we can all move onto the next problem.
>> Good idea...
>> I hope a scripted patches mechanism will be established.
> Yes, if I can automate myself out of job, then I can hang out of the
> roof and drink margaritas all day.  That is the plan of record, but
> this !##$'ing compiler is constantly broken!!!!1
>

