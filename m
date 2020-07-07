Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB85217517
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 19:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgGGR1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 13:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgGGR1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:27:10 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1307C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 10:27:10 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g37so11165658otb.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rMuppVQPw1RXuBiFiMtip818dqgzLT1r4LNtpXbqYiA=;
        b=Da7lTAGxPQmYXMvQQ4cWrsEYHZWwOInlr895o9PE9VLeruKvguPNzyTvemAQ/LrYS3
         DCf/hccEnf3/CIb91aCbopgUylSF/m/e5azHPG9mr0w6qgj+DvDQwlRXm+/GwyAIqIoo
         hTzEnElApg23ktZgKJoXMax6ANqQnXW9HMqtjEG0enAglxuDNKSKtapq12Vk44EnL84p
         5Stao3rqWDccSRI6DH1dhJZoeS+r6JYbKjPBpSwa9Y4PcrjR41m2L3njV4bWAtkF8Tcr
         JoS865rPiiDrtT5lDm6X4CmVHV1P5AvXOrebwF91HtRH8nfrBLwObxrCQp3eaijWbpGP
         Tn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rMuppVQPw1RXuBiFiMtip818dqgzLT1r4LNtpXbqYiA=;
        b=N/Rpang8Y6evg5l+W/4Qgr6NiiOCIJbH4eI7unMiR4snUDdiwTC2LYpjOiLZ5KTd1u
         EBfDStNVobE3/R7VR1bHHJzK2wu3R/HSlmW553HFy1rUoQ13c+uMGH8mmHW3SwyyoCr/
         kFdlhrhwVFjVpIP7qMjMG3jy9S88bvKKeiUxCQ4jY8iqs9FxcgKpOYwwC+gf2Zh7stvQ
         GNjoqZWbccCLvNrRdGPe5SQ9vJoQWSI0Htj7BE1/po02zuq+/5y+lnuv4Znydf/wYXZ+
         WKiQH8fbWIsPWvJnFcciCU+d3+usPdnyBwYLCFmkX0it8qiTVQzSHYPLjswgCJ7HY1L6
         qiSA==
X-Gm-Message-State: AOAM532vz+wqe6QXLEmnGroyFFWm979RP0AbwG6GRQPQvobG9CWrgFXk
        aBCWYoql3qG2+8vaPA4F0qtK3kSoxFmVzTq58mZg6g==
X-Google-Smtp-Source: ABdhPJzF8Ar2RTTATP+hMbbUYSw+rN5v6I36KsgvZGdJ7W8qxDfi5DUq8PDe5clf7m+OO0iWEvBEeJcUqeLFcuSqUa0=
X-Received: by 2002:a9d:688:: with SMTP id 8mr46326077otx.108.1594142824174;
 Tue, 07 Jul 2020 10:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200706211309.3314644-1-urielguajardojr@gmail.com>
 <20200706211309.3314644-3-urielguajardojr@gmail.com> <20200706213905.GA1916@lca.pw>
 <CAG30EeeV0c8vQCdtqPBUNMiN--0K+j5xE+PMwW-godhX1qqwQg@mail.gmail.com> <20200706231730.GA2613@lca.pw>
In-Reply-To: <20200706231730.GA2613@lca.pw>
From:   Uriel Guajardo <urielguajardo@google.com>
Date:   Tue, 7 Jul 2020 12:26:52 -0500
Message-ID: <CAG30EeeJL_LUpZdBYpi4TRhw8pzBxhSrVF-4j1g3z22-ZXTGrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: kmemleak integration
To:     Qian Cai <cai@lca.pw>
Cc:     Uriel Guajardo <urielguajardojr@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        catalin.marinas@arm.com, akpm@linux-foundation.org,
        rdunlap@infradead.org, masahiroy@kernel.org, 0x7f454c46@gmail.com,
        krzk@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 6:17 PM Qian Cai <cai@lca.pw> wrote:
