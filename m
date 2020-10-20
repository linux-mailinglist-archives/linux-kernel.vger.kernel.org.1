Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A18D28BAB2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbgJLOVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbgJLOVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:21:13 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEE6C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 07:21:12 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id m128so18860477oig.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 07:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgmtNie/zntd1O8Xi3/aeMkTtA9q5iGd/FaFCpPsSPs=;
        b=W5D1O2LhZGhhtUHHQ0CoKvhXXf/YejHLvjh9W17bi16WOd0iJo1QZTL1rcHvftYDMV
         h6XvT/lCmWVeoZLr9Tjqsc/fOiM7YbwnNwnvXem9eM/+1ZJs0pqwf/p48vjhWaDyD4CR
         fevht215iJjkDTi4Nl/dVbNS+ell3n3OgXOzmQQALEJPbD1Hs+2LUQ2DgtPXAcI2FXtB
         wvxHPK6QEYohTpdrIHAZabd9TDA5lbi7jQwcfY5cBpYSi1vec/iBwv6MfVEktJiRjr0b
         YdFUc251KB7K6IRHrYMSoZEFAbENaJ34qCFRqlILxCzqzjSKuJ15s+uDvLvRiavWHlIB
         mSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgmtNie/zntd1O8Xi3/aeMkTtA9q5iGd/FaFCpPsSPs=;
        b=h5+kem6CIi+GdvOg3DI2hdDZcnjCEpkH3QJo1r3luzqYvAylj7fFTbINAvaH/yVH00
         XdxAuugFE2v9a3A6ZpisHqaeruLPmn6G8Ter+q9nccCPP2Gwm+KQoz6B0PjXXxbYTvaS
         BW79O8+EHmlH6rs4vNftlffAM4ZEI6Wg2kDMQwp0D20S6UZ1YdyBNGpNIEgwIYuzrtMw
         9jIb6SvMYlkvF3Z5oNYxopI8qS3A+Z8ZxQPRl4XCHhqNpi+kuHXZRrWLtVGwBGqt3763
         3vS5DB6IXfJwh08V6mtzrzwxSg1rp7KvQVfJUWcsSWeedreq7VCxrGH8Sjvbg5i77jlu
         XOVQ==
X-Gm-Message-State: AOAM530vdB+gLGyQVjzv3jTojcYbwu4UGSpvjVziLU8lsfg8xP6Y927P
        wt2tA7BdYRqdMJkXKSHRxy9e/9su2b5A1/8ioLbevg==
X-Google-Smtp-Source: ABdhPJxW8RGoOJpKn2/G8YuZtMEiJ+Fre4lLQCyuU8ImxOvZHMcKn2i477QwV30ZDV2aJL70uTEAfHUomZ6GY2lTL2g=
X-Received: by 2002:a54:468f:: with SMTP id k15mr11407914oic.121.1602512471058;
 Mon, 12 Oct 2020 07:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200929133814.2834621-1-elver@google.com> <20200929133814.2834621-2-elver@google.com>
 <CAG48ez3+_K6YXoXgKBkB8AMeSQj++Mxi5u2OT--B+mJgE7Cyfg@mail.gmail.com>
 <20201002171959.GA986344@elver.google.com> <CAG48ez0D1+hStZaDOigwbqNqFHJAJtXK+8Nadeuiu1Byv+xp5A@mail.gmail.com>
 <CANpmjNN7s3o4DYbP64iLYo0MeDWciQnKd61njJKLsiZv+ZLQdA@mail.gmail.com> <CAG48ez0az-Mv1f6EpnQwO6cYQANwx4qCDLa+yda_i15AzciS1Q@mail.gmail.com>
In-Reply-To: <CAG48ez0az-Mv1f6EpnQwO6cYQANwx4qCDLa+yda_i15AzciS1Q@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 12 Oct 2020 16:20:59 +0200
Message-ID: <CANpmjNPb2JW6vjRODOzpbjh2HauAN2==NAs9tfpbxYiv53r_Zg@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] mm: add Kernel Electric-Fence infrastructure
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
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
        Ingo Molnar <mingo@redhat.com>,
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
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>, SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Sorry for delay, just noticed this one doesn't have a reply yet. ]

On Sat, 3 Oct 2020 at 00:27, Jann Horn <jannh@google.com> wrote:
> On Fri, Oct 2, 2020 at 11:28 PM Marco Elver <elver@google.com> wrote:
> > On Fri, 2 Oct 2020 at 21:32, Jann Horn <jannh@google.com> wrote:
> > > > That's another check; we don't want to make this more expensive.
> > >
> > > Ah, right, I missed that this is the one piece of KFENCE that is
> > > actually really hot code until Dmitry pointed that out.
> > >
> > > But actually, can't you reduce how hot this is for SLUB by moving
> > > is_kfence_address() down into the freeing slowpath? At the moment you
> > > use it in slab_free_freelist_hook(), which is in the super-hot
> > > fastpath, but you should be able to at least move it down into
> > > __slab_free()...
> > >
> > > Actually, you already have hooked into __slab_free(), so can't you
> > > just get rid of the check in the slab_free_freelist_hook()?
> >
> > I missed this bit: the loop that follows wants the free pointer, so I
> > currently see how this might work. :-/
>
> reverse call graph:
> __slab_free
>   do_slab_free
>     slab_free
>       kmem_cache_free (frees a single non-kmalloc allocation)
>       kmem_cache_free_bulk (frees multiple)
>       kfree (frees a single kmalloc allocation)
>     ___cache_free (frees a single allocation for KASAN)
>
> So the only path for which we can actually loop in __slab_free() is
> kmem_cache_free_bulk(); and you've already changed
> build_detached_freelist() (which is used by kmem_cache_free_bulk() to
> group objects from the same page) to consume KFENCE allocations before
> they can ever reach __slab_free(). So we know that if we've reached
> __slab_free(), then we are being called with either a single object
> (which may be a KFENCE object) or with a list of objects that all
> belong to the same page and don't contain any KFENCE allocations.

Yes, while that is true, we still cannot execute the code in
slab_free_freelist_hook(). There are several problems:

- getting the freepointer which accesses object + s->offset, may
result in KFENCE OOB errors.

- similarly for setting the freepointer.

- slab_want_init_on_free zeroing object according to memcache
object_size, because it'll corrupt KFENCE's redzone if memcache
object_size > actual allocation size.

Leaving this here is fine, since we have determined that recent
optimizations make the check in slab_free_freelist_hook() negligible.

Thanks,
-- Marco
