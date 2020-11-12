Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E1F2B083C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgKLPQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgKLPQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:16:42 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C82EC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:16:42 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id j31so4171327qtb.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TM7ug66yDX2zb6iHncrZGyoO9ARI1hTYVm8tRUTfYcA=;
        b=iDTiyouPcBFCJvdym2UzoWLGPR1UVGzGYChq9OHZt15+4jZNmVArIjG+fP1HTRIR0n
         lx3dgmlEebUKOhBgyk+rYwPlBk4njq6v8uJ+nGUuxHbWlLZCu00zVq6y1wHHiDJSyCHR
         xtWf7Sj7xiSIUOMr1I7x+PFSwJQQtd9MqVO2QmGJ49fn2AG8J7eNXN9nkzCej3R9Z4t4
         T3+rNllQbu79MIU6DOZpf2UwsVbj98A58k3CAQIDqZiIQwbBNRJxp8e5Yl8w1lCfumG/
         GyeWrtxugHjXZQVbMooNVaw1OYNVoKTF4N57Yczf0IiyuNvyz61sssR6FvXQH7GlcrbD
         h0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TM7ug66yDX2zb6iHncrZGyoO9ARI1hTYVm8tRUTfYcA=;
        b=ZNHjg0mECMZ0jBMx4z5L392j55Qvq7Kfe6/p6TsAu94fzmo0cLoD/z2Rhk8NWDL5Ix
         bRhfUSHQjJabp+CDXmIPZ9wT5aloP+YlQxXE6rRkmmn2ZyapCtuUDDIgq3yEYNWv5Dwv
         LBXFQ4c7GoNh/0CKZkCnbnKKHF3rE/wY3PjP76SttZzsE6OC0J/YT+8RRGn9KJWpjVeJ
         TWqWc/ynKA2jr1yBsxS8tpIeF+Vp3ilL9zBzvWyQ8jNTXTbuhb9/5DGMnAQ/OSp/xzA6
         9kVs7GOuIM6QUgFTku9lJCD7YuFIwat86jtnoVzoneIdAsfgqnB3FBVC7+isXFnmYUML
         NCyw==
X-Gm-Message-State: AOAM532ibJVMerK9d2RhBygUdaUvk+2h0yKqCsnSuffE4IqP1l8mnsQd
        EimpjJCw8qa+4U17Q2rm+WyJdCuUzaUC54rzBYxRFg==
X-Google-Smtp-Source: ABdhPJwsxso5pDSVeOq855FGuC4+//eRTgtFe6Ovvsk3SbMJr42aSSZxmbM9kKwfPuebC8Sz79SRt8vEEdevxhd3DY8=
X-Received: by 2002:ac8:5c85:: with SMTP id r5mr24292471qta.8.1605194200855;
 Thu, 12 Nov 2020 07:16:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <49f7f2c12b0d5805f9a7b7092b986bbc2dd077a1.1605046192.git.andreyknvl@google.com>
 <CAG_fn=VXhK0d__FkNdhdquy9F4VmB64_6eJQOQBRecy2oL6huQ@mail.gmail.com> <CAAeHK+wX+JPyZm2A5mDdGFCqnH6kdSBLyOZ2TnWfZnZuq_V0Bw@mail.gmail.com>
In-Reply-To: <CAAeHK+wX+JPyZm2A5mDdGFCqnH6kdSBLyOZ2TnWfZnZuq_V0Bw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 12 Nov 2020 16:16:29 +0100
Message-ID: <CAG_fn=VPEC4Lk+zaN25M8fygFKpvqLVzwYg-WHB9iXdY5JK1sg@mail.gmail.com>
Subject: Re: [PATCH v9 21/44] kasan: kasan_non_canonical_hook only for
 software modes
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 7:52 PM 'Andrey Konovalov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Wed, Nov 11, 2020 at 4:09 PM Alexander Potapenko <glider@google.com> w=
rote:
> >
> > On Tue, Nov 10, 2020 at 11:11 PM Andrey Konovalov <andreyknvl@google.co=
m> wrote:
> > >
> > > This is a preparatory commit for the upcoming addition of a new hardw=
are
> > > tag-based (MTE-based) KASAN mode.
> > >
> > > kasan_non_canonical_hook() is only applicable to KASAN modes that use
> > > shadow memory, and won't be needed for hardware tag-based KASAN.
> > >
> > > No functional changes for software modes.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > > Reviewed-by: Marco Elver <elver@google.com>
> > > ---
> > > Change-Id: Icc9f5ef100a2e86f3a4214a0c3131a68266181b2
> > > ---
> > >  mm/kasan/report.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > > index 5d5733831ad7..594bad2a3a5e 100644
> > > --- a/mm/kasan/report.c
> > > +++ b/mm/kasan/report.c
> > > @@ -403,7 +403,8 @@ bool kasan_report(unsigned long addr, size_t size=
, bool is_write,
> > >         return ret;
> > >  }
> > >
> > > -#ifdef CONFIG_KASAN_INLINE
> > > +#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))=
 && \
> > > +       defined(CONFIG_KASAN_INLINE)
> > >  /*
> > >   * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the=
 high
> > >   * canonical half of the address space) cause out-of-bounds shadow m=
emory reads
> >
> > Perhaps this comment also needs to be updated.
>
> In what way?

Ok, maybe not. I thought you were restricting the set of configs under
which this hook is used, so this should've been explained.
But as far as I understand, CONFIG_KASAN_INLINE already implies
"defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)",
doesn't it?
Maybe this change is not needed at all then?

>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/CAAeHK%2BwX%2BJPyZm2A5mDdGFCqnH6kdSBLyOZ2TnWfZnZuq_V0Bw%40mail.=
gmail.com.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
