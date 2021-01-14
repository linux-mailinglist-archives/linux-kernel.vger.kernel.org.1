Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AEA2F68C6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbhANSCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbhANSCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:02:32 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2187AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:01:52 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id g3so3312775plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZv4YjfcgChZSuWtgMAj6ahr1eW9ywFtx/Fxp020AaY=;
        b=Rm6m7vXoHi68V0d+j08hWcmBizYwZFtmyFLHHMyw4nWdnaUNBfgNjt/JIfOXVqskOp
         9s1GsRh+JgM7mCcvmr0fiuSQv2wdylTkfv+1r5y0lcK1dbldOtdLa05ZbHg9vR2LnQAf
         4D53VfDIceaWsawDWPBXsE6IntyuOeBk+xNt7ul6WlR7eN0qEJA8WgrXoN9JwmXof8/n
         pz93OMkOqPZD5SexDtlWJpyKY4t1jojH1tpgGEitEJlzPG4bcWU8RK9YTDnxZ51A5WQV
         2igDoFfjj9hpgLSjU1Z1tDdEdYLRrDhi1rm/CDIUlu8mDq5w4cfT7OwipKCi1Obq+gZi
         ZJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZv4YjfcgChZSuWtgMAj6ahr1eW9ywFtx/Fxp020AaY=;
        b=qo+ea9NUhAKy9nWhnOhZt0PD75goaQLzRbspWVLJWA18LmRYBpgcpIRyOsGR8mOx1J
         V00/IGyFjL7Ektke3D6fezXatD/POPHwmuJvQjWzZxxjlOHO/R1YPKYETfxdun3OEJKd
         cpL+MITpnqpjRRBSzjT7v7B0t4XxUX4S8A2t9jj/Pz1hpYGO12WaHErLvNSiWJNVPzAy
         9kNT53JHWsY0uUY9bEfndgxCWBotPqDEpFqGbCu6RRXKZd+cvaudE5xPFWu0Jk4gM96e
         rDaVUf2Xvpulz5u2tlQu6KVU0c6moMtcEoZJXV4jMaR35fXte0AsvMrwMrEwmGGvvzc3
         FPww==
X-Gm-Message-State: AOAM533puVfAYAiQFCi5LrbODuaHZP+Z8jXrXr8A/iSa6MR/RmOI0uqe
        lIeP8OCOWECJBIoPw7jT7U+VKMH2Vkbic2xviQj5TA==
X-Google-Smtp-Source: ABdhPJy0s4/a2xn2D2HxerBaHTjLtujT+Fg1JxsQy1qheSdNwkcolbjsyD/LGCmA3l0QYAvncD62Ygr9tvPuRG4oljY=
X-Received: by 2002:a17:902:9009:b029:dc:52a6:575 with SMTP id
 a9-20020a1709029009b02900dc52a60575mr8283559plp.57.1610647311542; Thu, 14 Jan
 2021 10:01:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com> <77015767eb7cfe1cc112a564d31e749d68615a0f.1610554432.git.andreyknvl@google.com>
 <CANpmjNPX9yn5izxtYMq14Aas2y4NA1ijkcS9KN4QQ-7Hv8qZEQ@mail.gmail.com>
In-Reply-To: <CANpmjNPX9yn5izxtYMq14Aas2y4NA1ijkcS9KN4QQ-7Hv8qZEQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 14 Jan 2021 19:01:40 +0100
Message-ID: <CAAeHK+zD17_esgDvsUd3Yku4cCKDdADo82_u3c47tMWtHL63oQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] kasan: fix bug detection via ksize for HW_TAGS mode
To:     Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 5:54 PM Marco Elver <elver@google.com> wrote:
>
> > +/*
> > + * Unlike kasan_check_read/write(), kasan_check_byte() is performed even for
> > + * the hardware tag-based mode that doesn't rely on compiler instrumentation.
> > + */
> > +bool __kasan_check_byte(const void *addr, unsigned long ip);
> > +static __always_inline bool kasan_check_byte(const void *addr, unsigned long ip)
> > +{
> > +       if (kasan_enabled())
> > +               return __kasan_check_byte(addr, ip);
> > +       return true;
> > +}
>
> Why was this not added to kasan-checks.h? I'd assume including all of
> kasan.h is also undesirable for tag-based modes if we just want to do
> a kasan_check_byte().

It requires kasan_enabled() definition. I can move both to
kasan-checks.h if you prefer. However, the only place where
kasan_check_byte() is currently used includes kasan.h anyway.
