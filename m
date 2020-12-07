Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084352D0FC3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgLGLxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgLGLxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:53:46 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FD0C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 03:52:59 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id r24so17625438lfm.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 03:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DbcZ0bSg2oe4ybbJwcruH4k64DkgbzTjybs+KQ5OE8s=;
        b=VEaoCPEDDAXEVGvnKp4E2uwASKtfwpkbQoIvWCOasNNEPTcZ/pMfUVB84Qtsf/xj0+
         JM7lDwrUKTe6ocSQNaUeoqfnhcidA0PbzByw1ZyztXWPjA+3pqCFE5q0A71Npr5OeM/m
         LG/ihoaRB7xuh+XhjEAEhAB+qbNhyyXwa+t68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DbcZ0bSg2oe4ybbJwcruH4k64DkgbzTjybs+KQ5OE8s=;
        b=fRwko7V6WSVTtZ3HKJz3m/GBsrhmPNeSleXQhaBTlTiKxGZ58xauxOorue5J4O66tC
         ZYSPn6NYJLzy2xFDdjw/6kO8wT5OEEsvdfxizz0I6YnaglDL3j4rPNBWxgX/oNmVK4Xu
         fKuwSc9OFdyfZDpk26rasU7SyXr2oookgWFlGdgoxx608+uB3YmewEpoWKHZaSypGRaT
         TuV2ds7A2GsxluHdqK8F9Y19y9QZwAtgzJZ4chLo2n/PhL6dAE8RXwHXDMMQs8e4DEDQ
         XJi1hYs7AHJFqz0IcvOaoomlQgObqLv3t4uG91HL4O58OBXd+AGcrM7ReSoHNnVIdu75
         joKg==
X-Gm-Message-State: AOAM530WRUvifuFbdpAAjYYr7whUmdULaHGGnInjQDM9teLl7Lrg4AwE
        4rslAGhc4ySVe3LjC+zUUAH1KERn8uR1/jN/QQNudBdRoPoH7yz2
X-Google-Smtp-Source: ABdhPJx0iAjqX3slY9qXKo4pURaFZHetOLHdAM82Tvhl40dxaCVXqff12112d7tosd5dcjJprLDsnDMIZEzE9biT+8k=
X-Received: by 2002:a19:ad41:: with SMTP id s1mr8618171lfd.571.1607341978531;
 Mon, 07 Dec 2020 03:52:58 -0800 (PST)
MIME-Version: 1.0
References: <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
 <20201130132014.mlvxeyiub3fpwyw7@linutronix.de> <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
 <20201130145229.mhbkrfuvyctniaxi@linutronix.de> <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
 <20201130160327.ov32m4rapk4h432a@linutronix.de> <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
 <20201202220826.5chy56mbgvrwmg3d@linutronix.de> <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
 <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de> <20201203133934.37aotbdjnd36lrxv@linutronix.de>
 <10d5088861ba219f3f7cd657fc95b0bedc19010a.camel@gmx.de> <cad7848c-7fd3-b4a4-c079-5896bb47ee49@konsulko.com>
 <3ffed6172820f2e8e821e1b8817dbd0bdd693c26.camel@gmx.de>
In-Reply-To: <3ffed6172820f2e8e821e1b8817dbd0bdd693c26.camel@gmx.de>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Mon, 7 Dec 2020 12:52:47 +0100
Message-ID: <CAM4kBBL5+xNWq6DWHY6nQjwDTj8PZKem-rGuFvimi7jekjA+Xw@mail.gmail.com>
Subject: Re: scheduling while atomic in z3fold
To:     Mike Galbraith <efault@gmx.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 3:18 AM Mike Galbraith <efault@gmx.de> wrote:
>
> On Mon, 2020-12-07 at 02:05 +0100, Vitaly Wool wrote:
> >
> > Could you please try the following patch in your setup:
>
> crash> gdb list *z3fold_zpool_free+0x527
> 0xffffffffc0e14487 is in z3fold_zpool_free (mm/z3fold.c:341).
> 336                     if (slots->slot[i]) {
> 337                             is_free = false;
> 338                             break;
> 339                     }
> 340             }
> 341             write_unlock(&slots->lock);  <== boom
> 342
> 343             if (is_free) {
> 344                     struct z3fold_pool *pool = slots_to_pool(slots);
> 345
> crash> z3fold_buddy_slots -x ffff99a3287b8780
> struct z3fold_buddy_slots {
>   slot = {0xdeadbeef, 0xdeadbeef, 0xdeadbeef, 0xdeadbeef},
>   pool = 0xffff99a3146b8400,
>   lock = {
>     rtmutex = {
>       wait_lock = {
>         raw_lock = {
>           {
>             val = {
>               counter = 0x1
>             },
>             {
>               locked = 0x1,
>               pending = 0x0
>             },
>             {
>               locked_pending = 0x1,
>               tail = 0x0
>             }
>           }
>         }
>       },
>       waiters = {
>         rb_root = {
>           rb_node = 0xffff99a3287b8e00
>         },
>         rb_leftmost = 0x0
>       },
>       owner = 0xffff99a355c24500,
>       save_state = 0x1
>     },
>     readers = {
>       counter = 0x80000000
>     }
>   }
> }

Thanks. This trace beats me because I don't quite get how this could
have happened.
Hitting write_unlock at line 341 would mean that HANDLES_ORPHANED bit
is set but obviously it isn't.
Could you please comment out the ".shrink = z3fold_zpool_shrink" line
and retry? Reclaim is the trickiest thing over there since I have to
drop page lock while reclaiming.

Thanks,
   Vitaly

> > diff --git a/mm/z3fold.c b/mm/z3fold.c
> > index 18feaa0bc537..efe9a012643d 100644
> > --- a/mm/z3fold.c
> > +++ b/mm/z3fold.c
> > @@ -544,12 +544,17 @@ static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
> >                       break;
> >               }
> >       }
> > -     if (!is_free)
> > +     if (!is_free) {
> >               set_bit(HANDLES_ORPHANED, &zhdr->slots->pool);
> > -     read_unlock(&zhdr->slots->lock);
> > -
> > -     if (is_free)
> > +             read_unlock(&zhdr->slots->lock);
> > +     } else {
> > +             zhdr->slots->slot[0] =
> > +                     zhdr->slots->slot[1] =
> > +                     zhdr->slots->slot[2] =
> > +                     zhdr->slots->slot[3] = 0xdeadbeef;
> > +             read_unlock(&zhdr->slots->lock);
> >               kmem_cache_free(pool->c_handle, zhdr->slots);
> > +     }
> >
> >       if (locked)
> >               z3fold_page_unlock(zhdr);
>
