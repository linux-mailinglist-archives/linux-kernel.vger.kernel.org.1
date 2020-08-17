Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D15F24636C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 11:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgHQJdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 05:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgHQJdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:33:15 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60241C06138A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 02:33:15 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c10so11727138edk.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 02:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1xQYs0Te2rfMJwjhbxsaCOgB/6GQdcnFRY7QjfAiQ3o=;
        b=ED64gzeg/M7EX+2k74ana8HeT9sotJMGEusKfdaM4E/ytYYzZ+v/Fol3t27iW5w8yC
         OsBfBZ3whC3TmnmJ2xz1oAkRx4zHI7FI3qxEs0pI58H6KD+RT3lzjA92C8sJz05/um2u
         i3rngDwyuqpTswvMcJIR3ZpfxudIAwLmfKLks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1xQYs0Te2rfMJwjhbxsaCOgB/6GQdcnFRY7QjfAiQ3o=;
        b=dyHIrNOX5Fgw90WvMOHhCPfYrKmsZrWR9ZdIn48ks94QAHecTIGWcfgcB0nwM3z8H0
         WQIfJxGgBfBgHcbAXE/sT7lvIrsnAVfJ1boSAl85Chmm+sEvXI3YvSO2TWqLQppcAfNy
         a3x/+JVlvRKul+aW8/plBqo0SxK4gmm4xX8L4dNgvSCau3OBLvWcO1Tc2N26r8wWj5hw
         yYB2ho1GBRV/UnCoo+KZjpeAzPA/iqHnd79cUyNQm0sD30UGrDR0Nfjj8XRLUmcHspoN
         HAXAfULuOqdZkfCvOcr18cxx5tHHDSO9f2xHhs0ScUPHHQZyJpaVfg1V0DPZE4z3u2pa
         M/yQ==
X-Gm-Message-State: AOAM533jCGiCvZct3ocFo4nrnN13SVjwqGFALn5vTnWRu/cmpQ67XEU0
        aeCDbzEg5cc5/PrPJp33zIpaIA==
X-Google-Smtp-Source: ABdhPJxf00b006Rln3mYlmymeUaXVm7P/IAFcx4EI3zWi9TVRNkruBZ044jZhMqhfnV70FZ5TW4BLw==
X-Received: by 2002:aa7:c259:: with SMTP id y25mr13745873edo.130.1597656793769;
        Mon, 17 Aug 2020 02:33:13 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s21sm14030677ejc.16.2020.08.17.02.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 02:33:13 -0700 (PDT)
Subject: Re: [PATCH v2] overflow: Add __must_check attribute to check_*()
 helpers
To:     dsterba@suse.cz, Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <202008151007.EF679DF@keescook>
 <20200817090854.GA2026@twin.jikos.cz>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <5da1506d-1627-a882-724d-057641791ccb@rasmusvillemoes.dk>
Date:   Mon, 17 Aug 2020 11:33:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817090854.GA2026@twin.jikos.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2020 11.08, David Sterba wrote:
> On Sat, Aug 15, 2020 at 10:09:24AM -0700, Kees Cook wrote:
>>  
>> +/*
>> + * Allows for effectively applying __must_check to a macro so we can have
>> + * both the type-agnostic benefits of the macros while also being able to
>> + * enforce that the return value is, in fact, checked.
>> + */
>> +static inline bool __must_check __must_check_overflow(bool overflow)
>> +{
>> +	return unlikely(overflow);
> 
> How does the 'unlikely' hint propagate through return? It is in a static
> inline so compiler has complete information in order to use it, but I'm
> curious if it actually does.

I wondered the same thing, but as I noted in a reply in the v1 thread,
that pattern is used in kernel/sched/, and the scheduler is a far more
critical path than anywhere these might be used, so if it's good enough
for kernel/sched/, it should be good enough here. I have no idea how one
could write a piece of non-trivial code to see if the hint actually
makes a difference.

> 
> In case the hint gets dropped, the fix would probably be
> 
> #define check_add_overflow(a, b, d) unlikely(__must_check_overflow(({	\
>  	typeof(a) __a = (a);			\
>  	typeof(b) __b = (b);			\
>  	typeof(d) __d = (d);			\
>  	(void) (&__a == &__b);			\
>  	(void) (&__a == __d);			\
>  	__builtin_add_overflow(__a, __b, __d);	\
> })))
> 

Well, maybe, but I'd be a little worried that the !! that unlikely()
slabs on its argument may count as a use of that argument, hence
nullifying the __must_check which is the main point - the unlikely just
being something we can add for free while touching this code. Haven't
tested it, though.

Rasmus
