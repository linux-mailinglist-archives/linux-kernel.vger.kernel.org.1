Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710E02CD970
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbgLCOkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:40:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387666AbgLCOki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607006351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2G4mWlkW5TmVzFzK4RnhP5wNPS0OZSaZvRoN4f2Nrlk=;
        b=P47NkMkrCNpemsq/61q5MTDKPh81ekxCGVSzqjA+Oz18WDYA9gzQcs0vnTGqnHVDyVmwr/
        UdhqB/xsChle13DxnFIcEBRRKv56BGKcpG91D0HqTcfm+HGowma1/4FFt0kN4kFpge5307
        Nrf05MxnAru40Jf0DuAliFmBYi+6iWM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-X240x5AkPhKLDVb89kT6YA-1; Thu, 03 Dec 2020 09:39:06 -0500
X-MC-Unique: X240x5AkPhKLDVb89kT6YA-1
Received: by mail-qt1-f199.google.com with SMTP id f33so1725592qtb.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 06:39:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2G4mWlkW5TmVzFzK4RnhP5wNPS0OZSaZvRoN4f2Nrlk=;
        b=FQfGZSt3OG79QMtTDIjjAEXfFGq33ncfzMCQjCnD8F7PxucdFNKZmLByar0Twiu42W
         LfEMeZFaKxuus/A2sOZE0KVYQV+xRZVG+Nyn8pNNLI8PaesCFEkk0+0h1vZCcquuK/p9
         6Q4qha2QYcO0T8Yu1QHZVF6Qvmn1SW0w8NET0IwddgEV4oIQkgEu+dh2VsAtNY6sPhWP
         j0VnTREMbdZLVzleoBSdmJ8907+qb1OGuiRhdaW9tjXvcSSLN68yvcG7AgE+40GT3bPf
         rxWC2X4Yh/xztnSJ6O9ZcEVvNoV1s4Jr3EGPUikfd196a8vwZGzJ2X0nz2t59gLvRXFd
         ZuxA==
X-Gm-Message-State: AOAM530XMdxY6SBpewwzmFS3xtPowGFhVDHccPN41iZ2pGgjyITo2b0t
        1QFiCEWKhosrqTQE+XVX9U3vnJAKykQ62bS5CGQFa9WHkRbHqKKL8IQLKkaYCvCukZdux2h+0Lp
        7IoueMqo/qBYpydekFEdHZ56L
X-Received: by 2002:a05:620a:1326:: with SMTP id p6mr3197349qkj.259.1607006346271;
        Thu, 03 Dec 2020 06:39:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzfOwSXuKy06/SSd6JxwxKCb8FNorPlkxiVy4CgF70hXgWWqLjQwPyK3nVpClptvcrhTF99g==
X-Received: by 2002:a05:620a:1326:: with SMTP id p6mr3197329qkj.259.1607006346005;
        Thu, 03 Dec 2020 06:39:06 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c65sm1365703qkf.47.2020.12.03.06.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 06:39:05 -0800 (PST)
Subject: Re: [PATCH] netfilter: conntrack: fix -Wformat
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
References: <20201107075550.2244055-1-ndesaulniers@google.com>
 <4910042649a4f3ab22fac93191b8c1fa0a2e17c3.camel@perches.com>
 <CAKwvOdn50VP4h7tidMnnFeMA1M-FevykP+Y0ozieisS7Nn4yoQ@mail.gmail.com>
 <26052c5a0a098aa7d9c0c8a1d39cc4a8f7915dd2.camel@perches.com>
 <CAKwvOdkv6W_dTLVowEBu0uV6oSxwW8F+U__qAsmk7vop6U8tpw@mail.gmail.com>
 <7ca84085-f8e1-6792-7d1c-455815986572@redhat.com>
 <CAKXUXMx0nSZqFfOF63J+awCpkPkgr-kuchUxd2-tuMbA2piD5A@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <844b0184-a74b-4d0a-8470-69d58323391a@redhat.com>
Date:   Thu, 3 Dec 2020 06:39:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAKXUXMx0nSZqFfOF63J+awCpkPkgr-kuchUxd2-tuMbA2piD5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/2/20 11:26 PM, Lukas Bulwahn wrote:
> On Thu, Dec 3, 2020 at 1:46 AM Tom Rix <trix@redhat.com> wrote:
>>
>> On 12/2/20 2:34 PM, Nick Desaulniers wrote:
>>> On Tue, Nov 10, 2020 at 2:04 PM Joe Perches <joe@perches.com> wrote:
>>>> On Tue, 2020-11-10 at 14:00 -0800, Nick Desaulniers wrote:
>>>>
>>>>> Yeah, we could go through and remove %h and %hh to solve this, too, right?
>>>> Yup.
>>>>
>>>> I think one of the checkpatch improvement mentees is adding
>>>> some suggestion and I hope an automated fix mechanism for that.
>>>>
>>>> https://lore.kernel.org/lkml/5e3265c241602bb54286fbaae9222070daa4768e.camel@perches.com/
>>> + Tom, who's been looking at leveraging clang-tidy to automate such
>>> treewide mechanical changes.
>>> ex. https://reviews.llvm.org/D91789
>> This looks like a good one to automate.
>>
>> If you don't mind, I'll give it a try next.
>>
>> Need a break from semicolons ;)
>>
>> Tom
>>
>>> See also commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging
>>> use of unnecessary %h[xudi] and %hh[xudi]") for a concise summary of
>>> related context.
> Nick, Tom,
>
> It is not a competition between checkpatch and clang-format, but if it would be:
>
> ...checkpatch was first...
>
> But jokes aside: Dwaipayan Ray, a mentee Joe and I are working with,
> has already submitted a patch to checkpatch that identifies those
> patterns and provides a fix:
>
> https://lore.kernel.org/lkml/20201128200046.78739-1-dwaipayanray1@gmail.com/
>
> Maybe that is helpful; and of course, clean-up patches to the various
> places still need to be sent out and having a second tool with
> clang-format that can check and provide automatic fixes as well is
> great.
>
> Tom, go for it: that clean-up is certainly helpful to get a "make
> CC=clang -W1" warning-free kernel build. For some smaller x86 kernel
> config (my playground config), there were not too many warnings
> outstanding, but the -Wformat was still among the larger class among
> them.

i see 17k for -Wformat-pedantic, beating out -Wextra-semi-stmt by a hefty 8k on my allyesconfig

Yes, enabling new warnings is one of the things i am chasing.


I agree if it can be done in checkpatch it should.

It is good to have multiple passes on cleaning.

checkpatch is best at fixing new problems, clang-tidy-fix is best at fixing old problems.

Tom

> Lukas
>

