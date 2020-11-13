Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844022B2433
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 20:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgKMTBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 14:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMTBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 14:01:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84875C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 11:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=+VYH633HeBt8E5JeA2s80RUtEwqaJDczWHeDnRYO0GE=; b=ezYr85hggMBZpzm2+Y3YTUOAJ0
        E+r5H4lDo4akR97FZCgxwK7f1l3s8oA1hUNaNTBWDMV6CBkFyrMZwQCL5WscvvoxDKq8vLuEF60/m
        pT1XKOybPZqPBsuqPA7kZZ3hhfcvQbTBTZV6lVbLtSqw3+rWQgc85k2InrCwqPGLttqUKd1UM0C9G
        ZpjDNMgVfwgJBJNCglCbHNiJbq3hIqukKrJd1q/zzD82aNAmD4sMW1xHBJh1HiirvM6zBfb3+7gBk
        sRoJ3IIi6wAGI2wZ44YmzAa7Qu7D69jfvbtxToPdxHKWhf9usVS8U/0IbBub3EiLh0AE/caW3cCiN
        ub5xpjfQ==;
Received: from [2601:1c0:6280:3f0::662d]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdeKG-00053m-7a; Fri, 13 Nov 2020 19:01:36 +0000
Subject: Re: [PATCH] x86/e820: fix the function type for e820__mapped_all
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20201113182654.967462-1-samitolvanen@google.com>
 <95513107-5aa4-5e42-467f-f9a415eb9f3f@infradead.org>
 <CABCJKueALv=zBf3MYwN-EaeGxN3py-tReb3sVaqe9caCt8cJwA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <352fcf22-aa5d-8f4b-686e-44df25f3ff4a@infradead.org>
Date:   Fri, 13 Nov 2020 11:01:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CABCJKueALv=zBf3MYwN-EaeGxN3py-tReb3sVaqe9caCt8cJwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/20 10:59 AM, Sami Tolvanen wrote:
> On Fri, Nov 13, 2020 at 10:35 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 11/13/20 10:26 AM, Sami Tolvanen wrote:
>>> e820__mapped_all is passed as a callback to is_mmconf_reserved, which
>>> expects a function of type:
>>>
>>>   typedef bool (*check_reserved_t)(u64 start, u64 end, unsigned type);
>>>
>>> This trips indirect call checking with Clang's Control-Flow Integrity
>>> (CFI). Change the last argument from enum e820_type to unsigned to fix
>>> the type mismatch.
>>
>> Hi,
>>
>> Kernel style is no raw unsigned -- use unsigned int or unsigned long, please.
>>
>> checkpatch should or could have found that issue.
> 
> It did, but the existing type definition for the callback in
> pci/mmconfig-shared.c uses raw unsigned. I can add a patch to change
> that to unsigned int as well, if you prefer.

Hm. :)
Well, yes, I prefer, but I can't require it.

thanks for the explanation.

-- 
~Randy

