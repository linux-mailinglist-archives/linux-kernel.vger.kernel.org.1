Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10A42C49D1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 22:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbgKYVXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 16:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730091AbgKYVXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 16:23:30 -0500
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60983C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 13:23:30 -0800 (PST)
Received: by mail-vk1-xa43.google.com with SMTP id r9so17148vkf.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 13:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h73/dF5vj6XnalyFbnJK6Lk3IaseF5CBAIr/8CD0T6Y=;
        b=fvqjHiQg70A9wBJ0T7oWmWhf6TgIPDGs1VO9bRjXmtLErOjTu0trejaPaK20zbUlM+
         OvD/z3HfmvbBF+gyhd3kBX/Vgnl31bBL3YOkCItuVYWYcijXcgiyojOdvL/ec0VMdoaX
         7mb2xzGRsydJxRtQL3Q/hZIogR/AQVAueIj3f40Fvyze4KOdW+sQpl6BnHgXMpqJuiuf
         eliSiImRVXm8nQLbYiFPU/6QZA3RNu45UdlJFRJQTMLMTtSszgdYpR1DwGzX2323i5V8
         wDPvf6nNgc41lohPRXFAMOEjdDkEUFB/aVBFgbqwh6JD6y8Lm3fkYunIpRCj9OfM5V0n
         7MNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h73/dF5vj6XnalyFbnJK6Lk3IaseF5CBAIr/8CD0T6Y=;
        b=PSMDKvMNmteQj4Kqkq9ldpmPNZ2CxiLKMcdzcgPA4mD+c2LDekI2ravebxtUEpg4MJ
         ZjnEjtvxU0QdHO8StUQw9c1vXtfIRq+9ppzFpIAAY8s2EP467D9ENA4Kh3Egsh2N4X02
         FKgkjX+JO8v6/koZBuYX328392Iji/idtc+mD9aRWEa8tdndB9uanksxzzwbOWT9HfLE
         gXCh3tUExmG0uFB1E6mwvuNDpB/d/nStAp/+ir0Fds+2KY/JMOV1r9VbZ11BYCBb0Gqm
         lLvmc6ghMzmyPQUhHgtIGSOzKG5T+8jmxG+o5ndpnAjuwkeIgJdsDyNibaeo3G7rZWMV
         5FIA==
X-Gm-Message-State: AOAM533VzxwZIysc4MJ4l3Ax3xQ3WjYMiM8y1AzVF+8OXOxyu7CFBBnQ
        FgkpIKVMYkAFuRkq/v789dZGYyz0hTzDtPur6fQ=
X-Google-Smtp-Source: ABdhPJzSQ5m/nAStvigIkwpdO7RkLx+pfpB55Lc6GkFvRq9dG0ceJ9F4xVTT44vLSzMqIPfM07pYycYVrfL3Dq1TJoM=
X-Received: by 2002:a1f:3658:: with SMTP id d85mr50774vka.10.1606339409256;
 Wed, 25 Nov 2020 13:23:29 -0800 (PST)
MIME-Version: 1.0
References: <20201125193626.2266995-1-jim.cromie@gmail.com>
 <20201125193626.2266995-8-jim.cromie@gmail.com> <d57d4f39-b9d3-99f0-6fd0-b3f072895edd@akamai.com>
In-Reply-To: <d57d4f39-b9d3-99f0-6fd0-b3f072895edd@akamai.com>
From:   jim.cromie@gmail.com
Date:   Wed, 25 Nov 2020 14:23:00 -0700
Message-ID: <CAJfuBxyE2De7gjoiv9Dnh4XK7+WjLMA+_x9h9-wOiN7NL6bWiA@mail.gmail.com>
Subject: Re: [PATCH 7/7] dyndbg: enable 'cache' of active pr_debug callsites
To:     Jason Baron <jbaron@akamai.com>
Cc:     linux-mm@kvack.org, Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 1:54 PM Jason Baron <jbaron@akamai.com> wrote:
>
>
>
> On 11/25/20 2:36 PM, Jim Cromie wrote:
> > In ddebug_putsite(), dont zs_unmap the callsite if it is enabled for
> > printing.  This means that the next time this pr_debug callsite is
> > executed, the _getsite() will succeed quickly without remapping the
> > zrec.
> >
> > Once the callsite is disabled via >control, a following _putsite()
> > will see the flag cleared, and zs_unmap it.
> >
> > This changes the lifetime of our zs_mappings from brief (only for the
> > single printk) to as long as uptime (if a prdebug is enabled til
> > poweroff).  This appears to be triggering the ensuing mayhem.
> >
> > I am able to get through init, to root console, by disabling all
> > dynamic-debugs, including the ones that are enabled at compile.
> >
> > $ kruna --kopt \*.dyndbg=-p --kopt debug_locks_proceed=1
> >
> > but enabling any pr-debug crashes.
> > Plain old boot also panics, as pasted below.
> >
>
>
> Hi Jim,
>
> Looks like you've made a lot of progress with this series...but if I
> understand correctly there are still some unresolved issues (panic).
> So I think this series is more 'RFC' at this point?
>

yes, RFC.  WIP suggests I know whats needed next.

certainly Ive seen a variety of sleeping while atomic ... BUGs,



> I was also expecting to see updates to the actual printing functions
> to now use dp->site. But perhaps I missed those bits?

those bits were changed in patch 5
basically changes are ~ s/dp/dc/g, and in ddebug_getsite / _putsite

>
> Thanks,
>
> -Jason
>
> > $ kruna --kopt debug_locks_proceed=1
> >




 [    1.915768]  ? rest_init+0x24d/0x24d
> > [    1.916417]  kernel_init+0xaf/0x103
> > [    1.917038]  ret_from_fork+0x22/0x30
> > [    1.917726] Kernel Offset: disabled
> > [    1.918324] ---[ end Kernel panic - not syncing: Requested init /bin/sh failed (error -14). ]---
> > QEMU 5.1.0 monitor - type 'help' for more information
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >  lib/dynamic_debug.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 534d73e45844..0c69aa52395d 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -165,7 +165,9 @@ static void ddebug_putsite(struct _ddebug *dp)
> >               /* need to keep site until zmap backing exists */
> >               return;
> >
> > -     /* always unmap for now. if !pr-debug has locking issues */
> > +     if (dp->flags & _DPRINTK_FLAGS_PRINT)
> > +             return; /* keep maps of enabled pr_debugs */
> > +
> >       zs_unmap_object(dd_callsite_zpool, dp->zhandle);
> >       dp->site = NULL;
> >  }
> >
