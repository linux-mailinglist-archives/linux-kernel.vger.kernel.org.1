Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09A32D9004
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 20:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395349AbgLMTXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 14:23:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29412 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394870AbgLMTW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 14:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607887290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UbL8Odta7ic6S0aPEogCx7D7h/B71ZIzRWsPMeenY94=;
        b=def49vyBeih9m64CO5vFMB2zNdIqDLpog/L3oqa+BWsK4KBQOk8fcfENpbw8h+q07BTeBv
        uGliGdYnfWMWHfD1Q+amBWNCrbHQBjvmQKq77w8ghDJc9PeyT7olbBtL7RrEm3i0oZJstk
        d1aR9+DPtK5R57ei3kHG++TllFmoUpc=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-sug00ybcNl-XoR1fxMzm6A-1; Sun, 13 Dec 2020 14:21:27 -0500
X-MC-Unique: sug00ybcNl-XoR1fxMzm6A-1
Received: by mail-oi1-f198.google.com with SMTP id j28so7784764oig.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 11:21:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UbL8Odta7ic6S0aPEogCx7D7h/B71ZIzRWsPMeenY94=;
        b=VaNACOtgqSpGLJwqFCo7edL4aZpYbytZDVZ7KFXxAu7GXcZWx8bsYQ+3HxuJL7AHIU
         BkYZj5+nM4i0E0wl6mamlWSA+QgmQFRY0Tjm0JBRbKfrWiWbY26ULnX9IraqvPiJR0cG
         746aqnIU2I9nb7pwTsAOfiqfrEHf0PdyAnVHXl/plFC/dGz8eyRwGQ6f8hvi4JZf1OzS
         ZiphaR0qGkL+qdSnwX0sNdfBZpUoV8YwZzQVBeoca2em9BjGvS1NrAKc9FJ7sAQai9b4
         IoE+4vI7EUw4F3oxuabnayrMyTq5jEhXBs+l9+1TNJT/t7X7DTwaXWjFRQh/LK2pGg+5
         Kymw==
X-Gm-Message-State: AOAM530/YgGnK449E1Yz8ZbCMXsCBVK8YI7h8CgJuxd83oE3p3EVYqup
        zu+xBuhf1qpkBitFp2Ww0OZm9yyu8ovDqRroN9WWMS1IZt9wE4JlLxJl0S1MZMIhYmpJHDc9PRV
        Y/V7OHjJAN1BUxGO8/wYnkILO
X-Received: by 2002:a9d:269:: with SMTP id 96mr16744065otb.174.1607887286714;
        Sun, 13 Dec 2020 11:21:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQkCv+SsykJEiclAhkJJmaIpJ8GofmaJCmKC2P9NkPzPSY2w5X75hXxW7iT/wQfqs4MJlolQ==
X-Received: by 2002:a9d:269:: with SMTP id 96mr16744053otb.174.1607887286519;
        Sun, 13 Dec 2020 11:21:26 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c5sm1967722otl.53.2020.12.13.11.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Dec 2020 11:21:25 -0800 (PST)
Subject: Re: [PATCH] netfilter: conntrack: fix -Wformat
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20201107075550.2244055-1-ndesaulniers@google.com>
 <4910042649a4f3ab22fac93191b8c1fa0a2e17c3.camel@perches.com>
 <CAKwvOdn50VP4h7tidMnnFeMA1M-FevykP+Y0ozieisS7Nn4yoQ@mail.gmail.com>
 <26052c5a0a098aa7d9c0c8a1d39cc4a8f7915dd2.camel@perches.com>
 <CAKwvOdkv6W_dTLVowEBu0uV6oSxwW8F+U__qAsmk7vop6U8tpw@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <527928d8-4621-f2f3-a38f-80c60529dde8@redhat.com>
Date:   Sun, 13 Dec 2020 11:21:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkv6W_dTLVowEBu0uV6oSxwW8F+U__qAsmk7vop6U8tpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/2/20 2:34 PM, Nick Desaulniers wrote:
> On Tue, Nov 10, 2020 at 2:04 PM Joe Perches <joe@perches.com> wrote:
>> On Tue, 2020-11-10 at 14:00 -0800, Nick Desaulniers wrote:
>>
>>> Yeah, we could go through and remove %h and %hh to solve this, too, right?
>> Yup.
>>
>> I think one of the checkpatch improvement mentees is adding
>> some suggestion and I hope an automated fix mechanism for that.
>>
>> https://lore.kernel.org/lkml/5e3265c241602bb54286fbaae9222070daa4768e.camel@perches.com/
> + Tom, who's been looking at leveraging clang-tidy to automate such
> treewide mechanical changes.
> ex. https://reviews.llvm.org/D91789
>
> See also commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging
> use of unnecessary %h[xudi] and %hh[xudi]") for a concise summary of
> related context.

I have posted the fixer here

https://reviews.llvm.org/D93182

It catches about 200 problems in 100 files, I'll be posting these soon.

clang-tidy-fix's big difference over checkpatch is using the __printf(x,y) attribute to find the log functions.

I will be doing a follow-on to add the missing __printf or __scanf's and rerunning the fixer.

Tom

