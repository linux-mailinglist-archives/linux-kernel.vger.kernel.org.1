Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A01B2A8B64
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 01:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732952AbgKFA01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 19:26:27 -0500
Received: from smtprelay0100.hostedemail.com ([216.40.44.100]:37834 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732181AbgKFA01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 19:26:27 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 14936100E7B42;
        Fri,  6 Nov 2020 00:26:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1801:2393:2559:2562:2692:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:4321:4362:4384:4605:4823:5007:6119:7875:7903:8531:9149:10004:10400:10848:11026:11232:11473:11658:11783:11914:12297:12663:12740:12895:13161:13229:13439:13894:14181:14659:14721:21080:21433:21451:21611:21627:21660:21789:21819:30003:30022:30029:30030:30054:30070:30083:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: blow35_160a2c4272ce
X-Filterd-Recvd-Size: 3200
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Nov 2020 00:26:24 +0000 (UTC)
Message-ID: <772993cade7e2def4ee9727255734bf9cd6d3f59.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: improve email parsing
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Aditya Srivastava <yashsri421@gmail.com>
Date:   Thu, 05 Nov 2020 16:26:23 -0800
In-Reply-To: <CABJPP5BTRtAjdNQdRCx-3HjmyJ0AnoXBzB95YiPRMoF0njOOaA@mail.gmail.com>
References: <20201105115949.39474-1-dwaipayanray1@gmail.com>
         <f83c2eeafdebc6307ee6e515e4d6652b2606a068.camel@perches.com>
         <CABJPP5BTRtAjdNQdRCx-3HjmyJ0AnoXBzB95YiPRMoF0njOOaA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-11-06 at 02:46 +0530, Dwaipayan Ray wrote:
> > Can you send me a file with the BAD_SIGN_OFF messages generated
> > and if possible the git SHA-1s of the commits?
> Yes sure, am attaching the file for data tested on about 27k commits
> from v5.4.

Thanks.

> Excluded the duplicate signatures, tags and spacing ones for
> simplicity.
> 
> >      24 linux-stable <stable@vger.kernel.org>
> >      21 5.4+ <stable@vger.kernel.org>
> >      14 All applicable <stable@vger.kernel.org>
> >       6 3.10+ <stable@vger.kernel.org>
> >       5 5.9+ <stable@vger.kernel.org>
> >       5 5.3+ <stable@vger.kernel.org>
> 
> Do I also convert these then for the fix?

Yes.

Ideally removing any case insensitive name like linux-stable or stable
and also removing any leading < or trailing > from the email address.

And the stable email address should be forced to lower case only.

Any other name should be moved as a comment after the email address
then #.

> > > Improvements to parsing:
> > > 
> > > - Detect and report unexpected content after email.
> > > - Quoted names are excluded from comment parsing.
> > > - Trailing dots or commas in email are removed during
> > >   formatting. Correspondingly a BAD_SIGN_OFF warning
> > >   is emitted.
> > > - Improperly quoted email like '"name <address>"' are now
> > >   warned about.
[]
> > > +                                                     my $new_comment = $comment;
> > > +                                                     $new_comment =~ s/^[ \(\[]+|[ \)\]]+$//g;
> > 
> > Does the comment include any leading whitespace here?
> > I presumed not given the $comment !~ /^#/ test above.
> > 
> I added it to discard empty spaces before or after the first
> brackets are unwrapped. Something like (  v5.7 ) would
> be better if translated to # v5.7. (The extra spaces would be purged).
> It just looks good :). Should I change it to keep it as it is?

No.  Converting the comment style is very sensible and a good change.
I did not understand why the regex included a space.  I do now.
I suggest changing the space to use \s in case there are tabs.


