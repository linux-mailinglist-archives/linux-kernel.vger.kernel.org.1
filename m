Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C18428885D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbgJIMMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388404AbgJIMMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:12:46 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3300CC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 05:12:46 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id i12so8791944ota.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 05:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vglF5TgelpcXWuhwbhmz3Tg260d8h9z/0FEQQjRk5vw=;
        b=UTyO88Bjpy8t9kBwxo/swiOkD1L6J1kBQ9GDBVYxyL/REnT78PO20a2P9CCqTLJ5du
         YKamn7VgJK8zBd7ObqFgEG1n2orYT+a2OyWzufbja7ebUkVpRyKu2PgojxPgIrELMr8e
         kludZFOOnFPXSa48JL0H9+A1WozKeALMfXbVdlnrXqjbPvLPVGIACtcJE/MuwhM5x52D
         EmvvBzQ2/FTePghmV73M5V02JB0rcu2SBD7GNbMMtZWEz3oFZehmP7IccR9vmfb1h649
         pFlQnW/kChNLHDc+9lKdy3Huao8U2qvnq+VmYbYauc3FIFqo0VqKNvCWHRpJA4bUFpi5
         aAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vglF5TgelpcXWuhwbhmz3Tg260d8h9z/0FEQQjRk5vw=;
        b=t1xJzVUcffuonxhaD8ef24FqLls7IWvKWLGrXP1Zq6FEQUNIHYFOpITijTELOcZd2j
         lrboBDdvdLky66DHURroeKndzFf0syPQZ3g1v3To+n6fqNjEZ3Tmbgnfx0je/c+tDgGH
         fTfIk95FlyFZ4SaFWmn4YaOUp1F+UXxyANEU7sGzkTOzjdw+OzA57FDUvgK2lEyYEkXM
         9KKFl3JkJX0XOygZahFijfjh1Sb9+1aeu4hcO1MhgAKGjHU701YSRoCrnFbaKy7v2JnA
         k/CwAJvDS2rTz+hWdqe5sVwjXGlMpTjEm/4mQilC8ZWoAxy07TVagL+y90WAoVsqInHt
         ViiA==
X-Gm-Message-State: AOAM531zcp7QnoEgv3vO13FCionrJlzkOK7LyPLOY4qWEF3hArt0Df2V
        6Vth89FnvJuKnS1fy/C/+dfEMrf5CUFGTnrPboYrx8xR/B8Hn8Mo
X-Google-Smtp-Source: ABdhPJynIFpoV4/xv/4/DqIHyB4TgoRXIVbijDMjFudDDNIymFhrX/mL2+SMq02IXJZWSbKGCJiwYbUdjQawdAIzNtI=
X-Received: by 2002:a9d:34d:: with SMTP id 71mr7876128otv.251.1602245565330;
 Fri, 09 Oct 2020 05:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201008233443.3335464-1-keescook@chromium.org>
In-Reply-To: <20201008233443.3335464-1-keescook@chromium.org>
From:   Marco Elver <elver@google.com>
Date:   Fri, 9 Oct 2020 14:12:34 +0200
Message-ID: <CANpmjNOwZ5VpKQn+SYWovTkFB4VsT-RPwyENBmaK0dLcpqStkA@mail.gmail.com>
Subject: Re: [PATCH] slub: Actually fix freelist pointer vs redzoning
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Oct 2020 at 01:34, Kees Cook <keescook@chromium.org> wrote:
> It turns out that SLUB redzoning ("slub_debug=Z") checks from
> s->object_size rather than from s->inuse (which is normally bumped to
> make room for the freelist pointer), so a cache created with an object
> size less than 24 would have their freelist pointer written beyond
> s->object_size, causing the redzone to corrupt the freelist pointer.
> This was very visible with "slub_debug=ZF":
>
> BUG test (Tainted: G    B            ): Redzone overwritten
> -----------------------------------------------------------------------------
>
> INFO: 0xffff957ead1c05de-0xffff957ead1c05df @offset=1502. First byte 0x1a instead of 0xbb
> INFO: Slab 0xffffef3950b47000 objects=170 used=170 fp=0x0000000000000000 flags=0x8000000000000200
> INFO: Object 0xffff957ead1c05d8 @offset=1496 fp=0xffff957ead1c0620
>
> Redzone (____ptrval____): bb bb bb bb bb bb bb bb               ........
> Object  (____ptrval____): 00 00 00 00 00 f6 f4 a5               ........
> Redzone (____ptrval____): 40 1d e8 1a aa                        @....
> Padding (____ptrval____): 00 00 00 00 00 00 00 00               ........
>
> Adjust the offset to stay within s->object_size.
>
> (Note that there appear to be no such small-sized caches in the kernel
> currently.)
>
> Reported-by: Marco Elver <elver@google.com>
> Link: https://lore.kernel.org/linux-mm/20200807160627.GA1420741@elver.google.com/
> Fixes: 89b83f282d8b (slub: avoid redzone when choosing freepointer location)
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  mm/slub.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)

Tested-by: Marco Elver <elver@google.com>

Thank you!

> diff --git a/mm/slub.c b/mm/slub.c
> index 68c02b2eecd9..979f5da26992 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3641,7 +3641,6 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>  {
>         slab_flags_t flags = s->flags;
>         unsigned int size = s->object_size;
> -       unsigned int freepointer_area;
>         unsigned int order;
>
>         /*
> @@ -3650,13 +3649,6 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>          * the possible location of the free pointer.
>          */
>         size = ALIGN(size, sizeof(void *));
> -       /*
> -        * This is the area of the object where a freepointer can be
> -        * safely written. If redzoning adds more to the inuse size, we
> -        * can't use that portion for writing the freepointer, so
> -        * s->offset must be limited within this for the general case.
> -        */
> -       freepointer_area = size;
>
>  #ifdef CONFIG_SLUB_DEBUG
>         /*
> @@ -3682,7 +3674,7 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>
>         /*
>          * With that we have determined the number of bytes in actual use
> -        * by the object. This is the potential offset to the free pointer.
> +        * by the object and redzoning.
>          */
>         s->inuse = size;
>
> @@ -3694,7 +3686,8 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>                  * kmem_cache_free.
>                  *
>                  * This is the case if we do RCU, have a constructor or
> -                * destructor or are poisoning the objects.
> +                * destructor, are poisoning the objects, or are
> +                * redzoning an object smaller than sizeof(void *).
>                  *
>                  * The assumption that s->offset >= s->inuse means free
>                  * pointer is outside of the object is used in the
> @@ -3703,13 +3696,13 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>                  */
>                 s->offset = size;
>                 size += sizeof(void *);
> -       } else if (freepointer_area > sizeof(void *)) {
> +       } else {
>                 /*
>                  * Store freelist pointer near middle of object to keep
>                  * it away from the edges of the object to avoid small
>                  * sized over/underflows from neighboring allocations.
>                  */
> -               s->offset = ALIGN(freepointer_area / 2, sizeof(void *));
> +               s->offset = ALIGN_DOWN(s->object_size / 2, sizeof(void *));
>         }
>
>  #ifdef CONFIG_SLUB_DEBUG
> --
> 2.25.1
>
