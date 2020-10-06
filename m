Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01A9284401
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 04:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgJFCQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 22:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJFCQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 22:16:40 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D558C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 19:16:40 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id md26so15180114ejb.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 19:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ifD/jW+MjbtS2EijgQAS4OITv0Z9zRA4cL1N04HQHu4=;
        b=VSSaWD0WAT8lHVeaIEU8br+ZuZLpGvG3RSgyTiKVEHpRLj5caJa8VuxrOzMMZmi4/I
         +jc18B7Thyp3/FetZnGQgiu+3jGf71BUbdlYdfQ/sXkO4yIffJZxsNlUT3OTfTYc+V53
         s/rD9zQmzH7e/+nYz+ii0l6JB/cgE0XhGNA8YvQrzBYVVZv+tfs+QQFQOzjgU6l2HxUK
         XgMhDW8lxfC88/jHL1K9CxVfkjKO7y42/ifl50NEIctn5atANq4PIvf9c4TvRkLRtmhv
         tnJm3J56L+FQTruYZN7URj8QELVaRv71JNVB9HeCWh34hlHaMpNzgxJKGO/gMn3MIfVk
         OgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ifD/jW+MjbtS2EijgQAS4OITv0Z9zRA4cL1N04HQHu4=;
        b=LR63pMov0uDCeK1FK9/6D3MSBbxk2un/uhH3XGFKfRoggUqMCgCG80DRR0TvVwL6+1
         5/zcMHQLCEUDf4NzAKY/k6WkGU+9S4ByVrjaHXWQ+2VOi+XDsoPhFSHZkA6im3z8+gml
         57Fryk2Z1qqha+ZSCgRuZDc8nilbMsGuP6m9j5NuURYTpmch7VX7Yy59AdnlEB4gjal2
         E8d79Xt0OwThhJge0tHym6+etdQLXq2PLsnOXiqdSU3XMmjJ+IUj6s4HhxtPWINBc6i6
         LSyy0taBs4qCh+ah01AhtJi3WwfBXrwhfHpfToemnfyM1Kqb1jSiiaK28pshyZLuso9c
         k6JA==
X-Gm-Message-State: AOAM5314Gml8NN3Q7TLvnw3aBMBYZsC0NeMO8r6f996OHqG/hqeGbGs3
        5FJXWHye11Vfpphr573u1OQ/b8ktAbmlE+I2x765Eg==
X-Google-Smtp-Source: ABdhPJwxo4AWg8S4Ze5aWA5+V2LLRVib5nWtluQURuOp9DVBriFY+LJHVl4ksm/ZNF2+q+SZWj8S0GCu3SVtK3S+aco=
X-Received: by 2002:a17:906:fcae:: with SMTP id qw14mr2849150ejb.537.1601950598646;
 Mon, 05 Oct 2020 19:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200929183513.380760-1-alex.popov@linux.com> <91d564a6-9000-b4c5-15fd-8774b06f5ab0@linux.com>
 <CAG48ez1tNU_7n8qtnxTYZ5qt-upJ81Fcb0P2rZe38ARK=iyBkA@mail.gmail.com>
 <20201006004414.GP20115@casper.infradead.org> <202010051905.62D79560@keescook>
In-Reply-To: <202010051905.62D79560@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 6 Oct 2020 04:16:12 +0200
Message-ID: <CAG48ez19ecXyqz+GZVsqqM73WZo7tNL4F7Q1vTTP6QG75NaWKw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/6] Break heap spraying needed for exploiting use-after-free
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexander Popov <alex.popov@linux.com>,
        Will Deacon <will@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Pavel Machek <pavel@denx.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>, notify@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 6, 2020 at 4:09 AM Kees Cook <keescook@chromium.org> wrote:
> On Tue, Oct 06, 2020 at 01:44:14AM +0100, Matthew Wilcox wrote:
> > On Tue, Oct 06, 2020 at 12:56:33AM +0200, Jann Horn wrote:
> > > It seems to me like, if you want to make UAF exploitation harder at
> > > the heap allocator layer, you could do somewhat more effective things
> > > with a probably much smaller performance budget. Things like
> > > preventing the reallocation of virtual kernel addresses with different
> > > types, such that an attacker can only replace a UAF object with
> > > another object of the same type. (That is not an idea I like very much
> > > either, but I would like it more than this proposal.) (E.g. some
> > > browsers implement things along those lines, I believe.)
> >
> > The slab allocator already has that functionality.  We call it
> > TYPESAFE_BY_RCU, but if forcing that on by default would enhance security
> > by a measurable amount, it wouldn't be a terribly hard sell ...
>
> Isn't the "easy" version of this already controlled by slab_merge? (i.e.
> do not share same-sized/flagged kmem_caches between different caches)

Yes, but slab_merge still normally frees slab pages to the page allocator.

> The large trouble are the kmalloc caches, which don't have types
> associated with them. Having implicit kmem caches based on the type
> being allocated there would need some pretty extensive plumbing, I
> think?

Well, a bit of plumbing, at least. You'd need to teach the compiler
frontend to grab type names from sizeof() and stuff that type
information somewhere, e.g. by generating an extra function argument
referring to the type, or something like that. Could be as simple as a
reference to a bss section variable that encodes the type in the name,
and the linker already has the logic to automatically deduplicate
those across compilation units - that way, on the compiler side, a
pure frontend plugin might do the job?
