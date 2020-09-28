Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1FF27AD4B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 13:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgI1LyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 07:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgI1LyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 07:54:08 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC46FC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 04:54:07 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id 4so218370ooh.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 04:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVxE17p4zsLCszLlrp2+yy6w1PaUWdFxLyFkrOjdfgU=;
        b=FrUJQhU8kLw5wzKwxdDxIRtiVoZ4lfeEZwy4LJPWfKENd3ZpDBr+fUeXyts5ABr4TM
         ZH5Q5AUVRyledcZkhZFHMj1Xb7lLb7lvKlji7ROGvzgo5ad7SJnlL95Wct+/0nKk++lq
         wYWBtVoulBHcCIV7zqSRjVQeTpnuEVHGkiONEu3FSe0BhD/SwyM/JVJg1Di8LjLpUzMQ
         Ed0RQHWOFbz70PZpdJtw4ZCSz3+jgk5repK1v2BzNhFohtN0QypxHHQD9EbCKbCxyof+
         XI+394+OH71KeoWaiKUNCaoq1tLs3vkcMfYf4L9lvcLWzyN3U+23iR3Pz3G1aYmjKf0n
         RJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVxE17p4zsLCszLlrp2+yy6w1PaUWdFxLyFkrOjdfgU=;
        b=mCWRC8fnFzeUP5I3IiB8McuMLMcWM1tg87G4OlEuWRJXhzi68BTQWz/h5EMJdxRASs
         y1OfikGs6YX2NzAl0hJAvHqaeka5wT2X60xxuTobQ0ifZhlKiBswV+W7FIh642RZkNuh
         jvJK7yAxYo9AxQ5JfLH9mi60J1uzZ15o6yuIYn7oDg7IhD+SwYwPOBWeaXYtnfpm/uSt
         XAhLRM/qm9/YSNlFFRg2FC29z91xbu3EHn6rUhsqBVeJYfxwpnSMs0m5v6JtmghDEDpF
         KDGMvO2gJD0MY1U2Xiw5RRSFKo/cQUisyx66a5s0AeooIVRxmL+H0nu1PVq/UyheEv6x
         UwDQ==
X-Gm-Message-State: AOAM530hyEeNqe3RdrCGYOJgdyvooexVf6x/EOCp+nhtE4EhVP8475rQ
        roC372YWf/jnGTd8Q0G5YyMTybrmzykv0sUVh7EKoQ==
X-Google-Smtp-Source: ABdhPJzpY53/CL/rlGYhaAH12AEPiz652/Rpx7oha4MEk7h+kTfhAQNGeyGlFXmxe76ygSbGoIxkc8SQ6hVOJ6Wmhdo=
X-Received: by 2002:a4a:a58f:: with SMTP id d15mr554121oom.36.1601294046985;
 Mon, 28 Sep 2020 04:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200921132611.1700350-1-elver@google.com> <20200921132611.1700350-4-elver@google.com>
 <20200921143059.GO2139@willie-the-truck>
In-Reply-To: <20200921143059.GO2139@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Mon, 28 Sep 2020 13:53:55 +0200
Message-ID: <CANpmjNMS-6mfDF6o31yiejP0wmgpEeuoh0PP9QJa-qt0OpiRBg@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] arm64, kfence: enable KFENCE for ARM64
To:     Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        SeongJae Park <sjpark@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Sep 2020 at 16:31, Will Deacon <will@kernel.org> wrote:
> On Mon, Sep 21, 2020 at 03:26:04PM +0200, Marco Elver wrote:
> > Add architecture specific implementation details for KFENCE and enable
> > KFENCE for the arm64 architecture. In particular, this implements the
> > required interface in <asm/kfence.h>. Currently, the arm64 version does
> > not yet use a statically allocated memory pool, at the cost of a pointer
> > load for each is_kfence_address().
[...]
> > For ARM64, we would like to solicit feedback on what the best option is
> > to obtain a constant address for __kfence_pool. One option is to declare
> > a memory range in the memory layout to be dedicated to KFENCE (like is
> > done for KASAN), however, it is unclear if this is the best available
> > option. We would like to avoid touching the memory layout.

> Given that the pool is relatively small (i.e. when compared with our virtual
> address space), dedicating an area of virtual space sounds like it makes
> the most sense here. How early do you need it to be available?

Note: we're going to send a v4 this or next week with a few other
minor fixes in it. But I think we just don't want to block the entire
series on figuring out what the static-pool arm64 version should do,
especially if we'll have a few iterations with only this patch here
changing.

So the plan will be:

1. Send v4, which could from our point-of-view be picked up for
merging. Unless of course there are more comments.

2. Work out the details for the static-pool arm64 version, since it
doesn't seem trivial to do the same thing as we do for x86. In
preparation for that, v4 will allow the __kfence_pool's attributes to
be defined entirely by <asm/kfence.h>, so that we can fiddle with
sections etc.

3. Send patch switching out the simpler arm64 version here for one
that places __kfence_pool at a static location.

Hopefully that plan is reasonable.

Thanks,
-- Marco
