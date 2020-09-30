Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBD827E8F0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgI3MvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3MvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:51:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D2DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 05:51:12 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x23so1578706wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 05:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=061+j+6egSPgQBxcQTsTW5phFlVIKpu1EERfRNYFm3I=;
        b=L7X6TOpxVSA1+/tKoz+lBrre35i6hykvaIsiSKRHazC1OEzRn8KvgpXAhkiiZiVegY
         hdXFas3bd8RElezjRN1Xeo7xyo7N2TkVLXtqU3NGt5Q8cVO3mr5kv+TEr1CYFZCRj4Z/
         NW5e/35SOVX/7oaogpcsuZY+pT2bwreoZd2XwBqQnwrCKrSePcNpSqJb0uFF/Id6AfFs
         KOYk8XjmATWuR/1g8kLMRJOhm10DPe9hbErIsERzBQXL30eRmJc/Lg9yUE0wgl2QU6er
         RnRvuI5XvMS9yKOd/4XI7PcEwBEw2l3rf/ujZ4+IWPrfSKuDeZm1cQ/nKtWd1HwBDjMP
         EdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=061+j+6egSPgQBxcQTsTW5phFlVIKpu1EERfRNYFm3I=;
        b=JC6Py8QXWfg3CHBWQiGHrPMMEauriTfXDEpilfw9LvMC4iLvV09ikv51nPZXuPL4iV
         PQCjQ1/exU185Jj3QGZdUe9c2aHRW8cv1Xt6ejVbQ862i95Tj3+7vkByDiwqyxwuVvMe
         /Rdd0Va8o7N3/JVlmO3bDRHvDhLBBYD1b/fuJz8s4TUYoWoiQlpFX5JN//zcgav4+Jki
         C4Y9ddHaSce4xKyEKB0PecPQwW/75hawLDR4JUf6srqZl6h+Lzu9JGNJRzg1p+PlJBPO
         e4Pxizw5KdYz1KrrYNVaDt+FK/q07oKfm/WJ/Om7cmgSxJxmn1Bt5Jebx9mfjZ+YwLsq
         blQw==
X-Gm-Message-State: AOAM530RiIw/al0ZrTGvla+iqI6tDG9vhMeDF1VAX3Qm/R+li5COX1ax
        1z+OBXBtwyHz1JeNT1rq6zMw8n8+hSEm3pm/ScUqjQ==
X-Google-Smtp-Source: ABdhPJzmy6011bRCaz/kYoxOSxfcZV6R3wEOIH1+eORfD6559vOkDZuINzOB4rqg9WTL3BgoD4kKzA3W5h9iSh2kySo=
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr2785473wmj.112.1601470270876;
 Wed, 30 Sep 2020 05:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200929183513.380760-1-alex.popov@linux.com> <20200929183513.380760-3-alex.popov@linux.com>
In-Reply-To: <20200929183513.380760-3-alex.popov@linux.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 30 Sep 2020 14:50:59 +0200
Message-ID: <CAG_fn=WY9OFKuy6utMHOgyr+1DYNsuzVruGCGHMDnEnaLY6s9g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/6] mm/slab: Perform init_on_free earlier
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Will Deacon <will@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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
        Matthew Wilcox <willy@infradead.org>,
        Pavel Machek <pavel@denx.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>, notify@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 8:35 PM Alexander Popov <alex.popov@linux.com> wrot=
e:
>
> Currently in CONFIG_SLAB init_on_free happens too late, and heap
> objects go to the heap quarantine being dirty. Lets move memory
> clearing before calling kasan_slab_free() to fix that.
>
> Signed-off-by: Alexander Popov <alex.popov@linux.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  mm/slab.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/slab.c b/mm/slab.c
> index 3160dff6fd76..5140203c5b76 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3414,6 +3414,9 @@ static void cache_flusharray(struct kmem_cache *cac=
hep, struct array_cache *ac)
>  static __always_inline void __cache_free(struct kmem_cache *cachep, void=
 *objp,
>                                          unsigned long caller)
>  {
> +       if (unlikely(slab_want_init_on_free(cachep)))
> +               memset(objp, 0, cachep->object_size);
> +
>         /* Put the object into the quarantine, don't touch it for now. */
>         if (kasan_slab_free(cachep, objp, _RET_IP_))
>                 return;
> @@ -3432,8 +3435,6 @@ void ___cache_free(struct kmem_cache *cachep, void =
*objp,
>         struct array_cache *ac =3D cpu_cache_get(cachep);
>
>         check_irq_off();
> -       if (unlikely(slab_want_init_on_free(cachep)))
> -               memset(objp, 0, cachep->object_size);
>         kmemleak_free_recursive(objp, cachep->flags);
>         objp =3D cache_free_debugcheck(cachep, objp, caller);
>         memcg_slab_free_hook(cachep, virt_to_head_page(objp), objp);
> --
> 2.26.2
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
