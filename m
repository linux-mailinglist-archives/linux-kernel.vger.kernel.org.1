Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F82B2EC2BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbhAFRvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbhAFRvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:51:10 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD40CC061575
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 09:50:29 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id b23so2186665vsp.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 09:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4UzEmPdihGym/Hm4w8gH/SEmYueVQ0z2H8+7KJQNQc=;
        b=M5iZVf1M0Hm1v1NPGcy5Rk85hsbltLOMPIa0cwhCxsnMjW9vFc+LHBVik58zmAbAYR
         Q0do3Bjh+hok2WA0L7P2sHV32eXTFLO+QDGUk3D5nQa1K5vEwQQpMCeFezv3prA0pvm2
         IuPw7g6Sqsmdx9vMJhfoH7cSUhSDk0di/zEOIfk0njxHL6zJz50mG6aEkT68ep/SvTY7
         sVgMLPGf/5Mi3j529yLwYtTmCYZjxT7419JZ4T5I+HSdWs6GSZ+JGeWbeafXAH01inyf
         rQSUNSfOv5LBD27ZVgjLpSegT2Y2N5tq7hUqce5S6B16Nn1WZL69J+/rg9ponstugnfm
         i+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4UzEmPdihGym/Hm4w8gH/SEmYueVQ0z2H8+7KJQNQc=;
        b=UoNvAXZBDu9YMdWQDI2VXM5MTHpoyqe/kmPjcSsgR3WV8wehC5ytEq5Fm++zXtNZ3i
         TV4etDoI1kVNOVZn1d4N7snbZLRU6bUxivhPllwoGpOvqbP47YhJRUmhd381eMyIBZ4i
         uXvZZ7sMoh56r9RRFgp6Wp6fO96rgzVcsZojELE3aYsGESyqIBc2VE1It+bc5e+meCWm
         uZK+SvzCJx3XhKnSAh2ReEvdT7TtdAWx0+qPA8y6Z64kFXmwXyY7ntkN7inj+fPyH8w4
         HY3sjJ5NK204OTTYjwyj6v1VwoFSk4G1Tk6rCWXS7aJ0JSNlpYdxYwZcaM+q0E81gYPq
         hxug==
X-Gm-Message-State: AOAM531iqlA97W5FoEBu6JTXyc/blIpjPJMmjGQlbelfHA05udAScRV4
        Hwjiv0THPJbQNS4o46v5ZZ8KNO6MSAVcsiUJvY6jA2WuB44=
X-Google-Smtp-Source: ABdhPJzkba1oNM7SHTnlbRFSQwi2pGgHZMwd+uZMsixWLUN2I6C1tY6r+4/B7+sKnAOAtPhlnabW6a2uszZiqbFfo/8=
X-Received: by 2002:a67:ca83:: with SMTP id a3mr4026459vsl.56.1609955428969;
 Wed, 06 Jan 2021 09:50:28 -0800 (PST)
MIME-Version: 1.0
References: <20201225201944.3701590-1-jim.cromie@gmail.com> <4520e86ead300c92de0736fcb7b1ec3045c34efa.camel@perches.com>
In-Reply-To: <4520e86ead300c92de0736fcb7b1ec3045c34efa.camel@perches.com>
From:   jim.cromie@gmail.com
Date:   Wed, 6 Jan 2021 10:50:01 -0700
Message-ID: <CAJfuBxzytECmfkB=GL_eu=+rphy1bcBreRsXkp1pQwLBVXKoCQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/19] dynamic debug diet plan
To:     Joe Perches <joe@perches.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Orson Zhai <orson.zhai@unisoc.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 11:56 AM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2020-12-25 at 13:19 -0700, Jim Cromie wrote:
> > Well, we're mostly overeating, but we can all look forward to a diet
> > in January.  And more exersize.
> >
> > dyndbg's compiled-in data-table currently uses 56 bytes per prdebug;
> > this includes 3 pointers to hierarchical "decorator" data, which is
> > primarily for adding "module:function:line:" prefixes to prdebug
> > messages, and for enabling and modifying those prdebugs selectively.
> >
> > This patchset decouples "decorator" data, and makes it optional, and
> > disposable.  By separating that data, it opens up possiblities to
> > compress it, swap it out, map it selectively, etc.
>
> While this may be somewhat useful, what debugging does it really help?
> Are there really memory limited platforms that enable dynamic debug?
>
>

hi Joe, happy new year!

Who wants to drop 5 lbs of weight for free ?
You dont even have to put down the turkey leg.

Seriously, I cant point to any particular use case that suddenly becomes
possible. and there are no powerful new debugging features here either.
but
    dynamic_debug: add an option to enable dynamic debug for modules only

Recently reduced dyndbg's system footprint, surely to open up new use
cases, users.  This is an orthogonal (and more involved) approach to
dropping more weight, and improving the coefficients in a
user's cost-benefit equation.


I tried out DRM as a user
https://lore.kernel.org/lkml/20201204035318.332419-1-jim.cromie@gmail.com/

it works, but I got the impression Ville is inclined to use static-keys
directly to replace drm_debug_enabled(), avoiding dyndbg overheads.

The possible in-memory savings here are asymptotically 24/64 (56 maybe)
of the footprint, which is easy if subsystems dont need the
decorators/selectors,
DRM has that option.

