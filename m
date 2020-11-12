Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B742B0A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgKLQlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbgKLQlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:41:31 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CA5C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:41:31 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id g15so4382534qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k1nxBPerHo0opWxBOg1iC4tCjytAR1tnAmyGb9xHH/M=;
        b=lX8a8EkakHNfH0gZYTjzQzld8uzEoqJCxSfCQ4OqTjeKIJSYiAdaOX4ju6X6g9kUUO
         RF4S2RPl7R0HtiAxZ45/vOfdVx0KvZK97bbr3uKu8O3DzHND55jt2Mc9gRnnRIRVa5Le
         uIJJbtg+jQ4EZfVCa8Oj3H9d5vQbh6WGAPZ24d7QTlv4qzpXumbpSYcHeSZ+x2awE/ov
         8LLx6nosw7m4FwZEiuLNyOPihO1HdacOxEqQql3lf+Bl1B4iAdd7EQRJHYJ3fE9EuCT0
         0zGyuL5DKegpQHgoCn1LrGZulu/lAYNrU/V2HpT/WpBExYpuxDppY6JDMtD3waasy1DF
         WSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k1nxBPerHo0opWxBOg1iC4tCjytAR1tnAmyGb9xHH/M=;
        b=k2PGaqSBk60zQ9VfPlEy77gy9kliCXQDAX/PtG9ZucT1DoFjBk/DPDRCWHuFpSyBe6
         HCX2FljxD/xbbisO7JbRyfXTuhfNuhscofXMf8cu4ldkMHs8MAyL1Ucs3yGiYkjlFSjG
         sU6XHdZ2bAhcE+9/8QJnDzJTuv9tCjWAYqUWxMp5q6oIcBexqBqI6tjA9B2Hmux8uUGN
         PanF2pILf1B/CuB7MxBvyjGeqBsXVQCw9KS7WC/gfIBZS90Uk14CKgDRywoJV+ndR1md
         xQ0hzp2t7uLuOkMPFtn+DsdTTUpGzgDHWyZ6+qCa6CeS3u46WqxjjpM7mxa3GHXeECal
         3bxQ==
X-Gm-Message-State: AOAM5310OyKypNYKI0FGajxX0LWpUQ2qD7a+K43aqFXCpAK+h6IQ92Zf
        HNNShlGXv7+hBa+5u5somMwQdnfh5VQl7iBo5iSIAw==
X-Google-Smtp-Source: ABdhPJxWrhPUcsJ8kMANXx3Rn2e8zWM2nnBNFFCtQUozkbcQQO7DjFpYPzTz7xSEkXo98tCCcUT8mHsqAezcWQ43NMI=
X-Received: by 2002:a05:622a:291:: with SMTP id z17mr18923qtw.180.1605199290292;
 Thu, 12 Nov 2020 08:41:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <bd6825832c0cb376fc68ad61ffec6d829401ed0e.1605046192.git.andreyknvl@google.com>
 <CAG_fn=XpB5ZQagAm6bqR1z+6hWdmk_shH0x8ShAx0qpmjMsp5Q@mail.gmail.com> <CANpmjNMaDkKBtWF8y22rhc6bFNN0CrXgfGNKXBLPvz3c2wd7rA@mail.gmail.com>
In-Reply-To: <CANpmjNMaDkKBtWF8y22rhc6bFNN0CrXgfGNKXBLPvz3c2wd7rA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 12 Nov 2020 17:41:18 +0100
Message-ID: <CAG_fn=VS7afjd4mXHvc+FcK=cnQC=SjEOJL6phkFLSWxP8+uaw@mail.gmail.com>
Subject: Re: [PATCH v9 44/44] kselftest/arm64: Check GCR_EL1 after context switch
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 5:09 PM Marco Elver <elver@google.com> wrote:
>
> On Thu, 12 Nov 2020 at 16:59, Alexander Potapenko <glider@google.com> wro=
te:
> >
> > On Tue, Nov 10, 2020 at 11:12 PM Andrey Konovalov <andreyknvl@google.co=
m> wrote:
> > >
> > > From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > >
> > > This test is specific to MTE and verifies that the GCR_EL1 register
> > > is context switched correctly.
> > >
> > > It spawn 1024 processes and each process spawns 5 threads. Each threa=
d
> >
> > Nit: "spawns"
> >
> >
> > > +       srand(time(NULL) ^ (pid << 16) ^ (tid << 16));
> > > +
> > > +       prctl_tag_mask =3D rand() % 0xffff;
> >
> > Nit: if you want values between 0 and 0xffff you probably want to use
> > bitwise AND.
>
> Another question would be, is the max here meant to be 0xffff or
> 0xffff-1. Because, as-is now, it's 0xffff-1. Only one of them has a
> trivial conversion to bitwise AND ( x % 2^n =3D=3D x & (2^n - 1) ).

Yes, that is basically what I meant, assuming that Vincenzo wanted the
max to be 0xffff

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
