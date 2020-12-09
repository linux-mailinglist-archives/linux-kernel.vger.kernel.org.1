Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D132D37DF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 01:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbgLIAfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 19:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731846AbgLIAff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 19:35:35 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDF8C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 16:34:55 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c12so280242pfo.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 16:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yfjcinr47VTzgisqYPUHQArc78spyM/01XXRMjQOugA=;
        b=bAA6ZiGlqR5mqLExQngiv0Z9725AMEo45CvF872+ngYP0+ky00CN7nWbGywFjU1wDV
         /0FwncwTwocCKdmsYcaZdxLo/itUO4VqNMDlxuz3mpsu2EuaLfYzo472Dh02/U1fJFsU
         H2Et+uR7fwhuQLDnAUgjtu84bFHxh/tF6gXjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yfjcinr47VTzgisqYPUHQArc78spyM/01XXRMjQOugA=;
        b=Jw/ZZ5ZWfxINVt6sEsisuaRpxQ8fu0aVEpJWQLP5oLonYC5VyJCCwmO0Jta5NLeJcd
         UyJynyBte04+MPSslo+tQoBxjAbBeO3lF6y2g08yY5DD9MPIVAeQyIZ3c6K41pYBfcCy
         GiIcvzqqODUzGkdp0rkZ6c4r4wAa1gOT5noeuJdCIxenrztydMj2ss8os4YXWYFISEry
         g4iB2c4yaCCe56S6YARQP0GdSkwse5iZSzAIj1Exm51UIGp/ghbhl8/epjkVQA0QfQjZ
         fIaZkVACLC36bpDbjUhEb2AIFKvUIiY3CM8uV4shThdttJTSAsGmEHqpOEFhtHJZ3gBO
         5LjA==
X-Gm-Message-State: AOAM532srmdeEBLrhmnQJj7Z/x25/EBxBCjHdy7zqQ+T0q/TMe1clXfX
        rSQBm2N3PhlLp8II4P6YJ3JTBw==
X-Google-Smtp-Source: ABdhPJxCR3MpbUaRZDBVwELjYtyV6KCW2nNi6pjTX7Hpqbj6e/WfAqBhQxH9M8bnm997LsZPLO+erw==
X-Received: by 2002:a17:90a:a785:: with SMTP id f5mr72418pjq.219.1607474094711;
        Tue, 08 Dec 2020 16:34:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o11sm44567pjs.36.2020.12.08.16.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 16:34:53 -0800 (PST)
Date:   Tue, 8 Dec 2020 16:34:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Ksummit-discuss] crediting bug reports and fixes folded into
 original patch
Message-ID: <202012081619.6593C87D3@keescook>
References: <ea32eb02-5e44-0469-772b-34b5cb882543@suse.cz>
 <CAPcyv4jDHMt4PpR2Htvw27rn5i5sCkwXtoZH-rFbtG8Hj7x1sg@mail.gmail.com>
 <20201203093458.GA16543@unreal>
 <CAMuHMdVcPELarE=eJEc-=AdyfmhhZQsYtUggWCaetuEdk=VpMQ@mail.gmail.com>
 <20201203104047.GD16543@unreal>
 <X8ku1MmZeeIaMRF4@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8ku1MmZeeIaMRF4@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 07:30:44PM +0100, Greg KH wrote:
