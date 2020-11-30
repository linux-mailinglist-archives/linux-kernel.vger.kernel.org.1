Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB092C8E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgK3UEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbgK3UEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:04:01 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BF5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:03:21 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id g3so4142609uae.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fa+AXncjpJw/ff0g436QBu0YJuPqD2FU3JPKGNwS/rI=;
        b=kLS2g72k66rQtzbbUx1snDOgjMDzQ2jOJ31X7qgJ35Qtyu/lqwAhdVCxaP0PsDoNzg
         aii6uCGT/7C5wGi+DCJOhGT/+E6mk/iXnWSzh84KKi/qjwRLXXhNSyIl8yHpcagPfBST
         +Sn2vquenJKYrlEGrzLp4txRnFDB5xkGyS0PnS75u0kSOOf2s0qzYbM0UPDAd2yRH/gp
         5VYxkwHZHCdL/1gox9LAp1GIGLlBOONuuBCPYiNK4kbB6SWrSYCKy/Ty8pIoL19BdIUr
         tz4VehybMGvZZAEvmllEklzJgNCbZsW8/vNS1yS022aV7KSCDQqw9yy65NJaOsKsqkOA
         CVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fa+AXncjpJw/ff0g436QBu0YJuPqD2FU3JPKGNwS/rI=;
        b=USDCdIMv4sUitGYOLJ7IiiSIS6qRWH/U5vI5+RkLdkm+0sLhPpjJObiE+treEw+brf
         ZdHpREfiHm5UJ1faS6tOwgvYiSI4x+nUJhRZcXyaCC4c/b5TbbfjtklG51QDsvT/eAKD
         wt5lVMpJwLXn8XCazeiKvj9vpfL7av1wqxwAQoOQ3AJU2H1XXnR+5yfV5Af/4EiF+PRP
         S48ZrNSdZN8Q7yEr3fwX7jSv9jaW++QEoiwXzBxhkUXPG6jsO0f1OdMY34aT7tdCjcJO
         px8ENz49Pldm2XqLhGHeULkBRiJ+bXIROn5gu6Iqgu31VKccT+1lBOBdG7jE7bLW9Rrx
         PgjQ==
X-Gm-Message-State: AOAM533OaXdYSY+F/p4GuJjAiCT3N6Ezjxm8DifogA6QjPjSIs46d+QU
        E88xjyNVsXk+Ic0USBqUFikgm6uniAGHfqI+z0bwog==
X-Google-Smtp-Source: ABdhPJz7xmDil6D+ZXjSZ4UTT4+T0Ks+mPkbaAtAtjjqWVrvJVOBt9dtTz0GVpuoelmTlstKT8DnIE+f4XaeFEZuQAw=
X-Received: by 2002:ab0:b15:: with SMTP id b21mr14988487uak.52.1606766600085;
 Mon, 30 Nov 2020 12:03:20 -0800 (PST)
MIME-Version: 1.0
References: <20201124195940.27061-1-samitolvanen@google.com>
 <20201124195940.27061-2-samitolvanen@google.com> <20201130114417.GA24563@willie-the-truck>
In-Reply-To: <20201130114417.GA24563@willie-the-truck>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 30 Nov 2020 12:03:09 -0800
Message-ID: <CABCJKudPqyM6z+Pv6gqCv1ygmW=seu64RDUkUNHWQO6fXc6LQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] scs: switch to vmapped shadow stacks
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 3:44 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Nov 24, 2020 at 11:59:39AM -0800, Sami Tolvanen wrote:
> > +void *scs_alloc(int node)
> >  {
> > -     void *s = kmem_cache_alloc_node(scs_cache, GFP_SCS, node);
> > +     int i;
> > +     void *s;
> > +
> > +     for (i = 0; i < NR_CACHED_SCS; i++) {
> > +             s = this_cpu_xchg(scs_cache[i], NULL);
> > +             if (s) {
> > +                     kasan_unpoison_vmalloc(s, SCS_SIZE);
> > +                     memset(s, 0, SCS_SIZE);
> > +                     goto out;
> > +             }
> > +     }
> > +
> > +     s = __vmalloc_node_range(SCS_SIZE, 1, VMALLOC_START, VMALLOC_END,
> > +                              GFP_SCS, PAGE_KERNEL, 0, node,
> > +                              __builtin_return_address(0));
> >
> >       if (!s)
> >               return NULL;
>
> Sorry I didn't spot this before, but if you put the xchg/vmalloc code
> into a new __scs_alloc() function then you can drop the label and this
> becomes:
>
>         s = __scs_alloc(...);
>         if (!s)
>                 return NULL;
>
>         *__scs_maghic(s) = SCS_ENG_MAGIC;
>         ...

Good point, I'll change this in v3.

Sami
