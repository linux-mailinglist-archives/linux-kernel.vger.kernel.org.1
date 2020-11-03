Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB532A49F5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgKCPeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgKCPeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:34:06 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA47C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:34:06 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i26so13946141pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HjUJI0OrjkWbAH3DienhZxTmqOna3ueAap2yYKG4ygM=;
        b=iP5XPK46EpWfmFeOfqdSZXFt9WYlJwjIRfQh65p0d3dVRcIyM9s2ElGMNxskEY7gGI
         C6zcH4JLnwQD9+c2B7DXyZ3KBi1IogrhWe3J61hRkd83t0spqehvY9PhEOlCpfdL98Kx
         DFvscLUxSS9yFHh6Mc/7cJeICEkM4VkZvJQ7i6LOieQz0UZxKS0MEup2NUbmD7Fcq36X
         v2FYom/i18e6HNWRLfsjcJiS3ONoPtx+xHvtoPI0LBpa/ngE83ylRJvxnbAN+/jJYKYc
         htV+HyLmcdvtfE4pV6IHGbkebT/L4/sJt+8xqAZnc/FSK0zfQaT0rzUR45Jdfhndgq4h
         6x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjUJI0OrjkWbAH3DienhZxTmqOna3ueAap2yYKG4ygM=;
        b=QHCAILUKgQG5tpuM94ECD5ey8+/LUYYteoZVC40WcgPbLjOTfyYsbv6uP2coePDmOl
         J3AvTTHrjU4Jp0rBPIK3gjqULoDWN47fTP9WmGTn8/bl0JJXQGbkghk6w4+xb2znJd3o
         VM3jO8vyMHigvBmlI4aVUtT5O6sHWMNQhtKdjhABWMAXNRQBU7P7LyJE7GUs2hXg8rwa
         O7imQ6h8GeYAcIUtFCQhHxTJJgQ548qizvDNkYXjZxXx1v0nC175qr2j0dfkp08x6poZ
         9F44Mxf9lJI3cPZ94qY66FySpZFN7m3KSIhv61DoCqXr1PaGvQXWtl7oCBb6u4vEr+IR
         qQjQ==
X-Gm-Message-State: AOAM531/CLRFIKnGinQ7mwSlIBkpOnZa0QF4fWqmaVRJXrpC1A6r0nFH
        1afWCHyPT5ep2YozPc1vJlx0EtmYyQQVFVG8spgOPQ==
X-Google-Smtp-Source: ABdhPJzj1KMRjCYm5PpARPnsanIfGJWoAOGU0mlig6qsZqXkvEODTi7bt8BldV8NNJqam4jCoEgpdUuz85GdWMmx7/c=
X-Received: by 2002:a17:90a:eb02:: with SMTP id j2mr356174pjz.136.1604417645395;
 Tue, 03 Nov 2020 07:34:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <1d87f0d5a282d9e8d14d408ac6d63462129f524c.1603372719.git.andreyknvl@google.com>
 <CACT4Y+Y6jbXh28U=9oK_1ihMhePRhZ6WP9vBwr8nVm_aU3BmNQ@mail.gmail.com> <CAAeHK+wqdtPkrhbxPanu79iCJxdYczKQ6k7+8u-hnC5JONEgNQ@mail.gmail.com>
In-Reply-To: <CAAeHK+wqdtPkrhbxPanu79iCJxdYczKQ6k7+8u-hnC5JONEgNQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 3 Nov 2020 16:33:54 +0100
Message-ID: <CAAeHK+xBZ_Rkew==1pj1YzU9XGdMJx5_uMP6n=BnnqdAH7LARw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 07/21] kasan, arm64: move initialization message
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

On Thu, Oct 29, 2020 at 9:14 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Wed, Oct 28, 2020 at 11:56 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Thu, Oct 22, 2020 at 3:19 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > >
> > > Tag-based KASAN modes are fully initialized with kasan_init_tags(),
> > > while the generic mode only requireds kasan_init(). Move the
> > > initialization message for tag-based modes into kasan_init_tags().
> > >
> > > Also fix pr_fmt() usage for KASAN code: generic mode doesn't need it,
> >
> > Why doesn't it need it? What's the difference with tag modes?
>
> I need to reword the patch descriptions: it's not the mode that
> doesn't need it, it's the generic.c file, as it doesn't use any pr_*()
> functions.
>
> >
> > > tag-based modes should use "kasan:" instead of KBUILD_MODNAME.
> >
> > With generic KASAN I currently see:
> >
> > [    0.571473][    T0] kasan: KernelAddressSanitizer initialized
> >
> > So KBUILD_MODNAME somehow works. Is there some difference between files?
>
> That code is printed from arch/xxx/mm/kasan_init*.c, which has its own
> pr_fmt defined.
>
> >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > Link: https://linux-review.googlesource.com/id/Idfd1e50625ffdf42dfc3dbf7455b11bd200a0a49
> > > ---
> > >  arch/arm64/mm/kasan_init.c | 3 +++
> > >  mm/kasan/generic.c         | 2 --
> > >  mm/kasan/hw_tags.c         | 4 ++++
> > >  mm/kasan/sw_tags.c         | 4 +++-
> > >  4 files changed, 10 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> > > index b6b9d55bb72e..8f17fa834b62 100644
> > > --- a/arch/arm64/mm/kasan_init.c
> > > +++ b/arch/arm64/mm/kasan_init.c
> > > @@ -290,5 +290,8 @@ void __init kasan_init(void)
> > >  {
> > >         kasan_init_shadow();
> > >         kasan_init_depth();
> > > +#if defined(CONFIG_KASAN_GENERIC)
> > > +       /* CONFIG_KASAN_SW/HW_TAGS also requires kasan_init_tags(). */
> >
> > A bit cleaner way may be to introduce kasan_init_early() and
> > kasan_init_late(). Late() will do tag init and always print the
> > message.
>
> It appears we'll also need kasan_init_even_later() for some
> MTE-related stuff. I'll try to figure out some sane naming scheme here
> and include it into the next version.

Actually, it looks like some arches already have
kasan_init_early/late() along with kasan_init(). I'd say we better
keep those for generic KASAN mode, and kasan_init_tags() for tag-based
modes.
