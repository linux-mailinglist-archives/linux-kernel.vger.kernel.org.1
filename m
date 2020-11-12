Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01182B0E81
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgKLTw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgKLTwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:52:25 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906D2C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:52:25 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id t143so7714088oif.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ku38Ht+p6L/Qff47Jz/ZEW3Rmq7V+uR73aOdxjfDMS0=;
        b=LyRcRhjy9O9Onai4KalpJMvwS0HgVos89lh0h/DSDaGHtHndNCyX4CxpDLuicoH2FB
         KwsEF5KZpU7cm359GOxKOSjFIw0SWUVglwF3TQFc7+Pw+EXy4jIEQsJd/mS7Y3iYsO90
         9olyGHAl8rLyBIWdFeoBNytZEYeANkpdla2eH0ct5Hjqk2nnB90HcqfO1cILYDWgXN61
         3KxG7dv6LgA+XUz/pRIEN5HB8/Un/Yn/R0KPLGJ6mSqEnBAc6HIbkTEYsUY8QFunQOMA
         HLXF0ccMMJuHrStP7aFBzIh2HIqpbFxBa7mW74b6m+jhyjx2hxd3q+3PeGlS08iLoKwN
         m65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ku38Ht+p6L/Qff47Jz/ZEW3Rmq7V+uR73aOdxjfDMS0=;
        b=LjbSWn7UTH7ArsQ7A4/GZLLRDmSI8iL2PE+wXLyrpBt7hV+t/+9jd6lWyDvZhiceb8
         dl3apD+OGWV9NRaQQbSz8dl7HNirbhkGv+EMBKd/1rwnsR9wPZWIMyt6GRpaTId988za
         tc905Gz8NTmGLkmAMy/soVlVoTyHXU6oqsFfctkB2WF1pefrkr3RM5TmhoMu1P5tXHDg
         6+JYs4/rtF+/MZweGM2bPfS1T4DzPPla6NqK3jq2TVCOg8g6QF5CP1r1xcwEOZEVuh3l
         2/UCqXAW7MjjjAvZUIbMAbKO4uwDU+B77iKy7CyFaYcjnWATHXMVcTdsi2X5r2GXXz/U
         7p0A==
X-Gm-Message-State: AOAM5330FjYR+bA/2Bj9K7n7MZrTVih/3iWTwFe+RHVfAqqopdTadfrf
        Q145vk5A/o2Owh1wtAQPGuMClf8XH7LiWwNT6CtqfQ==
X-Google-Smtp-Source: ABdhPJxGS7NXJM+KF1KuyYHIVqAed9DlcbOpk+BD8O26PFhlwzKyT5bWnxIP3ustua72qmFf7FMunXCN383WjCwEW5Q=
X-Received: by 2002:aca:a988:: with SMTP id s130mr943053oie.172.1605210744714;
 Thu, 12 Nov 2020 11:52:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com> <0a9b63bff116734ab63d99ebd09c244332d71958.1605046662.git.andreyknvl@google.com>
 <20201111174902.GK517454@elver.google.com> <CAAeHK+wvvkYko=tM=NHODkKas13h5Jvsswvg05jhv9LqE0jSjQ@mail.gmail.com>
In-Reply-To: <CAAeHK+wvvkYko=tM=NHODkKas13h5Jvsswvg05jhv9LqE0jSjQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 12 Nov 2020 20:52:12 +0100
Message-ID: <CANpmjNOboPh97HdMGAESSEYdeyd9+9MVy6E3QsvVAYuWVReRew@mail.gmail.com>
Subject: Re: [PATCH v2 10/20] kasan: inline and rename kasan_unpoison_memory
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 at 20:45, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Wed, Nov 11, 2020 at 6:49 PM Marco Elver <elver@google.com> wrote:
> >
> > On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> > > Currently kasan_unpoison_memory() is used as both an external annotation
> > > and as an internal memory poisoning helper. Rename external annotation to
> > > kasan_unpoison_data() and inline the internal helper for hardware
> > > tag-based mode to avoid undeeded function calls.
> >
> > I don't understand why this needs to be renamed again. The users of
> > kasan_unpoison_memory() outweigh those of kasan_unpoison_slab(), of
> > which there seems to be only 1!
>
> The idea is to make kasan_(un)poison_memory() functions inlinable for
> internal use. It doesn't have anything to do with the number of times
> they are used.
>
> Perhaps we can drop the kasan_ prefix for the internal implementations
> though, and keep using kasan_unpoison_memory() externally.

Whatever avoids changing the external interface, because it seems
really pointless. I can see why it's done, but it's a side-effect of
the various wrappers being added.

I'd much rather prefer we do it right from the beginning, and cleaning
up things very much is related to this series vs. just making things
uglier and hoping somebody will clean it up later.

> > So can't we just get rid of kasan_unpoison_slab() and just open-code it
> > in mm/mempool.c:kasan_unpoison_element()? That function is already
> > kasan-prefixed, so we can even place a small comment there (which would
> > also be an improvement over current interface, since
> > kasan_unpoison_slab() is not documented and its existence not quite
> > justified).
>
> We can, but this is a change unrelated to this patch.

Not quite, we're trying to optimize KASAN which is related -- this
patch as-is would obviously change, but replaced by a patch
simplifying things. This change as-is makes 2 changes outside of
KASAN, whereas if we removed it it would only be 1 and we end up with
less cruft.
