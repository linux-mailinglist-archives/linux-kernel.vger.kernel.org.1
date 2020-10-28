Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FA429D4BA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgJ1VyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbgJ1VyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:54:10 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28074C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:54:10 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p5so1065363ejj.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LloxvOwyNKym1ieXScf+I+cvC1STnkds6NcjDMINRkA=;
        b=AsSOWKx5oqHeIImaBlpxEsS55aSsDNwIts7m7bjyh2pvTvaf1EuvkXvmBsNy5g9n7m
         wtl9HsE0IGW+iDuZtr/w+N2Qx1JbmfbR7GzxSPiRWpZcETyC5K81qQ60bV/A7Kd1ili+
         HJdVxdqrnBn98Q7NOvso1kRT0qbK6D5/kqG/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LloxvOwyNKym1ieXScf+I+cvC1STnkds6NcjDMINRkA=;
        b=PVZY46Psgymivb5PJO9myGAatIEACJPtizpadlmYzo0pzTjdnBgybV6jP43GMQdJbj
         Y0L+T6cf/aCjzGTKRmEFYw/3XgW3lU3pxTi29pJeNQoQfVBovhm2FYpOiJ8RjpAoVVF1
         LNvDvxwZoylvdJPGLMiCIy/Z4bXp+8vW24BCGJBufGNCxEJhaWVR08ZN7ebVZQHpFADw
         hg1RVHcOE7T4GJB/WY2eaptVB1dav62JG7MDO8EVQLDsB3pz+//qfZkvT0ot1bsKIVyU
         nRG58O2mqZUb1hSmWTFXuoT705LULqfHFIEfcDrufxotBCyskBaPA/N1anJ+R99WMXnN
         wVkQ==
X-Gm-Message-State: AOAM5324tsdn8uYvl0w/Bj1iKt9ZNpAD4Ka/h7TJhqO8MjXQPkt3Pg4l
        yApzhmzd8U+kL97xVmE5k3F9YlOgedCH+pJKfKU=
X-Google-Smtp-Source: ABdhPJzESoRUe8lBXUj4TQJfv28e2BxHqS4A3MbYNj+NqUpJ32CubPAm2Xf0G9Vzb+LEkKOa6i5mBQ==
X-Received: by 2002:a2e:b60e:: with SMTP id r14mr2763100ljn.77.1603871491229;
        Wed, 28 Oct 2020 00:51:31 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 1sm438447lft.126.2020.10.28.00.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 00:51:30 -0700 (PDT)
Subject: Re: [PATCH] seqlock: avoid -Wshadow warnings
To:     Arnd Bergmann <arnd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201026165044.3722931-1-arnd@kernel.org>
 <20201026165805.GS2594@hirez.programming.kicks-ass.net>
 <CAK8P3a3wDEKSn307UXbc33+Uqu-NDV2V=0dDKbYJpAtgZjDNkQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <af5b457c-6615-0b4c-0add-529a28454459@rasmusvillemoes.dk>
Date:   Wed, 28 Oct 2020 08:51:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3wDEKSn307UXbc33+Uqu-NDV2V=0dDKbYJpAtgZjDNkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2020 00.34, Arnd Bergmann wrote:
> On Mon, Oct 26, 2020 at 5:58 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Mon, Oct 26, 2020 at 05:50:38PM +0100, Arnd Bergmann wrote:
>>
>>> -     unsigned seq;                                                   \
>>> +     unsigned __seq;                                                 \
>>
>>> -     unsigned seq = __read_seqcount_begin(s);                        \
>>> +     unsigned _seq = __read_seqcount_begin(s);                       \
>>
>>> -     unsigned seq = __seqcount_sequence(s);                          \
>>> +     unsigned __seq = __seqcount_sequence(s);                        \
>>
>> Can we have a consistent number of leading '_' ?
> 
> Not really ;-)
> 
> The warning comes from raw_read_seqcount_begin() calling
> __read_seqcount_begin() and both using the same variable
> name. I could rename one of them  and use double-underscores
> for both, but I haven't come up with a good alternative name
> that wouldn't make it less consistent in the process.

At least x86's put_user and get_user use _pu/_gu suffixes on their local
variables, so perhaps that could be made a weak default convention?

__seq_rsb
__seq_rrsb
__seq_rrs

Hm, or perhaps not. But it's still better than triplicating each macro
to do a UNIQUE_ID dance.

Rasmus
