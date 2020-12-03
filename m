Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D262CDDAB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 19:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502037AbgLCSaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 13:30:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727599AbgLCSaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 13:30:19 -0500
Date:   Thu, 3 Dec 2020 19:30:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607020177;
        bh=3XXWrx8mR/m+t5lqkDosOVllizg8JN+/aY2WXeZoxPU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+wVhhb8vKwfRAXg4lMwE0CQiykQ9fvsp0GdOILSHjBhqBWfPpTZABOCqifxuOXA6
         PyMh1wR0QfzYpsFNWgxn7dbQhaAui5QFdNf9QFNnVfDDqVQJdR/hrxP7UrO0xxSbvK
         bzcukMCzOs51okUrLKRnhBeU1xK11BD1uBo20zUo=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] crediting bug reports and fixes folded into
 original patch
Message-ID: <X8ku1MmZeeIaMRF4@kroah.com>
References: <ea32eb02-5e44-0469-772b-34b5cb882543@suse.cz>
 <CAPcyv4jDHMt4PpR2Htvw27rn5i5sCkwXtoZH-rFbtG8Hj7x1sg@mail.gmail.com>
 <20201203093458.GA16543@unreal>
 <CAMuHMdVcPELarE=eJEc-=AdyfmhhZQsYtUggWCaetuEdk=VpMQ@mail.gmail.com>
 <20201203104047.GD16543@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203104047.GD16543@unreal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 12:40:47PM +0200, Leon Romanovsky wrote:
> On Thu, Dec 03, 2020 at 10:36:56AM +0100, Geert Uytterhoeven wrote:
> > On Thu, Dec 3, 2020 at 10:35 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > On Wed, Dec 02, 2020 at 08:02:27PM -0800, Dan Williams wrote:
> > > > On Wed, Dec 2, 2020 at 3:44 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> > > > > there was a bit of debate on Twitter about this, so I thought I would bring it
> > > > > here. Imagine a scenario where patch sits as a commit in -next and there's a bug
> > > > > report or fix, possibly by a bot or with some static analysis. The maintainer
> > > > > decides to fold it into the original patch, which makes sense for e.g.
> > > > > bisectability. But there seem to be no clear rules about attribution in this
> > > > > case, which looks like there should be, probably in
> > > > > Documentation/maintainer/modifying-patches.rst
> > > > >
> > > > > The original bug fix might include a From: $author, a Reported-by: (e.g.
> > > > > syzbot), Fixes: $next-commit, some tag such as Addresses-Coverity: to credit the
> > > > > static analysis tool, and an SoB. After folding, all that's left might be a line
> > > > > as "include fix from $author" in the SoB area. This is a loss of
> > > > > metadata/attribution just due to folding, and might make contributors unhappy.
> > > > > Had they sent the fix after the original commit was mainline and immutable, all
> > > > > the info above would "survive" in the form of new commit.
> > > > >
> > > > > So I think we could decide what the proper format would be, and document it
> > > > > properly. I personally wouldn't mind just copy/pasting the whole commit message
> > > > > of the fix (with just a short issue description, no need to include stacktraces
> > > > > etc if the fix is folded), we could just standardize where, and how to delimit
> > > > > it from the main commit message. If it's a report (person or bot) of a bug that
> > > > > the main author then fixed, preserve the Reported-by in the same way (making
> > > > > clear it's not a Reported-By for the "main thing" addressed by the commit).
> > > > >
> > > > > In the debate one less verbose alternatve proposed was a SoB with comment
> > > > > describing it's for a fix and not whole patch, as some see SoB as the main mark
> > > > > of contribution, that can be easily found and counted etc. I'm not so sure about
> > > > > it myself, as AFAIK SoB is mainly a DCO thing, and for a maintainer it means
> > > > > something else ("passed through my tree") than for a patch author. And this
> > > > > approach would still lose the other tags.
> > > > >
> > > > > Thoughts?
> > > >
> > > > How about a convention to add a Reported-by: and a Link: to the
> > > > incremental fixup discussion? It's just polite to credit helpful
> > > > feedback, not sure it needs a more formal process.
> > >
> > > Maybe "Fixup-Reported-by:" and "Fixup-Link:"?
> >
> > And "Earlier-Review-Comments-Provided-by:"?
> >
> > How far do we want to go?
> 
> I don't want to overload existing meaning of "Reported-by:" and "Link:",
> so anything else is fine by me.
> 
> I imagine that all those who puts their own Reviewed-by, Signed-off-by
> and Tested-by in the same patch will be happy to use something like you
> are proposing - "Co-developed-Signed-Reviewed-Tested-by:" tag.

We already have "Co-developerd-by:" as a valid tag, no need to merge
more into this :)
