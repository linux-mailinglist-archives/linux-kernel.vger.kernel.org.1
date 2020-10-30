Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0562129FBB0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgJ3CuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgJ3CuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:50:00 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B272C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:50:00 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 23so5334442ljv.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z9WOxdh6RCpZm8X6kMwbW3XPGG0WSUUUAze88LfZLdE=;
        b=etxHYnTqjwBUbwtfAT9j7VihFyCPL/m5eoH6lV63Jwf/ogaS8IKuC/qJ0F2t2aJCTu
         YcXfkY8v4/Ze8lP8pZWLnoMm5+afhhjmu2kX8tx4XUTc2g3+taqkP5iw5O/XxbrXeokh
         /Z4gZPHmELyAamNnAVQZEPpF1z6I7AvobWo9rXIWQ4W9PVyMLUg7pHsdscCI4vcHhut2
         KDKv2h0XeSjZIlzeLYggI3qsLbeEI5HKczEYovWFfTlfU5RcMT5lRZ2+Xe9rQ1O/YFlY
         Bjdk2siK5slwbxSG7EkMj23241i3jE2SX9x0CZ83wo0uv4SrDXzDA4uTA7PNluOo5tQY
         TYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z9WOxdh6RCpZm8X6kMwbW3XPGG0WSUUUAze88LfZLdE=;
        b=Y2K6NOhBJlV3XelZqFTuAzdkIttCqm91Y7KEl04lM7t90VGyjUtT2Vx2i7GQPzSlIo
         mIy+HxDFgVNL0k1j21QrtnrbIawUmVsk4SHwxr8fnqhK4RsxYQXFFoL1k1eq5KJoTOVC
         Dd5nCvrLol+ZGFXLSxW2Gxlt9YCuKvIEr1fkm6gHAmGvJJ+/kzIfyBxVgA7b7UD3BwS7
         CMnqmISmuMWFlwVzcjXyNg6T+y7yERkPos+52IlfHJimMOf815UknrPYTA/xeBYG7iCH
         SeKtKkER4smjdPinHL4O6MtUh73sBQms0sm2dHtoslH4BfNuDbeW2Zc1A2Tcxzn9GN9d
         BdtA==
X-Gm-Message-State: AOAM532JS99y2UxMy1bEqxRM6bIVkTmNHEDXwpZK6CfefYwJFqo4unSq
        Pmr/YPHTxdv+ppmljc4gsqlbmd2x9V+4qbdaxuxQVw==
X-Google-Smtp-Source: ABdhPJwE/Q8Xn7eqLDDiYpTHlTjaaBJjfas81RL+GS05oC24gJGCW+LBgod9ZKVq7Rn7XWiNj/59sO4G5qgTD6gJ5JY=
X-Received: by 2002:a05:651c:1313:: with SMTP id u19mr95728lja.47.1604026198405;
 Thu, 29 Oct 2020 19:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201029131649.182037-1-elver@google.com> <20201029131649.182037-5-elver@google.com>
In-Reply-To: <20201029131649.182037-5-elver@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 30 Oct 2020 03:49:31 +0100
Message-ID: <CAG48ez1DxttDs6vj61c0jSGSbhoUmAW9_OSBSENrC-=hz-d+HA@mail.gmail.com>
Subject: Re: [PATCH v6 4/9] mm, kfence: insert KFENCE hooks for SLAB
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, joern@purestorage.com,
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

On Thu, Oct 29, 2020 at 2:17 PM Marco Elver <elver@google.com> wrote:
> Inserts KFENCE hooks into the SLAB allocator.
[...]
> diff --git a/mm/slab.c b/mm/slab.c
[...]
> @@ -3416,6 +3427,11 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
>  static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
>                                          unsigned long caller)
>  {
> +       if (kfence_free(objp)) {
> +               kmemleak_free_recursive(objp, cachep->flags);
> +               return;
> +       }

This looks dodgy. Normally kmemleak is told that an object is being
freed *before* the object is actually released. I think that if this
races really badly, we'll make kmemleak stumble over this bit in
create_object():

kmemleak_stop("Cannot insert 0x%lx into the object search tree
(overlaps existing)\n",
      ptr);


> +
>         /* Put the object into the quarantine, don't touch it for now. */
>         if (kasan_slab_free(cachep, objp, _RET_IP_))
>                 return;
