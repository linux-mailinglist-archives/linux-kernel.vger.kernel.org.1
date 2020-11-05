Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D002A84E7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbgKER3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKER33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:29:29 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76402C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 09:29:29 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id e21so1808903pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 09:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hezyq/zpP2iNRlcrlDKy/FRFvbv86R32DSeUr4scc0o=;
        b=pAsUxnB2mu0vKuTe90g6GcQlaRjnamfxYvayagil3r8FtZ2ZL7BmxK2N9/64Sqf54j
         uKRAXlqrO+fwBHQvMsO48vYRRecUpI3dddiV1YkXUEIbMTo4wVzZRyCUWvQEIYr+p8cM
         2lW9JJfGd0ciymjRqHySUxm5F2FJx0JKDy9o4blaPUxB2PrOC9AhEU/MlGvzxOqGmjZP
         4Dk8jNS6ndePMc38lP00Kv65ENNPEXiQFZ/aY4K/hI4lJh1h8VF0xUvkN08yhANORIqu
         1N47kifK+tBvxSuhzl5qlPpqlchcebqCPhUTeDZsNnkkrUSfDOZ29aoacsM1ROK8ghuw
         1b8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hezyq/zpP2iNRlcrlDKy/FRFvbv86R32DSeUr4scc0o=;
        b=FL5DIe3kvdPAGAEUdwSRcSS27pEAkKoi67aPcSal2/KNOhImJIwetgrqrjzh63dlBR
         IlPH99C76VxATbqjZwAshjgaITfBG9V+BdJ3L+mnY5QQir9XgrF9cg07vBtUyVOrN7WZ
         wkW7MM41gpFhRD1cNnw5W9gcT6oRKgu5n9xIwL6UIhpONg3b4LwUqcMkjCjs/tCVlZ+P
         u/55KXdTy42KxpjsqRW5ei7IxcZzVMrVuXBrIKUSI9YKvXiPe+G0g0GrZpj9eWBwDLWC
         igLVEowj9NySAC73WZ5YrqcoULdS6XkYkAkWvyp4B0Emj7faPPSJRWGL9KlEijYkak9X
         3SaA==
X-Gm-Message-State: AOAM533+xISuGALMwYoP40DgPenjzMYNe/QprQelks8FO2TfiH80y9Cc
        giya8o7xXfJE56VcwHmbdaq23qTO8Zt2F6K9u8ggQQ==
X-Google-Smtp-Source: ABdhPJzzSvGMennvofmZi4UsZQHlThxKk6oQoXuFoy6HIfGI8K3zZ4hhefHtAEfX/wFJyg+y58v2wsMHuZyb64SbYN0=
X-Received: by 2002:a62:64c1:0:b029:18a:d791:8162 with SMTP id
 y184-20020a6264c10000b029018ad7918162mr3218301pfb.24.1604597368896; Thu, 05
 Nov 2020 09:29:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com> <5e3c76cac4b161fe39e3fc8ace614400bc2fb5b1.1604531793.git.andreyknvl@google.com>
 <20201105172549.GE30030@gaia>
In-Reply-To: <20201105172549.GE30030@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 5 Nov 2020 18:29:17 +0100
Message-ID: <CAAeHK+x0pQyQFG9e9HRxW5p8AYamPFmP-mKpHDWTwL_XUq7msA@mail.gmail.com>
Subject: Re: [PATCH v8 30/43] arm64: kasan: Allow enabling in-kernel MTE
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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

On Thu, Nov 5, 2020 at 6:26 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Nov 05, 2020 at 12:18:45AM +0100, Andrey Konovalov wrote:
> > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > index 06ba6c923ab7..fcfbefcc3174 100644
> > --- a/arch/arm64/kernel/mte.c
> > +++ b/arch/arm64/kernel/mte.c
> > @@ -121,6 +121,13 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> >       return ptr;
> >  }
> >
> > +void __init mte_init_tags(u64 max_tag)
> > +{
> > +     /* Enable MTE Sync Mode for EL1. */
> > +     sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
> > +     isb();
> > +}
>
> Is this going to be called on each CPU? I quickly went through the rest
> of the patches and couldn't see how.

Yes, on each CPU. This is done via kasan_init_hw_tags() that is called
from cpu_enable_mte(). This change is added in the "kasan, arm64:
implement HW_TAGS runtime". Would it make sense to put it into a
separate patch?
