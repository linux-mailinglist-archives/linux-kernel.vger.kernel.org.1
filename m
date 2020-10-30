Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1872A0A15
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgJ3PmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJ3PmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:42:10 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCC7C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:42:10 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id j7so7026281oie.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jliMwvFbMuf3FmeyCOZHebsGYCHgE565UHogT5/5F4c=;
        b=DTRV++Wj97wRkgJERXq0rJLt5u61M6aqsGpPrrOnjKGZx0REQwXzkR/pMuc8yZvrEZ
         g2R1TVm26ePxCZVC0YEei38ODl21B1c3cWcMr2+PJorWGXwMP6J5U0Ntm+10TM2p6tJV
         CpCTQDAOD8oVls4YRHUrINL85+YtP9RuBxOGPHozp/ye9UomJjfrAgkI4rC1viw6jBG1
         u1uT9ybUrxa3TuQUNEFsK7bR9VjHCl2kWaOmTzJSlRJDGUptBLq263qR0rJJEHAyP3Aj
         vpPFDPfu3rWEXImVRC/Ipfyq5ldHGwmYoQ/ppzDNpXCJDsezNiAo0JKRBtZ5i7/I6ZB9
         zmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jliMwvFbMuf3FmeyCOZHebsGYCHgE565UHogT5/5F4c=;
        b=RyhSU6oXK0beVfuyBvd7HSr3THfFMowOFhFCktVt2dCZjvBlMz3QxvC9lSxNFOi6yV
         ccV6teh//8MgH5GhtKWV9mwKQGw7Q8wfdsb32I52ED2e7iSJu9TqFQTOemQ5rRWFJtao
         2DX2BJqNp+B9ifWZVtGwbCPARvPldkyxmPFQp04XT023at7jRQfCddnVfTUBt1TVBDB8
         XopKu/SCYm8ibea6ljQV0bIBxjQNltA5Q99AzWJNmY1YJ9cWwj/bPgI63cu0Y+MSm4IQ
         1A9uWPPnf5RwyE00sFYxePYE27BLZdc0ixnQ6gCFDqO6gi2qk2fx/AeKGc30pcreuA6O
         QcEQ==
X-Gm-Message-State: AOAM530bGgAWP78S/zdmZIaNVAOpPBw4No2wpxPgiYhddyMDkMEK+XIR
        Zy285hTBihhZJo8kyp2iDGS0X/Rbp9snWGmfzIsYeQ==
X-Google-Smtp-Source: ABdhPJz78rXAmUYJT2EaihG4wO2tbRCMfvht01XOnXsfIeEuKEo7TR1erogbgNJurtY7525vFsiGR0VO98zOblDC/OA=
X-Received: by 2002:aca:6206:: with SMTP id w6mr2138653oib.121.1604072528251;
 Fri, 30 Oct 2020 08:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201029131649.182037-1-elver@google.com> <20201029131649.182037-5-elver@google.com>
 <CAG48ez1DxttDs6vj61c0jSGSbhoUmAW9_OSBSENrC-=hz-d+HA@mail.gmail.com>
In-Reply-To: <CAG48ez1DxttDs6vj61c0jSGSbhoUmAW9_OSBSENrC-=hz-d+HA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 30 Oct 2020 16:41:56 +0100
Message-ID: <CANpmjNOPmgeVLb5COyE734F-1NNSU4vfok-8AQuDoAcLnQ=PbQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/9] mm, kfence: insert KFENCE hooks for SLAB
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
        =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@purestorage.com>,
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
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 at 03:49, Jann Horn <jannh@google.com> wrote:
> On Thu, Oct 29, 2020 at 2:17 PM Marco Elver <elver@google.com> wrote:
> > Inserts KFENCE hooks into the SLAB allocator.
> [...]
> > diff --git a/mm/slab.c b/mm/slab.c
> [...]
> > @@ -3416,6 +3427,11 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
> >  static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
> >                                          unsigned long caller)
> >  {
> > +       if (kfence_free(objp)) {
> > +               kmemleak_free_recursive(objp, cachep->flags);
> > +               return;
> > +       }
>
> This looks dodgy. Normally kmemleak is told that an object is being
> freed *before* the object is actually released. I think that if this
> races really badly, we'll make kmemleak stumble over this bit in
> create_object():
>
> kmemleak_stop("Cannot insert 0x%lx into the object search tree
> (overlaps existing)\n",
>       ptr);

Good catch. Although extremely unlikely, let's just avoid it by moving
the freeing after.

>
> > +
> >         /* Put the object into the quarantine, don't touch it for now. */
> >         if (kasan_slab_free(cachep, objp, _RET_IP_))
> >                 return;