> On Thu, Dec 03, 2020 at 12:40:47PM +0200, Leon Romanovsky wrote:
> > On Thu, Dec 03, 2020 at 10:36:56AM +0100, Geert Uytterhoeven wrote:
> > > On Thu, Dec 3, 2020 at 10:35 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > > On Wed, Dec 02, 2020 at 08:02:27PM -0800, Dan Williams wrote:
> > > > > On Wed, Dec 2, 2020 at 3:44 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> > > > > > there was a bit of debate on Twitter about this, so I thought I would bring it
> > > > > > here. Imagine a scenario where patch sits as a commit in -next and there's a bug
> > > > > > report or fix, possibly by a bot or with some static analysis. The maintainer
> > > > > > decides to fold it into the original patch, which makes sense for e.g.
> > > > > > bisectability. But there seem to be no clear rules about attribution in this
> > > > > > case, which looks like there should be, probably in
> > > > > > Documentation/maintainer/modifying-patches.rst
> > > > > >
> > > > > > The original bug fix might include a From: $author, a Reported-by: (e.g.
> > > > > > syzbot), Fixes: $next-commit, some tag such as Addresses-Coverity: to credit the
> > > > > > static analysis tool, and an SoB. After folding, all that's left might be a line
> > > > > > as "include fix from $author" in the SoB area. This is a loss of
> > > > > > metadata/attribution just due to folding, and might make contributors unhappy.
> > > > > > Had they sent the fix after the original commit was mainline and immutable, all
> > > > > > the info above would "survive" in the form of new commit.
> > > > > >
> > > > > > So I think we could decide what the proper format would be, and document it
> > > > > > properly. I personally wouldn't mind just copy/pasting the whole commit message
> > > > > > of the fix (with just a short issue description, no need to include stacktraces
> > > > > > etc if the fix is folded), we could just standardize where, and how to delimit
> > > > > > it from the main commit message. If it's a report (person or bot) of a bug that
> > > > > > the main author then fixed, preserve the Reported-by in the same way (making
> > > > > > clear it's not a Reported-By for the "main thing" addressed by the commit).
> > > > > >
> > > > > > In the debate one less verbose alternatve proposed was a SoB with comment
> > > > > > describing it's for a fix and not whole patch, as some see SoB as the main mark
> > > > > > of contribution, that can be easily found and counted etc. I'm not so sure about
> > > > > > it myself, as AFAIK SoB is mainly a DCO thing, and for a maintainer it means
> > > > > > something else ("passed through my tree") than for a patch author. And this
> > > > > > approach would still lose the other tags.
> > > > > >
> > > > > > Thoughts?
> > > > >
> > > > > How about a convention to add a Reported-by: and a Link: to the
> > > > > incremental fixup discussion? It's just polite to credit helpful
> > > > > feedback, not sure it needs a more formal process.

To me, "Reported-by:" is associated with "this person reported the
problem being fixed by this commit". For these kinds of larger commits,
that may not be sensible. I.e. it's some larger feature that the "I
found a problem with this commit" author wasn't even involved in.

I think it's important to capture those in some way, even if they're
not considered "copyrightable" or whatever -- that's not the bar I'm
interested in; I want to make sure people are acknowledged for the time
and effort they spent. And whether we like it or not, these kinds of
tags do that. Besides, such fix authors have expressly asked for this,
which should be sufficient reason enough to find a solution.

> > > > Maybe "Fixup-Reported-by:" and "Fixup-Link:"?
> > >
> > > And "Earlier-Review-Comments-Provided-by:"?
> > >
> > > How far do we want to go?
> > 
> > I don't want to overload existing meaning of "Reported-by:" and "Link:",
> > so anything else is fine by me.

Agreed.

> > I imagine that all those who puts their own Reviewed-by, Signed-off-by
> > and Tested-by in the same patch will be happy to use something like you
> > are proposing - "Co-developed-Signed-Reviewed-Tested-by:" tag.
> 
> We already have "Co-developerd-by:" as a valid tag, no need to merge
> more into this :)

"Co-developed-by", to me, has a connotation of significant authorship.
For the "weaker" cases, I tend to use "Suggested-by" or put something
like "Based on a patch by $person[link]" in the body.

For the kinds of fixes mentioned here, and more specifically for the
kinds of fixes that I have received from both Colin Ian King and Dan
Carpenter that fall into this "tiny fix"[1] category, I think something
simply like "Adjusted-by" could be used. I've already tried to include
"Link" tags to things that got folded in, but without the Adjusted-by tag,
it lacks the right kind of searchability and recognition.

"Fixes-by" is too close to "Fixes" (and implies more than one
fix). "Fixup-by" implies singular. "Debugged-by" is like the other
existing high-level tags, in that they speak to the ENTIRE patch.

If not "Adjusted-by", what about "Tweaked-by", "Helped-by",
"Corrected-by"?

Colin, Dan, any thoughts on how you'd like to see stuff?

-Kees

[1] "tiny" in the sense of characters changed, usually. There was very
    much NOT a "tiny" amount of time spent on it, nor do they have "tiny"
    impact -- which is the whole point of calling this out in the
    commit.

-- 
Kees Cook
