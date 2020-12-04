Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE472CE72B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgLDEzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:55:09 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59266 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726242AbgLDEzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:55:08 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B44sE4A008436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Dec 2020 23:54:15 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1E872420136; Thu,  3 Dec 2020 23:54:14 -0500 (EST)
Date:   Thu, 3 Dec 2020 23:54:14 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] crediting bug reports and fixes folded into
 original patch
Message-ID: <20201204045414.GP441757@mit.edu>
References: <ea32eb02-5e44-0469-772b-34b5cb882543@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea32eb02-5e44-0469-772b-34b5cb882543@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 12:43:52AM +0100, Vlastimil Babka wrote:
> 
> there was a bit of debate on Twitter about this, so I thought I would bring it
> here. Imagine a scenario where patch sits as a commit in -next and there's a bug
> report or fix, possibly by a bot or with some static analysis. The maintainer
> decides to fold it into the original patch, which makes sense for e.g.
> bisectability. But there seem to be no clear rules about attribution in this
> case, which looks like there should be, probably in
> Documentation/maintainer/modifying-patches.rst

I don't think there should be any kind of fixed, inflexible rules
about this.  

1) Sometimes there will be a *huge* number of comments and
suggestions.  Do we really want to require links to dozens of mail
message id's, and/or dozens or more e-mail addresses?

2) Sometimes a fixup is pretty trivial; even if it is expressed in the
form of a one-line patch, versus someone who does a detailed review of
a patch, but doesn't actually end up appending an explicit
Reviewed-by, perhaps because he or she didn't completely agree with
the final version of the patch.

3) I think this very much should be up to the maintainer's discretion,
as opposed to making rules that may result in some rediculous amount
of bloat in the git log.

4) It's really unhealthy, in my opinion for people to be fixed on
counting attributions.  If we create fixed rules, this can turn into
people try to game the system.  It's the same reason why I'm not
terribly enthusiastic about people trying to game Signed-off-by counts
by sending gazillions of white space or spelling fixes.

If the fix is large enough that for copyright reasons we need to
acknowledge the work, then folding in the SoB as for DCO reason makes
perfect sense.  But if it's a trivial patch (the kind where projects
that require copyright assignment wouldn't require executed legal
agreements), then perhaps attribution is not always a requirement.
Again, there are times when people who spend a lot of work discussing
patch may not get attributiionm even if they didn't actually create
the one-line whitespace fix and sent it in as a patch with a
signed-off-by with a demand that the attribution be preserved.

Common sense really needs to prevale here, and I'm concerned that
people who like to create rules don't realize what a mess this can
create when contributors approach their participation with a sense of
entitlement.

Cheers,

						- Ted