>
> On Mon, Jul 06, 2020 at 05:48:21PM -0500, Uriel Guajardo wrote:
> > On Mon, Jul 6, 2020 at 4:39 PM Qian Cai <cai@lca.pw> wrote:
> > >
> > > On Mon, Jul 06, 2020 at 09:13:09PM +0000, Uriel Guajardo wrote:
> > > > From: Uriel Guajardo <urielguajardo@google.com>
> > > >
> > > > Integrate kmemleak into the KUnit testing framework.
> > > >
> > > > Kmemleak will now fail the currently running KUnit test case if it finds
> > > > any memory leaks.
> > > >
> > > > The minimum object age for reporting is set to 0 msecs so that leaks are
> > > > not ignored if the test case finishes too quickly.
> > > >
> > > > Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> > > > ---
> > > >  include/linux/kmemleak.h | 11 +++++++++++
> > > >  lib/Kconfig.debug        | 26 ++++++++++++++++++++++++++
> > > >  lib/kunit/test.c         | 36 +++++++++++++++++++++++++++++++++++-
> > > >  mm/kmemleak.c            | 27 +++++++++++++++++++++------
> > > >  4 files changed, 93 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/include/linux/kmemleak.h b/include/linux/kmemleak.h
> > > > index 34684b2026ab..0da427934462 100644
> > > > --- a/include/linux/kmemleak.h
> > > > +++ b/include/linux/kmemleak.h
> > > > @@ -35,6 +35,10 @@ extern void kmemleak_free_part_phys(phys_addr_t phys, size_t size) __ref;
> > > >  extern void kmemleak_not_leak_phys(phys_addr_t phys) __ref;
> > > >  extern void kmemleak_ignore_phys(phys_addr_t phys) __ref;
> > > >
> > > > +extern ssize_t kmemleak_write(struct file *file,
> > > > +                           const char __user *user_buf,
> > > > +                           size_t size, loff_t *ppos);
> > > > +
> > > >  static inline void kmemleak_alloc_recursive(const void *ptr, size_t size,
> > > >                                           int min_count, slab_flags_t flags,
> > > >                                           gfp_t gfp)
> > > > @@ -120,6 +124,13 @@ static inline void kmemleak_ignore_phys(phys_addr_t phys)
> > > >  {
> > > >  }
> > > >
> > > > +static inline ssize_t kmemleak_write(struct file *file,
> > > > +                                  const char __user *user_buf,
> > > > +                                  size_t size, loff_t *ppos)
> > > > +{
> > > > +     return -1;
> > > > +}
> > > > +
> > > >  #endif       /* CONFIG_DEBUG_KMEMLEAK */
> > > >
> > > >  #endif       /* __KMEMLEAK_H */
> > > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > > index 21d9c5f6e7ec..e9c492cb3f4d 100644
> > > > --- a/lib/Kconfig.debug
> > > > +++ b/lib/Kconfig.debug
> > > > @@ -602,6 +602,32 @@ config DEBUG_KMEMLEAK_MEM_POOL_SIZE
> > > >         fully initialised, this memory pool acts as an emergency one
> > > >         if slab allocations fail.
> > > >
> > > > +config DEBUG_KMEMLEAK_MAX_TRACE
> > > > +     int "Kmemleak stack trace length"
> > > > +     depends on DEBUG_KMEMLEAK
> > > > +     default 16
> > > > +
> > > > +config DEBUG_KMEMLEAK_MSECS_MIN_AGE
> > > > +     int "Minimum object age before reporting in msecs"
> > > > +     depends on DEBUG_KMEMLEAK
> > > > +     default 0 if KUNIT
> > > > +     default 5000
> > > > +
> > > > +config DEBUG_KMEMLEAK_SECS_FIRST_SCAN
> > > > +     int "Delay before first scan in secs"
> > > > +     depends on DEBUG_KMEMLEAK
> > > > +     default 60
> > > > +
> > > > +config DEBUG_KMEMLEAK_SECS_SCAN_WAIT
> > > > +     int "Delay before subsequent auto scans in secs"
> > > > +     depends on DEBUG_KMEMLEAK
> > > > +     default 600
> > > > +
> > > > +config DEBUG_KMEMLEAK_MAX_SCAN_SIZE
> > > > +     int "Maximum size of scanned block"
> > > > +     depends on DEBUG_KMEMLEAK
> > > > +     default 4096
> > > > +
> > >
> > > Why do you make those configurable? I don't see anywhere you make use of
> > > them except DEBUG_KMEMLEAK_MSECS_MIN_AGE?
> > >
> >
> > That's correct. Strictly speaking, only DEBUG_KMEMLEAK_MSECS_MIN_AGE
> > is used to set a default when KUnit is configured.
> >
> > There is no concrete reason why these other variables need to be
> > configurable. At the time of writing this, it seemed to make the most
> > sense to configure the other configuration options, given that I was
> > already going to make MSECS_MIN_AGE configurable. It can definitely be
> > taken out.
> >
> > > Even then, how setting DEBUG_KMEMLEAK_MSECS_MIN_AGE=0 not giving too
> > > many false positives? Kmemleak simply does not work that instantly.
> > >
> >
> > I did not experience this issue, but I see your point.
> >
> > An alternative that I was thinking about -- and one that is not in
> > this patch -- is to wait DEBUG_KMEMLEAK_MSECS_MIN_AGE after each test
> > case in a test suite, while leaving kmemleak's default value as is. I
> > was hesitant to do this initially because many KUnit test cases run
> > quick, so this may result in a lot of time just waiting. But if we
> > leave it configurable, the user can change this as needed and deal
> > with the possible false positives.
>
> I doubt that is good idea. We don't really want people to start
> reporting those false positives to the MLs just because some kunit tests
> starts to flag them. It is wasting everyone's time. Reports from
> DEBUG_KMEMLEAK_MSECS_MIN_AGE=0 are simply trustful. I don't think there
> is a way around. Kmemleak was designed to have a lot of
> waitings/re-scans to be useful not even mentioning kfree_rcu() etc until
> it is redesigned...

I agree with your statement about false positives.
Is your suggestion to not make MSECS_MIN_AGE configurable and have
KUnit wait after each test case? Or are you saying that this will not
work entirely?
It seems like kmemleak should be able to work in some fashion under
KUnit, since it has specific documentation over testing parts of code
(https://www.kernel.org/doc/html/latest/dev-tools/kmemleak.html#testing-specific-sections-with-kmemleak).
