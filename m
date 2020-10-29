Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF2E29F36C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 18:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgJ2RhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 13:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgJ2RhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 13:37:19 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12100C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 10:37:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a72so604873wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 10:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yxVOjFjkk/aWg0934gm436IS5GNuiS+Phez+14sm9BM=;
        b=jZbxbIOd5GYVOZ17H4fWhjGODzjcbbv+MXolrFxm7Kq7w4cj18tJJEb0lA5g5sO9zF
         mwhV8oTNQDbbgvFFURrJQEztox44iD9lqGRYk5LjIv3/foRjQmiyRVaIJjMPbsSbadto
         r292mYEUZNtSTQA9BlqbEOP28g0ASvJY8KQODdl3JxpewlWkFBly474S+Oyzx59Nhsuc
         ld6dB9JbpXlCKfpJBTivonxXJYG3Gm57Wo+wDPdgn3L7XeOMWwiUnr0OnWidobpM0Gi1
         7aN319CH2AQ4xblTfuhmiO7Xz0MzTNS6I7DbEvLrd3Ysx/bEf54IwxiP76QFm9GLlHde
         m3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yxVOjFjkk/aWg0934gm436IS5GNuiS+Phez+14sm9BM=;
        b=Uf9QOIRh5c8N7V2r6WWHE9HffLZphEeonkYksK1BJh17eZ5FGPXLFnfY68+n15RXHN
         LDGkKy8ED8qunFbWRyDS+FsM7NhDYt/HJ5tZNoI8KV/jCeux159VcE9XhKOoZff3soIs
         SqWujvHtoJud/qb1R6s3aSdO5LZHvIJ7BJU5hmF4BSGtd4++JRQQTrqpiZgL+KLFQ2Er
         8hT/DqqCjEAVtqvhg8XOcr9ms6A5DFy75xvZsUqqLpNPaBlNJCl6ajzzcRiBmo2xvN4Q
         nn/hwWOQMNxs0DucPUclb/ACH6T2oSFGQoiKUamnI0hpPKU07XHZBiWWpr77zpq39Acw
         eiVQ==
X-Gm-Message-State: AOAM530b+bk6DzVcsT0VCya26DR+LzKhWisIWQvEB6Gh9csSDQ5iEgtm
        ahJxZsHPXvEa1yx8t8DbnS89S1HMnWUfd2XvTIGx7g==
X-Google-Smtp-Source: ABdhPJz/ws+tQdTlD2sro4O3KJY0G2O9Z2dFSKkGdI9/xqHwUEDbMwkiwcMYMZHYYK/aGD6hzY3rio10qCe6eKIGuDc=
X-Received: by 2002:a1c:980a:: with SMTP id a10mr216873wme.103.1603993037592;
 Thu, 29 Oct 2020 10:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201026173358.14704-1-vbabka@suse.cz> <20201026173358.14704-4-vbabka@suse.cz>
 <93ab79df-cf8c-294b-3ed1-8a563e4a452b@redhat.com> <1fc7ec3a-367c-eb9f-1cb4-b9e015fea87c@suse.cz>
 <81faf3d6-9536-ff00-447d-e964a010492d@suse.cz>
In-Reply-To: <81faf3d6-9536-ff00-447d-e964a010492d@suse.cz>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 29 Oct 2020 18:37:04 +0100
Message-ID: <CAG_fn=VGOVGn3Vx177ACDqg8BaTS96B6Kx01_pxXG5R1D-cWRw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm, page_alloc: reduce static keys in prep_new_page()
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Laura Abbott <labbott@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 2:32 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 10/27/20 12:05 PM, Vlastimil Babka wrote:
> > On 10/27/20 10:10 AM, David Hildenbrand wrote:
> >> On 26.10.20 18:33, Vlastimil Babka wrote:
> >>> prep_new_page() will always zero a new page (regardless of __GFP_ZERO=
) when
> >>> init_on_alloc is enabled, but will also always skip zeroing if the pa=
ge was
> >>> already zeroed on free by init_on_free or page poisoning.
> >>>
> >>> The latter check implemented by free_pages_prezeroed() can involve tw=
o
> >>> different static keys. As prep_new_page() is really a hot path, let's=
 introduce
> >>> a single static key free_pages_not_prezeroed for this purpose and ini=
tialize it
> >>> in init_mem_debugging().
> >>
> >> Is this actually observable in practice? This smells like
> >> micro-optimization to me.
> >>
> >> Also, I thought the whole reason for static keys is to have basically =
no
> >> overhead at runtime, so I wonder if replacing two static key checks by=
 a
> >> single one actually makes *some* difference.
> >
> > You're right, the difference seems to be just a single NOP. The static =
key
> > infrastructure seems to be working really well.
> > (At least the asm inspection made me realize that kernel_poison_pages()=
 is
> > called unconditionally and the static key is checked inside, not inline=
 so I'll
> > be amending patch 2...)
> >
> > Initially I thought I would be reducing 3 keys to 1 in this patch, but =
I got the
> > code wrong. So unless others think it's a readability improvements, we =
can drop
> > this patch.

I agree with David that replacing two static keys with one is probably
a micro-optimization.
Also, if someone is enabling both init_on_alloc and init_on_free, they
are already paying so much that no one is going to notice an extra
static key.

> > Or we can also reconsider this whole optimization. If the point is to b=
e
> > paranoid and enable both init_on_free and init_on_alloc, should we trus=
t that
> > nobody wrote something after the clearing on free via use-after-free? :=
) Kees/Alex?

I think we must trust the kernel to not overwrite zeroed pages.
After all, this could theoretically happen at any time, not only while
the memory chunk is freed.

> More thoughts...
>
> PAGE_POISONING_NO_SANITY skips the check on "unpoisoning" whether poison =
was
> corrupted
> PAGE_POISONING_ZERO uses zero instead of 0xAA as poison pattern
>
> the point of enabling both of these seems to be moot now that init_on_fre=
e
> exists, as that zeroes pages that are being freed, without checking on al=
loc
> that they are still zeroed.
>
> What if only one is enabled?
> - PAGE_POISONING_NO_SANITY without PAGE_POISONING_ZERO - we poison with t=
he 0xAA
> pattern but nobody checks it, so does it give us anything over init_on_fr=
ee
> writing zeroes? I don't think so?
>
> - PAGE_POISONING_ZERO without PAGE_POISONING_NO_SANITY - we use zeroes (l=
ike
> init_on_free) but also check that it wasn't corrupted. We save some time =
on
> writing zeroes again on alloc, but the check is still expensive. And writ=
ing
> 0xAA would possibly detect more corruptions than writing zero (a stray wr=
ite of
> NULL is more likely to happen than of 0xAA?).
>
> So my conclusion:
> - We can remove PAGE_POISONING_NO_SANITY because it only makes sense with
> PAGE_POISONING_ZERO, and we can use init_on_free instead

Agreed.

> - We can also probably remove PAGE_POISONING_ZERO, because if we want to =
do the
> unpoisoning sanity check, then we also most likely want the 0xAA pattern =
and not
> zero.

Agreed.
It might also make sense to somehow merge page poisoning and
init_on_free together and have one config dimension instead of two
(providing something similar to the
INIT_STACK_NONE/INIT_STACK_ALL_ZERO/INIT_STACK_ALL_PATTERN configs)

> Thoughts?
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
