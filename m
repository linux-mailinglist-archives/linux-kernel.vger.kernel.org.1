Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF272CCB36
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 01:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgLCArj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 19:47:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726689AbgLCArj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 19:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606956372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tn3Df7eygk6Izda6RvZQkxxok8dSHVZu45DeLEEIxTY=;
        b=P4RwmPgnKb4X6D+aDEL/Evn4dmqxuxyUMh1aQjGzn+jcucavv0cbxTzjGvfl7JcxHAFGE0
        jay//RiVokVVuyQmMFyUso3jSXsYv7AEe0+6jKJDR81cG00+JVAhDs92y3CgULSmMr0UTf
        6AX0BC05wCToVzPnEb99zcDGdk+1OQQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-sHjpcHNvPeCPn-2uYcG9LA-1; Wed, 02 Dec 2020 19:46:10 -0500
X-MC-Unique: sHjpcHNvPeCPn-2uYcG9LA-1
Received: by mail-qk1-f199.google.com with SMTP id d206so530023qkc.23
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 16:46:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tn3Df7eygk6Izda6RvZQkxxok8dSHVZu45DeLEEIxTY=;
        b=YBc8ZhqEAlx0Q2Ft9q5NXRMVUyyBJ/aXALR4ZCZIOvs8Fn3bKSBzCVTg1T1vyRtDGW
         3/RmBkavqK0CWTsmYlEs4o8njs5B0bzCCet17qVjtLBrBLayvLJbDGXleG9gD9wjH7q9
         B7bI+CegfBU1ymB572ALeHxOdbxbPcQc05SCr8VOdk2dnZ1STifXshoDLFD8huCSzd87
         Ado8Aumxl3XkRXi4PmCJgGAWud9B7k1R8DSXtWUNyEj5jhsWrQHU8kiKIxPDvsv40r3a
         S3ElcYw9irfJBrMTOSTYumYnHWtRewqE8CRl8nXJymgYbalD1q1TkNvZ/ruVO+7Ogsx5
         Ar9A==
X-Gm-Message-State: AOAM532dHFyfWVhSFbv5xHCdIzXxLjNPS9OSxyYA8D7xCaTN4e+8hUsR
        mpRGJdobDkAkMu8vjmyJlImdOFNsl2hxKXMbqAm7bKWwA3vOYool5k43dvRyBbdqc0830SUzw/j
        LlcD2wUq4s3kj8Uf6jCAl/koU
X-Received: by 2002:a37:7145:: with SMTP id m66mr516126qkc.396.1606956369586;
        Wed, 02 Dec 2020 16:46:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzaQv8hATwzHtFhNcgeEgzuieWjSpIuQkb2SlVf60UIlQ0qMAa0FWuaYoO5eZoFUPJPsB6hRw==
X-Received: by 2002:a37:7145:: with SMTP id m66mr515968qkc.396.1606956367260;
        Wed, 02 Dec 2020 16:46:07 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a6sm347081qkg.136.2020.12.02.16.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 16:46:06 -0800 (PST)
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
Message-ID: <7ca84085-f8e1-6792-7d1c-455815986572@redhat.com>
Date:   Wed, 2 Dec 2020 16:46:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
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

This looks like a good one to automate.

If you don't mind, I'll give it a try next.

Need a break from semicolons ;)

Tom

>
> See also commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging
> use of unnecessary %h[xudi] and %hh[xudi]") for a concise summary of
> related context.

