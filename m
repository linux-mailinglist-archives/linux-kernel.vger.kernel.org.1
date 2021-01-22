Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D674300252
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbhAVMB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:01:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbhAVMAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:00:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EC0422C9F;
        Fri, 22 Jan 2021 12:00:10 +0000 (UTC)
Date:   Fri, 22 Jan 2021 12:00:08 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Subject: Re: [PATCH v5 6/6] kasan: Forbid kunit tests when async mode is
 enabled
Message-ID: <20210122120007.GB8567@gaia>
References: <20210121163943.9889-1-vincenzo.frascino@arm.com>
 <20210121163943.9889-7-vincenzo.frascino@arm.com>
 <CAAeHK+yaFtXUDVExoyqkYysOPdxLVhfY53nb-msFYEJLZx6k8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+yaFtXUDVExoyqkYysOPdxLVhfY53nb-msFYEJLZx6k8Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 06:40:35PM +0100, Andrey Konovalov wrote:
> On Thu, Jan 21, 2021 at 5:40 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
> >
> > Architectures supported by KASAN_HW_TAGS can provide a sync or async
> > mode of execution. KASAN KUNIT tests can be executed only when sync
> > mode is enabled.
> >
> > Forbid the execution of the KASAN KUNIT tests when async mode is
> > enabled.
> >
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > Cc: Alexander Potapenko <glider@google.com>
> > Cc: Andrey Konovalov <andreyknvl@google.com>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > ---
> >  lib/test_kasan.c | 5 +++++
> >  mm/kasan/kasan.h | 2 ++
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > index 7285dcf9fcc1..1306f707b4fe 100644
> > --- a/lib/test_kasan.c
> > +++ b/lib/test_kasan.c
> > @@ -52,6 +52,11 @@ static int kasan_test_init(struct kunit *test)
> >                 return -1;
> >         }
> >
> > +       if (!hw_is_mode_sync()) {
> > +               kunit_err(test, "can't run KASAN tests in async mode");
> > +               return -1;
> > +       }
> 
> I'd rather implement this check at the KASAN level, than in arm64
> code. Just the way kasan_stack_collection_enabled() is implemented.
> 
> Feel free to drop this change and the previous patch, I'll implement
> this myself later.

I agree, it makes sense.

-- 
Catalin
