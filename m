Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0EC270100
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgIRP3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgIRP3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:29:35 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 559FA2388B;
        Fri, 18 Sep 2020 15:29:32 +0000 (UTC)
Date:   Fri, 18 Sep 2020 16:29:29 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 35/37] kasan, slub: reset tags when accessing metadata
Message-ID: <20200918152928.GF6335@gaia>
References: <cover.1600204505.git.andreyknvl@google.com>
 <f511f01a413c18c71ba9124ee3c341226919a5e8.1600204505.git.andreyknvl@google.com>
 <20200918144423.GF2384246@elver.google.com>
 <CAAeHK+yJ=86KfVN5bSvXpawjNtLuG4zvsPVtcYCBQR_PPfV4Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+yJ=86KfVN5bSvXpawjNtLuG4zvsPVtcYCBQR_PPfV4Bw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 04:55:45PM +0200, Andrey Konovalov wrote:
> On Fri, Sep 18, 2020 at 4:44 PM Marco Elver <elver@google.com> wrote:
> >
> > On Tue, Sep 15, 2020 at 11:16PM +0200, Andrey Konovalov wrote:
> > [...]
> > >  static void set_track(struct kmem_cache *s, void *object,
> > > @@ -583,7 +585,8 @@ static void set_track(struct kmem_cache *s, void *object,
> > >               unsigned int nr_entries;
> > >
> > >               metadata_access_enable();
> > > -             nr_entries = stack_trace_save(p->addrs, TRACK_ADDRS_COUNT, 3);
> > > +             nr_entries = stack_trace_save(kasan_reset_tag(p->addrs),
> > > +                                             TRACK_ADDRS_COUNT, 3);
> >
> > Suggested edit (below 100 cols):
> >
> > -               nr_entries = stack_trace_save(kasan_reset_tag(p->addrs),
> > -                                               TRACK_ADDRS_COUNT, 3);
> > +               nr_entries = stack_trace_save(kasan_reset_tag(p->addrs), TRACK_ADDRS_COUNT, 3);
> 
> Ah, yes, it's a 100 lines now :) Will do in v3, thanks!

Don't get too carried way ;). The preferred limit is still 80, as per
Documentation/process/coding-style.rst (and commit bdc48fa11e46), unless
it significantly increases readability and does not hide information.
The checkpatch.pl was changed as not to make 80 a hard limit (and so an
arbitrary higher limit was picked).

What (to me) would increase readability above is aligning the
descendants to the open function parenthesis rather than increasing the
line length. Anyway, it's up to you on the kasan code, just don't bother
changing the patches for longer lines in arch/arm64.

-- 
Catalin
