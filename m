Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A9F281E4D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 00:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgJBW1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 18:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBW1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 18:27:44 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A97C0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 15:27:44 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dn5so3317426edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 15:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WenNmI5oUkGle0L0WRFJAM5U4b70dfVnKCotDQT26ic=;
        b=qpOS6AVUOpuYRfzrRmEmY8nFGGqKUYhiSPRrmYu88Du2AlPVrjadxaORzyWIUB+fjv
         xpaD/n3wkuOKLrC9HL/gQdNsnY351O+V0ZdYMLnIVW2BKM9QtUmYIvTjPSk/Zfcq3pBN
         xsaKuY05LuXKpImIi1CiXpmFMSJ+WoX6JllYGomKn8gKTHCaHKeMWepJgmt5iX4SYnkM
         hXpZng8JV1+NGujOYQZt5ix2ASa/uwXlpzl2sc7HOPP3UKX1TxAPv2X9zN37wP9VfVbR
         RyR9KEP4ICSJJTRkowmJI7H/md2Pjy0JEq2U1hjvc1iMjpe41ESKQ/mHcBumKoqhLD0c
         Uk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WenNmI5oUkGle0L0WRFJAM5U4b70dfVnKCotDQT26ic=;
        b=pFdvcJ+Px2Ex367dr+FJamAE45La9zXCg7bvkpZZB31P5pNrHWNJ0FeCddnHHn6LpW
         VFNANZhsLVOPf/j4roBvIlXKFenHKZDJa++4FlID2g3QukbKcbI4x2z47fGQrtoifAYU
         uCB30GOtMIT1EujUV4ubVWXBUAtZWrsIx1assPx2iJzY0xKA6hdMKcerVVsMqMWJPRro
         0PTxUlOW7xnlOf6vu4RG47ZYTavugYKlxcBTFl//xIBBIoOK/BlU3P0aWr6ieQANYwGP
         dxi7/9CxyKRT6jxf7lRRXOwsCnl8gL9B2HUZSXMLY/BA0awiI5V4XNU4J6XGO0uM3qbG
         dklQ==
X-Gm-Message-State: AOAM530/7XFl+3RgP9g++GHo8rfF7+9GuCHQgAZz5ijJAuCLCuFOqjhi
        rGRGR0rj/3XKfqxpVvl1Sm/EzGAjkVoC6Fkp8ghoVA==
X-Google-Smtp-Source: ABdhPJzj0f7XvxzsCDrfMmIeI3C8DfvP4DCgq9+cCHs7tz7tMvkK8DfUcfTEg3mEkcGuHbAuc2NOlXwWuav+aHlt06Q=
X-Received: by 2002:a05:6402:b0e:: with SMTP id bm14mr5117814edb.259.1601677662551;
 Fri, 02 Oct 2020 15:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200929133814.2834621-1-elver@google.com> <20200929133814.2834621-2-elver@google.com>
 <CAG48ez3+_K6YXoXgKBkB8AMeSQj++Mxi5u2OT--B+mJgE7Cyfg@mail.gmail.com>
 <20201002171959.GA986344@elver.google.com> <CAG48ez0D1+hStZaDOigwbqNqFHJAJtXK+8Nadeuiu1Byv+xp5A@mail.gmail.com>
 <CANpmjNN7s3o4DYbP64iLYo0MeDWciQnKd61njJKLsiZv+ZLQdA@mail.gmail.com>
In-Reply-To: <CANpmjNN7s3o4DYbP64iLYo0MeDWciQnKd61njJKLsiZv+ZLQdA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 3 Oct 2020 00:27:16 +0200
Message-ID: <CAG48ez0az-Mv1f6EpnQwO6cYQANwx4qCDLa+yda_i15AzciS1Q@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] mm: add Kernel Electric-Fence infrastructure
To:     Marco Elver <elver@google.com>
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

On Fri, Oct 2, 2020 at 11:28 PM Marco Elver <elver@google.com> wrote:
> On Fri, 2 Oct 2020 at 21:32, Jann Horn <jannh@google.com> wrote:
> > > That's another check; we don't want to make this more expensive.
> >
> > Ah, right, I missed that this is the one piece of KFENCE that is
> > actually really hot code until Dmitry pointed that out.
> >
> > But actually, can't you reduce how hot this is for SLUB by moving
> > is_kfence_address() down into the freeing slowpath? At the moment you
> > use it in slab_free_freelist_hook(), which is in the super-hot
> > fastpath, but you should be able to at least move it down into
> > __slab_free()...
> >
> > Actually, you already have hooked into __slab_free(), so can't you
> > just get rid of the check in the slab_free_freelist_hook()?
>
> I missed this bit: the loop that follows wants the free pointer, so I
> currently see how this might work. :-/

reverse call graph:
__slab_free
  do_slab_free
    slab_free
      kmem_cache_free (frees a single non-kmalloc allocation)
      kmem_cache_free_bulk (frees multiple)
      kfree (frees a single kmalloc allocation)
    ___cache_free (frees a single allocation for KASAN)

So the only path for which we can actually loop in __slab_free() is
kmem_cache_free_bulk(); and you've already changed
build_detached_freelist() (which is used by kmem_cache_free_bulk() to
group objects from the same page) to consume KFENCE allocations before
they can ever reach __slab_free(). So we know that if we've reached
__slab_free(), then we are being called with either a single object
(which may be a KFENCE object) or with a list of objects that all
belong to the same page and don't contain any KFENCE allocations.
