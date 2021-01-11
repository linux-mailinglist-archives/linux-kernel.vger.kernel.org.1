Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1F02F1CAF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389831AbhAKRk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389647AbhAKRk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:40:59 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C65DC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 09:40:19 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id p12so5099pju.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 09:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qjQEnNzMbx9jfPqlYY0N0jYj1R3Q/O+LmSxzsF9dUuI=;
        b=vMdJQPxBpe62gqG1pM4PczjRnOrPEyBn6OX27rJgh3RoP9Bb8niJeXWnlLtYASKzs1
         3tec2zfE91shpqvsoUtUzkG/s3YvNOUBIs6QRIpbj5A2uTZilfmqSgEHCupMdmtcskw3
         z/0Ho9FHyV3j6J1WTeTJ6ki8j0WWTYpMEMl0kNXESAM7BHsOSEN5BvaVIJrRezTX9O++
         54WMwrTMCRPa2hxQD6G+aGtFz3ktlz5+uiSLFgT2YlOhNAAkdL03lR/0nNzjGTsVyTJY
         FPQNiuvc4oFV+C92Xx1rH933KYdXsTRE6t9fEHQ3WjlZaghphrDKguNdYDsJa+44c0Ob
         da3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjQEnNzMbx9jfPqlYY0N0jYj1R3Q/O+LmSxzsF9dUuI=;
        b=nwsVRDKI03A/wNiCzx65PoQkxL6tcCp9QfNNzEIMLdYVP6oorPYHQamoDIfEzpHpp5
         R0tAExYHXYtn338NtU8KKP24nsrrGJqnecJ286aY+V/JCtDF/swGb2KBICbkiCjw7fIK
         NyR9H+5G7AtQNs5lyhE+AaSjk1PaRdSit8cxAwDdPL5gYEUVw+BzisO6w6oPIhQM22uV
         Ie2aLCp9MIa58fvs1HwjjwlwVJ00jE8guEqsBZQfUb8NFJQNtCe+JgoxZCPPgKc2J+L+
         Y56S9VbGQJ+qrP4QtpXAMMFI2i6v+vGV35TVChFj8+0GrfhI9FkRCCFntqS0J8w17jLP
         8M+Q==
X-Gm-Message-State: AOAM532bY/S6Fx08Ku1fGXkobhXWVp6qsotIOxKXsLHwQQi/zYFqU5V1
        zlNqNKIjd8TMsOxgbOrgYcX9ZMO78cbDvCWb0MqLuA==
X-Google-Smtp-Source: ABdhPJz90wo+LNABRutfNJ9IAurAbJzzUQp2ytJ+Y6N0wWoqRh/YQRSb/ZBZwZsHxcnBTnLqMoLIoyxfsgW7wTllDmY=
X-Received: by 2002:a17:90a:f683:: with SMTP id cl3mr383204pjb.136.1610386818720;
 Mon, 11 Jan 2021 09:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20210108040940.1138-1-walter-zh.wu@mediatek.com>
 <CAAeHK+wW3bTCvk=6v_vDQFYLC6=3kunmprXA-P=tWyXCTMZjhQ@mail.gmail.com> <CAK8P3a3FakV-Y9xkoy_fpYKBNkMvcO7DPOQC8R7ku7yPcgDw3g@mail.gmail.com>
In-Reply-To: <CAK8P3a3FakV-Y9xkoy_fpYKBNkMvcO7DPOQC8R7ku7yPcgDw3g@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 11 Jan 2021 18:40:07 +0100
Message-ID: <CAAeHK+zB0=eBgrWTxcUK8GkxmUAn-W44NWDFE4zEB79CxVpwXg@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: remove redundant config option
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 9:31 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Jan 8, 2021 at 7:56 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > On Fri, Jan 8, 2021 at 5:09 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> > > @@ -2,6 +2,12 @@
> > >  CFLAGS_KASAN_NOSANITIZE := -fno-builtin
> > >  KASAN_SHADOW_OFFSET ?= $(CONFIG_KASAN_SHADOW_OFFSET)
> > >
> > > +ifdef CONFIG_KASAN_STACK
> > > +       stack_enable := 1
> > > +else
> > > +       stack_enable := 0
> > > +endif
> > > +
> >
> > AFAIR, Arnd wanted to avoid having KASAN_STACK to be enabled by
> > default when compiling with Clang, since Clang instrumentation leads
> > to very large kernel stacks, which, in turn, lead to compile-time
> > warnings. What I don't remember is why there are two configs.
> >
> > Arnd, is that correct? What was the reason behind having two configs?
>
> I think I just considered it cleaner than defining the extra variable in the
> Makefile at the time, as this was the only place that referenced
> CONFIG_KASAN_STACK.
>
> The '#if CONFIG_KASAN_STACK' (rather than #ifdef) that got added
> later do make my version more confusing though, so I agree that
> Walter's second patch improves it.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Got it, thanks!

> On a related note: do you have any hope that clang will ever fix
> https://bugs.llvm.org/show_bug.cgi?id=38809 and KASAN_STACK
> can be enabled by default on clang without risking stack
> overflows?

Not sure :(

I've filed this on KASAN bugzilla to not forget:
https://bugzilla.kernel.org/show_bug.cgi?id=211139
