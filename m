Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F10C2A8514
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbgKERjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:39:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKERjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:39:09 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A230206CA;
        Thu,  5 Nov 2020 17:39:05 +0000 (UTC)
Date:   Thu, 5 Nov 2020 17:39:02 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 30/43] arm64: kasan: Allow enabling in-kernel MTE
Message-ID: <20201105173901.GH30030@gaia>
References: <cover.1604531793.git.andreyknvl@google.com>
 <5e3c76cac4b161fe39e3fc8ace614400bc2fb5b1.1604531793.git.andreyknvl@google.com>
 <20201105172549.GE30030@gaia>
 <CAAeHK+x0pQyQFG9e9HRxW5p8AYamPFmP-mKpHDWTwL_XUq7msA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+x0pQyQFG9e9HRxW5p8AYamPFmP-mKpHDWTwL_XUq7msA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 06:29:17PM +0100, Andrey Konovalov wrote:
> On Thu, Nov 5, 2020 at 6:26 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > On Thu, Nov 05, 2020 at 12:18:45AM +0100, Andrey Konovalov wrote:
> > > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > > index 06ba6c923ab7..fcfbefcc3174 100644
> > > --- a/arch/arm64/kernel/mte.c
> > > +++ b/arch/arm64/kernel/mte.c
> > > @@ -121,6 +121,13 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> > >       return ptr;
> > >  }
> > >
> > > +void __init mte_init_tags(u64 max_tag)
> > > +{
> > > +     /* Enable MTE Sync Mode for EL1. */
> > > +     sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
> > > +     isb();
> > > +}
> >
> > Is this going to be called on each CPU? I quickly went through the rest
> > of the patches and couldn't see how.
> 
> Yes, on each CPU. This is done via kasan_init_hw_tags() that is called
> from cpu_enable_mte(). This change is added in the "kasan, arm64:
> implement HW_TAGS runtime".

Ah, I got there eventually in patch 38. Too many indirections ;) (I'm
sure we could have trimmed them down a bit, hw_init_tags ==
arch_init_tags == mte_init_tags).

> Would it make sense to put it into a separate patch?

I think that's fine. I had the impression that kasan_init_hw_tags()
should only be called once.

-- 
Catalin
