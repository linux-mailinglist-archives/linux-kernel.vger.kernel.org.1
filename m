Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CAB2CD2AD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 10:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgLCJht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 04:37:49 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36497 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgLCJht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 04:37:49 -0500
Received: by mail-oi1-f193.google.com with SMTP id x16so1549019oic.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 01:37:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jvny1rtUiDgjADL0gl6coThE7hbff0ih3DlnnP8/5jo=;
        b=Rc4/cxx0I80fW9WaaLqAaBy1WD2I1bUuUVJIzC/rQtoLoGkhU1S07EIf35NP7QFr5r
         hRHf60FQbXnWV+E2CPVkeWRzIyML6q6CB6TLKBYcXfoOER4/uax5LJf5Y2nj6P9FRyze
         Knz+JTT0jGBnD8Wh0P4hfFp626TwzS/N00JY8EMgt0EIZMAPe9h6kG5fra7ROC5Onc37
         YqkyL2fcL0TbfbsoOYMfPaBffNReUA5QcVBZ5BcGuXzeBwOJpmhF0aXR3CmN5SpFohoI
         4ukpPHDaMQF70ycPokiE8vi5SEjpm5CibZ3MXu7WHu7YmBNYMWNYa1J5Tctbh8b2R+eR
         iNpw==
X-Gm-Message-State: AOAM531eAlA0iJ1zwJUTzqhlBl4m2gPWi0XYA0bOkbLPLkunNhzdrzpQ
        Vq71pDSwScw3sRLkBsygjYR18xnyL9m3gQ6H96+KIKpy
X-Google-Smtp-Source: ABdhPJw4GKrS5Viye7DaliTruHqlREe1NdLISwc/nLmA8wqlEaJsNx9bI4Esu7LyGFrsK/31Ymq2sbT3Qb2UsLRC6Kc=
X-Received: by 2002:aca:ec09:: with SMTP id k9mr1271015oih.153.1606988228261;
 Thu, 03 Dec 2020 01:37:08 -0800 (PST)
MIME-Version: 1.0
References: <ea32eb02-5e44-0469-772b-34b5cb882543@suse.cz> <CAPcyv4jDHMt4PpR2Htvw27rn5i5sCkwXtoZH-rFbtG8Hj7x1sg@mail.gmail.com>
 <20201203093458.GA16543@unreal>
In-Reply-To: <20201203093458.GA16543@unreal>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 3 Dec 2020 10:36:56 +0100
Message-ID: <CAMuHMdVcPELarE=eJEc-=AdyfmhhZQsYtUggWCaetuEdk=VpMQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] crediting bug reports and fixes folded into
 original patch
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 10:35 AM Leon Romanovsky <leon@kernel.org> wrote:
> On Wed, Dec 02, 2020 at 08:02:27PM -0800, Dan Williams wrote:
> > On Wed, Dec 2, 2020 at 3:44 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> > > there was a bit of debate on Twitter about this, so I thought I would bring it
> > > here. Imagine a scenario where patch sits as a commit in -next and there's a bug
> > > report or fix, possibly by a bot or with some static analysis. The maintainer
> > > decides to fold it into the original patch, which makes sense for e.g.
> > > bisectability. But there seem to be no clear rules about attribution in this
> > > case, which looks like there should be, probably in
> > > Documentation/maintainer/modifying-patches.rst
> > >
> > > The original bug fix might include a From: $author, a Reported-by: (e.g.
> > > syzbot), Fixes: $next-commit, some tag such as Addresses-Coverity: to credit the
> > > static analysis tool, and an SoB. After folding, all that's left might be a line
> > > as "include fix from $author" in the SoB area. This is a loss of
> > > metadata/attribution just due to folding, and might make contributors unhappy.
> > > Had they sent the fix after the original commit was mainline and immutable, all
> > > the info above would "survive" in the form of new commit.
> > >
> > > So I think we could decide what the proper format would be, and document it
> > > properly. I personally wouldn't mind just copy/pasting the whole commit message
> > > of the fix (with just a short issue description, no need to include stacktraces
> > > etc if the fix is folded), we could just standardize where, and how to delimit
> > > it from the main commit message. If it's a report (person or bot) of a bug that
> > > the main author then fixed, preserve the Reported-by in the same way (making
> > > clear it's not a Reported-By for the "main thing" addressed by the commit).
> > >
> > > In the debate one less verbose alternatve proposed was a SoB with comment
> > > describing it's for a fix and not whole patch, as some see SoB as the main mark
> > > of contribution, that can be easily found and counted etc. I'm not so sure about
> > > it myself, as AFAIK SoB is mainly a DCO thing, and for a maintainer it means
> > > something else ("passed through my tree") than for a patch author. And this
> > > approach would still lose the other tags.
> > >
> > > Thoughts?
> >
> > How about a convention to add a Reported-by: and a Link: to the
> > incremental fixup discussion? It's just polite to credit helpful
> > feedback, not sure it needs a more formal process.
>
> Maybe "Fixup-Reported-by:" and "Fixup-Link:"?

And "Earlier-Review-Comments-Provided-by:"?

How far do we want to go?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
