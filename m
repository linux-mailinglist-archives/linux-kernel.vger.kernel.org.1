Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8E52DD4AF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 16:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgLQP6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 10:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgLQP56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 10:57:58 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B811C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 07:57:18 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id p12so13479520qvj.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 07:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T7Af0WGDzuMPlnkW0mmNLYKjVtF8jTxv62OsHLUaGj4=;
        b=WAINATTepcPgPrSyn0yPP9zTBQEdvwKM5k1moOzHpik9Ufa5/mpKQazFKRjM8Z49t2
         4AUZHXR8qrDmskILAHqq74ibIBH95H3FD/mKDaXeQlhQM+xrjeO5ovhHZRVMcaaI38PP
         sS5P6AjhzL2+EIvDTyXdfL9fGAkUJxsSaqpdTM5udPUsrnUFpDfz60kmB/6EsjtN2yRU
         XKaqt9xIPQvK3qrTCbR+l5yFPBBgdnCOmUt9rJFZL3FiBws0a6NSC2lx4yrhmzZBaScg
         a4VuLLRvb+puX3E5R+aPLQn8uyE7ggWCXC3uwa1iMakkRPdkE3DwQV2jI+FP1ZQmOavQ
         AJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T7Af0WGDzuMPlnkW0mmNLYKjVtF8jTxv62OsHLUaGj4=;
        b=VceitkIxK967W2vUkWVSfr3J2ViFqQ8e3EMXY6+bEdMPurmdrqVDYdlCGDBUfnQVCg
         AD3eSErWwZXf1XLMyO4IDh+XQthpEpMpjR5CVgSqh+GeSr+iPGE2MvyrIYaDp/y9HWY6
         e8FyqDxSMFB22VQ8FXyXx2+n6f/0PSJ3hTK4XaGY3dK9O28csDQRK7Djxhi5bvmCaWhN
         nbnHaSQXS1uJkZ53AucjXHJ3zzoo0ZB1JLHgpTP5V3yyMDfv8QYXIcYqO2eEVuQ149sV
         Tl70HKZ1mJqxHyeMBLtLWgbnC9xakE/TgVgHGM6cUTVc44EoUogrbjb1vBmZIga9C5I8
         jmNg==
X-Gm-Message-State: AOAM5307BLp7NBKqfycS+AARWkae4QxspMw6RaPXjo0GRCYSOdPxoP1Z
        c7XEm8L6MPBC0+5pivFL3u5nMeOsZMlJScABQyvSoA==
X-Google-Smtp-Source: ABdhPJwqF37+SawHs9+yv9V81dXgoeJN1J6Mw4jypPTzJMQPrRvuj2RwIW3uSkjiMTJCkM0lOQ3KsiIGGARlcy/U1+U=
X-Received: by 2002:a0c:e90a:: with SMTP id a10mr41908062qvo.38.1608220636994;
 Thu, 17 Dec 2020 07:57:16 -0800 (PST)
MIME-Version: 1.0
References: <X9lHQExmHGvETxY4@elver.google.com> <CANpmjNO5ykmE5kWJ0x08-dTDOLe+Wu=2yQ0OmfdQEbQfHByeWg@mail.gmail.com>
In-Reply-To: <CANpmjNO5ykmE5kWJ0x08-dTDOLe+Wu=2yQ0OmfdQEbQfHByeWg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 17 Dec 2020 16:57:05 +0100
Message-ID: <CAG_fn=WY9qkUAg+5CjQKYGHMEqxUxsGaYSYcGgb=uumiO-BnTw@mail.gmail.com>
Subject: Re: [PATCH] kfence: fix typo in test
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        kernel test robot <lkp@intel.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 12:44 AM Marco Elver <elver@google.com> wrote:
>
> On Wed, 16 Dec 2020 at 00:31, Marco Elver <elver@google.com> wrote:
> > Fix a typo/accidental copy-paste that resulted in the obviously
> > incorrect 'GFP_KERNEL * 2' expression.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Alexander Potapenko <glider@google.com>

> > ---
> >  mm/kfence/kfence_test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> > index 1433a35a1644..f57c61c833e6 100644
> > --- a/mm/kfence/kfence_test.c
> > +++ b/mm/kfence/kfence_test.c
> > @@ -665,7 +665,7 @@ static void test_krealloc(struct kunit *test)
> >         for (; i < size * 3; i++) /* Fill to extra bytes. */
> >                 buf[i] =3D i + 1;
> >
> > -       buf =3D krealloc(buf, size * 2, GFP_KERNEL * 2); /* Shrink. */
> > +       buf =3D krealloc(buf, size * 2, GFP_KERNEL); /* Shrink. */
> >         KUNIT_EXPECT_GE(test, ksize(buf), size * 2);
> >         for (i =3D 0; i < size * 2; i++)
> >                 KUNIT_EXPECT_EQ(test, buf[i], (char)(i + 1));
> > --
> > 2.29.2.684.gfbc64c5ab5-goog
> >
>
> This patch could, if appropriate, be squashed into "kfence: add test suit=
e".
>
> Thanks,
> -- Marco



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
