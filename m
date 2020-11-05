Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83052A7E62
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgKEMOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKEMOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:14:45 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BAAC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 04:14:45 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id t6so688666plq.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 04:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ef2UKiaY0UPMW9RqmrlSoTPjHgSZ5RMf4W5kfRO/DMA=;
        b=UcB9WgQUdrPev+x+sdbFmlmQPdbxkywEAlI6FpkjKoRRDsCjeQCbVIe5L6jWzSsy7s
         V8piICbdYe7nXj24a6wAuohsjGwPrsQdHj0Z7juolpUSf5tm2Z/RVjeQFS+iWoPmIDbZ
         B5nO1iBMJAYqTQXjZ2Bliieudt3lCFiEe7FFI3vZZCkf2VwPFXMNubg5j7Qd8IFd5Pgi
         TeAAQMe5UmhHpgtEaWREBWsQG4hYwNJfMgHagOFyu28OlcjbFsAGrsEt9NIMOo4HTSY9
         y9KoFD3NbOr3GPT0FemlQchbZLBl8fvOgjFIPm098/N7wT4pFxt4UCoxGMqecQ6gxaIQ
         Sa+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ef2UKiaY0UPMW9RqmrlSoTPjHgSZ5RMf4W5kfRO/DMA=;
        b=N9yC2dmEkejdPfGuL2E71e6O4TYfQjeaoChczQGkECcVwPPnOcl7hVh1Kb7Zy2G558
         j2YVl5bI8VSSZL2gC0vdxdSDCs5Gb7vuz/G4iA21/3XRaNV5hg1To2VmCaiGwtx8ir7J
         gpgEK13dH5Sp4SDojKw7X/xtnbP4qMXFCbuMjqiEhIlXEsw+YBGlqMHGPgNLkNxZFMOT
         eyIDjQgph3mZZY6eHQfk21ymmFaKsjvmQphvsX6xon5bGFKuF5hNvfWznDsDyOe8DmWf
         qO+YOLtD4fyUkqH/CxHonw/EZ14wThIUHPZhRXOSxJ3FKq3U5nYOGKAvhX+FelZ0iPsB
         he/Q==
X-Gm-Message-State: AOAM532z+KTnGuyhV3o7Yrdt8NiO4AYqJTmFs82Cf4vEa7/q+3I9skm/
        RLH4dIZv0CAp5QclWXpm/d+xTrFTYFcf4nPGGlVxOw==
X-Google-Smtp-Source: ABdhPJw8QpPqW7lkuoMpPysT9VHxZsCMlkpgbleXXoFwD4YW2Sti7UeZhKoCgBI0w2vuVeh7y7iTsnwIgMFr1imWxFk=
X-Received: by 2002:a17:902:e993:b029:d6:41d8:9ca3 with SMTP id
 f19-20020a170902e993b02900d641d89ca3mr2100463plb.57.1604578484325; Thu, 05
 Nov 2020 04:14:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com> <5e3c76cac4b161fe39e3fc8ace614400bc2fb5b1.1604531793.git.andreyknvl@google.com>
 <58aae616-f1be-d626-de16-af48cc2512b0@arm.com> <CAAeHK+yfQJbHLP0ja=_qnEugyrtQFMgRyw3Z1ZOeu=NVPNCFgg@mail.gmail.com>
 <1ef3f645-8b91-cfcf-811e-85123fea90fa@arm.com>
In-Reply-To: <1ef3f645-8b91-cfcf-811e-85123fea90fa@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 5 Nov 2020 13:14:33 +0100
Message-ID: <CAAeHK+zuJtMbUK75TEFSmLjpu8h-wTfkra1ZGV533shYKEYi6g@mail.gmail.com>
Subject: Re: [PATCH v8 30/43] arm64: kasan: Allow enabling in-kernel MTE
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 12:39 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> On 11/5/20 11:35 AM, Andrey Konovalov wrote:
> > This will work. Any preference on the name of this function?
> >
>
> I called it in my current iteration mte_enable(), and calling it from
> cpu_enable_mte().
>
> > Alternatively we can rename mte_init_tags() to something else and let
> > it handle both RRND and sync/async.
>
> This is an option but then you need to change the name of kasan_init_tags and
> the init_tags indirection name as well. I would go for the simpler and just
> splitting the function as per above.
>
> What do you think?

OK, let's split. mte_enable() as a name sounds good to me. Both
functions will still be called one right after another from
kasan_init_hw_tags (as it's now called) though. I think the name
works, as it means initializing the hw_tags mode, not just the tags.

Will do in v9.
