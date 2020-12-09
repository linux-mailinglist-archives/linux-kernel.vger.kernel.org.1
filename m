Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA5D2D3E6F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgLIJT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:19:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46939 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbgLIJTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:19:21 -0500
Received: by mail-ot1-f66.google.com with SMTP id w3so663644otp.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 01:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4nn+85WfZz1IIZTvFFrEl51XM3m+HvNSslhv6pMm04=;
        b=smAliysNoO4T5jntVVicb/7lkM9DvLuufNkhEqaYxG/TyusdK14mkMHIkmrb4IBbbA
         c15Go1HdrOrhmEURuBEKuVbRGymLuQWVqb9TSx3sC0ID6AR6d8ytvRmSjSQnips0qJ73
         z/mdFTP533yqNznqU9gjx22Q9BBoOc7IwahdAFYBV3DU2clLF9izTkpoHc1jq+psnsfz
         cKlHd4BGZJSTl74ndnCF8filzWYf9PihArWw1Yntr6Ke8DP0xhB1hpMclcboYLUqXkyt
         9njHL4RIffgEPGef95e6rXSKE3T2e9qGzq+XnD4tH/aog8juXWKWEM58zl2n/S5GsP3S
         PFlQ==
X-Gm-Message-State: AOAM5328o0Q9q37FcNPA5yXh9l5aFp+tWXSWs+s8Mw/eCQCKMhEUsxxY
        fMZ5ZRXN83nU4/A3s2Q04WnCbyHL6RDeUIhcr58=
X-Google-Smtp-Source: ABdhPJyaQvoIu2F0E+occhOnj1kS4x9aI1lKpD2DaqLRfZGiwoY1S4sSlQagNnAEnx7OXKB6oGOa0N6DV+/mxrLEIXQ=
X-Received: by 2002:a9d:2203:: with SMTP id o3mr935809ota.107.1607505520523;
 Wed, 09 Dec 2020 01:18:40 -0800 (PST)
MIME-Version: 1.0
References: <ea32eb02-5e44-0469-772b-34b5cb882543@suse.cz> <CAPcyv4jDHMt4PpR2Htvw27rn5i5sCkwXtoZH-rFbtG8Hj7x1sg@mail.gmail.com>
 <20201203093458.GA16543@unreal> <CAMuHMdVcPELarE=eJEc-=AdyfmhhZQsYtUggWCaetuEdk=VpMQ@mail.gmail.com>
 <20201203104047.GD16543@unreal> <X8ku1MmZeeIaMRF4@kroah.com>
 <202012081619.6593C87D3@keescook> <13d04c4cc769ebd1dd58470f4d22ada5c9cd28e7.camel@perches.com>
 <20201209075849.GD2767@kadam> <a6dfe760-c3b4-8bc4-3c7f-cc1208b626fa@suse.cz>
In-Reply-To: <a6dfe760-c3b4-8bc4-3c7f-cc1208b626fa@suse.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Dec 2020 10:18:29 +0100
Message-ID: <CAMuHMdWtJnkK5LP+_YLWvZ5knnd+i72h60PA+Z-EqjNYdEN3SA@mail.gmail.com>
Subject: Re: [Ksummit-discuss] crediting bug reports and fixes folded into
 original patch
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Joe Perches <joe@perches.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 9:45 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> On 12/9/20 8:58 AM, Dan Carpenter wrote:
> > On Tue, Dec 08, 2020 at 09:01:49PM -0800, Joe Perches wrote:
> >> On Tue, 2020-12-08 at 16:34 -0800, Kees Cook wrote:
> >>
> >> > If not "Adjusted-by", what about "Tweaked-by", "Helped-by",
> >> > "Corrected-by"?
> >>
> >> Improved-by: / Enhanced-by: / Revisions-by:
> >>
> >
> > I don't think we should give any credit for improvements or enhancements,
>
> Well, some are actually useful and not about reviewer's preferred style :) But
> if an author redoes the patch as a result, it's their choice to mention useful
> improvements in the next version's change log.
>
> > only for fixes.  Complaining about style is its own reward.
>
> Right, let's focus on fixes and reports of bugs, that would have resulted in a
> standalone commit, but don't.
>
> > Having to redo a patch is already a huge headache.  Normally, I already
> > considered the reviewer's prefered style and decided I didn't like it.
> > Then to make me redo the patch in an ugly style and say thankyou on
> > top of that???  Forget about it.  Plus, as a reviewer I hate reviewing
> > patches over and over.
> >
> > I've argued for years that we should have a Fixes-from: tag.  The zero
>
> Standardizing the Fixes-from: tag (or any better name) would be a forward
> progress, yes.
>
> > day bot is already encouraging people to add Reported-by tags for this
> > and a lot of people do.
>
> "Reported-by:" becomes ambiguous once the bugfix for the reported issue in the
> patch is folded, as it's no longer clear whether the bot reported the original
> issue the patch is fixing, or a bug in the fix. So we should have a different
> variant. "Fixes-reported-by:" so it has the same prefix?

Taken-into-account-comments-from:

Any terse English word for that?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