Possible savings in dyndbg aside, a static-key takes 16 bytes.
I think I can get struct _ddebug down to 32 bytes (RFC on 18,19 particularly)
so Im still playing catch-up wrt what a minimal static-keys drm update could do.
Theres also a vector of jump-labels form of static-keys
that Ville may be able to exploit too.

IOW, drm is not my ace card.  but memory savings is still nice.

Where Id like to RFC:

(patch-19) DEFINE_DYNAMIC_DEBUG_TABLE(i915)  worked.
it adds a pair of header records into the 2 elf sections, It will let me drop
the site pointer currently needed to get each site's decorations, when needed.

But I had to code it in manually, as a test. Its not a general solution.

I'd like to figure out how to have it defined in module scope automatically,
and weakly, and maybe-unused, so that if the module does not have any
pr_debugs, the header record is silently excluded, and that module's
sections are left empty.

When the header is linked in, as with my hacked i915.ko,
It becomes possible to finally lose the  _ddebug.site pointer.
.module_index and container-of can replace it:
it gets us from struct _ddebug *p back up to the header,
then we could follow a header.sites_vector[.module_index]
to the right decorators/selectors.
Its a modest cost increase for a rarely used path,
to shave 8/40 off our minimum footprint

Then the total footprint reduces back to 56 bytes/callsite,
but now with 24 optional, and manageable..
module_index would be a fine lookup to a compressed RO table of callsites,
and a good-enough key to a hashtable of active/enabled pr-debug callsites.

I played with zs-pool to store callsite data. Though it had problems,
I did see 3/1 pages/zs-page, which is a decent (slightly pessimistic)
proxy for what could be had with another (block) compression choice.

Once compressed callsites works, we can drop and recycle the
__dyndbg_callsites section.


other pertinences:

the 2 section relative ordering may be a consequence of :
- natural ordering of compilation & lexical placement of the paired declarations
- OR the site pointer, and its initialization between the 2 records.
I suspect former.

if 2nd, dropping site may lose the constraint between 2 sections.
I havent tried yet to test the drop to see what happens,
I cannot use the current BUG_ON (site_iter != iter->site) construct.

I tried invoking TABLE from METADATA,
hoping that __weak and __maybe_unused would allow redundant definitions
it errored, something about "local" and "section" mumble.
I now believe that initialization in TABLE is part of the problem,



I tried :
$ objcopy --dump-section __dyndbg_callsites=dd_callsites
--dump-section __dyndbg=dd vmlinux.o

I got mostly null data, as if some final linking wasnt yet done.

[jimc@frodo local-i915m]$ od -c dd_callsites
0000000  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0205620

trying it on vmlinux doesnt work;
objcopy: vmlinux: can't dump section '__dyndbg' - it does not exist:
file format not recognized
objcopy: vmlinux: can't dump section '__dyndbg_callsites' - it does
not exist: file format not recognized

[jimc@frodo local-i915m]$ ll dd*
-rw-rw-r--. 1 jimc jimc 114160 Dec 31 11:36 dd
-rw-rw-r--. 1 jimc jimc  68496 Dec 31 11:36 dd_callsites
[jimc@frodo local-i915m]$ od -d dd | head -n 40
0000000     1     0     0     0     1     0     0     0
0000020     0     0     0     0     0     0     0     0
0000040  1349     4     0     0     1     0     0     0
0000060     1     0     0     0     0     0     0     0
0000100     0     0     0     0  1347     4     0     0
0000120     1     0     0     0     1     0     0     0
0000140     0     0     0     0     0     0     0     0
0000160  1346     4     0     0     1     0     0     0
0000200     1     0     0     0     0     0     0     0
0000220     0     0     0     0  1344     4     0     0
0000240     1     0     0     0     1     0     0     0
0000260     0     0     0     0     0     0     0     0
0000300  1133     4     0     0     1     0     0     0
0000320     1     0     0     0     0     0     0     0
0000340     0     0     0     0  1094     4     0     0
0000360     0     0     0     0     0     0     0     0
*
0000420   485     0     0     0     0     0     0     0
0000440     0     0     0     0     0     0     0     0
0000460     0     0     0     0   926     0     0     0
0000500     0     0     0     0     0     0     0     0
*
0000540   897     0     0     0     0     0     0     0
0000560     0     0     0     0     0     0     0     0
0000600     0     0     0     0   890     0     0     0
0000620     0     0     0     0     0     0     0     0
*
0000660   782     0     0     0     0     0     0     0
0000700     0     0     0     0     0     0     0     0
0000720     0     0     0     0   779     0     0     0
0000740     0     0     0     0     0     0     0     0
*
0001000  9691     0     0     0     0     0     0     0
0001020     0     0     0     0     0     0     0     0
0001040     0     0     0     0  2109     0     0     0
0001060     0     0     0     0     0     0     0     0
*
0001120   273     0     0     0     0     0     0     0
0001140     0     0     0     0     0     0     0     0
0001160     0     0     0     0   457     0     0     0

Theres obviously some pattern to it, but I dont see a path towards
compressing and packaging it to load like a DT-file

And sorry for late reply, Ive continued cooking, thinking it would
help clarify my responses here.  I'll send v3 at some point

thanks
JIm
