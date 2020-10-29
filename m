Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2947A29F5BE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgJ2UA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgJ2UAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:00:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE5DC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:00:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id c20so3253053pfr.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lCP1WO1+VHzaoW6B3s0gmUP2QnpBjOsDZXHhfza/ed8=;
        b=iMDTwDLekHKm2kQfUw61OXhU4hv2TL3TfsFBwe0mJNO4y8ryLBGRm4NP8gPS1ptNNi
         2UBqD0A+kYcmo2GaqCAIUiRBemjZqKbLb4zYxzsqBTZ3R1q5kKSUJTBkbgRL5wXuGy16
         Nw5lkLNmpAY1+ijcd4JMdBxZKVDKHagbuTI/qV4tWM4wgZMjCkqOd6DmZ/yIgA0sV8EA
         2HKhL0PXWZzMDvCJjYpJCJNCA0LoOilEU84xno560sBrevL2uDsZtdwD3VOnVgRlYw4f
         Jqv4RDQ0zswFqUpFu1xhtwI2Fq8M0okebXZNgYib+IM8ZMiBdpM0sXVJkFAcl6dDbAa3
         IMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCP1WO1+VHzaoW6B3s0gmUP2QnpBjOsDZXHhfza/ed8=;
        b=WJhOI/ZnbCEZCR2GhInfW3FBIl+K5DqXHYBjykha9iutgI+57Ibie+wxBhx9M+pYOS
         9kx5VsczQ49Usk2MFnScfli4ciCGEqLFNRifDfUx4ttTpQgLuUQdIFmYyF+MEI6M0squ
         ne5ScCowjNQjXpmHSAKBJtKatr/odbHRXkikwI4f3uiBKQLtTUdnkLkmfvCSQD1mJgAg
         mn8gAiUOGZtLd30MwoHzX97YGvIIVdkh0ZRwFnZObLEgrFxNBOXBht+UOCM9rT9bG5G+
         BM/Fhgv0uUoYmIO49XECGOzMI4dkKoSUhvR3xdx6R4pr101mb9MGPx0yLw1UbhDAUfSM
         8PMw==
X-Gm-Message-State: AOAM531mqU3v090KmysKoXAiUnUXKIJ8htsBUOCJtJ8tiwj0pz3S46d9
        p5ErlwfkfJ6/q6tqJ3frdLpW/9RqK8TX0/h7F6pg1A==
X-Google-Smtp-Source: ABdhPJzbQAUJk0kVFK3CtTs1GowkCphU5iW79ZzmaFBk380eaBTxf6iWXo14Dh/UKx+4MymCnOiVLxpRA+Ly/HIOhCU=
X-Received: by 2002:a17:90b:807:: with SMTP id bk7mr1438790pjb.166.1604001649764;
 Thu, 29 Oct 2020 13:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <1049f02fb4132390a6a314eb21dccfe5500e69d6.1603372719.git.andreyknvl@google.com>
 <CACT4Y+a8e3c54Bzf5r2zhoC-cPziaVR=r89ONxrp9gx9arhrnw@mail.gmail.com>
In-Reply-To: <CACT4Y+a8e3c54Bzf5r2zhoC-cPziaVR=r89ONxrp9gx9arhrnw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 29 Oct 2020 21:00:38 +0100
Message-ID: <CAAeHK+wKWrhBC0V8Y=FEj8Cz+DuLdpEMy3KXeF96dyNc+L7qSg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 05/21] kasan: allow VMAP_STACK for HW_TAGS mode
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 1:49 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Oct 22, 2020 at 3:19 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > Even though hardware tag-based mode currently doesn't support checking
> > vmalloc allocations, it doesn't use shadow memory and works with
> > VMAP_STACK as is.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Link: https://linux-review.googlesource.com/id/I3552cbc12321dec82cd7372676e9372a2eb452ac
> > ---
> >  arch/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index af14a567b493..3caf7bcdcf93 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -868,7 +868,7 @@ config VMAP_STACK
> >         default y
> >         bool "Use a virtually-mapped stack"
> >         depends on HAVE_ARCH_VMAP_STACK
> > -       depends on !KASAN || KASAN_VMALLOC
> > +       depends on !(KASAN_GENERIC || KASAN_SW_TAGS) || KASAN_VMALLOC
>
> I find it a bit simpler to interpret:
>
>     depends on !KASAN || KASAN_HW_TAGS || KASAN_VMALLOC
>
> due to simpler structure. But maybe it's just me.

This looks better, will fix in the next version, thanks!
