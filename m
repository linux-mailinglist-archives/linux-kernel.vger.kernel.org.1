Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902801DEE1A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 19:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbgEVRWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 13:22:09 -0400
Received: from smtprelay0183.hostedemail.com ([216.40.44.183]:59076 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730471AbgEVRWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:22:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 452C2180A8153;
        Fri, 22 May 2020 17:22:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2693:2828:2897:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3874:4031:4321:5007:6119:7514:7903:8909:8957:10007:10400:10848:10967:11232:11658:11914:12043:12297:12740:12760:12895:13439:14096:14097:14181:14659:14721:21080:21324:21451:21611:21627:21740:21939:30012:30020:30029:30054:30056:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: wall47_0510ab926d28
X-Filterd-Recvd-Size: 3359
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 22 May 2020 17:22:05 +0000 (UTC)
Message-ID: <162676bb69044efadd31daa9ea49fc6fb9664297.camel@perches.com>
Subject: Re: [PATCH] taging: speakup: remove volatile
From:   Joe Perches <joe@perches.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        MugilRaj <dmugil2000@gmail.com>, devel@driverdev.osuosl.org,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        Chris Brannon <chris@the-brannons.com>
Date:   Fri, 22 May 2020 10:22:03 -0700
In-Reply-To: <20200522171312.s2ciifuxozwav2ym@function>
References: <1590138989-6091-1-git-send-email-dmugil2000@gmail.com>
         <20200522103406.GK30374@kadam>
         <6ab4139ec78928961a19e5fdbda139bb8cff9cb5.camel@perches.com>
         <20200522171312.s2ciifuxozwav2ym@function>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-22 at 19:13 +0200, Samuel Thibault wrote:
> Joe Perches, le ven. 22 mai 2020 09:36:05 -0700, a ecrit:
> > On Fri, 2020-05-22 at 13:34 +0300, Dan Carpenter wrote:
> > > On Fri, May 22, 2020 at 02:46:28PM +0530, MugilRaj wrote:
> > > > fix checkpatch.pl warning, which is Use of volatile is usually wrong: see
> > > > Documentation/process/volatile-considered-harmful.rst
> > > > Signed-off-by: MugilRaj <dmugil2000@gmail.com>
> > > 
> > > Please put a blank before the Signed-off-by line.
> > > 
> > > Probably there should be a space between your first and last name.  It's
> > > supposed to your legal name like for signing a legal document so use
> > > whatever is appropriate legal documents in your country.
> > > 
> > > Also the Documentation/process/volatile-considered-harmful.rst explains
> > > that people often use "volatile" when they should be using locking for
> > > synchronization.  That seems to be the case here.  So the correct fix is
> > > to add locking.  That's a little bit complicated to do and requires
> > > testing.
> > > 
> > > If we apply this patch, then we have silenced the warning so now someone
> > > will have to look for the bug.  But if we leave it as-is, then everyone
> > > will know that the code is buggy.  So let's leave it as-is until we are
> > > able to fix the bug.
> > > 
> > > It's always better to have easy to find bugs, than hidden bugs.
> > 
> > And better still to comment known opportunities to
> > improve the code so the next time someone tries to
> > remove this volatile, there's a comment right there
> > showing what's necessary instead.
> 
> Actually I don't think adding the suggestion is a good thing if it's
> only a "rule-of-thumb-replace-volatile-with-lock".
> 
> Actually possibly volatile might not even be needed because there could
> be already a lock protecting this.
> 
> Put another way: I don't think putting any hint here would help, on the
> contrary, somebody has to really look at what protection is needed,
> without getting influenced by rules-of-thumb.

checkpatch newbies/robots will submit this change again otherwise.

Comment wording can always be improved.


